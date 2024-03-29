# Homebrew
if [[ ! ${HOMEBREW_CELLAR} ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi
