#!/bin/bash

# Скрипт для получения информации из Star Wars API (SWAPI).
# Позволяет просматривать список ресурсов (персонажи, планеты, фильмы, звездолеты, транспортные средства, виды)
# и получать детальную информацию о конкретном ресурсе по его ID.

# Использование: ./starwars_api.sh

# Интерактивный скрипт, не принимает аргументов командной строки.
# После запуска пользователю предлагается выбрать тип ресурса из меню:
# 1. Персонажи
# 2. Планеты
# 3. Фильмы
# 4. Звездолеты
# 5. Транспортные средства
# 6. Виды персонажей
# 0. Выход

# После выбора типа ресурса, появляется меню с действиями:
# 1. Список всех ресурсов выбранного типа
# 2. Информация о конкретном ресурсе по ID
# 0. Назад (к выбору типа ресурса)

# Для детальной информации о ресурсе запрашивается ID ресурса.
# Выводятся соответствующие данные, специфичные для каждого типа ресурса.

# Пример работы:
# 1. Запустить скрипт: ./starwars_api.sh
# 2. Выбрать тип ресурса, введя соответствующий номер.
# 3. Выбрать действие: список всех ресурсов (1) или информацию по ID (2).
# 4. При выборе информации по ID ввести ID ресурса.
# 5. Скрипт выведет соответствующую информацию.
# 6. Пользователю будет предложено вернуться к выбору ресурса или завершить работу.

# Функция для выполнения GET запроса к API
get_starwars_data() {
    url=$1
    response=$(curl -s "$url")
    echo "$response"
}

# Функция для вывода всех ресурсов с заданным URL
get_all_resources() {
    resource_name=$1
    url="https://swapi.py4e.com//api/$resource_name/"
    response=$(get_starwars_data "$url")
    total_results=$(echo "$response" | jq '.count')

    echo "Список всех $resource_name:"

    for i in $(seq 1 $total_results); do
        id=$(echo "$response" | jq -r ".results[$i-1].url" | awk -F'/' '{print $(NF-1)}')
        name=$(echo "$response" | jq -r ".results[$i-1].name // .results[$i-1].title")

        # Фильтрация пустых значений
        if [[ -z "$name" || "$name" == "null" ]]; then
            continue
        fi

        echo "ID: $id - Название: $name"
        
    done
}


# Функция для получения информации о ресурсе по ID
get_resource_by_id() {
    resource_name=$1
    resource_id=$2
    url="https://swapi.py4e.com//api/$resource_name/$resource_id/"
    response=$(get_starwars_data "$url")

    if [ -z "$response" ]; then
        echo "$resource_name с ID $resource_id не найден."
        return
    fi

    echo "----------------------------"
    echo "Информация о $resource_name:"
    case $resource_name in
        people)
            name=$(echo "$response" | jq -r '.name')
            gender=$(echo "$response" | jq -r '.gender')
            height=$(echo "$response" | jq -r '.height')
            mass=$(echo "$response" | jq -r '.mass')
            hair_color=$(echo "$response" | jq -r '.hair_color')
            eye_color=$(echo "$response" | jq -r '.eye_color')
            birth_year=$(echo "$response" | jq -r '.birth_year')
            homeworld_url=$(echo "$response" | jq -r '.homeworld')
            homeworld_name=$(get_starwars_data "$homeworld_url" | jq -r '.name')

            echo "----------------------------"
            echo "Имя: $name"
            echo "Пол: $gender"
            echo "Рост: $height см"
            echo "Масса: $mass кг"
            echo "Цвет волос: $hair_color"
            echo "Цвет глаз: $eye_color"
            echo "Дата рождения: $birth_year"
            echo "Родная планета: $homeworld_name"
            ;;
        planets)
            name=$(echo "$response" | jq -r '.name')
            diameter=$(echo "$response" | jq -r '.diameter')
            gravity=$(echo "$response" | jq -r '.gravity')
            climate=$(echo "$response" | jq -r '.climate')
            terrain=$(echo "$response" | jq -r '.terrain')
            population=$(echo "$response" | jq -r '.population')

            echo "----------------------------"
            echo "Название: $name"
            echo "Диаметр: $diameter км"
            echo "Гравитация: $gravity"
            echo "Климат: $climate"
            echo "Тип местности: $terrain"
            echo "Население: $population"
            ;;
        films)
            title=$(echo "$response" | jq -r '.title')
            director=$(echo "$response" | jq -r '.director')
            producer=$(echo "$response" | jq -r '.producer')
            release_date=$(echo "$response" | jq -r '.release_date')

            echo "----------------------------"
            echo "Название: $title"
            echo "Режиссёр: $director"
            echo "Продюсер: $producer"
            echo "Дата выхода: $release_date"
            ;;
        starships | vehicles)
            name=$(echo "$response" | jq -r '.name')
            model=$(echo "$response" | jq -r '.model')
            manufacturer=$(echo "$response" | jq -r '.manufacturer')
            cost_in_credits=$(echo "$response" | jq -r '.cost_in_credits')
            length=$(echo "$response" | jq -r '.length')
            crew=$(echo "$response" | jq -r '.crew')
            passengers=$(echo "$response" | jq -r '.passengers')

            echo "----------------------------"
            echo "Название: $name"
            echo "Модель: $model"
            echo "Производитель: $manufacturer"
            echo "Стоимость: $cost_in_credits кредитов"
            echo "Длина: $length м"
            echo "Экипаж: $crew"
            echo "Пассажиры: $passengers"
            ;;
        species)
            name=$(echo "$response" | jq -r '.name')
            classification=$(echo "$response" | jq -r '.classification')
            designation=$(echo "$response" | jq -r '.designation')
            average_height=$(echo "$response" | jq -r '.average_height')
            skin_colors=$(echo "$response" | jq -r '.skin_colors')
            hair_colors=$(echo "$response" | jq -r '.hair_colors')
            eye_colors=$(echo "$response" | jq -r '.eye_colors')
            average_lifespan=$(echo "$response" | jq -r '.average_lifespan')

            echo "----------------------------"
            echo "Название: $name"
            echo "Классификация: $classification"
            echo "Назначение: $designation"
            echo "Средний рост: $average_height см"
            echo "Цвета кожи: $skin_colors"
            echo "Цвета волос: $hair_colors"
            echo "Цвета глаз: $eye_colors"
            echo "Средняя продолжительность жизни: $average_lifespan лет"
            ;;
        *)
            echo "Детальная информация для ресурса '$resource_name' не поддерживается."
            ;;
    esac
}

# Меню выбора типа ресурса
while true; do
    echo "----------------------------"
    echo "Выберите тип ресурса:"
    echo "----------------------------"
    echo "1. Персонажи"
    echo "2. Планеты"
    echo "3. Фильмы"
    echo "4. Звездолеты"
    echo "5. Транспортные средства"
    echo "6. Виды персонажей"
    echo "0. Выход"
    echo "----------------------------"
    read -p "Введите номер действия: " choice
    

    case $choice in
        1)
            resource_type="people"
            ;;
        2)
            resource_type="planets"
            ;;
        3)
            resource_type="films"
            ;;
        4)
            resource_type="starships"
            ;;
        5)
            resource_type="vehicles"
            ;;
        6)
            resource_type="species"
            ;;
        0)
            echo "----------------------------"
            echo "Выход из программы."
            exit 0
            ;;
        *)
            echo "----------------------------"
            echo "Неверный выбор. Попробуйте снова."
            continue
            ;;
    esac

    # Меню с действиями для выбранного ресурса
    while true; do
        echo "----------------------------"
        echo "Выберите действие:"
        echo "----------------------------"
        echo "1. Список всех $resource_type"
        echo "2. Информация о ресурсе по ID"
        echo "0. Назад"
        read -p "Введите номер действия: " action

        case $action in
            1)
                get_all_resources "$resource_type"
                ;;
            2)
                echo "----------------------------"
                read -p "Введите ID ресурса: " resource_id
                get_resource_by_id "$resource_type" "$resource_id"
                ;;
            0)
                echo "----------------------------"
                break  # Возвращаемся в основное меню
                ;;
            *)
                echo "----------------------------"
                echo "Неверный выбор. Попробуйте снова."
                ;;
        esac
    done

done
