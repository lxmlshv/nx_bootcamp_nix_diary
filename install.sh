#! /bin/bash
DIARY_INSTALLED=$(grep -c "source $HOME/diary/.diary.sh" "$HOME/.bashrc")
if (( DIARY_INSTALLED == 1))
then
	. "$HOME/.bashrc"
	echo "Diary установлен. Используйте diary help для получения списка команд."
else
	echo "Not installed"
	read -r -p "Добавить diary.sh в ~/.bashrc? " ANSWER
	if [[ "$ANSWER" =~ ^[yY1]+.*$ ]]
	then
		{ echo ""; echo -n "source $HOME/diary/.diary.sh"; } >> ~/.bashrc
		. "$HOME/.bashrc"
		echo "Diary установлен. Используйте diary help для получения списка команд."
	fi
fi