CREATE TABLE gratificacao (
    competencia date,                       -- Competência é um valor alfanumérico de 6 caracteres
    matricula VARCHAR,                        -- Matrícula pode ser um número ou código alfanumérico
    cargo VARCHAR,                           -- Cargo, que pode ter texto longo
    sigla_regional VARCHAR,                   -- Sigla regional
    diretoria VARCHAR,                       -- Diretoria, que pode ter texto longo
    superintendencia VARCHAR,                       -- Superintendência
    lotacao_hierarquica VARCHAR,             -- Lotação hierárquica, texto longo
    nivel_fca_fct_gfe INTEGER,                    -- Nível FCA_FCT_GFE, valor numérico (inteiro)
    valor_fca_fct_gfe NUMERIC(12, 2),             -- Valor FCA_FCT_GFE, com vírgula como separador decimal
    data_designacao_fct TIMESTAMP,                -- Data designação FCT
    data_destituicao_fct TIMESTAMP                -- Data destituição FCT
);

CREATE INDEX idx_gratificacao_competencia_matricula
ON gratificacao (competencia, matricula);

CREATE INDEX idx_gratificacao_competencia_matricula_cargo_sigla_diretoria
ON gratificacao (competencia, matricula, cargo, sigla_regional, diretoria);

CREATE INDEX idx_gratificacao_competencia ON gratificacao (competencia);
CREATE INDEX idx_gratificacao_matricula ON gratificacao (matricula);


CREATE EXTENSION IF NOT EXISTS pg_trgm;

CREATE INDEX idx_gratificacao_text_search
ON gratificacao USING GIN (
    cargo gin_trgm_ops,
    sigla_regional gin_trgm_ops
);

CREATE TABLE anotacoes (
    id SERIAL PRIMARY KEY,                    -- Identificador único para cada anotação
    data TIMESTAMP NOT NULL,                  -- Data da criação da anotação
    tags TEXT[],                              -- Lista de tags associadas (array de texto)
    titulo VARCHAR(255) NOT NULL,             -- Título da anotação
    descricao TEXT,                           -- Descrição detalhada da anotação
    data_fim TIMESTAMP                        -- Data final associada à anotação
);


INSERT INTO anotacoes (data, tags, titulo, descricao, data_fim) VALUES

(TO_TIMESTAMP('05/12/2023 12:00:00', 'DD/MM/YYYY HH24:MI:SS'),ARRAY['Concurso2023'],'Serpro convoca os primeiros 200 aprovados no concurso público', 'O Serpro, empresa pública de TI do governo federal, dá início à convocação dos primeiros 200 classificados do concurso público realizado em 2023. A previsão é que esses convocados iniciem suas atividades no dia 15 de janeiro de 2024. A expectativa da empresa é que todos os aprovados dentro das 602 vagas de Analista com Especialização em Tecnologia, disponibilizadas pelo concurso, sejam convocados até março de 2024.', NULL),

(TO_TIMESTAMP('08/01/2024 12:00:00', 'DD/MM/YYYY HH24:MI:SS'),ARRAY['Concurso2023'],'Serpro convoca mais 300 aprovados no concurso público', 'O Serpro, empresa pública de TI do governo federal, convoca nesta segunda-feira, 8 de janeiro, mais 300 profissionais classificados no concurso público de 2023. Em dezembro do ano passado, a empresa chamou os primeiros 200, cuja previsão de início das atividades é agora no dia 15/1.', NULL),

(TO_TIMESTAMP('01/02/2024 12:00:00', 'DD/MM/YYYY HH24:MI:SS'),ARRAY['Concurso2023'],'As convocações do concurso público não param. Neste 1º de fevereiro, Serpro convoca mais 170 candidatos aprovados no processo seletivo de 2023', 'O Serpro mantém o ritmo acelerado de fortalecimento do seu quadro de profissionais iniciado com o Concurso Público de 2023, que ofereceu 602 vagas de Analista com Especialização em Tecnologia. Neste 1º de fevereiro, a empresa convoca mais 170 pessoas aprovadas no processo seletivo do ano passado, respeitando a ordem de classificação na lista final, e a expectativa é de contratação destes em 13 de março.', NULL),

(TO_TIMESTAMP('03/05/2024 12:00:00', 'DD/MM/YYYY HH24:MI:SS'),ARRAY['Concurso2023'],'Serpro realiza nova convocação do concurso público', 'O Serpro convoca novos candidatos e candidatas aprovadas no concurso público nesta sexta-feira, 3 de maio. Com isso, a empresa espera preencher todas as 602 vagas oferecidas no processo seletivo iniciado no ano passado. Atualmente o Serpro conta com 553 novos empregados e empregadas.', NULL),

(TO_TIMESTAMP('04/07/2024 12:00:00', 'DD/MM/YYYY HH24:MI:SS'),ARRAY['Concurso2023'],'Serpro convoca mais 12 aprovados no Concurso Público de 2023', 'O Serpro anunciou nesta terça-feira, 4 de junho, a convocação de mais 12 candidatos aprovados no concurso público, com o objetivo de preencher as 602 vagas oferecidas no edital de abertura do certame. Para serem efetivamente contratados, os convocados precisam cumprir os requisitos do cargo, como formação em Tecnologia, regularidade com obrigações militares e eleitorais, entre outros.', NULL),

(TO_TIMESTAMP('01/07/2024 12:00:00', 'DD/MM/YYYY HH24:MI:SS'),ARRAY['Concurso2023'],'Serpro convoca mais nove aprovados no Concurso Público de 2023', 'O Serpro convocou na segunda-feira, 1º de julho, mais nove candidatos aprovados no concurso público, com o objetivo de preencher as 602 vagas oferecidas no edital de abertura do processo seletivo para analista com especialização em tecnologia.', NULL),

(TO_TIMESTAMP('01/08/2024 12:00:00', 'DD/MM/YYYY HH24:MI:SS'),ARRAY['Concurso2023'],'Serpro convoca mais 234 classificados no Concurso Público 2023', 'O Serpro publicou aditivo de 228 vagas no Concurso Público 2023, além das 602 inicialmente previstas, num movimento estratégico para reforçar o compromisso da empresa com o seu crescimento, inovação e entrega de ainda mais resultados à sociedade brasileira. Neste 1º de agosto, a empresa convoca os candidatos classificados para preencher essas 228 vagas de analista com especialização em tecnologia e mais 6 vagas de saldo remanescente das convocações anteriores.', NULL),

(TO_TIMESTAMP('04/09/2024 12:00:00', 'DD/MM/YYYY HH24:MI:SS'),ARRAY['Concurso2023'],'Serpro convoca mais 57 aprovados do Concurso 2023', 'O Serpro anunciou em 4 de setembro, a convocação de mais 57 candidatos aprovados no concurso público, realizado em 2023, com 830 vagas oferecidas para Analista de Tecnologia, somando-se as 602 vagas ofertadas inicialmente e o aditivo de 228 vagas anunciado em julho. A convocação tem como objetivo repor vagas que não foram preenchidas na última convocação.', NULL),

(TO_TIMESTAMP('01/11/2024 12:00:00', 'DD/MM/YYYY HH24:MI:SS'),ARRAY['Concurso2023'],'Serpro convoca mais 61 aprovados do Concurso Público 2023', 'oje, 1º de novembro, o Serpro convocou mais 61 candidatos aprovados no concurso público realizado em 2023. O objetivo da empresa é preencher as 278 vagas adicionais, ofertadas no edital n°10 e no edital nº11. O número inicial de 602 vagas, estabelecido no edital de abertura do concurso, já foi preenchido.', NULL),

(TO_TIMESTAMP('01/10/2024 12:00:00', 'DD/MM/YYYY HH24:MI:SS'),ARRAY['Concurso2023'],'Serpro convoca mais 25 aprovados do Concurso 2023', 'O Serpro convoca neste 1º de outubro mais 25 candidatos aprovados no concurso público realizado em 2023. O objetivo da empresa é preencher todas as 830 vagas para analista de tecnologia oferecidas no processo seletivo, que foi aberto inicialmente com 602 vagas, somadas a mais 228 que foram anunciadas no último aditivo, de julho de 2024.', NULL),

(TO_TIMESTAMP('06/09/2024 12:00:00', 'DD/MM/YYYY HH24:MI:SS'),ARRAY['ACT'],'Aprovação do ACT 2024/2025', 'Proposta está sendo levada às assembleias hoje, 6 de setembro, pelos sindicatos locais em reunião online.', NULL),

(TO_TIMESTAMP('01/11/2024 12:00:00', 'DD/MM/YYYY HH24:MI:SS'),ARRAY['NovosHorizontes2024'],'109 Empregados foram desligados em Novembro de 2024', NULL, NULL),
(TO_TIMESTAMP('01/12/2024 12:00:00', 'DD/MM/YYYY HH24:MI:SS'),ARRAY['NovosHorizontes2024'],'23 Empregados foram desligados em Dezembro de 2024', NULL, NULL),
(TO_TIMESTAMP('01/01/2025 12:00:00', 'DD/MM/YYYY HH24:MI:SS'),ARRAY['NovosHorizontes2024'],'88 Empregados foram desligados em Janeiro de 2025', NULL, NULL);


