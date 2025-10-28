# Use Python 3.11 slim image as base
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Copy project files
COPY pyproject.toml ./
COPY README.md ./

# Create a requirements file for demonstration
RUN echo "# Add your dependencies here" > requirements.txt

# Install any dependencies (currently empty, but ready for use)
# RUN uv pip install -r requirements.txt

# Verify uv is installed
RUN uv --version

# Set the default command to show Python and uv versions
CMD ["sh", "-c", "python --version && uv --version"]
