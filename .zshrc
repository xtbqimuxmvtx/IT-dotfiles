#Environment variables:
export ZSH_MYCONF=$HOME/.config/zsh/.zshrc
#####################################
## Aliases
alias vim=nvim 
alias vic=vi 
alias vi=\vim
alias v=nvim
alias p='sudo pacman'
alias Ss='sudo systemctl'
alias ss='sudo systemctl'
alias light='brightnessctl -m s'
alias bright='brightnessctl -q s 100%'
alias cpugperf='sudo cpupower frequency-set -g performance'
alias cpuperf='cpugperf'
alias cpugpower='sudo cpupower frequency-set -g powersave'
alias cpubalanced='cpugpower'
alias cpuPower='cpugpower'
alias cpupowersave='cpugpower'
alias cpuGet='cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor'
alias cpupower-get='cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor'
alias energyperf='sudo cpupower set -e performance'
alias energypowersave='sudo cpupower set -e power'
alias energypower='energypowersave'
#####################################
## Configuration
# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
#####################################
# Basic auto/tab completed From Luke's video (https://youtu.be/eLEo4OQ-cuQ)
#####################################
autoload -U compinit
zstyle ':completion*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files
#####################################
## edit-command-line mode
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
#####################################
# Vi Mode BINDS (bunnyfly, colemak forums)
#####################################
bindkey -v
export KEYTIMEOUT=2
# Colemak.
  bindkey -M vicmd "h" backward-char
  bindkey -M vicmd "K" down-line-or-history
  bindkey -M vicmd "J" up-line-or-history
  bindkey -M vicmd "l" forward-char
  bindkey -M vicmd "i" vi-insert
  bindkey -M vicmd "I" vi-insert-bol
#  bindkey -M vicmd "k" vi-repeat-search
  bindkey -M vicmd "K" vi-rev-repeat-search
  bindkey -M vicmd "e" vi-forward-word-end
  bindkey -M vicmd "E" vi-forward-blank-word-end

# Sane Undo, Redo, Backspace, Delete.
  bindkey -M vicmd "u" undo
  bindkey -M vicmd "U" redo
  bindkey -M vicmd "^?" backward-delete-char
  bindkey -M vicmd "^[[3~" delete-char

# Visual mode (J)
  bindkey -M visual "h" backward-char
  bindkey -M visual "k" down-line-or-history
  bindkey -M visual "j" up-line-or-history
  bindkey -M visual "l" forward-char

# Keep ctrl+r searching
#  bindkey -M viins '^R' history-incremental-pattern-search-forward
#  bindkey -M viins '^r' history-incremental-pattern-search-backward # End bunnyfly config

## Luke Smith's in menuselect (!ls ; then tab):
### Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'k' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
###
#####################################
## Attempt unbind all arrow keys:
#####################################
bindkey -M main "^[OA" vi-forward-char
bindkey -M main "^[OB" vi-forward-char
bindkey -M main "^[OC" vi-forward-char
bindkey -M main "^[OD" vi-forward-char
bindkey -M main '^[[D' vi-forward-char
bindkey -M main '^[[A' vi-forward-char
bindkey -M main '^[[B' vi-forward-char
bindkey -M main '^[[C' vi-forward-char
bindkey -M vicmd '^[[D' vi-forward-char
bindkey -M vicmd '^[[A' vi-forward-char
bindkey -M vicmd '^[[B' vi-forward-char
bindkey -M vicmd '^[[C' vi-forward-char
bindkey -M viopp '^[[C' vi-forward-char
bindkey -M viopp '^[[A' vi-forward-char
bindkey -M viopp '^[[B' vi-forward-char
bindkey -M viopp '^[[D' vi-forward-char
bindkey -M isearch '^[[D' vi-forward-char
bindkey -M isearch '^[[A' vi-forward-char
bindkey -M isearch '^[[C' vi-forward-char
bindkey -M isearch '^[[B' vi-forward-char
bindkey -M visual '^[[A' vi-forward-char
bindkey -M visual '^[[B' vi-forward-char
bindkey -M visual '^[[C' vi-forward-char
bindkey -M visual '^[[D' vi-forward-char
bindkey -M viins "^[OA" vi-forward-char
bindkey -M viins "^[OB" vi-forward-char
bindkey -M viins "^[OC" vi-forward-char
bindkey -M viins "^[OD" vi-forward-char
bindkey -M viins '^[[A' vi-forward-char
bindkey -M viins '^[[B' vi-forward-char
bindkey -M viins '^[[C' vi-forward-char
bindkey -M viins '^[[D' vi-forward-char
# bindkey '^[[D' vi-forward-char
# bindkey '^[[A' vi-forward-char
# bindkey '^[[B' vi-forward-char
# bindkey '^[[C' vi-forward-char
# bindkey "^[[1;5C" vi-forward-char
# bindkey "^[[1;5D" vi-forward-char
# bindkey -M main "^[OA" vi-forward-char
bindkey -M menuselect "^[OA" vi-forward-char
bindkey -M menuselect "^[OB" vi-forward-char
bindkey -M menuselect "^[OC" vi-forward-char
bindkey -M menuselect "^[OD" vi-forward-char
bindkey -M menuselect '^[[D' vi-forward-char
bindkey -M menuselect '^[[A' vi-forward-char
bindkey -M menuselect '^[[B' vi-forward-char
bindkey -M menuselect '^[[C' vi-forward-char
bindkey -M command "^[OA" vi-forward-char
bindkey -M command "^[OB" vi-forward-char
bindkey -M command "^[OC" vi-forward-char
bindkey -M command "^[OD" vi-forward-char
bindkey -M command '^[[D' vi-forward-char
bindkey -M command '^[[A' vi-forward-char
bindkey -M command '^[[B' vi-forward-char
bindkey -M command '^[[C' vi-forward-char
bindkey -M emacs "^[OA" vi-forward-char
bindkey -M emacs "^[OB" vi-forward-char
bindkey -M emacs "^[OC" vi-forward-char
bindkey -M emacs "^[OD" vi-forward-char
bindkey -M emacs '^[[D' vi-forward-char
bindkey -M emacs '^[[A' vi-forward-char
bindkey -M emacs '^[[B' vi-forward-char
bindkey -M emacs '^[[C' vi-forward-char
# bindkey -r vicmd '^[[D'
# bindkey -r vicmd '^[[A'
# bindkey -r vicmd '^[[B'
# bindkey -r vicmd '^[[C'
# bindkey -r viopp '^[[C'
# bindkey -r viopp '^[[A'
# bindkey -r viopp '^[[B'
# bindkey -r viopp '^[[D'
# bindkey -r isearch '^[[D'
# bindkey -r isearch '^[[A'
# bindkey -r isearch '^[[C'
# bindkey -r isearch '^[[B'
# bindkey -r visual '^[[B' 
# bindkey -r visual '^[[A'
# bindkey -r visual '^[[C'
# bindkey -r visual '^[[D'
#####################################
# Cursor context for Normal and Insert modes
# from Luke Smith:
# https://youtu.be/eLEo4OQ-cuQ
#####################################
# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

#####################################
## zsh-history-substring-search binds:
# https://github.com/zsh-users/zsh-history-substring-search
bindkey -M vicmd 'j' history-substring-search-up
bindkey -M vicmd 'k' history-substring-search-down
#####################################
# Plugins:
# Syntax highlighting & History subsearch (similar to fish)
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh > /dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh > /dev/null
