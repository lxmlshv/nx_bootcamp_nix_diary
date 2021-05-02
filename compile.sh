#! /bin/bash
echo "compiling..."
{ \
    cat src/diary_head.sh; \
    tail +2 src/diary_help.sh; \
    tail +2 src/diary_install.sh; \
    tail +2 src/diary_add.sh; \
    tail +2 src/diary_config.sh; \
    tail +2 src/diary_stats.sh; \
    tail +2 src/diary_delete.sh; \
    tail +2 src/diary_trash.sh; \
    tail +2 src/diary_backup.sh; \
} > diary.sh
echo "All done!"