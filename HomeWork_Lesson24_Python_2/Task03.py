import os

directory = input("Введите путь к директории (или нажмите Enter для текущей): ")

#Текекущая директория
if not directory:
    directory = os.getcwd()

substring = input("Введите подстроку для поиска в названиях файлов: ")

if not os.path.isdir(directory):
    print("Указанный путь не является директорией или не существует.")
else:

    matching_files = []

    # Обход всех файлов в директории и поддиректориях
    for root, dirs, files in os.walk(directory):
        for file in files:
            if substring in file:
                # Добавляем найденный файл в список
                matching_files.append(os.path.join(root, file))

    if matching_files:
        print("Найденные файлы:")
        for file in matching_files:
            print(file)
    else:
        print("Файлы, содержащие подстроку, не найдены.")
    
