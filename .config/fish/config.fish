
# Setting PATH for Python 3.12
# The original version is saved in /Users/henrymartinez/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$PATH"

# Setting PATH for Python 3.12
# The original version is saved in /Users/henrymartinez/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"
fastfetch --localip-default-route-only false --localip-name-prefix utun6
alias fastfetch="fastfetch --localip-default-route-only false --localip-name-prefix utun6"

set SLIVER_ROOT_DIR "~/sliver"
