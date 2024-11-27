#!/bin/bash

# Аргументы
search_string="$1"
directory="$2"
mode="${3:--default}"  # Если режим не указан, устанавливается -default

# Проверка наличия хотя бы двух аргументов (строка поиска и каталог)
if [ $# -lt 2 ]; then
  echo "Использование: $0 <строка_для_поиска> <каталог> [-force/-default]"
  exit 1
fi

# Проверка на пустую строку поиска
if [ -z "$search_string" ]; then
  echo "Ошибка: Строка для поиска не может быть пустой."
  exit 1
fi

# Проверка существования каталога
if [ ! -d "$directory" ]; then
  echo "Ошибка: Каталог '$directory' не существует или недоступен."
  exit 1
fi

# Проверка выбора режима
if [[ "$mode" != "-default" && "$mode" != "-force" ]]; then
  echo "Ошибка: Укажите корректный режим -default (однопоточный) или -force (многопоточный)."
  exit 1
fi

# Запрос о игнорировании регистра
while true; do
  read -p "Игнорировать регистр? (Да/Нет): " ignore_case_answer
  ignore_case_answer=$(echo "$ignore_case_answer" | tr '[:upper:]' '[:lower:]')
  if [[ "$ignore_case_answer" =~ ^(да|д|yes|y|\+)$ ]]; then
    grep_option="-i"
    break
  elif [[ "$ignore_case_answer" =~ ^(нет|н|no|n|\-)$ ]]; then
    grep_option=""
    break
  else
    echo "Ошибка: Неверный ввод."
  fi
done

echo "Поиск строки: '$search_string' в каталоге: '$directory'"

if [ "$mode" == "-default" ]; then
  echo "Режим: последовательный (однопоточный)"
else
  echo "Режим: параллельный (многопоточный)"
fi

start_time=$(date +%s)

if [ "$mode" == "-default" ]; then
  find "$directory" -type f -print0 | while IFS= read -r -d $'\0' file; do
    if [[ -r "$file" ]]; then
      if grep --binary-files=without-match "$grep_option" "$search_string" "$file" > /dev/null; then
        size=$(stat -c "%s" "$file")
        echo "Строка содержится в файле: $file ~ [$size байт]"
      fi
    else
      echo "Ошибка: Нет доступа к файлу '$file'"
    fi
  done

elif [ "$mode" == "-force" ]; then
  cpu_threads=$(($(nproc) )) # Используем все ядра
  export search_string grep_option
  find "$directory" -type f -print0 | xargs -0 -n 1 -P "$cpu_threads" bash -c '
    for file in "$@"; do
      if [[ -r "$file" ]]; then
        if grep --binary-files=without-match "$grep_option" "$search_string" "$file" > /dev/null; then
          size=$(stat -c "%s" "$file")
          echo "Строка содержится в файле: $file ~ [$size байт]"
        fi
      else
        echo "Ошибка: Нет доступа к файлу '$file'"
      fi
    done
  ' _
fi

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))

echo "Поиск завершен. Общее время выполнения: $elapsed_time секунд."
exit 0