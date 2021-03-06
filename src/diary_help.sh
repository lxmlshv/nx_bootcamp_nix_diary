#! /bin/bash

#
# Команда help | -h | --help
#

if [[ $1 == help || $1 == -h || $1 == --help ]]
then
	cat <<EOF
Запуск без аргументов
	Выводит последние пять записей если дневник установлен. В противном случае выводит команду для помощи и команду для установки.

add [-t имя_шаблона] [<Заголовок записи>]
	Добавление записи с указанным шаблоном, либо с шаблоном по-умолчанию, если параметр не указан.

config 
	Открывает .diaryrc для редактирования.

config [-d <имя_папки_с_записями>]
	Задаёт новое имя для папки дневника.

config [-e <редактор_по_умолчанию>]
	Задаёт новый редактор по умолчанию.

stats
	Вывод статистики дневника.
delete [<ID_записи>]
	Удаление записи.
trash
	Выводит список удалённых записей.

backup [<путь_к_файлу_бэкапа>]
	Создать бэкап по указанному пути.
EOF
	return
fi