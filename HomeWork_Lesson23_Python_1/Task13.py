import statistics

number1 = float(input("Введите первое число:"))
number2 = float(input("Введите второе число:"))

numbers = [number1, number2]
average_number = statistics.mean(numbers)
print(f"{average_number:.1f}")

