from collections import Counter

input_tuple = input("Введите кортеж (элементы через запятую): ")

# Преобразуем строку в кортеж
input_tuple = tuple(input_tuple.split(","))

# Подсчитываем количество каждого элемента
counter = Counter(input_tuple)

if len(input_tuple) == len(counter):
    print("Все элементы уникальны")
else:
    print("Есть повторяющиеся элементы")

    print("Повторяющиеся элементы:")
    for element, count in counter.items():
        if count > 1:
            print(f"{element} - {count} раз(а)")
