#!/bin/bash

# Скрипт для получения информации о погоде в указанном городе.
# Использует API OpenWeatherMap для получения данных.
# Позволяет выбирать язык интерфейса (русский/английский) и запрашивать данные о погоде для разных городов.
# После вывода данных о городе и погоде, предлагает пользователю продолжить или завершить работу.

# Использование: ./weather.sh

# Интерактивный скрипт, не принимает аргументов командной строки.
# После запуска пользователю предлагается выбрать язык интерфейса,
# затем вводится название города, для которого необходимо получить информацию о погоде.
# Вывод включает информацию о городе (название, координаты, страна, население, часовой пояс, время восхода и заката)
# и информацию о погоде (температура, ощущается как, давление, влажность, скорость ветра и другие параметры).

# Пример работы:
# 1. Запустить скрипт: ./weather.sh
# 2. Выбрать язык интерфейса, введя 1 (русский) или 2 (английский).
# 3. Ввести название города, например "Минск".
# 4. Скрипт выведет информацию о городе и погоде.
# 5. Скрипт предложит продолжить или завершить работу.

API_KEY="6f750ece60478d7abaabe2cebdf5e594"

# Преобразованные текстовые ассоциации для английского и русского языков
declare -A TEXTS

TEXTS["ru_choose_lang"]="Выберите язык:"
TEXTS["en_choose_lang"]="Choose language:"
TEXTS["ru_1"]="1 - Русский"
TEXTS["en_1"]="1 - Russian"
TEXTS["ru_2"]="2 - Английский"
TEXTS["en_2"]="2 - English"
TEXTS["ru_0"]="0 - Выход"
TEXTS["en_0"]="0 - Exit"
TEXTS["ru_enter_city"]="Введите город:"
TEXTS["en_enter_city"]="Enter city:"
TEXTS["ru_city_info"]="Информация о городе:"
TEXTS["en_city_info"]="City Information:"
TEXTS["ru_weather_info"]="Информация о погоде:"
TEXTS["en_weather_info"]="Weather Information:"
TEXTS["ru_not_found"]="Город не найден или произошла ошибка API."
TEXTS["en_not_found"]="City not found or API error occurred."
TEXTS["ru_continue"]="Желаете продолжить? (Да/Нет):"
TEXTS["en_continue"]="Do you want to continue? (Yes/No):"

# Функция для получения перевода текста в зависимости от языка
get_text() {
    echo "${TEXTS[$1]}"
}


# Функция для получения и вывода данных о погоде
fetch_data() {
    local city="$1"
    local lang="$2"
    local weather_url="http://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=${API_KEY}&units=metric"

    weather_response=$(curl -s "$weather_url")

    # Извлечение данных
    lat=$(echo "$weather_response" | jq -r '.city.coord.lat // empty')
    lon=$(echo "$weather_response" | jq -r '.city.coord.lon // empty')
    country=$(echo "$weather_response" | jq -r '.city.country // empty')
    population=$(echo "$weather_response" | jq -r '.city.population // empty')
    timezone=$(echo "$weather_response" | jq -r '.city.timezone // empty')
    sunrise_timestamp=$(echo "$weather_response" | jq -r '.city.sunrise // empty')
    sunset_timestamp=$(echo "$weather_response" | jq -r '.city.sunset // empty')
    sunrise=$(date -d "@$sunrise_timestamp" +"%H:%M" 2>/dev/null || echo "N/A")
    sunset=$(date -d "@$sunset_timestamp" +"%H:%M" 2>/dev/null || echo "N/A")
    temp=$(echo "$weather_response" | jq -r '.list[0].main.temp // empty')
    feels_like=$(echo "$weather_response" | jq -r '.list[0].main.feels_like // empty')
    pressure=$(echo "$weather_response" | jq -r '.list[0].main.pressure // empty')
    sea_level=$(echo "$weather_response" | jq -r '.list[0].main.sea_level // empty')
    grnd_level=$(echo "$weather_response" | jq -r '.list[0].main.grnd_level // empty')
    humidity=$(echo "$weather_response" | jq -r '.list[0].main.humidity // empty')
    weather=$(echo "$weather_response" | jq -r '.list[0].weather[0].main // empty')
    clouds=$(echo "$weather_response" | jq -r '.list[0].clouds.all // empty')
    wind_speed=$(echo "$weather_response" | jq -r '.list[0].wind.speed // empty')
    wind_deg=$(echo "$weather_response" | jq -r '.list[0].wind.deg // empty')
    wind_gust=$(echo "$weather_response" | jq -r '.list[0].wind.gust // empty')
    visibility=$(echo "$weather_response" | jq -r '.list[0].visibility // empty')
    pop=$(echo "$weather_response" | jq -r '.list[0].pop // empty')


    if [[ -z $temp || -z $pressure ]]; then
        echo "$(get_text "${lang}_not_found")"
        return 1
    fi

    echo "$(get_text "${lang}_city_info")"
    if [ "$lang" == "ru" ]; then
        printf "Город: %s\n" "$city"
        printf "Координаты: широта %s, долгота %s\n" "$lat" "$lon"
        printf "Страна: %s\n" "$country"
        printf "Население: %s\n" "${population:-N/A}"
        printf "Часовой пояс: %s\n" "${timezone:-N/A}"
        printf "Восход солнца: %s\n" "$sunrise"
        printf "Закат солнца: %s\n" "$sunset"
    else
        printf "City: %s\n" "$city"
        printf "Coordinates: Latitude %s, Longitude %s\n" "$lat" "$lon"
        printf "Country: %s\n" "$country"
        printf "Population: %s\n" "${population:-N/A}"
        printf "Timezone: %s\n" "${timezone:-N/A}"
        printf "Sunrise: %s\n" "$sunrise"
        printf "Sunset: %s\n" "$sunset"
    fi
    echo ""

    echo "$(get_text "${lang}_weather_info")"
    if [ "$lang" == "ru" ]; then
        printf "Температура: %s°C\n" "${temp:-N/A}"
        printf "Ощущается как: %s°C\n" "${feels_like:-N/A}"
        printf "Давление: %d гПа\n" "${pressure:-N/A}"
        printf "Уровень моря: %d гПа\n" "${sea_level:-N/A}"
        printf "Уровень земли: %d гПа\n" "${grnd_level:-N/A}"
        printf "Влажность: %d%%\n" "${humidity:-N/A}"
        printf "Погода: %s\n" "$weather"
        printf "Облачность: %d%%\n" "${clouds:-N/A}"
        printf "Скорость ветра: %s м/с\n" "${wind_speed:-N/A}"
        printf "Направление ветра: %d°\n" "${wind_deg:-N/A}"
        printf "Порывы ветра: %s м/с\n" "${wind_gust:-N/A}"
        printf "Видимость: %d м\n" "${visibility:-N/A}"
        printf "Вероятность осадков: %s%%\n" "${pop:-N/A}"
    else
        printf "Temperature: %s°C\n" "${temp:-N/A}"
        printf "Feels like: %s°C\n" "${feels_like:-N/A}"
        printf "Pressure: %d hPa\n" "${pressure:-N/A}"
        printf "Sea level: %d hPa\n" "${sea_level:-N/A}"
        printf "Ground level: %d hPa\n" "${grnd_level:-N/A}"
        printf "Humidity: %d%%\n" "${humidity:-N/A}"
        printf "Weather: %s\n" "$weather"
        printf "Cloudiness: %d%%\n" "${clouds:-N/A}"
        printf "Wind speed: %s m/s\n" "${wind_speed:-N/A}"
        printf "Wind direction: %d°\n" "${wind_deg:-N/A}"
        printf "Wind gust: %s m/s\n" "${wind_gust:-N/A}"
        printf "Visibility: %d m\n" "${visibility:-N/A}"
        printf "Precipitation probability: %s%%\n" "${pop:-N/A}"
    fi
    echo ""
}

# Функция для выбора языка и города
choose_language() {
    echo "$(get_text "${lang}_choose_lang")"
    echo "$(get_text "${lang}_1")"
    echo "$(get_text "${lang}_2")"
    echo "$(get_text "${lang}_0")"
    read -rp "> " language_choice

    case $language_choice in
        1) lang="ru" ;;
        2) lang="en" ;;
        0) exit 0 ;;
        *) echo "Неверный выбор. Попробуйте снова."; choose_language ;;
    esac
}

choose_city() {
    echo "$(get_text "${lang}_enter_city")"
    read -rp "> " city
    fetch_data "$city" "$lang"
}

# Задаем начальное значение для lang, например, "ru"
lang="ru"

# Основной цикл
while true; do
    choose_language
    while true; do
        choose_city
         read -p "$(get_text "${lang}_continue") " continue_choice
          continue_choice=$(echo "$continue_choice" | tr '[:upper:]' '[:lower:]')
         if [[ "$continue_choice" =~ ^(Да|да|Д|д|Yes|yes|Y|y|\+)$ ]]; then
           break
         elif [[ "$continue_choice" =~ ^(Нет|нет|Н|н|No|no|N|n|\-)$ ]]; then
          exit 0
         else
          echo "Ошибка: Неверный ввод."
        fi
    done
done