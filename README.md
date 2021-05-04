# nx_bootcamp_nix_diary
Small diary application written in bash.
## Установка
	source <(curl -fsSL https://raw.githubusercontent.com/lxmlshv/nx_bootcamp_nix_diary/main/net_install.sh)
## Описание
Diary - для ведения дневника. По-умолчанию устанавливается в ~/diary/.diary.sh
### Шаблоны
Diary поддерживает шаблоны для создания записей. Формат шаблонов - Markdown. Шаблоны расположены в ~/diary/.templates
#### Макросы в шаблонах
{{title}} Заголовок записи введённый при её создании
{{date}} Дата создания записи в формате дд.мм.гггг
{{time}} Время создания записи в формате ЧЧ:ММ
## Команды
### Запуск без аргументов
Выводит последние пять записей если дневник установлен. В противном случае выводит команду для помощи и команду для установки.

### add [-t имя_шаблона] [<Заголовок записи>]
Добавление записи с указанным шаблоном, либо с шаблоном по-умолчанию, если параметр не указан.

### config 
Открывает .diaryrc для редактирования.

### config [-d <имя_папки_с_записями>]
Задаёт новое имя для папки дневника.

### config [-e <редактор_по_умолчанию>]
Задаёт новый редактор по умолчанию.

### stats
Вывод статистики.
Сколько записей всего хранится в дневнике
Когда была сделана последняя запись
Сколько записей сделано за каждый год и месяц
Самая длинная запись в дневнике
### delete [<ID_записи>]
Удаление записи. Помещает запись в ~/diary/.deleted
### trash
Выводит список удалённых записей.

### backup [<путь_к_файлу_бэкапа>]
Создать бэкап по указанному пути. Архивирует ~/diary