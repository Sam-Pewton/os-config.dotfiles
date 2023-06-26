#
# ~/.bashrc
#

# Attach tmux session
# [ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit; }

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/sam/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sam/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/sam/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sam/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

parse_conda_env() {
    if [ ! -z "$CONDA_DEFAULT_ENV" ]
    then
        echo "<$(basename "$CONDA_DEFAULT_ENV")> "
    fi
}

YELLOW="\[\033[0;33m\]"
WHITE="\[\e[00m\]"

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}
export OLD_PS1="\u@\h \[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "
export PS1="\[\e[32m\]\W \[\e[91m\]\$(parse_git_branch)$YELLOW>$WHITE "

# Run process closing script from 'linux_startup_scripts' on start of user
# login session.
function login_session_closer() {
	# Get the login time for the current user.
	local LOGIN_TIME=$(whoami | w -h | awk '{print $3}')
	local MIN_LOGIN=$(echo "$LOGIN_TIME" | cut -c4,5 )
	local MIN_NOW=$(date +"%M")
	local HOUR_LOGIN=$(echo "$LOGIN_TIME" |  cut -c1,2 )
	local HOUR_NOW=$(date +"%H")


	local MIN_DIFF=$( expr "$MIN_NOW" - "$MIN_LOGIN" )
	local HOUR_DIFF=$( expr "$HOUR_NOW" - "$HOUR_LOGIN" )

		# CASE 1 - same hour, minute difference of less than or equal to 2
		#          and greater than or equal to 0
		if [[ "$HOUR_DIFF" -eq 0 && "$MIN_DIFF" -le 2 && "$MIN_DIFF" -ge 0 ]]; then
			source /home/sam/Repositories/linux_startup_scripts/close_processes.sh
			# CASE 2 - user logged in at 59 past the hour..
			#          hour difference of 1, minute diff either equal to -58 or -59
		elif [[ "$HOUR_DIFF" -eq 1 && "$MIN_DIFF" -ge -59 && "$MIN_DIFF" -le -58 ]]; then
			source /home/sam/Repositories/linux_startup_scripts/close_processes.sh
		fi
	}

# Execute login session closer function
#login_session_closer

# Run neofetch on opening terminal
#neofetch
. "$HOME/.cargo/env"

unclutter &


[ -f "/home/sam/.ghcup/env" ] && source "/home/sam/.ghcup/env" # ghcup-env