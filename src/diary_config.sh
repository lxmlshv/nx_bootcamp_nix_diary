#! /bin/bash

#
# Команда config
#   config [-d <имя_папки_с_записями>]
#   config [-e <редактор_по_умолчанию>]
#

if [[ $1 == config ]]
then
	shift
	if (( $# == 0)); then
		eval "$DIARY_EDITOR" "$DIARY_PATH/.diaryrc"
		return
	fi
	if [[ $1 == -e ]]; then
		shift
		if (( $# == 0)); then
			echo "Не указан редактор"
			return
		fi
		export DIARY_EDITOR=$1
		sed -i "s/export DIARY_EDITOR=.*/export DIARY_EDITOR=$1/" "$DIARY_PATH/.diaryrc"
		return
	fi
	if [[ $1 == -d ]]; then
		shift
		if (( $# == 0)); then
			echo "Не указано имя папки"
			return
		fi
		printf -v DIARY_PATH "%q" "$1"
		export DIARY_PATH
		sed -i "s/^export DIARY_PATH=.*/export DIARY_PATH=${DIARY_PATH//\//\\/}/" "${HOME}/diary/.diary.sh"
		return
	fi
	return
fi