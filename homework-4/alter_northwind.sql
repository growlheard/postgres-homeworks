-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
ALTER TABLE products ADD CONSTRAINT chk_unit_price CHECK (unit_price > 0);

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE products ADD CONSTRAINT chk_discontinued CHECK (discontinued IN (0, 1));


-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
-- Вариант Первый:
SELECT * INTO discontinued_products FROM products WHERE discontinued = 1;
-- Вариант второй:
CREATE TABLE discontinued_products AS
SELECT * FROM products WHERE discontinued = 1;
-- Не знаю есть лии разница между ними.

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.
-- как я понял можно сделать двумя вариантами,
--более безопасным:
SELECT * FROM order_details WHERE product_id IN (SELECT product_id FROM products WHERE discontinued = 1);
-- удалить данные оттуда: 
DELETE FROM order_details WHERE product_id IN (SELECT product_id FROM products WHERE discontinued = 1);
-- или более ненадежным способом с убиранием ограничения внешнего ключа:
ALTER TABLE order_details DROP CONSTRAINT fk_order_details_products;
-- и удалить нужные нам записи:
DELETE FROM products WHERE discontinued = 1;
