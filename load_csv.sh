#!/bin/bash

# Configura os pg_hba.conf para permitir todas as conexões
echo "host  all all all          trust" > /var/lib/postgresql/data/pg_hba.conf
echo "local all all              trust" >> /var/lib/postgresql/data/pg_hba.conf
echo "host  all all 127.0.0.1/32 trust" >> /var/lib/postgresql/data/pg_hba.conf
echo "host  all all ::1/128      trust" >> /var/lib/postgresql/data/pg_hba.conf
echo "Configuração do pg_hba.conf concluída!"

# Espera o PostgreSQL iniciar completamente antes de rodar o comando COPY
echo "Aguardando o PostgreSQL iniciar..."
for i in {1..30}; do
  if pg_isready -U user_fct -d gratificacoes_db; then
    echo "PostgreSQL está pronto!"
    break
  else
    echo "Esperando o PostgreSQL iniciar... tentativa $i/30"
    sleep 2
  fi
done

# Verifica se o PostgreSQL não iniciou após 30 tentativas
if ! pg_isready -U user_fct -d gratificacoes_db; then
  echo "Erro: O PostgreSQL não inicializou a tempo."
  exit 1
fi

# Carregar o CSV em uma tabela temporária
psql -U user_fct -d gratificacoes_db -c "
CREATE TABLE temp_gratificacao (
    competencia VARCHAR,
    matricula VARCHAR,
    cargo VARCHAR,
    sigla_regional VARCHAR,
    diretoria VARCHAR,
    lotacao_hierarquica VARCHAR,
    nivel_fca_fct_gfe INTEGER,
    valor_fca_fct_gfe TEXT,  -- Carregar como texto primeiro
    data_designacao_fct TEXT,  -- Carregar como texto
    data_destituicao_fct TEXT  -- Carregar como texto
);

COPY temp_gratificacao(competencia, matricula, cargo, sigla_regional, diretoria, lotacao_hierarquica, nivel_fca_fct_gfe, valor_fca_fct_gfe, data_designacao_fct, data_destituicao_fct)
FROM '/docker-entrypoint-initdb.d/lai_120282.csv'
DELIMITER ','
CSV HEADER
QUOTE '\"'
NULL AS '–'
ENCODING 'UTF8';
";

# Agora, corrigir os valores e inserir na tabela final
psql -U user_fct -d gratificacoes_db -c "
INSERT INTO gratificacao (competencia, matricula, cargo, sigla_regional, diretoria, superintendencia, lotacao_hierarquica, nivel_fca_fct_gfe, valor_fca_fct_gfe, data_designacao_fct, data_destituicao_fct)
SELECT
    to_date(competencia || '01', 'YYYYMMDD') AT TIME ZONE 'UTC' as competencia,
    matricula,
    cargo,
    sigla_regional,
    diretoria,
    SPLIT_PART(lotacao_hierarquica, '/', 1) AS superintendencia,
    SUBSTRING(lotacao_hierarquica FROM POSITION('/' IN lotacao_hierarquica) + 1) AS lotacao,    
    nivel_fca_fct_gfe,    
    CASE WHEN valor_fca_fct_gfe = '-' THEN NULL ELSE     REPLACE(valor_fca_fct_gfe, ',', '.')::NUMERIC END,  -- Substituir vírgula por ponto e converter para NUMERIC e Substituir "-" por NULL        
    CASE WHEN data_designacao_fct = '-' THEN NULL ELSE TO_TIMESTAMP(data_designacao_fct, 'DD/MM/YYYY HH24:MI:SS') END,  -- Converte para timestamp com formato DD/MM/YYYY HH24:MI:SS
    CASE WHEN data_destituicao_fct = '-' THEN NULL ELSE TO_TIMESTAMP(data_destituicao_fct, 'DD/MM/YYYY HH24:MI:SS') END  -- Converte para timestamp com formato DD/MM/YYYY HH24:MI:SS
FROM temp_gratificacao;

-- Excluir a tabela temporária após a importação
DROP TABLE temp_gratificacao;
";

echo "Importação do CSV concluída!"  
