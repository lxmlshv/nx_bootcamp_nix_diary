#! /bin/bash

#
# Команда stats
#

if [[ $1 == stats ]]
then
	echo "Записей в дневнике:" $(ls -1q "$DIARY_PATH"/*/*/*.md | wc -l)
	return
fi