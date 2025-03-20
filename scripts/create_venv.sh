#!/bin/bash

# Change to the directory where the script was triggered
cd "$(pwd)"

PREFIX_URL="https://github.com/indygreg/python-build-standalone/releases/download/20240909/"

# Set Python version directly to 3.11
PYTHON_VERSION="3.11"
VERSION="3.11.10"

if [[ -d "/usr/local/python${VERSION}" ]]; then
    echo "Python version ${VERSION} already exists. Skipping installation."
else
    # Detect OS
    if [[ "$(uname -s)" == "Darwin" && "$(uname -m)" == "arm64" ]]; then
        # Download Python for Apple Silicon
        curl -Lo python${VERSION}.tar.gz "${PREFIX_URL}cpython-${VERSION}+20240909-aarch64-apple-darwin-install_only.tar.gz"
    elif [[ "$(uname -s)" == "Linux" ]]; then
        # Download Python for Linux
        curl -Lo python${VERSION}.tar.gz "${PREFIX_URL}cpython-${VERSION}+20240909-x86_64-unknown-linux-gnu-install_only.tar.gz"
    fi

    # Extract Python binary
    tar -xzf python${VERSION}.tar.gz

    # Rename Python binary
    sudo mv python /usr/local/python${VERSION}

    # Remove tarball
    rm python${VERSION}.tar.gz
fi

# Create Python virtual environment
/usr/local/python${VERSION}/bin/python3 -m venv .venv

# Activate the virtual environment
source .venv/bin/activate

# Install Poetry
pip install -U pip
pip install -U poetry

if [[ -f "pyproject.toml" ]]; then
    poetry install --without dl --with dev
else
    poetry init
fi
