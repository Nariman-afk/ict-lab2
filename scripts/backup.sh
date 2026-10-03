#!/bin/bash
# Останавливать выполнение при любой ошибке
set -e

# Директории
SRC_DIR="/home/zhmsh/ict_lab2/docs"
BACKUP_DIR="/home/zhmsh/ict_lab2/backup"
LOG_FILE="/home/zhmsh/ict_lab2/logs/backup.log"

# Пункт 5.3: Обработка ошибок (проверка существования исходной директории)
if [ ! -d "$SRC_DIR" ]; then
    echo "Error: Source directory $SRC_DIR does not exist!" >&2
    exit 1
fi

# Пункт 5.1: Генерация имени с текущей датой и временем
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
ARCHIVE_NAME="docs_backup_$TIMESTAMP.tar.gz"

# Создание архива
tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" -C "$(dirname "$SRC_DIR")" "$(basename "$SRC_DIR")"

# Запись строки в лог-файл
echo "[$TIMESTAMP] Backup created successfully: $ARCHIVE_NAME" >> "$LOG_FILE"

# Пункт 5.1: Удаление архивов старше 7 дней
find "$BACKUP_DIR" -name "docs_backup_*.tar.gz" -mtime +7 -delete

echo "Backup completed: $ARCHIVE_NAME"

