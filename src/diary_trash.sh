#! /bin/bash

#
# Команда trash
#

if [[ $1 == trash ]]
then
	if ! compgen -G "$DIARY_PATH/.deleted/*.md" > /dev/null; then
		cat <<-EOF
			Вы не удалили ни одной записи.
		EOF
		return
	fi
	ls -rt $DIARY_PATH/.deleted/*.md | \
	while read -r ENTRY_PATH
	do
		echo -n "$ENTRY_PATH" | grep -Po "[^/_]*(?=__)|(?<=__)[^/_]*" | tr "\n" " "
		cat "$ENTRY_PATH" | grep -Po "(?<=# ).*$"
	done
	return
fi