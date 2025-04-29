#!/usr/bin/env sh

# Project folder
current_file="${BASH_SOURCE[0]:-${(%):-%x}}"
scripts_dir="$(realpath "$(dirname "$current_file")")"

# Deactivate current environment
deactivate

# Remove the virtualenv folder and associated soft-links
echo -e "🧹 Cleaning environment at: \033[;34m${VENV_DIR}/\033[0m"
unlink "${PROJECT_DIR}/.venv"
rm --recursive "${VENV_DIR}"

# Remove soft-link the virtualenv kernel
unlink "${KERNEL_SPECS_DIR}/${KERNEL_NAME}"

echo -e "\033[1;32m ✓\033[0m Environment '\033[1;37m${KERNEL_NAME}\033[0m' successfully removed."
