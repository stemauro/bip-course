current_file="${BASH_SOURCE[0]:-${(%):-%x}}"
scripts_dir="$(realpath "$(dirname "$current_file")")"

if [[ ! (-f "$scripts_dir/namespaces.sh") ]]; then
    echo "Cannot find \`$scripts_dir/namespaces.sh\`; its existence is required."
    return 1
fi
source "${scripts_dir}/namespaces.sh"

module --force purge
if ! [[ -f "$scripts_dir/modules.sh" ]]; then
    echo "Cannot find \`$scripts_dir/modules.sh\`; its existence is required."
    return 1
fi
source "${scripts_dir}/modules.sh"

if ! [[ -d "$VENV_DIR" ]]; then
    echo "Please manually execute \`nice bash ${scripts_dir@Q}/setup.sh\`" \
         "on a login node to create the \`venv\`."
    return 1
elif ! [[ -f "$VENV_DIR/bin/activate" ]]; then
    echo "Something seems to be wrong with the \`venv\` at \`$VENV_DIR\`." \
         "Please delete it (\`nice rm -rf ${VENV_DIR@Q}\`) and" \
         "execute \`nice bash ${scripts_dir@Q}/setup.sh\`" \
         "on a login node to re-create the \`venv\`."
    return 1
fi
activate_environment