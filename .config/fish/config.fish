
set -gx PATH ~/.config/lsp/lua-language-server/bin $PATH
# Setting PATH for Python 3.12
# The original version is saved in /Users/henrymartinez/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$PATH"

# Setting PATH for Python 3.12
# The original version is saved in /Users/henrymartinez/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.12/bin" "$PATH"

eval "$(/opt/homebrew/bin/brew shellenv)"

source "$HOME/.cargo/env.fish"

set script_directory "$HOME/Documents/scripts/"

# Define functions instead of aliases
function pc
    ~/Documents/proxychains-ng/proxychains4 -f /opt/homebrew/etc/proxychains.conf $argv
end

function roblox_project_setup
    $script_directory/roblox_project.sh
end

function yt-dlp
    $script_directory/yt-dlp $argv
end


function argon
    $script_directory/argon $argv
end

fastfetch
