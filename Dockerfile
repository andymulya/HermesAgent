FROM node:20-slim

# Install dependency dasar
RUN apt-get update && apt-get install -y \
    curl \
    git \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Hermes Agent & 9router secara global
RUN curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash || true
RUN npm install -g 9router

# Salin script startup
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

EXPOSE 10000

ENTRYPOINT ["/app/entrypoint.sh"]
