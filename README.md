# docker-compose
Docker Compose para visualizar as gratificações do Serpro através do Grafana.

## 1. Pré-requisito (instalar):
- Docker
- Docker Compose

## 2. Rodar:
```bash
sudo docker-compose up
```

## 3. Acessar:
- http://localhost:3000/
- user: admin
- password: admin2

## 4. Parar:

```bash
sudo docker-compose down
```

## 5. Resolver problemas:

- Conflitos de container: 

```bash
sudo docker container prune
```

- Painel não carregou os dados

Se após executar o docker-compose up, o painel apresentar erros ao carregar os dados, pode ser que o script load_csv.sh não executou corretamente dentro do container do PostgreSQL. Neste caso, você pode acessar o contêiner manualmente e executar o script:

 - Acesse o contêiner:
```bash
sudo docker exec -it postgresql_db bash
```

 - Verifique se o script está no contêiner:
```bash
ls /docker-entrypoint-initdb.d/
```
 - Execute o script manualmente:
```bash
bash /docker-entrypoint-initdb.d/load_csv.sh
```

## 6. Exemplos
- Gratificação Média da Empresa
![Arquitetura Background RFB](exemple/gratificacao_media_empresa_12_2024.png)
- Gratificação Média Por Regional
![Arquitetura Background RFB](exemple/gratificacao_media_por_regional.png)
- Gratificação Média Por Superintendêcia
![Arquitetura Background RFB](exemple/gratificacao_media_por_superintendencia.png)
- Gratificação Média Por Diretoria
![Arquitetura Background RFB](exemple/gratificacao_media_por_diretoria.png)
- Gratificação Média Por Cargo
![Arquitetura Background RFB](exemple/gratificacao_media_por_cargo.png)
