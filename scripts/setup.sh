#!/usr/bin/env sh

current_file="${BASH_SOURCE[0]:-${(%):-%x}}"
scripts_dir="$(realpath "$(dirname "$current_file")")"

source "${scripts_dir}/namespaces.sh"

# Install the uv package/environment manager
echo "${BOLDFONT}🛠️  Installing uv...${NORMALFONT}"
curl -LsSf https://astral.sh/uv/install.sh | sh
echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bashrc
echo 'eval "$(uvx --generate-shell-completion bash)"' >> ~/.bashrc
source "${HOME}/.local/bin/env"
uv self update

# Create and initialize the virtual environment
if ! [[ -d "${VENV_DIR}" ]]; then
    [[ -x "$(command -v deactivate)" ]] && deactivate

    # 1. Load the required system modules
    module --force purge
    if [[ ! (-f "${scripts_dir}/modules.sh") ]]; then
        echo "Cannot find \`$scripts_dir/modules.sh\`; its existence is required."
        return 1
    fi
    source "${scripts_dir}/modules.sh"

    # 2. Create an virtual environment referencing the
    # system modules already loaded       
    uv venv --system-site-packages "${VENV_DIR}"
    ln -s "${VENV_DIR}" "${PROJECT_DIR}/.venv"

    # 3. Activate the freshly created virtual environment
    if [[ ! (-f "${VENV_DIR}/bin/activate") ]]; then
        echo "Something seems to be wrong with the \`venv\` at \`$VENV_DIR\`." \
             "Please delete it (\`nice rm -rf ${VENV_DIR@Q}\`) and" \
             "execute \`nice bash ${scripts_dir@Q}/setup.sh\`" \
             "on a login node to re-create the \`venv\`."
        return 1
    fi
    activate_environment

    # 4. Install external dependencies within the virtual environment
    if [[ ! (-f "${PROJECT_DIR}/requirements.txt") ]]; then
        echo "Cannot find \`$PROJECT_DIR/requirements.txt\`;" \
             "its existence is required."
        deactivate
        return 1
    fi
    echo "${BOLDFONT}🛠️  Installing dependencies...${NORMALFONT}"
    if [[ ! (-f "${PROJECT_DIR}/pyproject.toml") ]]; then
        uv init --bare .
    fi
    uv add --active -r "$PROJECT_DIR"/requirements.txt

    # 5. Clean up and exit
    deactivate
else
    echo "\`venv\` is already set up at \`$VENV_DIR\`. Please" \
         "delete it (\`nice rm -rf ${VENV_DIR@Q}\`) to force a re-generation."
fi

