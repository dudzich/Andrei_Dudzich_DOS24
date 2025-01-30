import statistics

def calculate_statistics(numbers):
    if not numbers:
        return "Список чисел пуст."
    
    mean_value = statistics.mean(numbers)
    median_value = statistics.median(numbers)
    variance_value = statistics.variance(numbers) if len(numbers) > 1 else 0
    
    return {
        "Среднее арифметическое": mean_value,
        "Медиана": median_value,
        "Дисперсия": variance_value
    }

if __name__ == "__main__":
    try:
        numbers = list(map(float, input("Введите список чисел через пробел: ").split()))
        result = calculate_statistics(numbers)
        print(f"Данные: [{numbers}]")
        for key, value in result.items():
            print(f"{key}: {value:.2f}")
    except ValueError:
        print("Ошибка: Введите корректные числовые значения.")