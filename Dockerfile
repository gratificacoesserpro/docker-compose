FROM postgres:latest

# Copiar o script SQL de inicialização para o container
COPY init.sql /docker-entrypoint-initdb.d/
