#! /bin/bash

#
# diary - приложение для ведения дневника
#

#
# Обработка запуска без команды
#

if (( $# == 0))
# TODO проверить установку
then
cat <<EOF
Для установки приложения используйте команду
    . diary.sh install
Для вывода списка команд используйте команду
    . diary.sh help
EOF
return
fi
#
# Команда help | -h | --help
#

# TODO: проверить команды -h и --help тоже
if [[ $1 == help ]]
then
    echo "Команда help"
fi
#
# Команда install [-d <имя_папки_с_записями>] [-e <редактор_по_умолчанию>]
#

if [[ $1 == install ]]
then
    echo "Команда install"
fi
#
# Команда add [-t <имя_шаблона>] [<Заголовок записи>]
#

if [[ $1 == add ]]
then
    echo "Команда add"
fi
#
# Команда config
#   config [-d <имя_папки_с_записями>]
#   config [-e <редактор_по_умолчанию>]
#

if [[ $1 == config ]]
then
    echo "Команда config"
fi
#
# Команда stats
#

if [[ $1 == stats ]]
then
    echo "Команда stats"
fi
#
# Команда delete [ID_записи]
#

if [[ $1 == delete ]]
then
    echo "Команда delete"
fi
#
# Команда trash
#

if [[ $1 == trash ]]
then
    echo "Команда trash"
fi
#
# Команда backup [<пусть_к_файлу_бэкапа>]
#

if [[ $1 == backup ]]
then
    echo "Команда backup"
fi