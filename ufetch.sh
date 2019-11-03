#!/bin/sh

# ufetch-linux - tiny system info for linux

## INFO

# user is already defined
host="$(hostname)"
os='Linux'	# I'd just like to interject for a moment...
kernel="$(uname -sr)"
uptime="$(uptime | awk -F, '{sub(".*up ",x,$1);print $1}' | sed -e 's/^[ \t]*//')"
shell="$(basename ${SHELL})"

if [ -z "${WM}" ]; then
	if [ "${XDG_CURRENT_DESKTOP}" ]; then
		envtype='DE'
		WM="${XDG_CURRENT_DESKTOP}"
	elif [ "${DESKTOP_SESSION}" ]; then
		envtype='DE'
		WM="${DESKTOP_SESSION}"
	else
		envtype='WM'
		WM="$(tail -n 1 "${HOME}/.xinitrc" | cut -d ' ' -f 2)"
	fi
else
	envtype='WM'
fi

## DEFINE COLORS

# probably don't change these
bold="$(tput bold)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"
reset="$(tput sgr0)"

# you can change these
lc="${reset}${bold}${black}"	# labels
nc="${reset}${bold}${black}"	# user and hostname
ic="${reset}${bold}${white}"	# info
c0="${reset}${bold}${black}"	# first color
c1="${reset}${white}"			# second color
c2="${reset}${yellow}"			# third color

## OUTPUT

cat <<EOF
${c0}      ___     ${nc}${USER}${ic}@${nc}${host}${reset}
${c0}     (${c1}.. ${c0}\    ${lc}OS:        ${ic}${os}${reset}
${c0}     (${c2}<> ${c0}|    ${lc}KERNEL:    ${ic}${kernel}${reset}
${c0}    /${c1}/  \\ ${c0}\\   ${lc}UPTIME:    ${ic}${uptime}${reset}
${c0}   ( ${c1}|  | ${c0}/|  ${lc}SHELL:     ${ic}${shell}${reset}
${c2}  _${c0}/\\ ${c1}__)${c0}/${c2}_${c0})  ${lc}${envtype}:        ${ic}${WM}${reset}
${c2}  \/${c0}-____${c2}\/${reset}
EOF
