# Use Python 3.12 slim image as base
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install git (required for git+ dependencies)
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Copy project files
COPY pyproject.toml ./
COPY README.md ./

# Verify uv is installed
RUN uv --version

# Set the default command to show Python and uv versions
CMD ["sh", "-c", "python --version && uv --version"]
