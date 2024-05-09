import calendar

"""Простой метод который выводит, календарь на месяц в консоль"""

print('Добро пожаловать в календарь\n')

year = int(input('Пожалуйста введите год: '))
month = int(input('Введите номер любого месяца: '))

print(calendar.month(year, month))

print('Всего хорошего!')