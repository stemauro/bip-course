#!/usr/bin/env sh

current_file="${BASH_SOURCE[0]:-${(%):-%x}}"
scripts_dir="$(realpath "$(dirname "$current_file")")"

# 1. Activate environment which the kernel will be bound to
source "${scripts_dir}/activate.sh"

# 2. Start an ipykernel process inside the environment
kernel_file="${VENV_DIR}/kernel.sh"

echo -e "Setting up the kernel script at: \033[;34m${kernel_file}\033[0m"
echo -e "\033[1;33mwarning\033[0m: If you use multiprocessing, edit this file to remove the srun call from the kernel and run it again."
echo '#!/bin/bash

source '"${scripts_dir}/activate.sh"'

hostname=$(hostname)

if [[ $hostname == *"login"* || $hostname == *"jsfl"* ]]; then
   exec python -m ipykernel "$@"
else
   srun python -m ipykernel "$@"
fi
' > "${kernel_file}"

chmod +x "${kernel_file}"

# 3. Create Jupyter kernel configuration directory and files
python -m ipykernel install --name=${KERNEL_NAME} --prefix "${VENV_DIR}"

# 4. Adjust the kernel.json file
kernel_dir="${VENV_KERNELS_DIR}/${KERNEL_NAME}"
mv "${kernel_dir}/kernel.json" "${kernel_dir}/kernel.json.orig"

echo -e "Patching kernelspec at: \033[;34m${kernel_dir}/kernel.json\033[0m"
echo '{
  "argv": [
    "'"${KERNEL_VENVS_DIR}/${KERNEL_NAME}/kernel.sh"'",
    "-m",
    "ipykernel_launcher",
    "-f",
    "{connection_file}"
  ],
  "display_name": "'"${KERNEL_NAME}"'",
  "language": "python",
  "metadata": {
   "debugger": true
  }
}' > "${kernel_dir}/kernel.json"

# 5. Create link to kernel specs
mkdir -p "${KERNEL_SPECS_DIR}"
cd "${KERNEL_SPECS_DIR}"
ln -s "${kernel_dir}" .

echo -e "\033[1;32m ✓\033[0m New kernel '\033[1;37m${KERNEL_NAME}\033[0m' successfully added to: \033[;34m${KERNEL_SPECS_DIR}/\033[0m"
