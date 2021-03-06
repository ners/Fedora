#!/bin/zsh

eval "$(direnv hook zsh)"

function open() { nohup xdg-open &>/dev/null $* & disown }

alias makevars='gmake -pn | grep -A1 "^# makefile"| grep -v "^#\|^--" | sort | uniq'
alias ls='ls -A --color=auto'
alias diff='diff --color=auto'

export PATH="$PATH:$HOME/.local/bin"

function peval()
{
    echo -e "\e[7m$1\e[0m"
    eval "$1"
    return $?
}

function gitr()
{
    local params="${@:1}"
    if [ -z "$params" ]; then
        echo 'Missing command!'
        return
    fi
    find * -name .git | while read line; do
        local repo=$(dirname $line)
        local git="git -C $repo"
        local evalCommand=''
        local echoCommand=''
        if [ $params = 'mastersync' ]; then
            evalCommand="$git fetch && $git merge --no-edit origin/master"
        elif [ $params = 'status' ]; then
            if [ ! -z "$(eval $git status --branch --porcelain | egrep '( \[behind| \[ahead|^ M )')" ]; then                                                             evalCommand="$git status"
            fi
        elif [ $params = 'diff' ]; then
            if [ ! -z "$(eval $git diff)" ]; then
                evalCommand="$git diff"
            fi
        else
            evalCommand="$git $params"
        fi
        if [ -z "$evalCommand" ]; then continue; fi
        if [ -z "$echoCommand" ]; then echoCommand=evalCommand; fi
        peval "$evalCommand" || return $?
    done
}

function shake()
{
	mkdir -p .shake
	stack ghc -- -o .shake/shake -odir .shake -hidir .shake Shake.hs && \
	.shake/shake --progress --color --report=.shake/report.html $@
}
