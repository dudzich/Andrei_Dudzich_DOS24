#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Использование: $0 <output_file> <directory> [extension]"
    exit 1
fi

output_file="$1"
directory="$2"
extension="$3"

if [ ! -d "$directory" ]; then
    echo "Ошибка: Каталог $directory не существует."
    exit 1
fi

if [ ! -r "$directory" ]; then
    echo "Ошибка: Нет прав на чтение каталога $directory."
    exit 1
fi

if ! touch "$output_file" 2>/dev/null; then
    echo "Ошибка: Нет прав на запись в файл $output_file."
    exit 1
fi

if [ -z "$extension" ]; then
    find "$directory" -type f ! -name "*.*" > "$output_file"
    echo "Имена файлов без расширения из каталога $directory записаны в файл $output_file."
else
    find "$directory" -type f -name "*.$extension" > "$output_file"
    echo "Имена файлов с расширением .$extension из каталога $directory записаны в файл $output_file."
fi
