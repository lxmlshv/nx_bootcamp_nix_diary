#! /bin/bash

#
# Команда delete [ID_записи]
#

if [[ $1 == delete ]]
then
	shift
	if (( $# == 0)); then
		echo "Не указан ID записи которую требуется удалить"
		return
	fi
	DIARY_DELETE_ENTRY=$(ls -rt $DIARY_PATH/*/*/*.md | grep "$1")
	if [[ -z $DIARY_DELETE_ENTRY ]]; then
		echo "Запись не найдена"
		return
	fi
	mv "$DIARY_DELETE_ENTRY" "$DIARY_PATH/.deleted"
	echo "Запись удалена"
	return
fi