
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
