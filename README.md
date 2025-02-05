# LLMs Prompting from Manual to Automatic

This repository provides a tutorial on transitioning from manual to automatic prompting techniques for Large Language Models (LLMs). Follow the steps below to set up your environment and get started.

## Getting Started

### Setting Up the Environment

**Important Note for Windows Users:** Open your repository in VS Code. If you haven't already, create and configure a Dev Container. Refer to the [Quick Start: Open an Existing Folder in a Container](https://code.visualstudio.com/docs/devcontainers/containers#_quick-start-open-an-existing-folder-in-a-container) guide for detailed instructions. Once done, ensure you reopen your project in the Dev Container before proceeding with the remaining setup steps. Wait for the container to fully initialize and load.

#### Option 1: Automated Setup (Recommended)
Run the following command to automatically set up a virtual environment and install dependencies:
```bash
bash scripts/create_venv.sh
```

**Note**: This script will:
1. Download a standalone Python executable (if needed).
2. Create a virtual environment.
3. Install all required dependencies.

You may be prompted to enter your password to run the script with `sudo`. This is necessary for installing system-level dependencies.

#### Option 2: Manual Setup
If you prefer to use an existing Python installation, follow these steps:

1. Create a virtual environment:
    ```bash
    python -m venv .venv
    ```
2. Activate the virtual environment:
    ```bash
    source .venv/bin/activate
    ```
3. Install the required dependencies:
    ```bash
    pip install -r requirements.txt
    ```

### Running the Tutorial
Once the environment is set up, you can start exploring the tutorial materials. Refer to the `notebooks/` directory for detailed instructions and examples.

---

Happy prompting! 🚀
