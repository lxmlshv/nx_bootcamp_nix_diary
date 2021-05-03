#! /bin/bash
function diary()
{

#
# diary - приложение для ведения дневника
#
if [ ! -d "${DIARY_PATH}" ]
then
mkdir -p "${DIARY_PATH}"
fi
if [ -r "${DIARY_PATH}/.diaryrc" ]
then
	source "${DIARY_PATH}/.diaryrc"
else
	cat <<- EOF > "${DIARY_PATH}/.diaryrc"
		export DIARY_EDITOR=nano
	EOF
	source "${DIARY_PATH}/.diaryrc"
fi

#
# Обработка запуска без команды
#

# TODO: проверить установку

if (( $# == 0))
then
    cat <<EOF
Вывод пяти последних записей
EOF
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

if [[ $1 == add ]]
then
    echo "Команда add"
    return
fi

#
# Команда config
#   config [-d <имя_папки_с_записями>]
#   config [-e <редактор_по_умолчанию>]
#

if [[ $1 == config ]]
then
    echo "Команда config"
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
export DIARY_PATH="${HOME}/diary"
