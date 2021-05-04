#!/bin/bash
if [ ! -d ${HOME}/diary ]; then
    mkdir ${HOME}/diary
fi
curl https://raw.githubusercontent.com/lxmlshv/nx_bootcamp_nix_diary/main/diary.sh > "${HOME}/diary/.diary.sh"
DIARY_INSTALLED=$(grep -c "source ${HOME}/diary/.diary.sh" "$HOME/.bashrc")
if (( DIARY_INSTALLED == 1))
then
	. "$HOME/.bashrc"
	echo "Diary установлен. Используйте diary help для получения списка команд."
    return
fi
read -r -p "Добавить /${HOME}/.diary.sh в ~/.bashrc? " ANSWER
if [[ "$ANSWER" =~ ^[yY1]+.*$ ]]
then
    { echo ""; echo -n "source ${HOME}/diary/.diary.sh"; } >> "${HOME}/.bashrc"
    . "$HOME/.bashrc"
    echo "Diary установлен. Используйте diary help для получения списка команд."
fi