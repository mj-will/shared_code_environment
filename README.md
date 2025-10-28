# shared_code_environment

Github CI to build a shared code environment for UK LISA work and documentation related to this.

## Features

This repository includes:

- **Docker Image**: A Python 3.11 Docker image with `uv` package manager pre-installed
- **GitHub CI Workflow**: Automated Docker image build on push/PR to main and develop branches
- **Python Project Configuration**: Basic `pyproject.toml` setup for Python projects

## Building the Docker Image

### Locally

```bash
docker build -t shared-code-environment .
docker run --rm shared-code-environment
```

### Via GitHub Actions

The Docker image is automatically built by GitHub Actions on:
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop` branches
- Manual workflow dispatch

## Using uv for Package Management

The Docker image includes [uv](https://github.com/astral-sh/uv), a fast Python package installer and resolver. To add dependencies:

1. Add dependencies to `pyproject.toml`:
   ```toml
   dependencies = ["requests", "numpy"]
   ```

2. Update the Dockerfile to install dependencies:
   ```dockerfile
   RUN uv pip install --system .
   ```

## Development

To extend this project with your own Python code:

1. Add your Python code to a `src/` directory
2. Update `pyproject.toml` with your dependencies
3. Modify the Dockerfile to install your package
4. Push changes to trigger the CI build

