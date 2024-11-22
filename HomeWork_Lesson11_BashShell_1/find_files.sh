#!/bin/bash

# Скрипт для поиска файлов с заданным расширением в указанном каталоге и записи результатов в файл.  Проверяет существование файла.

# Использование:
# ./find_files.sh <output_file> <directory> [extension]

# Аргументы:
#   <output_file> - Имя файла, в который будут записаны результаты поиска.  Файл будет создан в текущем каталоге.
#   <directory> - Путь к каталогу, в котором будет осуществляться поиск файлов.
#   [extension] - (Необязательный) Расширение файлов для поиска (без точки).  Если не указано, будут найдены все файлы без расширения.

# Примеры использования:
#   ./find_files.sh results.txt /home/user/documents          # Найдёт все файлы без расширения в /home/user/documents
#   ./find_files.sh results.txt /tmp txt                      # Найдёт все файлы с расширением .txt в /tmp
#   ./find_files.sh my_files.txt . log                        # Найдёт все файлы с расширением .log в текущем каталоге
#   ./find_files.sh output.txt /path/to/my/directory .pdf     # Найдёт все файлы с расширением .pdf  в /path/to/my/directory


# Проверка аргументов
if [ "$#" -lt 2 ]; then
    echo "Ошибка: Недостаточно аргументов. Использование: $0 <output_file> <directory> [extension]"
    exit 1
fi

output_file="$1"
directory="$2"
extension="$3"

# Проверка существования и прав доступа к директории
if [ ! -d "$directory" ]; then
    echo "Ошибка: Каталог '$directory' не существует."
    exit 1
fi

if [ ! -r "$directory" ]; then
    echo "Ошибка: Нет прав на чтение каталога '$directory'."
    exit 1
fi

# Проверка существования выходного файла и возможности записи
if [ -f "$output_file" ]; then
    echo "Ошибка: Файл '$output_file' уже существует. Переименуйте файл или удалите его."
    exit 1
elif ! touch "$output_file" 2>/dev/null; then
    echo "Ошибка: Невозможно создать файл '$output_file'. Проверьте права доступа."
    exit 1
fi

# Поиск файлов
if [ -z "$extension" ]; then
    find_command="find \"$directory\" -type f ! -name '*.*'"
else
  extension="${extension/#./}" # Удаляем точку, если она есть
  find_command="find \"$directory\" -type f -name \"*.$extension\""
fi

find_result=$(eval "$find_command" 2>&1)
status=$?

# Обработка результатов поиска
if [ $status -eq 0 ]; then
    echo "$find_result" > "$output_file"
    if [ -s "$output_file" ]; then
        echo "Имена файлов${extension:+ с расширением .$extension} из каталога '$directory' записаны в файл '$output_file'."
    else
        echo "В каталоге '$directory' не найдено файлов${extension:+ с расширением .$extension}."
    fi
else
    echo "Ошибка при выполнении команды find: $find_result"
    exit 1
fi

echo "Скрипт завершён."
exit 0