# Usar a imagem base do Ubuntu
FROM ubuntu:20.04

# Configurar argumentos para evitar prompts interativos
ARG DEBIAN_FRONTEND=noninteractive

# Atualizar pacotes e instalar dependências
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Criar o diretório de trabalho
WORKDIR /app

# Copiar os arquivos de dependências para o container
COPY requirements.txt /app/requirements.txt

# Instalar as dependências do Python
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# Copiar o código da aplicação para o container
COPY . /app

# Expor a porta que o FastAPI usará
EXPOSE 8000

# Comando para iniciar o servidor FastAPI
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]