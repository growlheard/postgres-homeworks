-- SQL-команды для создания таблиц
create table employees
(
  employee_id int PRIMARY KEY,
  first_name varchar(100) not null,
  last_name varchar(100) NOT NULL,
  title varchar NOT NULL ,
  birth_date date NOT NULL,
  notes text NOT NULL
);

CREATE TABLE customers
(
     customer_id varchar PRIMARY KEY,
	 company_name varchar NOT NULL,
	 contact_name varchar NOT NULL
);

CREATE TABLE orders
(
    order_id int PRIMARY KEY,
	customer_id varchar REFERENCES customers(customer_id) NOT NULL,
	employee_id int REFERENCES employees(employee_id) NOT NULL,
	order_date date NOT NULL,
	ship_city varchar NOT NULL

);