#!/bin/bash

# Лог-файл
LOGFILE="${1:-server.log}"

# Проверка существования файла
if [[ ! -f "$LOGFILE" ]]; then
    echo "Error: Log file '$LOGFILE' not found."
    exit 1
fi

# Проверка на пустоту
if [[ ! -s "$LOGFILE" ]]; then
    echo "Error: Log file '$LOGFILE' is empty."
    exit 1
fi

# Успешные входы (IP-адреса)
SUCCESSFUL_IPS=$(grep -E "user=[^ ]+ ip=[^ ]+ status=200" "$LOGFILE" | awk -F'ip=' '{print $2}' | awk '{print $1}' | sort | uniq)
if [[ -z "$SUCCESSFUL_IPS" ]]; then
    echo "No successful logins found."
else
    echo "Successful logins (IP addresses):"
    echo "$SUCCESSFUL_IPS"
fi

# Ошибки авторизации (уникальные пользователи)
FAILED_USERS=$(grep -E "user=[^ ]+ ip=[^ ]+ status=403" "$LOGFILE" | awk -F'user=' '{print $2}' | awk '{print $1}' | sort | uniq)
if [[ -z "$FAILED_USERS" ]]; then
    echo "No failed logins found."
else
    echo "Users with failed logins:"
    echo "$FAILED_USERS"
fi
