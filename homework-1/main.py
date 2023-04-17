import csv
import psycopg2

conn = psycopg2.connect(host='localhost', database='north', user='postgres', password='qwerty')


try:
    with conn:
        with conn.cursor() as cur:
            with open("north_data/employees_data.csv") as file:
                i = 1
                reader = csv.reader(file)
                for row in reader:
                    if '_' not in row[0]:
                        cur.execute("INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)",
                                    (i, row[0], row[1], row[2], row[3], row[4]))
                        i += 1
            with open("north_data/customers_data.csv") as file:
                reader = csv.reader(file)
                for row in reader:
                    if '_' not in row[0]:
                        cur.execute("INSERT INTO customers VALUES (%s, %s, %s)",
                                    (row[0], row[1], row[2]))
            with open("north_data/orders_data.csv") as file:
                reader = csv.reader(file)
                for row in reader:
                    if '_' not in row[0]:
                        cur.execute("INSERT INTO orders VALUES (%s, %s, %s, %s, %s)",
                                    (row[0], row[1], row[2], row[3], row[4]))
except psycopg2.Error as e:
    print(f"Ошибка при вставке данных в базу данных: {e}")
finally:
    conn.close()
