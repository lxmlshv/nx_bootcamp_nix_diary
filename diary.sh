#! /bin/bash
function diary()
{

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
	# if [[ ! -e $DIARY_PATH/*/*/*.md ]]; then
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
		cat "$ENTRY_PATH" | grep -Po "(?<=# ).*$"
	done
	return
fi

#
# Команда help | -h | --help
#

if [[ $1 == help || $1 == -h || $1 == --help ]]
then
	echo "Команда help"
	return
fi

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
		sed -i "s/^export DIARY_PATH=.*/export DIARY_PATH=${DIARY_PATH//\//\\/}/" "$PWD/diary.sh"
		return
	fi
	return
fi

#
# Команда stats
#

if [[ $1 == stats ]]
then
	echo "Команда stats"
	return
fi

#
# Команда delete [ID_записи]
#

if [[ $1 == delete ]]
then
	echo "Команда delete"
	return
fi

#
# Команда trash
#

if [[ $1 == trash ]]
then
	echo "Команда trash"
	return
fi

#
# Команда backup [<пусть_к_файлу_бэкапа>]
#

if [[ $1 == backup ]]
then
	echo "Команда backup"
	return
fi

#
# сообщение о неверной команде
#

echo "Команда $1 не найдена."
}

function _diary
{
	local word opts
	COMPREPLY=()
	word="${COMP_WORDS[COMP_CWORD]}"
	opts="add backup config delete help stats trash"
	COMPREPLY=( $(compgen -W "${opts}" -- ${word}) )
}
complete -F _diary diary
export DIARY_PATH=/home/alex/newdiary
