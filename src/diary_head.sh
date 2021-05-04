#! /bin/bash

#
# diary - приложение для ведения дневника
#

# Проверка/создание папки с дневником
if [ ! -d "${DIARY_PATH}" ]
then
mkdir -p "${DIARY_PATH}"
fi

# config
if [ -r "${DIARY_PATH}/.diaryrc" ]
then
	source "${DIARY_PATH}/.diaryrc"
else
	#default config
	cat <<- EOF > "${DIARY_PATH}/.diaryrc"
		export DIARY_EDITOR=nano
	EOF
	source "${DIARY_PATH}/.diaryrc"
fi

# templates
if [ ! -d "${DIARY_PATH}/.templates" ]
then
mkdir -p "${DIARY_PATH}/.templates"
fi
if [ ! -r "${DIARY_PATH}/.templates/default.md" ]
then
	#default template
	cat <<- EOF > "${DIARY_PATH}/.templates/default.md"
		*{{date}} {{time}}*
		# {{title}}

	EOF
fi

# folder for deleted entries
if [ ! -d "${DIARY_PATH}/.deleted" ]
then
mkdir -p "${DIARY_PATH}/.deleted"
fi

#
# Обработка запуска без команды
#

if (( $# == 0))
then
	if ! compgen -G "$DIARY_PATH/*/*/*.md" > /dev/null; then
		cat <<-EOF
			В дневнике ещё нет записей.
			Добавьте новую запись с помощью команды
			    diary add <Заголовок>
		EOF
		return
	fi
	ls -rt $DIARY_PATH/*/*/*.md | tail -n5 | \
	while read -r ENTRY_PATH
	do
		echo -n "$ENTRY_PATH" | grep -Po "[^/_]*(?=__)|(?<=__)[^/_]*" | tr "\n" " "
		cat "$ENTRY_PATH" | grep -Po "(?<=# ).*$" | head -1
	done
	return
fi