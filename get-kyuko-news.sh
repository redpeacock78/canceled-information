#!/usr/bin/env bash
shopt -s expand_aliases


###FUNCTION###
##PRESENCE_OF_COMMAND##
if type "gsed" >/dev/null 2>&1; then
  alias sed="gsed"
else
  alias sed="sed"
fi
##EXISTENCE_OF_FILE##
if [[ -e ./data.txt ]]; then
  :
else
  curl -sS https://www.kyoto-art.ac.jp/student/ \
  | grep -B 1 -A 5 '<p class="time">' \
  | sed 's/<[^>]*>//g;s/ //g' \
  | sed '/^$/d;s/--//g' \
  | sed '/曜/s/^/(/;s/曜/) /' \
  | sed '/：/s/\n/ /g' \
  | tr \\n ' ' \
  | sed 's/  /\n/g;s/$/\n/' \
  | sed 's/担当教員：/ /g;s/・/,/g;s/　//g;y/１２３４５６/123456/' \
  | awk '{print $1$2,$3,"\x5b"$4"\x5d"$5,$6}' > ./data.txt
fi


###PARAMETERS###
NEW_KYUKO="$(curl -sS https://www.kyoto-art.ac.jp/student/ | grep -B 1 -A 5 '<p class="time">' | sed 's/<[^>]*>//g;s/ //g' | sed '/^$/d;s/--//g' | sed '/曜/s/^/(/;s/曜/) /' | sed '/：/s/\n/ /g' | tr \\n ' ' | sed 's/  /\n/g;s/$/\n/' | sed 's/担当教員：/ /g;s/・/,/g;s/　//g;y/１２３４５６/123456/' | awk '{print $1$2,$3,"\x5b"$4"\x5d"$5,$6}')"
EXISTING_KYUKO="$(cat ./data.txt)"


###TEXT###
if [[ "$(echo "${NEW_KYUKO}" | sha1sum)" == "$(echo "${EXISTING_KYUKO}" | sha1sum)" ]]; then
    :
else
    echo "${NEW_KYUKO}" > ./data.txt
fi
