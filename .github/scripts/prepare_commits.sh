#!/bin/bash
# prepare_commits.sh

prepare_commits() {
    local repository_name="$1"
    local ref_name="$2"
    local before_sha="$3"
    local after_sha="$4"
    local actor="$5"
    local repository="$6"

    # Проверка наличия всех параметров
    if [ -z "$repository_name" ] || [ -z "$ref_name" ] || [ -z "$before_sha" ] || [ -z "$after_sha" ] || [ -z "$actor" ] || [ -z "$repository" ]; then
        echo "Error: Missing required parameters" >&2
        echo "Usage: prepare_commits repository_name ref_name before_sha after_sha actor repository" >&2
        return 1
    fi

    # Подготовка заголовка
    HEADER="<b>[${repository_name}:${ref_name}]</b>"
    
    # Инициализируем массив
    declare -a readarray

    if [ "$before_sha" = "0000000000000000000000000000000000000000" ]; then
        git fetch origin HEAD || { echo "Error: Failed to fetch git repository" >&2; return 1; }
        git checkout HEAD || { echo "Error: Failed to checkout HEAD" >&2; return 1; }
        
        # Читаем вывод git log в массив
        while IFS= read -r line; do
            readarray+=("$line")
        done < <(git log --pretty=format:"'<code>%h</code>' - %an, %ar : %s" "HEAD..${after_sha}")
        COMPARE_HASH="${after_sha}"
    else
        # Читаем вывод git log в массив
        while IFS= read -r line; do
            readarray+=("$line")
        done < <(git log --pretty=format:"'<code>%h</code>' - %an, %ar : %s" "${before_sha}..${after_sha}")
        COMPARE_HASH="${before_sha}..${after_sha}"
    fi

    TOTAL_COMMITS=${#readarray[@]}
    
    if [ "$TOTAL_COMMITS" -eq 1 ]; then
        COMMITS_TEXT="$TOTAL_COMMITS new commit"
    else
        COMMITS_TEXT="$TOTAL_COMMITS new commits"
    fi

    HEADER="$HEADER <b><a href=\"https://github.com/${repository}/compare/${COMPARE_HASH}\">$COMMITS_TEXT</a></b> by <b><a href=\"https://github.com/${actor}\">${actor}</a></b>"

    # Создаем временную директорию для сообщений
    mkdir -p ./tmp_messages || { echo "Error: Failed to create tmp_messages directory" >&2; return 1; }

    # Разбиваем коммиты на части по 40 штук
    PART_INDEX=0
    CHUNK="$HEADER<br><br>"
    COUNT=0
    MAX_COMMITS=5

    for COMMIT in "${readarray[@]}"; do
        CHUNK+="$COMMIT<br>"
        COUNT=$((COUNT + 1))
        
        if [ $COUNT -eq $MAX_COMMITS ]; then
            echo "$CHUNK" > "./tmp_messages/part_${PART_INDEX}.txt" || { echo "Error: Failed to write to file" >&2; return 1; }
            PART_INDEX=$((PART_INDEX + 1))
            COUNT=0
            CHUNK="$HEADER<br><br>"
        fi
    done

    # Добавляем оставшиеся коммиты, если есть
    if [ $COUNT -gt 0 ]; then
        echo "$CHUNK" > "./tmp_messages/part_${PART_INDEX}.txt" || { echo "Error: Failed to write to file" >&2; return 1; }
        PART_INDEX=$((PART_INDEX + 1))
    fi

    echo $PART_INDEX
}
