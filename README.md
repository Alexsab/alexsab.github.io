# alexsab.github.io
[github pages](https://alexsab.github.io)

test repo

add -100 to channel id in Telegram


```bash
chmod +x ./.github/scripts/prepare_commits.sh
chmod +x ./.github/scripts/send_telegram.sh

source ./.github/scripts/prepare_commits.sh
prepare_commits "repo-name" "main" "13adf7b" "2df69d6" "username" "org/repo"

source ./.github/scripts/prepare_commits.sh
prepare_commits "repo-name" "main" "91d47a0" "2df69d6" "username" "org/repo"

if [ -z "$TELEGRAM_TOKEN" ] && [ -f .env ]; then
    export TELEGRAM_TOKEN=$(grep '^TELEGRAM_TOKEN=' .env | awk -F'=' '{print substr($0, index($0,$2))}' | sed 's/^"//; s/"$//')
fi
if [ -z "$TELEGRAM_TO" ] && [ -f .env ]; then
    export TELEGRAM_TO=$(grep '^TELEGRAM_TO=' .env | awk -F'=' '{print substr($0, index($0,$2))}' | sed 's/^"//; s/"$//')
fi
source ./.github/scripts/send_telegram.sh
send_telegram_messages $TELEGRAM_TOKEN $TELEGRAM_TO 2
```
