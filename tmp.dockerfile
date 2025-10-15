FROM python:3.12-slim

WORKDIR /usr/src/app

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

COPY --from=node:24-slim /usr/local/bin/node /usr/local/bin/node
COPY --from=node:24-slim /usr/local/lib/node_modules /usr/local/lib/node_modules

# シンボリックリンクを作成
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm && \
    ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://install.duckdb.org | sh
ENV PATH="/root/.duckdb/cli/latest:$PATH"


COPY pyproject.toml .
COPY uv.lock .

RUN uv venv --clear && \
    . .venv/bin/activate && \
    uv sync --frozen

