#!/usr/bin/env bash

main() {
  _thisfile="$(readlink -f "${BASH_SOURCE[0]}")"
  _symbols="${1:-${_thisfile%/*}/symbols/main}"
#  _symbolss="${1:-${_thisfile%/*}/symbols/brbr}"

  [[ -f $_symbols ]] \
    || ERX "no such file: '$_symbols'"

  _symbols="$(readlink -f "$_symbols")"
  _dir="${_symbols%/*}"
  _name="${_symbols##*/}"
  _namee="${_symbolss##*/}"

  [[ ${_dir##*/} = symbols ]] \
    || ERX "$_symbols not located in symbols dir."

  echo $_namee
  
  # -w 0 ; warning level 0, no warnings
  setxkbmap main -print \
    | xkbcomp -w 0 -I"${_dir%/*}" - "$DISPLAY"
}

set -E
trap '[ "$?" -ne 77 ] || exit 77' ERR

ERM(){

  local mode

  getopts xr mode
  case "$mode" in
    x ) urg=critical ; prefix='[ERROR]: '   ;;
    r ) urg=low      ; prefix='[WARNING]: ' ;;
    * ) urg=normal   ; mode=m ;;
  esac
  shift $((OPTIND-1))

  msg="${prefix}$*"

  if [[ -t 2 ]]; then
    echo "$msg" >&2
  else
    notify-send -u "$urg" "$msg"
  fi

  [[ $mode = x ]] && exit 77
}

ERX() { ERM -x "$*" ;}
ERR() { ERM -r "$*" ;}

main "$@"
