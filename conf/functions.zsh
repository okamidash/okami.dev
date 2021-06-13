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
    printf "%s \n" "    - ${yelb}services${end}"
    rando
}

function rando {
    FUNCMDS=("dd" "fortune" "sl" "lolcat" "exp")
    selectedexpression=${FUNCMDS[$RANDOM % ${#FUNCMDS[@]} ]}
    printf "%s\n" " Hint: try ${blub}$selectedexpression ${end}"
}

function pcol {
    printf "%s\n" "${red}red${end} ${grn}green${end} ${yel}yellow${end} ${blu}blue${end} ${mag}magneta${end} ${cyn}cyan${end}"
    printf "%s\n" "${redb}redb${end} ${grnb}greenb${end} ${yelb}yellowb${end} ${blub}blueb${end} ${magb}magnetab${end} ${cynb}cyanb${end}"
}
function about {
    print_centered "" "-"
    printf "%s\n" "${whb}#### About me${end}"
    printf "%s\n" "     I'm Eve. I'm from the UK and 23 years old."
    printf "%s\n" "     You'll find me either tinkering about with Containers, VMs or Hardware."
    printf "%s\n" "     I have a keen interest in running a homelab (much to the dismay of my powerbill)."
    printf "%s\n" "     My employment experience is fairly varied; but most of the time it's been in some form of tech."
    printf "%s\n" "     Currently I work as a Software Tester, but you probably already know that :p"
    echo " "
    printf "%s\n" "${whb}#### Stats${end}"
    printf "%s\n" "     - Age:         23"
    printf "%s\n" "     - Gender:      Female (MtF)"
    echo " "
    printf "%s\n" "${whb}#### Interests${end}"
    printf "%s\n" "     - Linux"
    printf "%s\n" "     - DevOps"
    printf "%s\n" "     - Containerisation"
    printf "%s\n" "     - Networking"
    print_centered "" "-"
    print_centered "" "-"
}

function skills {
    print_centered "" "-"
    printf "%s\n" "${whb}#### Skills${end}"
    printf "%s\n" "     - Linux Systems Administration"
    printf "%s\n" "     - Kubernetes"
    printf "%s\n" "     - Ansible"
    printf "%s\n" "     - Nginx"
    printf "%s\n" "     - Docker"
    printf "%s\n" "     - Git"
    printf "%s\n" "     - Networking (VLANS, Routing etc)"
    printf "%s\n" "     - Virtualization"
    printf "%s\n" "${whb}#### Languages${end}"
    printf "%s\n" "     - Bash"
    printf "%s\n" "     - Javascript"
    printf "%s\n" "     - Go"
    printf "%s\n" "     - HTML"
    printf "%s\n" "     - Python"
    print_centered "" "-"
}

function contact {
    print_centered "" "-"
    printf "%s\n" "Feel free to contact me if any of my services are down."
    printf "%s\n" " ${whb}#### Email				#### Discord	#### Keybase${end}"
    printf "%s\n" " - eve@doubledash.org			 - okami#1010	 - okamidash"
    printf "%s\n" " - onetrickpone@protonmail.com		${whb}#### Twitter	#### Telegram${end}"
    printf "%s\n" " - okami@doubledash.org		         - @okamidash	 - okamidash"
    echo " "
    printf "%s\n" " ${whb}#### Github				#### Reddit${end}"
    printf "%s\n" "  - okamidash			 	 - /u/okami_dash"
    printf "%s\n" " link: https://github.com/okamidash	link: https://reddit.com/u/okami_dash"
    echo " "
    printf "%s\n" " ${whb}#### Private Git${end}"
    printf "%s\n" "  - okami"
    printf "%s\n" " link: https://git.doubledash.org/okami"
    print_centered "" "-"
}

function services {
    print_centered "" "-"
    printf "%s\n" " Here is a non exhaustive list of the services that I currently run"
    printf "%s\n" " to give you an idea of the things I do:"
    printf "%s\n" "  - Nextcloud    - Mariadb   - Ansible Tower"
    printf "%s\n" "  - Nginx        - Plex      - Ghost"
    printf "%s\n" "  - InfluxDB     - Grafana   - Telegraf"
    printf "%s\n" "  - Jenkins      - Postgres  - Gitea"
    echo " "
    printf "%s\n" " And a list of public endpoints you can connect to:"
    printf "%s\n" "  - Nextcloud    https://cloud.doubledash.org"
    printf "%s\n" "  - Homepage     https://okami.dev"
    printf "%s\n" "  - Blog         https://blog.okami.dev"
    printf "%s\n" "  - Gitea        https://git.doubledash.org"
}
