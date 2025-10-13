FROM python:3.12-slim

WORKDIR /usr/src/app

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN uv venv --clear && \
    . .venv/bin/activate && \
    uv sync --frozen

RUN curl https://install.duckdb.org | sh
ENV PATH="/root/.duckdb/cli/latest:$PATH"
