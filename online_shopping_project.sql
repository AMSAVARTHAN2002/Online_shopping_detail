CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    address TEXT,
    city VARCHAR(50) DEFAULT 'Chennai',
    state VARCHAR(50),
    zip_code VARCHAR(10),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    description TEXT,
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2),
    order_status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE
);
CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50),
    payment_status VARCHAR(20) DEFAULT 'Pending',
    amount_paid DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);
CREATE TABLE Shipping (
    shipping_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    shipping_address TEXT,
    shipping_city VARCHAR(50),
    shipping_state VARCHAR(50),
    shipping_zip VARCHAR(10),
    shipping_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    delivery_status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);
-- Customer Data
INSERT INTO Customer (first_name, last_name, email, phone_number, address, city, state, zip_code)
VALUES
('Arjun', 'Reddy', 'arjun.reddy@example.com', '9876543211', '789 Street, T. Nagar', 'Chennai', 'Tamil Nadu', '600017'),
('Priya', 'Sharma', 'priya.sharma@example.com', '9876543212', '987 Street, Mylapore', 'Chennai', 'Tamil Nadu', '600004'),
('Vikram', 'Iyer', 'vikram.iyer@example.com', '9876543213', '123 Street, Nungambakkam', 'Chennai', 'Tamil Nadu', '600034'),
('Aishwarya', 'Sundar', 'aishwarya.sundar@example.com', '9876543214', '456 Street, Adyar', 'Chennai', 'Tamil Nadu', '600020'),
('Karthik', 'Murthy', 'karthik.murthy@example.com', '9876543215', '321 Street, Saidapet', 'Chennai', 'Tamil Nadu', '600015'),
('Lakshmi', 'Raj', 'lakshmi.raj@example.com', '9876543216', '654 Street, Perambur', 'Chennai', 'Tamil Nadu', '600011'),
('Suresh', 'Nair', 'suresh.nair@example.com', '9876543217', '852 Street, Guindy', 'Chennai', 'Tamil Nadu', '600032'),
('Sneha', 'Rao', 'sneha.rao@example.com', '9876543218', '987 Street, Royapettah', 'Chennai', 'Tamil Nadu', '600014');

-- Product Data
INSERT INTO Product (product_name, category, price, stock_quantity, description)
VALUES
('Smart TV', 'Electronics', 35000.00, 15, '42-inch Smart LED TV with 4K resolution'),
('Washing Machine', 'Home Appliances', 20000.00, 8, 'Fully Automatic Front Load Washing Machine'),
('Bluetooth Speaker', 'Electronics', 3000.00, 50, 'Portable Bluetooth speaker with powerful bass'),
('Refrigerator', 'Home Appliances', 25000.00, 12, 'Double door refrigerator with 300L capacity'),
('Microwave Oven', 'Home Appliances', 8000.00, 20, 'Convection Microwave Oven with grill function'),
('Air Conditioner', 'Electronics', 45000.00, 10, '1.5 Ton Split Air Conditioner with inverter technology'),
('Gaming Console', 'Electronics', 50000.00, 5, 'Next-gen gaming console with 4K gaming support'),
('Laptop', 'Electronics', 60000.00, 10, '14-inch laptop with 16GB RAM and 512GB SSD storage'),
('Smartphone', 'Electronics', 15000.00, 25, 'Mid-range smartphone with 6.5-inch display and 128GB storage'),
('Headphones', 'Electronics', 2000.00, 30, 'Over-ear wireless headphones with noise cancellation');

-- Insert Orders
INSERT INTO Orders (customer_id, total_amount, order_status)
VALUES
(1, 35000.00, 'Confirmed'),  -- Arjun Reddy orders a Smart TV
(2, 20000.00, 'Confirmed'),  -- Priya Sharma orders a Washing Machine
(3, 3000.00, 'Shipped'),     -- Vikram Iyer orders a Bluetooth Speaker
(4, 25000.00, 'Processing'), -- Aishwarya Sundar orders a Refrigerator
(5, 45000.00, 'Delivered'),  -- Karthik Murthy orders an Air Conditioner
(6, 15000.00, 'Confirmed'),  -- Lakshmi Raj orders a Smartphone
(7, 60000.00, 'Processing'), -- Suresh Nair orders a Laptop
(8, 2000.00, 'Confirmed');   -- Sneha Rao orders a pair of Headphones

-- Insert Order Details
INSERT INTO OrderDetails (order_id, product_id, quantity, price_per_unit)
VALUES
(1, 1, 1, 35000.00),  -- Arjun Reddy ordered 1 Smart TV
(2, 2, 1, 20000.00),  -- Priya Sharma ordered 1 Washing Machine
(3, 3, 1, 3000.00),   -- Vikram Iyer ordered 1 Bluetooth Speaker
(4, 4, 1, 25000.00),  -- Aishwarya Sundar ordered 1 Refrigerator
(5, 6, 1, 45000.00),  -- Karthik Murthy ordered 1 Air Conditioner
(6, 9, 1, 15000.00),  -- Lakshmi Raj ordered 1 Smartphone
(7, 8, 1, 60000.00),  -- Suresh Nair ordered 1 Laptop
(8, 10, 1, 2000.00);  -- Sneha Rao ordered 1 Headphones

SELECT o.order_id, o.order_date, c.first_name, c.last_name, o.total_amount, o.order_status 
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id;


SELECT p.product_name, od.quantity, od.price_per_unit 
FROM OrderDetails od
JOIN Product p ON od.product_id = p.product_id
WHERE od.order_id = 1;


-- View customer details
CREATE VIEW CustomerDetails AS
SELECT customer_id, first_name, last_name, email, city, state
FROM Customer;

-- Query from the view
SELECT * FROM CustomerDetails;
-- Insert a new customer
INSERT INTO Customer (first_name, last_name, email, phone_number, address, city, state, zip_code)
VALUES ('Ravi', 'Kumar', 'ravi.kumar@example.com', '9876543219', '321 Street, Anna Nagar', 'Chennai', 'Tamil Nadu', '600040');
-- Fetch all customers from Chennai
SELECT * FROM Customer
WHERE city = 'Chennai';
-- Fetch all products ordered by price ascending
SELECT * FROM Product
ORDER BY price ASC;

-- Fetch all products ordered by price descending
SELECT * FROM Product
ORDER BY price DESC;
-- Find the total amount spent by each customer
SELECT customer_id, SUM(total_amount) AS total_spent
FROM Orders
GROUP BY customer_id;

-- Calculate the average product price
SELECT AVG(price) AS average_price
FROM Product;
-- Group products by category and count the number of products in each category
SELECT category, COUNT(product_id) AS product_count
FROM Product
GROUP BY category;
-- Insert new customer, ignoring duplicates based on unique email
INSERT IGNORE INTO Customer (first_name, last_name, email, phone_number, address, city, state, zip_code)
VALUES ('Ajay', 'Mehta', 'ajay.mehta@example.com', '9876543220', '456 Street, Velachery', 'Chennai', 'Tamil Nadu', '600042');
-- Fetch all orders with customer names
SELECT Orders.order_id, Customer.first_name, Customer.last_name, Orders.total_amount
FROM Orders
INNER JOIN Customer ON Orders.customer_id = Customer.customer_id;
-- Fetch all customers and their orders (even if some customers haven't placed an order)
SELECT Customer.first_name, Customer.last_name, Orders.order_id, Orders.total_amount
FROM Customer
LEFT JOIN Orders ON Customer.customer_id = Orders.customer_id;
-- Fetch names of customers from Chennai and products from the Electronics category
SELECT first_name AS name FROM Customer WHERE city = 'Chennai'
UNION
SELECT product_name AS name FROM Product WHERE category = 'Electronics';
-- Find all customers who have placed an order for an amount greater than any order placed by customer_id = 1
SELECT * FROM Customer
WHERE customer_id IN (SELECT customer_id FROM Orders WHERE total_amount > ANY (SELECT total_amount FROM Orders WHERE customer_id = 1));

-- Find all products whose price is less than all prices of products in the 'Electronics' category
SELECT * FROM Product
WHERE price < ALL (SELECT price FROM Product WHERE category = 'Electronics');
-- Calculate cumulative total spent by each customer in order history
SELECT customer_id, total_amount, SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS cumulative_total
FROM Orders;
-- Create a stored function that calculates total amount spent by a customer
DELIMITER $$

CREATE FUNCTION GetTotalSpent(customerID INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE totalSpent DECIMAL(10,2);
    SELECT SUM(total_amount) INTO totalSpent
    FROM Orders
    WHERE customer_id = customerID;
    
    IF totalSpent IS NULL THEN
        SET totalSpent = 0.00;
    END IF;
    
    RETURN totalSpent;
END $$

DELIMITER ;

-- Example usage: Get the total amount spent by customer with ID 1
SELECT GetTotalSpent(1) AS total_spent_by_customer_1;


-- Enable safe mode (strict SQL mode)
SET sql_mode = 'STRICT_ALL_TABLES';

-- Disable safe mode (allow more lenient behavior)
SET sql_mode = '';



