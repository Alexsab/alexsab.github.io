# alexsab.github.io
[github pages](https://alexsab.github.io)

test repo

add -100 to channel id in Telegram


```bash
chmod +x ./.github/scripts/prepare_commits.sh
chmod +x ./.github/scripts/send_telegram.sh

source ./.github/scripts/prepare_commits.sh
prepare_commits "repo-name" "main" "fc23010" "2df69d6" "username" "org/repo"

source ./.github/scripts/prepare_commits.sh
prepare_commits "repo-name" "main" "2df69d6" "fc23010" "username" "org/repo"
```
