#!/usr/bin/env bash

# Функция для отображения справки
function show_help() {
  echo "Usage: $0 [OPTIONS]"
  echo
  echo "Опции:"
  echo "  -p, --prepare_commits     Подготовить коммиты для мержа."
  echo "  -s, --send_telegram       Отправить сообщения в Telegram."
  echo "  -h, --help       Показать эту справку."
  echo
  exit 0
}

# Переменные для флагов
prepare=false
send=false

# Обрабатываем аргументы командной строки
for arg in "$@"; do
  case $arg in
    -h|--help)
      show_help
      ;;
    -p|--prepare_commits)
      prepare=true
      ;;
    -s|--send_telegram)
      send=true
      ;;
    *)
      echo "Неизвестный аргумент: $arg"
      show_help
      ;;
  esac
done

if $prepare; then
    source ./.github/scripts/sh/utils.sh
    source ./.github/scripts/sh/prepare_commits.sh
    prepare_commits "repo-name" "main" "13adf7b" "2df69d6" "username" "org/repo"
fi

if $send; then
    if [ -z "$TELEGRAM_TOKEN" ] && [ -f .env ]; then
        export TELEGRAM_TOKEN=$(grep '^TELEGRAM_TOKEN=' .env | awk -F'=' '{print substr($0, index($0,$2))}' | sed 's/^"//; s/"$//')
    fi
    if [ -z "$TELEGRAM_TO" ] && [ -f .env ]; then
        export TELEGRAM_TO=$(grep '^TELEGRAM_TO=' .env | awk -F'=' '{print substr($0, index($0,$2))}' | sed 's/^"//; s/"$//')
    fi
    source ./.github/scripts/sh/utils.sh
    source ./.github/scripts/sh/send_telegram.sh
    send_telegram_messages $TELEGRAM_TOKEN $TELEGRAM_TO 2
fi