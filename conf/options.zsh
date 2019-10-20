#b
#-------------------------------
#                    ZSH OPTIONS
#-------------------------------

# Directories
setopt chase_links          # Treat ../ as Going to the parent directory
# Completion
setopt auto_list            # Automatically List choices on ambiguous completion
setopt auto_menu            # Automatically use menu completion on the second <tab>
setopt auto_param_slash     # Automatically add a / when Completing a directory
setopt auto_remove_slash    # Remove a slash if it completes 'wrong'
setopt glob_complete        # When the current word has a glob pattern, do not insert all the words resulting from the expression, but cycle through them
setopt complete_in_word     # Complete from both ends
setopt hash_list_all        # Hash entire command path first, before command completion
    setopt list_packed      # List with different Widths, to pack as many options in.
setopt list_ambiguous
setopt list_types           # Show the type of file when listing them as completions
    setopt rec_exact        # In Completion, recognize exact matches even if they are ambiguous
# Expansion and Globbing
setopt bad_pattern          # If a pattern for filename generation is badly formed, print an error
    setopt extended_glob        # Treat #,~ and ^ Characters as part of patterns for filename generation
setopt glob                 # Perform filename generation
    setopt glob_dots            # Do not require a leading . in a filename to be matched explicitly
setopt mark_dirs            # Append a trailing / to all directory names resulting from filename generation
setopt multibyte            # Respect Multibyte characters when found in strings
setopt nomatch              # Print an error if filename expansion returns no result
# History
setopt append_history           # Append to history instead of replacing the file
setopt extended_history         # Save each command's beginning timestamp and duration to the history file
setopt hist_expire_dups_first   # If the internal histroy needs to be trimmed, this option will cause the oldest history duplicate to be lost
setopt hist_fcntl_lock          # Lock the history file using modern locking
setopt inc_append_history       # Save to the history file incrementally
setopt prompt_subst         # Prompt Substitution
# Initalisation
    setopt all_export       # Automatically export parameters that are defined
# Input/Output
setopt aliases              # Expand Aliases
setopt clobber              # Allows for >, >>, <, << redirection to create and append files.
setopt correct              # Try to correct the spelling of commands
unsetopt flow_control       # Disable Flow Control
setopt interactive_comments # Allows comments even in interactive shells
setopt hash_cmds            # Note the location of each command the first time it's executed
setopt hash_dirs            # when a command name is hashed, hash the directory containing it, and directories that occur before
setopt print_exit_value     # Print the exit value of programs with non zero exit status
setopt share_history
# Job control
setopt check_jobs           # Report the status of background and suspended jobs before exiting a shell with job control
setopt notify               # Report the stateus of background jobs immeadiately

#-------------------------------
#                    ZSH MODULES
#-------------------------------
zmodload zsh/complete       # Allows for command completion
zmodload zsh/deltochar      # Adds 2 ZLE functions, delete-to-char and zap-to-char
zmodload zsh/zle            # Allows the use of the Zsh Line Editor
zmodload zsh/zpty           # ZPTY Module
zmodload zsh/zleparameter   # Access to internals of the ZLE
zmodload zsh/zutil          # Gives some zstyle options

#-------------------------------
#              ZSH FUNCTION PATH
#-------------------------------
fpath=("$HOME/config/zsh/plugins/completions/src" /usr/share/zsh/site-functions $fpath)
#for ifile in $fpath/*; autoload -Uz $ifile;
autoload -Uz compinit promptinit colors
autoload -Uz zmv zed fast-highlight add-zle-hook-widget predict-on
autoload -Uz edit-command-line vcs_info select-word-style
compinit
promptinit
colors
select-word-style bash;

zle -N edit-command-line


#-----------------------------------------
#   Keybindings
#-----------------------------------------
bindkey -e
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -C most-recent-file menu-complete _generic
zle -N edit-command-line
zle -N autosuggest-fetch
zle -N history-substring-search-up
zle -N history-substring-search-down

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[5~' history-search-backward
bindkey '^[[6~' history-search-forward
bindkey '^[^I'      reverse-menu-complete
bindkey '^[[1;5D'   backward-word
bindkey '^[[1;5C'   forward-word
bindkey '^H'     backward-kill-word
bindkey '^[[3^'  kill-word
bindkey '^[[H' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[4h'   overwrite-mode          # Insert
bindkey '^[[P'   delete-char             # Del
bindkey '^R'      history-incremental-pattern-search-backward 

