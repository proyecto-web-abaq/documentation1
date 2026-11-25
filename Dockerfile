FROM python:3.12-slim AS builder

WORKDIR /app

# Instalar uv para manejar dependencias rápidamente
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Instalar zensical directamente (pyproject.toml y uv.lock no están en el repo)
RUN uv pip install --system --no-cache "zensical>=0.0.57"

# Copiar el código fuente y construir el sitio estático con Zensical
COPY . .
RUN zensical build --clean

FROM nginx:alpine

COPY --from=builder /app/site /usr/share/nginx/html

ENV PORT=8080
EXPOSE 8080

RUN mkdir -p /etc/nginx/templates && \
    printf 'server {\n    listen 0.0.0.0:${PORT};\n    root /usr/share/nginx/html;\n    index index.html;\n\n    location / {\n        try_files $uri $uri/ =404;\n    }\n}\n' > /etc/nginx/templates/default.conf.template
