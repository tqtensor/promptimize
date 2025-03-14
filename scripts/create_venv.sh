#!/bin/bash

# Change to the directory where the script was triggered
cd "$(pwd)"

PREFIX_URL="https://github.com/indygreg/python-build-standalone/releases/download/20240909/"

# Prompt for Python version
read -p "Enter the desired Python version (e.g., 3.11): " PYTHON_VERSION

# Determine the full version based on user input
case "$PYTHON_VERSION" in
3.12) VERSION="3.12.6" ;;
3.11) VERSION="3.11.10" ;;
3.10) VERSION="3.10.15" ;;
3.9) VERSION="3.9.20" ;;
3.8) VERSION="3.8.20" ;;
*) echo "Error: Unsupported Python version. Please enter 3.8 to 3.12." && exit 1 ;;
esac

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
    poetry install --without dl
else
    poetry init
fi
