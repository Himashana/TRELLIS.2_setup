# !/bin/bash

# This script sets up the TRELLIS.2 environment, including cloning the repository, installing Miniconda, setting up the environment, and installing necessary dependencies.

# Get the destination directory from the parameter passed to the script, or throw an error if it's not provided
if [ -z "$1" ]; then
  echo "Error: No destination directory provided. Please provide a destination directory as a parameter."
  exit 1
fi

DEST_DIR="$1"

# Navigate to the destination directory
cd "$DEST_DIR"

# Clone the TRELLIS.2 repository
git clone -b main https://github.com/microsoft/TRELLIS.2.git --recursive
cd TRELLIS.2

# Install Miniconda and initialize it
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3
$HOME/miniconda3/bin/conda init bash

# Install Hugging Face CLI and authenticate
curl -LsSf https://hf.co/cli/install.sh | bash
# Re-source the .bashrc to ensure conda and hf commands are available
source ~/.bashrc
hf auth login

# Set up the TRELLIS.2 environment with the specified options
. ./setup.sh --new-env --basic --flash-attn --nvdiffrast --nvdiffrec --cumesh --o-voxel --flexgemm

# Activate the TRELLIS.2 environment
conda activate trellis2

# Install ipykernel and set up the Jupyter kernel for TRELLIS.2
conda install ipykernel -y
python -m ipykernel install --user --name=trellis2 --display-name="Python (TRELLIS.2)"

# Modify the BiRefNet.py file to set low_cpu_mem_usage to False to avoid Out of Memory errors during inference
# sed -i 's/trust_remote_code=True/trust_remote_code=True, low_cpu_mem_usage=False/g' /TRELLIS.2/trellis2/pipelines/rembg/BiRefNet.py

# Install the required versions of transformers and flash-attention for TRELLIS.2
pip install "transformers<5.0.0"
pip install https://github.com/Dao-AILab/flash-attention/releases/download/v2.8.3/flash_attn-2.8.3+cu12torch2.5cxx11abiFALSE-cp310-cp310-linux_x86_64.whl

GRADIO_SERVER_NAME="0.0.0.0" python app.py