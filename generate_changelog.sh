#!/bin/bash

# Получаем последний тег
last_tag=$(git describe --tags --abbrev=0)

# Получаем дату для записи в changelog
current_date=$(date +%Y-%m-%d)

# Получаем список коммитов с момента последнего тега
commits=$(git log $last_tag..HEAD --pretty=format:"%h - %s")

# Определяем версию
version="v$(date +%Y.%m.%d)"  # Формат версии: ГГГГ.ММ.ДД

# Создаем новый раздел в changelog
echo "## [$version] - $current_date" >> changelog.md

# Добавляем коммиты в changelog
echo "$commits" | while IFS= read -r commit; do
    echo "- $commit [$(echo $commit | awk '{print $1}')] (https://github.com/marilynhantzis/rgzz/commit/$(echo $commit | awk '{print $1}'))" >> changelog.md
done
