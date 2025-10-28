# Use Python 3.12 slim image as base
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install git (required for git+ dependencies when installing packages)
RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Copy project files
COPY pyproject.toml ./
COPY README.md ./

# Verify uv is installed
RUN uv --version

# Make sure pip, setuptools and wheel are current and install Cython into the global environment
RUN uv pip install --upgrade pip setuptools wheel \
 && uv pip install --system cython


# Install dependencies from pyproject.toml  
# Set GIT_SSL_NO_VERIFY as a workaround for SSL certificate verification issues
ENV GIT_SSL_NO_VERIFY=1
RUN uv pip install --system .
ENV GIT_SSL_NO_VERIFY=

# Set the default command to show Python and uv versions
CMD ["sh", "-c", "python --version && uv --version"]
