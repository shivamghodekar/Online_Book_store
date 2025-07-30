CREATE DATABASE OnlineBookstore;

DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

-- import all the csv file using import/export option

-- Basic Questions : 

-- 1) Retrieve all books in the "Fiction" genre:
-- 2) Find books published after the year 1950:
-- 3) List all customers from the Canada:
-- 4) Show orders placed in November 2023:
-- 5) Retrieve the total stock of books available:
-- 6) Find the details of the most expensive book:
-- 7) Show all customers who ordered more than 1 quantity of a book
-- 8) Retrieve all orders where the total amount exceeds $20:
-- 9) List all genres available in the Books table:
-- 10) Find the book with the lowest stock:
-- 11) Calculate the total revenue generated from all orders:

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
-- 2) Find the average price of books in the "Fantasy" genre:
-- 3) List customers who have placed at least 2 orders:
-- 4) Find the most frequently ordered book:
-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
-- 6) Retrieve the total quantity of books sold by each author:
-- 7) List the cities where customers who spent over $30 are located:
-- 8) Find the customer who spent the most on orders:
-- 9) Calculate the stock remaining after fulfilling all orders:

-- Solve The Questions :

-- 1) Retrieve all books in the "Fiction" genre:

SELECT *
FROM books
WHERE genre = 'Fiction'

-- 2) Find books published after the year 1950:

SELECT *
FROM books
WHERE published_year > 1950

-- 3) List all customers from the Canada:

SELECT *
FROM Customers
WHERE country = 'Canada'

-- 4) Show orders placed in November 2023:

SELECT *
FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30'

-- or yearly data in 2023

SELECT *
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = 2023;

-- 5) Retrieve the total stock of books available:

SELECT SUM(stock) AS Total_Stocks
FROM books
GROUP BY stock

-- 6) Find the details of the most expensive book:

SELECT *
FROM books
ORDER BY price DESC
LIMIT 1

-- 7) Show all customers who ordered more than 1 quantity of a book

SELECT *
FROM Orders
WHERE quantity > 1

-- Using join

SELECT c.name, b.title, o.quantity
FROM Customers AS c
JOIN Orders AS o
ON c.customer_id = o.customer_id
JOIN books AS b
ON o.book_id = b.book_id
WHERE quantity > 1

-- 8) Retrieve all orders where the total amount exceeds $20:

SELECT *
FROM orders
WHERE total_amount > 20

-- 9) List all genres available in the Books table:

SELECT DISTINCT genre
FROM books

-- 10) Find the book with the lowest stock:

SELECT *
FROM books
ORDER BY stock 
LIMIT 1

-- 11) Calculate the total revenue generated from all orders:

SELECT SUM(total_amount) from orders

-- Advance Questions :

-- 1) Retrieve the total number of books sold for each genre:

SELECT b.genre, SUM(o.quantity) AS total_book_sold
FROM books AS b
JOIN orders AS o
ON b.book_id = o.book_id
GROUP BY  b.genre

-- 2) Find the average price of books in the "Fantasy" genre:

SELECT genre, avg(price) AS Average_Price
FROM books
WHERE genre = 'Fantasy'
GROUP BY 1

-- 3) List customers who have placed at least 2 orders:

SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c 
ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;

-- 4) Find the most frequently ordered book:

SELECT o.Book_id, b.title, COUNT(o.order_id) AS freaqently_order
FROM orders o
JOIN books b 
ON o.book_id = b.book_id
GROUP BY 1,2
ORDER BY freaqently_order DESC 
LIMIT 1

--  Confusion bothy are may be same in my point of view but result are different

SELECT b.book_id, b.title, COUNT(o.order_id) AS freaqently_order
FROM books AS b
JOIN orders AS o
ON b.book_id = o.book_id
GROUP BY 1, 2
ORDER BY freaqently_order DESC
LIMIT 1

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT *
FROM books
WHERE genre = 'Fantasy' 
ORDER BY price DESC
LIMIT 3

-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.author, SUM(o.quantity) AS total_quantity
FROM books AS b
JOIN orders AS o
ON b.book_id = o.book_id
GROUP BY b.author

-- or exchange join

SELECT b.author, SUM(o.quantity) AS total_quantity
FROM orders o
JOIN books b 
ON o.book_id = b.book_id
GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located:

SELECT c.city, o.total_amount
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.total_amount > 30

-- 8) Find the customer who spent the most on orders:

SELECT c.name, count(order_id) AS most_on_orders
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY 1
ORDER BY most_on_orders DESC
LIMIT 1

----

-- 🔹 Basic Level Questions

-- 1) Retrieve the names and emails of all customers.

SELECT name, email
FROM customers

-- 2) Show the titles and prices of all books priced above $15.

SELECT title, price
FROM books
WHERE price > 15

-- 3) List all books sorted by published year in descending order.

SELECT published_year
FROM books
ORDER BY 1 DESC

-- 4) Retrieve all orders placed by a customer with the name 'Christine Maldonado'.

SELECT o.*
FROM orders AS o
JOIN customers AS c
ON o.customer_id = c.customer_id
WHERE c.name = 'Christine Maldonado'

-- 5) Find the number of customers in each country.

SELECT country, COUNT(name)
FROM customers
GROUP BY 1

-- 6) Show the names of customers who have not placed any orders.

SELECT c.name
FROM customers AS c
LEFT JOIN orders AS o
ON  c.customer_id = o.customer_id 
WHERE o.order_id IS NULL

-- 7) Find books that are out of stock.



SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;



