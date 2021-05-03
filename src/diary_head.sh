#! /bin/bash

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
