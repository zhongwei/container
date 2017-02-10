FROM ubuntu
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*
