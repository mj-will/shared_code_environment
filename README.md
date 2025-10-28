# shared_code_environment

Github CI to build a shared code environment for UK LISA work and documentation related to this.

## Features

This repository includes:

- **Docker Image**: A Python 3.12 Docker image with `uv` package manager pre-installed
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

The Docker image includes [uv](https://github.com/astral-sh/uv), a fast Python package installer and resolver, along with git for installing packages from GitHub.

### Installing Dependencies

To install the dependencies defined in `pyproject.toml`, run:

```bash
docker run --rm -v $(pwd):/work -w /work shared-code-environment uv pip install --system .
```

Or, if you need to install dependencies interactively:

```bash
docker run -it --rm shared-code-environment bash
# Inside the container:
uv pip install --system <package-name>
```

### GitHub Dependencies

Some dependencies are installed directly from GitHub repositories:
- `pyEFPE` from https://github.com/gmorras/pyEFPE
- `lisagap` from https://github.com/ollieburke/lisagap

**Note**: The `phenomxpy` repository (https://github.com/imrphenom-dev/phenomxpy) is currently empty and commented out in `pyproject.toml`. It will be enabled once the repository contains installable Python code.

### Adding New Dependencies

1. Add dependencies to `pyproject.toml`:
   ```toml
   dependencies = ["requests", "numpy"]
   ```

2. For GitHub repositories, use the git+ URL format:
   ```toml
   dependencies = ["package @ git+https://github.com/user/repo.git"]
   ```

## Development

To extend this project with your own Python code:

1. Add your Python code to a `src/` directory
2. Update `pyproject.toml` with your dependencies
3. Modify the Dockerfile to install your package
4. Push changes to trigger the CI build

