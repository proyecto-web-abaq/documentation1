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

# Railway asigna el puerto dinámicamente en $PORT
CMD ["sh", "-c", "sed -i \"s/80;/${PORT:-8080};/g\" /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"]
