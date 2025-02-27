CREATE DATABASE ecommerce;
USE ecommerce;
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(100),
signup_date DATE 
);
CREATE TABLE products (
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50),
price DECIMAL(10,2)
);
CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
total_amount DECIMAL(10,2),
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
);
CREATE TABLE order_details (
order_detail_id INT PRIMARY KEY,
order_id INT,
product_id INT,
quantity INT,
subtotal DECIMAL(10,2),
FOREIGN KEY (order_id) 
REFERENCES orders(order_id),
FOREIGN KEY (product_id)
REFERENCES products(product_id)
);
INSERT INTO customers (customer_id, first_name, last_name, email, signup_date) VALUES
(1, 'Alice', 'Smith', 'alice@example.com', '2024-01-15'),
(2, 'Bob', 'Johnson', 'bob@example.com', '2024-02-01'),
(3, 'Charlie',  'Brown', 'charlie@example.com', '2024-02-10');
INSERT INTO products (product_id, product_name, category, price) VALUES 
(101, 'Laptop', 'Electronics', 800.00),
(102, 'Phone', 'Electronics', 500.00),
(103, 'Headphones', 'Accessories', 50.00),
(104, 'Monitor', 'Electronics', 200.00);
INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES 
(1001, 1, '2024-02-01', 850.00),
(1002, 2, '2024-02-05', 500.00),
(1003, 3, '2024-02-07', 250.00); 
INSERT INTO order_details (order_detail_id, order_id, product_id, quantity, subtotal) VALUES 
(1, 1001, 101, 1, 800.00),
(2, 1001, 103, 1, 50.00),
(3, 1002, 102, 1, 500.00),
(4, 1003, 104, 1, 200.00),
(5, 1003, 103, 1, 50.00);

--Find Total Sales Per Product
SELECT p.product_name,
SUM(od.quantity) AS total_sold,
SUM(od.subtotal) AS total_revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

--Find the Best Customers by Spending
SELECT c.first_name, c.last_name,
SUM(o.total_amount) AS total_spent
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;

--Monthly Sales Trend
SELECT date_format(order_date,'%y-%m') AS month, SUM(total_amount) AS monthly_sales
FROM orders
GROUP BY month 
ORDER BY month;

--Most Popular Product Category
SELECT p.category, SUM(od.subtotal) AS total_revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

--Customer Order Frequency
SELECT c.first_name, c.last_name,
COUNT(o.order_id) AS order_count
FROM customers c 
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY order_count DESC;
 




