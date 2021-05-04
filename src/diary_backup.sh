#! /bin/bash

#
# Команда backup [<пусть_к_файлу_бэкапа>]
#

if [[ $1 == backup ]]
then
	shift
	if (( $# == 0)); then
		echo "Укажите имя архива"
		return
	fi
	tar -cvzf "$1.tar.gz" -C "$DIARY_PATH/../" $(basename $DIARY_PATH)
	return
fi