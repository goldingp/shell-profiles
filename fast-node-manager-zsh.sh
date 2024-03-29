# Fast Node Manager zsh
if [[ ! ${PATH} = *"${HOME}/Library/Application Support/fnm"* ]]; then
	export PATH="${HOME}/Library/Application Support/fnm:${PATH}"
fi



remove_fnm_multishells() {

  local multishells_path=~/Library/Caches/fnm_multishells
  local num_other_shells=$( ps -o pid=,ppid=,comm= | grep -v -e grep -e $$ | grep zsh | wc -l)
  if [[ ${num_other_shells} -eq 0 && -d ${multishells_path} ]]; then

    local current_shell=""

    if [[ -d ${FNM_MULTISHELL_PATH} ]]; then

      current_shell=${FNM_MULTISHELL_PATH:t}
    fi

    local shells=(${(@f)$(ls -F1 ${multishells_path} | grep @ | tr -d @)})
    local item=""
    for item in ${shells}; do

      if [[ ${current_shell} && ${item} = ${current_shell} ]]; then

        continue
      fi

      if [[ ${multishells_path} && ${item} ]]; then
        rm ${multishells_path}/${item}
      fi
    done
  fi
}

remove_fnm_multishells
unset -f remove_fnm_multishells



add_fnm_multishell() {

  if [[ ! -d ${FNM_MULTISHELL_PATH} ]]; then

    eval "$(fnm env --corepack-enabled --shell zsh --use-on-cd)"
  fi
}

add_fnm_multishell
unset -f add_fnm_multishell
