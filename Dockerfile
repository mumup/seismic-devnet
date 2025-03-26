# Stage 1: Build stage
FROM rust:latest as builder

# 1. Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    jq \
    git \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 2. Explicitly create .cargo directory and set environment variables
ENV CARGO_HOME=/usr/local/cargo
RUN mkdir -p ${CARGO_HOME} && \
    echo 'export CARGO_HOME=/usr/local/cargo' >> /etc/profile.d/cargo.sh

# Set SEISMIC_DIR to global path
ENV SEISMIC_DIR=/usr/local/seismic

# 3. Install sfoundryup
RUN mkdir -p /usr/local/seismic/bin && \
    curl -sSfL "https://raw.githubusercontent.com/SeismicSystems/seismic-foundry/seismic/sfoundryup/sfoundryup" \
    -o /usr/local/seismic/bin/sfoundryup && \
    chmod +x /usr/local/seismic/bin/sfoundryup

# 4. Run installation
RUN /usr/local/seismic/bin/sfoundryup && \
    rm -rf ${CARGO_HOME}/registry/cache/* ${CARGO_HOME}/registry/src/*

# 5. Install Bun
RUN curl -fsSL https://bun.sh/install | bash -s "bun-v1.0.0"

# 6. Clone project
RUN git clone --depth=1 --shallow-submodules --recurse-submodules \
    https://github.com/SeismicSystems/try-devnet.git /app

# 7. Install Node dependencies
WORKDIR /app/packages/cli
RUN /root/.bun/bin/bun install

# ===============================================

# Stage 2: Runtime image
FROM debian:stable-slim

# 1. Install runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libssl3 \
    curl \
    libcurl4 \
    && rm -rf /var/lib/apt/lists/*

# 2. Copy files from build stage (using explicit paths)
COPY --from=builder /usr/local/seismic/bin/ /usr/local/seismic/bin/
COPY --from=builder /usr/local/bin/ssolc /usr/local/bin/ssolc
COPY --from=builder /usr/local/cargo /usr/local/cargo
COPY --from=builder /root/.bun /root/.bun
COPY --from=builder /app /app

# 3. Set environment variables
ENV PATH="/usr/local/seismic/bin:/usr/local/cargo/bin:/root/.bun/bin:${PATH}" \
    CARGO_HOME=/usr/local/cargo

# 4. Verify tools
RUN ls -la /usr/local/seismic/bin && \
    ls -la /usr/local/cargo/bin && \
    which bun

# 5. Cleanup
RUN rm -rf /usr/local/cargo/registry/cache/* /usr/local/cargo/registry/src/*

# 6. Set working directory
WORKDIR /app/packages/cli

# 7. Entrypoint script
COPY --chmod=755 entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]