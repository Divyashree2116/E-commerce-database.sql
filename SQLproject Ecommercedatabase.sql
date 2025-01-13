create database Easyshop;
use easyshop;
-- 1. Categories Table (Parent)
CREATE TABLE Categories (
    Category_ID INT PRIMARY KEY AUTO_INCREMENT,
    Category_Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255)
);

-- 2. Customers Table (Parent)
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address TEXT NOT NULL
);


-- 3. Products Table (Child of Categories)
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY AUTO_INCREMENT,
    Product_Name VARCHAR(100) NOT NULL,
    Category_ID INT,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    Description TEXT,
    CONSTRAINT fk_category FOREIGN KEY (Category_ID) 
        REFERENCES Categories(Category_ID) 
        ON DELETE SET NULL
);


-- 4. Orders Table (Child of Customers)
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    Order_Date DATE,
    Total_Amount DECIMAL(10, 2) NOT NULL,
    Order_Status VARCHAR(50) DEFAULT 'Pending',
    CONSTRAINT fk_customer FOREIGN KEY (Customer_ID) 
        REFERENCES Customers(Customer_ID) 
        ON DELETE CASCADE
);

-- 5. Order_Items Table (Child of Orders and Products)
CREATE TABLE Order_Items (
    Order_Item_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Quantity INT NOT NULL,
    Price_Per_Unit DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_order FOREIGN KEY (Order_ID) 
        REFERENCES Orders(Order_ID) 
        ON DELETE CASCADE,
    CONSTRAINT fk_product FOREIGN KEY (Product_ID) 
        REFERENCES Products(Product_ID) 
        ON DELETE CASCADE
);


-- 6. Payments Table (Child of Orders)
CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Order_ID INT NOT NULL,
    Payment_Date DATE,
    Payment_Method VARCHAR(50),
    Payment_Amount DECIMAL(10, 2) NOT NULL,
    Payment_Status VARCHAR(50) DEFAULT 'Completed',
    CONSTRAINT fk_payment_order FOREIGN KEY (Order_ID) 
        REFERENCES Orders(Order_ID) 
        ON DELETE CASCADE
);
-- 7. Shipment Table (Child of Orders)
CREATE TABLE Shipment (
Shipment_ID INT PRIMARY KEY AUTO_INCREMENT,
Order_ID INT NOT NULL,
Shipping_Address TEXT NOT NULL,
Shipment_Date DATE,
Shipment_Status VARCHAR(50) DEFAULT 'Processing',
    CONSTRAINT fk_shipment_order FOREIGN KEY (Order_ID) 
        REFERENCES Orders(Order_ID) 
        ON DELETE CASCADE
);

-- 8. Reviews Table (Child of Customers and Products)
CREATE TABLE Reviews (
    Review_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Feedback VARCHAR(255),
    Review_Date DATE,
    CONSTRAINT fk_customers_review FOREIGN KEY (Customer_ID) 
        REFERENCES Customers(Customer_ID) 
        ON DELETE CASCADE,
    CONSTRAINT fk_products_review FOREIGN KEY (Product_ID) 
        REFERENCES Products(Product_ID) 
        ON DELETE CASCADE
);

use easyshop;
INSERT INTO Categories (Category_Name, Description) VALUES
('Fashion', 'Clothing and accessories'),
('Health', 'Healthcare and wellness products'),
('Kitchen', 'Kitchen tools and appliances'),
('Travel', 'Travel gear and accessories'),
('Stationery', 'Stationery items and office supplies'),
('Technology', 'Gadgets and electronics'),
('Outdoor', 'Outdoor and adventure equipment'),
('Books', 'Books and reading materials'),
('Toys', 'Toys and games for kids'),
('Sports', 'Sports equipment and accessories'),
('Beauty', 'Cosmetics and beauty products'),
('Groceries', 'Daily groceries and food items'),
('Jewelry', 'Jewelry and ornaments');

INSERT INTO Customers (Customer_Name, Email, Phone, Address) VALUES
('Arun Kumar', 'arun@gmail.com', '9876543210', 'Chennai, Tamil Nadu'),
('Priya Sharma', 'priya@gmail.com', '9876543211', 'Delhi, Delhi'),
('Rahul Verma', 'rahul@gmail.com', '9876543212', 'Mumbai, Maharashtra'),
('Sneha Rao', 'sneha@gmail.com', '9876543213', 'Hyderabad, Telangana'),
('Anil Mehta', 'anil@gmail.com', '9876543214', 'Bengaluru, Karnataka'),
('Meera Iyer', 'meera@gmail.com', '9876543215', 'Kochi, Kerala'),
('Ramesh Gupta', 'ramesh@gmail.com', '9876543216', 'Pune, Maharashtra'),
('Ananya Das', 'ananya@gmail.com', '9876543217', 'Kolkata, West Bengal'),
('Naveen Kumar', 'naveen@gmail.com', '9876543218', 'Jaipur, Rajasthan'),
('Deepa Menon', 'deepa@gmail.com', '9876543219', 'Lucknow, Uttar Pradesh'),
('Vikram Singh', 'vikram@gmail.com', '9876543220', 'Chandigarh, Punjab'),
('Simran Kaur', 'simran@gmail.com', '9876543221', 'Chennai, Tamil Nadu'),
('Ashok Reddy', 'ashok@gmail.com', '9876543222', 'Madurai, Tamil Nadu');

INSERT INTO Products (Product_Name, Category_ID, Price, Stock, Description) VALUES
('T-shirt', 1, 500.00, 100, 'Comfortable cotton T-shirt'),
('Yoga Mat', 2, 800.00, 50, 'Eco-friendly yoga mat'),
('Blender', 3, 2500.00, 30, 'High-speed kitchen blender'),
('Backpack', 4, 1500.00, 40, 'Durable travel backpack'),
('Notebook', 5, 50.00, 200, 'Hardcover notebook'),
('Smartphone', 6, 12000.00, 20, 'Latest Android smartphone'),
('Tent', 7, 5000.00, 10, 'Waterproof camping tent'),
('Novel', 8, 300.00, 100, 'Bestselling fiction novel'),
('Toy Car', 9, 200.00, 150, 'Miniature toy car'),
('Cricket Bat', 10, 1200.00, 25, 'Premium cricket bat'),
('Lipstick', 11, 350.00, 60, 'Long-lasting matte lipstick'),
('Rice', 12, 40.00, 300, 'Organic basmati rice'),
('Gold Ring', 13, 15000.00, 10, '22k gold ring');


INSERT INTO Orders (Order_ID, Customer_ID, Order_Date, Total_Amount, Order_Status) VALUES
(1, 1, '2024-01-10', 1650.00, 'Completed'), 
(2, 2, '2024-02-15', 4000.00, 'Pending'), 
(3, 3, '2024-03-20', 42000.00, 'Completed'), 
(4, 4, '2024-04-05', 7400.00, 'Shipped'), 
(5, 5, '2024-05-12', 450.00, 'Completed'), 
(6, 6, '2024-06-25', 650.00, 'Processing'), 
(7, 7, '2024-07-08', 1000.00, 'Completed'), 
(8, 8, '2024-08-16', 3100.00, 'Pending'), 
(9, 9, '2024-09-09', 2500.00, 'Completed'), 
(10, 10, '2024-10-22', 650.00, 'Shipped'), 
(11, 11, '2024-11-11', 24000.00, 'Completed'), 
(12, 12, '2024-12-02', 5000.00, 'Completed'), 
(13, 13, '2024-12-25', 1200.00, 'Pending');

INSERT INTO Order_Items (Order_ID, Product_ID, Quantity, Price_Per_Unit) VALUES
(1, 2, 2, 800.00), 
(1, 5, 1, 50.00), 
(2, 4, 1, 1500.00),
(2, 3, 1, 2500.00), 
(3, 6, 1, 12000.00), 
(3, 13, 2, 15000.00), 
(4, 7, 1, 5000.00), 
(4, 10, 2, 1200.00), 
(5, 5, 5, 50.00), 
(5, 9, 1, 200.00), 
(6, 8, 1, 300.00), 
(6, 11, 1, 350.00), 
(7, 12, 25, 40.00), 
(8, 2, 2, 800.00), 
(8, 4, 1, 1500.00), 
(9, 3, 1, 2500.00), 
(10, 8, 1, 300.00),
(10, 11, 1, 350.00),
(11, 6, 2, 12000.00), 
(12, 7, 1, 5000.00), 
(13, 11, 2, 350.00),
(13, 1, 1, 500.00);

INSERT INTO Payments (Order_ID, Payment_Date, Payment_Method, Payment_Amount, Payment_Status) VALUES
(1, '2024-01-10', 'Credit Card', 1650.00, 'Completed'), -- Same day payment
(2, '2024-02-17', 'Cash on Delivery', 4000.00, 'Pending'), -- 2 days after Order_Date
(3, '2024-03-25', 'UPI', 42000.00, 'Completed'), -- Same day payment
(4, '2024-04-06', 'Net Banking', 7400.00, 'Completed'), -- Same day payment
(5, '2024-05-12', 'Credit Card', 450.00, 'Completed'), -- Same day payment
(6, '2024-06-30', 'UPI', 650.00, 'Cancelled'), -- Same day payment
(7, '2024-07-10', 'Debit Card', 1000.00, 'Completed'), -- Same day payment
(8, '2024-08-16', 'UPI', 3100.00, 'Pending'), -- 3 days after Order_Date
(9, '2024-09-12', 'Cash', 2500.00, 'Completed'), -- Same day payment
(10, '2024-10-25', 'Net Banking', 650.00, 'Completed'), -- Same day payment
(11, '2024-11-15', 'Credit Card', 24000.00, 'Completed'), -- Same day payment
(12, '2024-12-03', 'UPI', 5000.00, 'Completed'), -- Same day payment
(13, '2024-12-30', 'Cash on Delivery', 1200.00, 'Pending'); -- 4 days after Order_Date

INSERT INTO Shipment (Order_ID, Shipping_Address, Shipment_Date, Shipment_Status) VALUES
(1, 'Chennai, Tamil Nadu', '2024-01-11', 'Delivered'),
(2, 'Delhi, Delhi', '2024-02-18', 'Pending'),
(3, 'Mumbai, Maharashtra', '2024-03-25', 'Shipped'),
(4, 'Hyderabad, Telangana', '2024-04-10', 'Shipped'),
(5, 'Bengaluru, Karnataka', '2024-05-14', 'Delivered'),
(6, 'Kochi, Kerala', '2024-06-30', 'Cancelled'),
(7, 'Pune, Maharashtra', '2024-07-09', 'Delivered'),
(8, 'Kolkata, West Bengal', '2024-08-20', 'Processing'),
(9, 'Jaipur, Rajasthan', '2024-09-10', 'Delivered'),
(10, 'Lucknow, Uttar Pradesh', '2024-10-23', 'Shipped'),
(11, 'Chandigarh, Punjab', '2024-11-12', 'Shipped'),
(12, 'Chennai, Tamil Nadu', '2024-12-03', 'Delivered'),
(13, 'Madurai, Tamil Nadu', '2024-12-26', 'Processing');

INSERT INTO Reviews (Customer_ID, Product_ID, Rating, Feedback, Review_Date) VALUES
(1, 2, 5, 'The yoga mat is sturdy and provides great grip during sessions.', '2024-01-11'), -- yogamat(Product_ID 2)
(2, 4, 4, 'Great product', '2024-02-18'), -- Backpack (Product_ID 4)
(3, 6, 5, 'The smartphone has amazing features, fast performance, and great battery life.', '2024-03-25'), -- Smartphone (Product_ID 6)
(4, 7, 3, 'The tent is good for camping, but a bit pricey for the quality.', '2024-04-10'), -- Tent (Product_ID 7)
(5, 5, 4, 'The notebook is simple, elegant, and ideal for writing.', '2024-05-14'), -- Notebook (Product_ID 5)
(6, 8, 5, 'The novel was engaging, well-written, and a great read!', '2024-06-30'), -- Novel (Product_ID 8)
(7, 12, 4, 'The rice was of good quality and tastes great.', '2024-07-09'), -- Rice (Product_ID 12)
(8, 2, 4, 'The yoga mat provides great grip but could use more cushioning.', '2024-08-23'), -- Yoga Mat (Product_ID 2)
(9, 3, 3, 'The blender is okay for basic tasks but needs better build quality.', '2024-09-10'), -- Blender (Product_ID 3)
(10, 11, 4, 'The lipstick is long-lasting with vibrant color but feels a bit dry.', '2024-10-23'), -- Lipstick (Product_ID 11)
(11, 6, 5, 'The smartphone is excellent with fast performance and long battery life.', '2024-11-12'), -- Smartphone (Product_ID 6)
(12, 7, 5, 'The tent was durable, easy to set up, and kept me warm and dry.', '2024-12-03'), -- Tent (Product_ID 7)
(13, 1, 4, 'The T-shirt is comfortable with a great fit, though could be a bit softer.', '2024-12-26'); -- T-shirt (Product_ID 1)


use easyshop;
  -- simple query: 1. Selection with Subquery
  -- To filter data based on conditions (e.g., finding products not ordered).
SELECT product_id, product_name
FROM products
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM order_items);
  -- 2. Aggregation Query
SELECT customer_id, AVG(total_amount) AS avg_order_value
FROM orders
GROUP BY customer_id
ORDER BY avg_order_value desc;
  -- 3. Filtering Specific Data
SELECT *FROM customers
WHERE customer_id = 11;
  -- 4. Date-Based Grouping or Date Aggregation Query
SELECT DATE(order_date) AS order_day, SUM(total_amount) AS daily_sales
FROM orders
GROUP BY order_day
ORDER BY order_day DESC;
  -- 5. specific date Query
SELECT * FROM orders
WHERE order_date = '2024-01-10';
  -- 6. Date Range Query
SELECT order_id, customer_id, order_date, total_amount
FROM orders
WHERE order_date BETWEEN '2024-04-05' AND '2024-06-25';


  -- challenging queries: 1. Revenue Calculation Query
SELECT product_id, SUM(Quantity * Price_Per_Unit) AS total_revenue
FROM order_items
GROUP BY product_id
ORDER BY total_revenue desc
LIMIT 5;
  -- 2. Max Revenue Per Product Query
SELECT product_id, max(Quantity * Price_Per_Unit) AS total_revenue
FROM order_items
GROUP BY product_id
ORDER BY total_revenue desc;
  -- 3. Low-Order Customers Query
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING total_orders < 6;
-- 4.  Product Sales and Stock Query
SELECT p.product_id, p.product_name, SUM(oi.quantity) AS total_sold
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
HAVING total_sold > 5 OR total_sold IS NULL
ORDER BY total_sold ASC;

-- 5. Customer Order History Query
SELECT c.Customer_Name, c.Email, COUNT(o.Order_ID) AS Total_Orders
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Order_Date >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
GROUP BY c.Customer_Name, c.Email
ORDER BY Total_Orders DESC;

--  6. Top-Selling Products Query
SELECT p.Product_Name, SUM(oi.Quantity) AS Total_Sold
FROM Products p
JOIN Order_Items oi ON p.Product_ID = oi.Product_ID
JOIN Orders o ON oi.Order_ID = o.Order_ID
WHERE o.Order_Date >= DATE_SUB(CURRENT_DATE, INTERVAL 6 month )
GROUP BY p.Product_Name
ORDER BY Total_Sold DESC;

-- view query
SELECT * 
FROM OrderSummary
WHERE Order_Status = 'completed';
