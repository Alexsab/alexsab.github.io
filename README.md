# alexsab.github.io
[github pages](https://alexsab.github.io)

test repo

add -100 to channel id in Telegram


```bash
chmod +x ./.github/scripts/sh/test.sh
chmod +x ./.github/scripts/sh/prepare_commits.sh
chmod +x ./.github/scripts/sh/send_telegram.sh

source ./.github/scripts/sh/utils.sh
source ./.github/scripts/sh/prepare_commits.sh
prepare_commits "repo-name" "main" "13adf7b" "2df69d6" "username" "org/repo"

source ./.github/scripts/sh/utils.sh
source ./.github/scripts/sh/prepare_commits.sh
prepare_commits "repo-name" "main" "91d47a0" "2df69d6" "username" "org/repo"

if [ -z "$TELEGRAM_TOKEN" ] && [ -f .env ]; then
    export TELEGRAM_TOKEN=$(grep '^TELEGRAM_TOKEN=' .env | awk -F'=' '{print substr($0, index($0,$2))}' | sed 's/^"//; s/"$//')
fi
if [ -z "$TELEGRAM_TO" ] && [ -f .env ]; then
    export TELEGRAM_TO=$(grep '^TELEGRAM_TO=' .env | awk -F'=' '{print substr($0, index($0,$2))}' | sed 's/^"//; s/"$//')
fi
source ./.github/scripts/sh/utils.sh
source ./.github/scripts/sh/send_telegram.sh
send_telegram_messages $TELEGRAM_TOKEN $TELEGRAM_TO 2
```



## Tests:

defaults to HEAD~1..HEAD, confirmed it builds the headered message and writes tmp_messages/part_0.txt

```sh
./.github/scripts/sh/telegram_test.sh -p
```


verified the header suppression path

```sh
./.github/scripts/sh/telegram_test.sh -p --no-header --before 5b582188077b86e66247c5c9cc63ff86f389fac7 --after 03d5a8d0d76bee2a3671840f7ffecd39e06dbba5 --actor Alexsab --repository Alexsab/alexsab.github.io --repo-name alexsab.github.io --ref develop

./.github/scripts/sh/telegram_test.sh -p --before 0000000000000000000000000000000000000000 --after 494eb21f7767b11b7b00a7071fcf3ef8e612f600
```


send to telegram part 1

```sh
./.github/scripts/sh/telegram_test.sh -s --parts 1;
```

Next step: once you’re on a machine with network access (and real token/chat IDs), run 

```sh
./.github/scripts/sh/telegram_test.sh -p -s
```

with your desired SHA range to exercise both steps end-to-end.