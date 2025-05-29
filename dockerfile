FROM python:3.10-slim

USER root

# Instala tesseract y sus idiomas
RUN apt-get update && \
    apt-get install -y tesseract-ocr tesseract-ocr-spa tesseract-ocr-eng && \
    rm -rf /var/lib/apt/lists/*

RUN apk update \
    && apk add --no-cache bash \
    && rm -rf /var/cache/apk/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 5000
CMD ["python", "app.py"]

# Ajusta permisos de usuario
RUN chown -R node:node /home/node

# Cambia de nuevo al usuario node para ejecutar n8n
USER node
