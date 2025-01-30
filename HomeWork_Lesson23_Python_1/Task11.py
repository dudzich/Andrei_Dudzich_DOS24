import math

number = float(input("Введите число:"))
power = int(input("Введите степень:"))

result = math.pow(number, power)
print(f"{number} в степени {power} равно {result:.2f}")
