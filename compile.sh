#! /bin/bash
echo "Собираю diary.sh"
{ \
    echo "#! /bin/bash"; \
    echo "function diary()"; \
    echo "{"; \
    tail +2 src/diary_head.sh; echo ""; \
    tail +2 src/diary_help.sh; echo ""; \
    tail +2 src/diary_add.sh; echo ""; \
    tail +2 src/diary_config.sh; echo ""; \
    tail +2 src/diary_stats.sh; echo ""; \
    tail +2 src/diary_delete.sh; echo ""; \
    tail +2 src/diary_trash.sh; echo ""; \
    tail +2 src/diary_backup.sh; echo ""; \
    tail +2 src/diary_tail.sh; echo ""; \
    echo "}"; \
    tail +2 src/completion.sh; echo ""; \
    echo "export DIARY_PATH=\"\${HOME}/diary\""; \
} > diary.sh
cat <<EOF
Готово! Для установки используйте команду
    . install.sh
EOF