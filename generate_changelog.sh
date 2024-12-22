#!/bin/bash

# Проверка наличия последнего тега
last_tag=$(git describe --tags --abbrev=0)
if [ -z "$last_tag" ]; then
  echo "Нет тегов в репозитории."
  exit 1
fi

# Получение всех коммитов с момента последнего релиза
commits=$(git log "$last_tag"..HEAD --pretty=format:"%h %s")

# Установка версии и даты
version="v$(date +%Y.%m.%d)"
date=$(date +%Y-%m-%d)

# Форматирование новой секции changelog
changelog_section="## [$version] - $date\n"

# Добавление коммитов в секцию
while IFS= read -r commit; do
  sha=$(echo "$commit" | awk '{print $1}')
  message=$(echo "$commit" | cut -d ' ' -f2-)
  changelog_section+=" - $message [$sha](https://github.com/USERNAME/REPOSITORY/commit/$sha)\n"
done <<< "$commits"

# Добавление новой секции в changelog.md
echo -e "$changelog_section" >> changelog.md

echo "Changelog обновлен." #
