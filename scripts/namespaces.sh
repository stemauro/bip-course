# User defined names
kernel_name="bip"

# Project folder
current_file="${BASH_SOURCE[0]:-${(%):-%x}}"
scripts_dir="$(realpath "$(dirname "$current_file")")"
export PROJECT_DIR="$(realpath "$(dirname "$scripts_dir")")"

source "${scripts_dir}/secrets.sh"

# Kernel
export KERNEL_NAME="$(echo "${kernel_name}" | awk '{print tolower($0)}')"
export KERNEL_SPECS_PREFIX="${HOME}/.local"
export KERNEL_SPECS_DIR="${KERNEL_SPECS_PREFIX}/share/jupyter/kernels"
export KERNEL_VENVS_DIR="${PROJECT}/${USER}/jupyter/kernels"

# Virtual environment
export VENV_DIR="${KERNEL_VENVS_DIR}/${KERNEL_NAME}"
export VENV_KERNELS_DIR="${VENV_DIR}/share/jupyter/kernels"

# Style
BOLDFONT=$(tput bold)
NORMALFONT=$(tput sgr0)

# Utility functions
activate_environment () {
    source "${VENV_DIR}/bin/activate"
    pyv="$(python -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')"
    export PYTHONPATH="${VENV_DIR}/lib/python${pyv}/site-packages:${PYTHONPATH}"
}
