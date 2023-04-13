"""Скрипт для заполнения данными таблиц в БД Postgres."""
import csv
import psycopg2

# Создаем подключение к базе данных Postgres
conn = psycopg2.connect(host='localhost', database='north', user='postgres', password='qwerty')

# Читаем данные из CSV-файлов и заполняем списки словарей для каждой таблицы
employees_data = []
with open('north_data/employees_data.csv', 'r') as ed:
    data = csv.DictReader(ed)
    for i in data:
        employees_data.append(i)

custumers_data = []
with open('north_data/customers_data.csv', 'r') as cd:
    data = csv.DictReader(cd)
    for i in data:
        custumers_data.append(i)

orders_data = []
with open('north_data/orders_data.csv', 'r') as od:
    data = csv.DictReader(od)
    for i in data:
        orders_data.append(i)

try:
    with conn:
        with conn.cursor() as cur:
            # Вставляем данные в таблицу employees
            for i in range(len(employees_data)):
                cur.execute('INSERT INTO employees VALUES (%s, %s, %s, %s, %s)',
                            (employees_data[i]['first_name'],
                             employees_data[i]['last_name'],
                             employees_data[i]['title'],
                             employees_data[i]['birth_date'],
                             employees_data[i]['notes']))

            # Вставляем данные в таблицу customers
            for i in range(len(custumers_data)):
                cur.execute('INSERT INTO customers VALUES (%s, %s, %s)',
                            (custumers_data[i]['customer_id'],
                             custumers_data[i]['company_name'],
                             custumers_data[i]['contact_name']))

            # Вставляем данные в таблицу orders
            for i in range(len(employees_data)):
                cur.execute('INSERT INTO orders VALUES (%s, %s, %s, %s, %s)',
                            (orders_data[i]['order_id'],
                             orders_data[i]['customer_id'],
                             orders_data[i]['employee_id'],
                             orders_data[i]['order_date'],
                             orders_data[i]['ship_city']))

except psycopg2.Error as e:
    print(f"Ошибка при вставке данных в базу данных: {e}")

finally:
    conn.close()
