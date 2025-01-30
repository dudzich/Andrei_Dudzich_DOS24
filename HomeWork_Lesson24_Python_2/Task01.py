import os

# Определение текущей директории для создания в ней файла
current_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(current_dir, "ping_results.txt")

# IP через запятую
input_ips = input("Введите IP-адреса через запятую: ")
ips = [ip.strip() for ip in input_ips.split(",")]

with open(file_path, "w") as file:
    for ip in ips:
        
        command = f"ping -c 1 {ip}"
        
        response = os.system(command)
        
        if response == 0:
            result = f"{ip} - {'Доступен'}"
            print(f"\033[32m{result}\033[0m")
        else:
            result = f"{ip} - {'Недоступен'}"
            print(f"\033[31m{result}\033[0m")
        
        file.write(result + "\n")

print(f"Проверка завершена! Результаты сохранены в файле {file_path}")
