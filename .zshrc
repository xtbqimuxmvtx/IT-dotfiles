#Environment variables:
export ZSH_MYCONF=$HOME/.config/zsh/.zshrc
#####################################
## Aliases
alias vim=nvim 
alias vic=vi 
alias vi=vim
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
  bindkey -M vicmd "k" down-line-or-history
  bindkey -M vicmd "j" up-line-or-history
  bindkey -M vicmd "l" forward-char
  bindkey -M vicmd "i" vi-insert
  bindkey -M vicmd "I" vi-insert-bol
#  bindkey -M vicmd "k" vi-repeat-search
  bindkey -M vicmd "K" vi-rev-repeat-search
# bindkey -M vicmd "0" beginning-of-line
# bindkey -M vicmd "$" end-of-line
  bindkey -M vicmd "e" vi-forward-word-end
  bindkey -M vicmd "E" vi-forward-blank-word-end

# Sane Undo, Redo, Backspace, Delete.
  bindkey -M vicmd "u" undo
  bindkey -M vicmd "U" redo
  bindkey -M vicmd "^?" backward-delete-char
  bindkey -M vicmd "^[[3~" delete-char

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
