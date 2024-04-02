#!/usr/bin/env sh

TARGET_NAME="plugins"
TEMPLATE_NAME="p_plugin.lua"

NVIM_CONFIG_DIR="${HOME}/.config/nvim"
PLUG_LIST_FILE="${NVIM_CONFIG_DIR}/lua/plug_list.lua"
TEMPLATE_FILE="${NVIM_CONFIG_DIR}/templates/${TEMPLATE_NAME}"
TARGET_DIR="${NVIM_CONFIG_DIR}/lua/${TARGET_NAME}"

plug_name="${1}"
file_name="${plug_name}.lua"
mod_name="${TARGET_NAME}.${plug_name}"

get_require_code() {
    printf "table.insert(plug_list, require('${mod_name}'))\n\n${1}"
}

format_plug_list() {
    last_line_content=$(sed -e '/^ *$/d' $PLUG_LIST_FILE |
        sed -n '$p')

    echo "${last_line_content}" |
        grep 'return' > /dev/null  #ensure that it's the correct line

    #the command below will create a temp file to store the new content
    sed -n "/${last_line_content}/q;p" "${PLUG_LIST_FILE}" |
        sed -e ':a;/^ *\n*$/{$d;N};/\n$/ba' > "${PLUG_LIST_FILE}.tmp"
    get_require_code "${last_line_content}" >>"${PLUG_LIST_FILE}.tmp" 

    #update file and delete the temp one
    cat "${PLUG_LIST_FILE}.tmp" > "${PLUG_LIST_FILE}"
    rm "${PLUG_LIST_FILE}.tmp"
}

create_file() {
    cp "${TEMPLATE_FILE}" "${TARGET_DIR}/${file_name}"
}

format_plug_list
create_file
