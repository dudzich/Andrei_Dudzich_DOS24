#!/bin/bash

# Поиск строки в файлах директории.  Использует grep.  Режимы: -default (последовательный), -force (параллельный).

# Использование:  ./find_string.sh <строка> <директория> [-default|-force]

# Аргументы:
#   <строка> - строка для поиска.
#   <директория> - директория для поиска файлов.
#   [-default|-force] - режим поиска (по умолчанию -default).

# Примеры:
# ./find_string.sh "ошибка" /var/log -default   # Последовательный поиск "ошибка" в /var/log
# ./find_string.sh "ключ" /home/user/ -force   # Параллельный поиск "ключ" в /home/user/

# Аргументы
search_string="$1"
directory="$2"
mode="${3:--default}"  # Если режим не указан, устанавливается -default

# Проверка наличия аргументов: строка поиска и каталог
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
  if [[ "$ignore_case_answer" =~ ^(Да|да|Д|д|Yes|yes|Y|y|\+)$ ]]; then
    grep_option="-i"
    break
  elif [[ "$ignore_case_answer" =~ ^(Нет|нет|Н|н|No|no|N|n|\-)$ ]]; then
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
      matches=$(grep -n --binary-files=without-match $grep_option "$search_string" "$file")
      if [[ -n "$matches" ]]; then
        size=$(stat -c "%s" "$file")
        echo "Строка содержится в файле: $file ~ [$size байт]"
        echo "$matches" | while IFS= read -r line; do
          line_number=$(echo "$line" | cut -d':' -f1)
          echo "  Номер строки: $line_number"
        done
      fi
    else
      echo "Ошибка: Нет доступа к файлу $file"
    fi
  done

elif [ "$mode" == "-force" ]; then
  cpu_threads=$(nproc) # Используем все ядра
  export search_string grep_option
  find "$directory" -type f -print0 | xargs -0 -n 1 -P "$cpu_threads" bash -c '
    file="$1"
    if [[ -r "$file" ]]; then
      matches=$(grep -n --binary-files=without-match $grep_option "$search_string" "$file")
      if [[ -n "$matches" ]]; then
        size=$(stat -c "%s" "$file")
        echo "Строка содержится в файле: $file ~ [$size байт]"
        echo "$matches" | while IFS= read -r line; do
          line_number=$(echo "$line" | cut -d":" -f1)
          echo "  Номер строки: $line_number"
        done
      fi
    else
      echo "Ошибка: Нет доступа к файлу $file"
    fi
  ' _
fi

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))

echo "Поиск завершен. Общее время выполнения: $elapsed_time секунд."
exit 0