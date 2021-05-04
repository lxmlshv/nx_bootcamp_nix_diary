#! /bin/bash

#
# Команда add [-t <имя_шаблона>] [<Заголовок записи>]
#

if [[ $1 == add ]]; then
	shift
	if [[ $1 == -t ]]; then
		if [ ! -r "${DIARY_PATH}/.templates/$2.md" ]; then
			echo "Шаблон $2 не найден"
			return;
		fi
		DIARY_TEMPLATE="${DIARY_PATH}/.templates/$2.md"
		shift 2
	else
		DIARY_TEMPLATE="${DIARY_PATH}/.templates/default.md"
	fi
	DIARY_NEWENTRY_TITLE=$(printf '%q' "$*")
	DIARY_NEWENTRY_ID=$(date +%s | gzip -c | tail -c8 | od -t x4 -N 4 -A n | awk '{ print $1 }')
	DIARY_NEWENTRY="${DIARY_PATH}/$(date +%Y)/$(date +%m)/${DIARY_NEWENTRY_ID}__$(date +%Y-%m-%d_%H-%M).md"
	install -D "$DIARY_TEMPLATE" "$DIARY_NEWENTRY"
	sed -i "s/{{title}}/${DIARY_NEWENTRY_TITLE}/g" "$DIARY_NEWENTRY"
	sed -i "s/{{date}}/$(date +%d.%m.%Y)/g" "$DIARY_NEWENTRY"
	sed -i "s/{{time}}/$(date +%H:%M)/g" "$DIARY_NEWENTRY"
	eval "$DIARY_EDITOR" "$DIARY_NEWENTRY"
	return
fi