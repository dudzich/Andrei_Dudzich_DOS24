str1 = input("Введите первую строку: ")
str2 = input("Введите вторую строку: ")

# Поиск общих символов с использованием множеств
common_chars = set(str1) & set(str2)

if common_chars:
    print("Общие символы:", " ".join(common_chars))
else:
    print("Общих символов нет")
