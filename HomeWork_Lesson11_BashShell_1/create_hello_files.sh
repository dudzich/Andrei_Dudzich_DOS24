#!/bin/bash

output_dir="test_files"
mkdir -p "$output_dir"  

file_contents=(
  # Файл 1: "Hello world" однажды
  "Hello world\nThis is a test file."
  
  # Файл 2: "Hello world" несколько раз
  "Random text\nHello world\nAnother line\nHello world\nEnd of file."
  
  # Файл 3: "Hello world" однажды
  "Some text before\nHello world\nSome text after."
  
  # Файл 4: "Hello world" несколько раз
  "Hello world\nMore text\nHello world\nHello world\nRandom end."
  
  # Файл 5: Вариация строки
  "HELLO WORLD\nSome random text\nAnother line."
  
  # Файл 6: Вариация строки
  "Random line\nhello WORLD\nEnd of file."
  
  # Файл 7: Строка отсутствует
  "No Hello here\nJust some random text."
  
  # Файл 8: Строка отсутствует
  "Another file\nWith no match\nJust text."
)

for i in {1..8}; do
  file_name="$output_dir/file_$i.txt"
  echo -e "${file_contents[$((i - 1))]}" > "$file_name"
  echo "Создан файл: $file_name"
  if [[ $i -eq 6 ]]; then
    chmod 000 "$file_name"  
  fi
done

mkdir test_files/directory_without_permissions
chmod 000 test_files/directory_without_permissions 
