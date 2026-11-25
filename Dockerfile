FROM python:3.12-slim AS builder

WORKDIR /app

# Instalar uv para manejar dependencias rápidamente
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Copiar archivos de configuración del proyecto e instalar dependencias
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

# Copiar el código fuente y construir el sitio estático con Zensical
COPY . .
RUN uv run zensical build --clean

FROM nginx:alpine

COPY --from=builder /app/site /usr/share/nginx/html

ENV PORT=8080
EXPOSE 8080

# Railway asigna el puerto dinámicamente en $PORT
CMD ["sh", "-c", "sed -i \"s/80;/${PORT:-8080};/g\" /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"]
