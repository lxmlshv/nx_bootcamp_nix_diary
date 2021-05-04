#! /bin/bash

#
# Команда stats
#

if [[ $1 == stats ]]
then
	echo "Записей в дневнике:" $(ls -1q "$DIARY_PATH"/*/*/*.md | wc -l)
	echo "Последняя запись сделана:" $(ls -rt $DIARY_PATH/*/*/*.md | tail -n1 | grep -Po "(?<=__)[^/_]*")
	return
fi