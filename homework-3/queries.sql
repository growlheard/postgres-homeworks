-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT DISTINCT customers.company_name, CONCAT(first_name, ' ', last_name) AS employee_name
FROM customers
INNER JOIN orders USING(customer_id)
INNER JOIN employees USING(employee_id)
INNER JOIN shippers ON orders.ship_via = shippers.shipper_id
WHERE customers.city = 'London' 
AND employees.city = 'London' 
AND shippers.company_name = 'United Package'
ORDER BY customers.company_name;

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT product_name, units_in_stock, contact_name, phone
FROM products
JOIN suppliers USING(supplier_id)
WHERE discontinued = 0 AND units_in_stock < 25 AND (category_id = 4 OR category_id = 2)
ORDER BY products.units_in_stock ASC

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT company_name
FROM customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM orders)


-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT DISTINCT product_name
FROM products
WHERE product_id IN (
  SELECT product_id 
  FROM order_details 
  WHERE quantity = 10
)
