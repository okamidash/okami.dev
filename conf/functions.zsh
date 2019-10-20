#!/bin/zsh


chpwd () {
    if [[ $(ls -1 | wc -l) == 0 ]]; then la; 
        else ls;
    fi
}


man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

precmd () {print -Pn "\e]0;%n@%m: %~\a"}

function print_centered {
     [[ $# == 0 ]] && return 1

     declare -i TERM_COLS="$(tput cols)"
     declare -i str_len="${#1}"
     [[ $str_len -ge $TERM_COLS ]] && {
          echo "$1";
          return 0;
     }

     declare -i filler_len="$(( (TERM_COLS - str_len) / 2 ))"
     [[ $# -ge 2 ]] && ch="${2:0:1}" || ch=" "
     filler=""
     for (( i = 0; i < filler_len; i++ )); do
          filler="${filler}${ch}"
     done

     printf "%s%s%s" "$filler" "$1" "$filler"
     [[ $(( (TERM_COLS - str_len) % 2 )) -ne 0 ]] && printf "%s" "${ch}"
     printf "\n"

     return 0
}

function help {
    printf "%s \n" "Commands:"
    printf "%s \n" "    - ${redb}about${end}"
    printf "%s \n" "    - ${blub}skills${end}"
    printf "%s \n" "    - ${magb}contact${end}"
}

function pcol {
    printf "%s\n" "${red}red${end} ${grn}green${end} ${yel}yellow${end} ${blu}blue${end} ${mag}magneta${end} ${cyn}cyan${end}"
    printf "%s\n" "${redb}redb${end} ${grnb}greenb${end} ${yelb}yellowb${end} ${blub}blueb${end} ${magb}magnetab${end} ${cynb}cyanb${end}"
}
function about {
    printf "%s\n" "${whb}#### About me${end}"
    printf "%s\n" "     I'm Eve. I'm from the UK and 21 years old."
    printf "%s\n" "     You'll find me either tinkering about with Containers, VMs or Hardware."
    printf "%s\n" "     I have a keen interest in running a homelab (much to the dismay of my powerbill)."
    printf "%s\n" "     My employment experience is fairly varied; but most of the time it's been in some form of tech."
    echo " "
    printf "%s\n" "${whb}#### Stats${end}"
    printf "%s\n" "     - Age:         21"
    printf "%s\n" "     - Location:    South UK"
    printf "%s\n" "     - Employed by: ${blub}IBM${end}"
    printf "%s\n" "     - Gender:      Female (MtF)"
    echo " "
    printf "%s\n" "${whb}#### Interests${end}"
    printf "%s\n" "     - Furry Community"
    printf "%s\n" "     - Linux"
    printf "%s\n" "     - DevOps"
    printf "%s\n" "     - Containerisation"
    printf "%s\n" "     - Networking"
}

function skills {
    
    printf "%s\n" "${whb}#### Skills${end}"
    printf "%s\n" "     - Linux Systems Administration"
    printf "%s\n" "     - Automation (Ansible)"
    printf "%s\n" "     - Nginx"
    printf "%s\n" "     - Docker"
    printf "%s\n" "     - Git"
    printf "%s\n" "     - Basic Systems Networking (VLANS, Routing etc)"
    printf "%s\n" "     - Virtualization"
    printf "%s\n" "${whb}#### Languages${end}"
    printf "%s\n" "     - Bash"
    printf "%s\n" "     - Java"
    printf "%s\n" "     - Javascript"
    printf "%s\n" "     - HTML"
    printf "%s\n" "     - Python"
}

function contact {
    OPTIONS="all \nemail \ndiscord \nreddit \ngithub \ntwitter \ntelegram \nkeybase"
    source ~/contacts/$(echo $OPTIONS | fzf)
}
