#!/bin/bash

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

# Функция для получения перевода текста в зависимости от языка
get_text() {
    echo "${TEXTS[$1]}"
}

# Функция форматирования чисел с плавающей точкой
format_float() {
    echo "${1:-N/A}"
}

# Функция форматирования целых чисел
format_int() {
    echo "${1:-N/A}"
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
        printf "Город: %s\nКоординаты: широта %s, долгота %s\nСтрана: %s\nНаселение: %s\nЧасовой пояс: %s\nВосход солнца: %s\nЗакат солнца: %s\n" "$city" "$lat" "$lon" "$country" "${population:-N/A}" "${timezone:-N/A}" "$sunrise" "$sunset"
    else
        printf "City: %s\nCoordinates: Latitude %s, Longitude %s\nCountry: %s\nPopulation: %s\nTimezone: %s\nSunrise: %s\nSunset: %s\n" "$city" "$lat" "$lon" "$country" "${population:-N/A}" "${timezone:-N/A}" "$sunrise" "$sunset"
    fi
    echo ""

    echo "$(get_text "${lang}_weather_info")"
    if [ "$lang" == "ru" ]; then
        printf "Температура: %s°C\nОщущается как: %s°C\nДавление: %d гПа\nУровень моря: %d гПа\nУровень земли: %d гПа\nВлажность: %d%%\nПогода: %s\nОблачность: %d%%\nСкорость ветра: %s м/с\nНаправление ветра: %d°\nПорывы ветра: %s м/с\nВидимость: %d м\nВероятность осадков: %s%%\n" "$(format_float "$temp")" "$(format_float "$feels_like")" "$(format_int "$pressure")" "$(format_int "$sea_level")" "$(format_int "$grnd_level")" "$(format_int "$humidity")" "$weather" "$(format_int "$clouds")" "$(format_float "$wind_speed")" "$(format_int "$wind_deg")" "$(format_float "$wind_gust")" "$(format_int "$visibility")" "$(format_float "$pop")"
    else
        printf "Temperature: %s°C\nFeels like: %s°C\nPressure: %d hPa\nSea level: %d hPa\nGround level: %d hPa\nHumidity: %d%%\nWeather: %s\nCloudiness: %d%%\nWind speed: %s m/s\nWind direction: %d°\nWind gust: %s m/s\nVisibility: %d m\nPrecipitation probability: %s%%\n" "$(format_float "$temp")" "$(format_float "$feels_like")" "$(format_int "$pressure")" "$(format_int "$sea_level")" "$(format_int "$grnd_level")" "$(format_int "$humidity")" "$weather" "$(format_int "$clouds")" "$(format_float "$wind_speed")" "$(format_int "$wind_deg")" "$(format_float "$wind_gust")" "$(format_int "$visibility")" "$(format_float "$pop")"
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

# Основной цикл
while true; do
    choose_language
    choose_city
done
