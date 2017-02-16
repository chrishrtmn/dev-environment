# Color output
alias ls='ls -G'
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Load git branch prompt
source ~/.git-prompt.sh
PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(__git_ps1)\[\033[00m\] $ "

# Autocomplete git
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Variable colors
NONE='\033[0m'
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'

DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

# Aliases - Commands
alias bash-open='sublime ~/.bash_profile'
alias bash-source='source ~/.bash_profile && echo -e "${YELLOW}~/.bash_profile${GREEN} has been sourced successfully.${NONE}"'

# PATH
export PATH="$HOME/.composer/vendor/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# PATH - Use MAMP version of PHP fallback
# export PATH="/Applications/MAMP/bin/php/php5.4.30/bin:$PATH"



# Add Homebrew `/usr/local/bin` and User `~/bin` to the `$PATH`
#PATH=/usr/local/bin:$PATH
#PATH=$HOME/bin:$PATH
#export PATH

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.

#for file in ~/.{bash_paths,bash_prompt,bash_aliases}; do
#  [ -r "$file" ] && source "$file"
#done
#unset file
