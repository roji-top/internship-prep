CREATE DATABASE codeit_internship;

USE codeit_internship;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
);


INSERT INTO Customers VALUES
(1, 'Ram', 'Kathmandu'),
(2, 'Sita', 'Bhaktapur'),
(3, 'Hari', 'Lalitpur'),
(4, 'Gita', 'Kathmandu'),
(5, 'Rita', 'Pokhara');

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 80000),
(102, 'Mouse', 'Electronics', 1000),
(103, 'Keyboard', 'Electronics', 2000),
(104, 'Chair', 'Furniture', 5000),
(105, 'Table', 'Furniture', 10000);

INSERT INTO Orders VALUES
(201, 1, '2026-01-10'),
(202, 2, '2026-01-12'),
(203, 1, '2026-01-15'),
(204, 3, '2026-01-18'),
(205, 4, '2026-01-20');

INSERT INTO Order_Items VALUES
(1, 201, 101, 1),
(2, 201, 102, 2),
(3, 202, 103, 1),
(4, 203, 104, 2),
(5, 204, 105, 1),
(6, 205, 102, 3);


SELECT * FROM Customers;

SELECT * FROM Customers
WHERE city = 'Kathmandu';


SELECT * FROM Products
ORDER BY price DESC;

SELECT city, COUNT(*)
FROM Customers
GROUP BY city;

SELECT Customers.customer_name,
       Orders.order_id
FROM Customers
INNER JOIN Orders
ON Customers.customer_id = Orders.customer_id;


SELECT COUNT(*) FROM Customers;

SELECT SUM(price) FROM Products;

SELECT AVG(price) FROM Products;

SELECT MIN(price) FROM Products;

SELECT MAX(price) FROM Products;
#Sort products by price
SELECT *
FROM Products
WHERE price > 5000;

# Sort products by price
SELECT *
FROM Products
ORDER BY price ASC;

SELECT COUNT(*) AS total_customers
FROM Customers;

SELECT MIN(price) AS cheapest_price
FROM Products;


# Count customers in each city
SELECT city,
       COUNT(*) AS total_customers
FROM Customers
GROUP BY city;


#Display customer names and order IDs
SELECT Customers.customer_name,
       Orders.order_id
FROM Customers
INNER JOIN Orders
ON Customers.customer_id = Orders.customer_id;


#Display all customers, including those without orders.
SELECT Customers.customer_name,
       Orders.order_id
FROM Customers
LEFT JOIN Orders
ON Customers.customer_id = Orders.customer_id;

-- 1. Total value of each order
SELECT o.order_id, SUM(p.price * oi.quantity) AS order_total
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY o.order_id;

-- 2. Total spending per customer (highest first)
SELECT c.customer_name, SUM(p.price * oi.quantity) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- 3. Customers who never placed an order
SELECT c.customer_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 4. Best-selling product by quantity
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- 5. Revenue by category
SELECT p.category, SUM(p.price * oi.quantity) AS revenue
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.category;

-- 6. Total revenue across all orders
SELECT SUM(p.price * oi.quantity) AS total_revenue
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id;

-- 7. Customers who spent more than 5000
SELECT c.customer_name, SUM(p.price * oi.quantity) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY c.customer_name
HAVING SUM(p.price * oi.quantity) > 5000;

-- 8. Average order value
SELECT AVG(order_total) AS avg_order_value
FROM (
    SELECT o.order_id, SUM(p.price * oi.quantity) AS order_total
    FROM Orders o
    JOIN Order_Items oi ON o.order_id = oi.order_id
    JOIN Products p ON oi.product_id = p.product_id
    GROUP BY o.order_id
) AS t;

-- 9. RIGHT JOIN: all customers, with their orders if any
SELECT c.customer_name, o.order_id
FROM Orders o
RIGHT JOIN Customers c ON o.customer_id = c.customer_id;

-- 10. Number of orders per customer
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
