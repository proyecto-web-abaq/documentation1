# ABAQ — Manuales

Sitio público con los manuales de usuario de la **Plataforma ABAQ** y del **Organizador ABAQ**, construido con [Zensical](https://zensical.org).

Sitio publicado: <https://proyecto-web-abaq.github.io/documentation1/>

## Contenido

```
docs/
├── index.md                     # Página de inicio
├── guias/
│   ├── index.md                 # Índice de manuales de la plataforma
│   ├── usuario/                 # Manuales para Servicio Social y Voluntario General
│   └── administrador/           # Manual para la Coordinación
└── organizador-abaq/            # Manuales del colaborador y del administrador
```

## Desarrollo local

Requiere Python 3.12 o superior.

```bash
pip install zensical
zensical serve
```

El sitio queda disponible en `http://localhost:8000` con recarga en vivo.

## Build

```bash
zensical build --clean
```

El sitio generado se guarda en `site/`, que no se versiona.

## Publicación

Cada push a la rama `dev` publica el sitio en GitHub Pages mediante `.github/workflows/docs.yml`.

> **Importante:** este repositorio es público. Solo deben vivir aquí los manuales de usuario: Zensical publica cualquier archivo `.md` dentro de `docs/`, aunque no aparezca en el menú.
