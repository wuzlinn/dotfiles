export HISTCONTROL=ignoreboth:erasedups
export LANG="en_US.UTF-8"

# MacOS
if [ $(uname -s) == "Darwin" ]; then
        # setup homebrew
        if command -v /opt/homebrew/bin/brew > /dev/null; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
                [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && \
                        . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

                # Added by OrbStack: command-line tools and integration
                # This won't be added again if you remove it.
                source ~/.orbstack/shell/init.bash 2>/dev/null || :
        fi

        export CLICOLOR=1
        export GREP_OPTIONS='--color=always'
        export GREP_COLOR='1;32;40'
        export BASH_SILENCE_DEPRECATION_WARNING=1
fi

# WSL
if [[ "$(uname -r)" =~ WSL ]]; then
        alias open='explorer.exe'
fi

# https://jeroenjanssens.com/navigate/
export MARKPATH=$HOME/.marks
function j {
        cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
        mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
        rm -i "$MARKPATH/$1"
}
function marks {
        ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
_completemarks() {
        local curw=${COMP_WORDS[COMP_CWORD]}
        local wordlist=$(find $MARKPATH -type l -printf "%f\n")
        COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
        return 0
}
complete -F _completemarks j unmark
