# 📚 OnlineBookstore SQL Project

This project involves designing and querying a simple relational database for an **Online Bookstore** using SQL. The database contains tables for books, customers, and orders, and provides a set of queries ranging from basic to advanced levels.

---

## 🏧 Database Schema

**Tables:**

* `Books`: Stores details about books available in the bookstore.
* `Customers`: Contains customer information.
* `Orders`: Records purchase details made by customers.

### Schema Creation

```sql
CREATE DATABASE OnlineBookstore;

-- Books Table
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

-- Customers Table
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

-- Orders Table
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);
```

📌 *Use the import/export option to load data from CSV files into the tables.*

---

## 📘 Basic SQL Queries

1. **All books in the "Fiction" genre**

```sql
SELECT * FROM books WHERE genre = 'Fiction';
```

2. **Books published after 1950**

```sql
SELECT * FROM books WHERE published_year > 1950;
```

3. **Customers from Canada**

```sql
SELECT * FROM customers WHERE country = 'Canada';
```

4. **Orders placed in November 2023**

```sql
SELECT * FROM orders WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';
```

5. **Total stock of books available**

```sql
SELECT SUM(stock) AS Total_Stocks FROM books;
```

6. **Most expensive book**

```sql
SELECT * FROM books ORDER BY price DESC LIMIT 1;
```

7. **Customers who ordered more than 1 quantity**

```sql
SELECT c.name, b.title, o.quantity
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
JOIN books AS b ON o.book_id = b.book_id
WHERE o.quantity > 1;
```

8. **Orders where total amount exceeds \$20**

```sql
SELECT * FROM orders WHERE total_amount > 20;
```

9. **List all genres**

```sql
SELECT DISTINCT genre FROM books;
```

10. **Book with the lowest stock**

```sql
SELECT * FROM books ORDER BY stock ASC LIMIT 1;
```

11. **Total revenue generated from all orders**

```sql
SELECT SUM(total_amount) FROM orders;
```

---

## 🔍 Advanced SQL Queries

1. **Total books sold per genre**

```sql
SELECT b.genre, SUM(o.quantity) AS total_book_sold
FROM books AS b
JOIN orders AS o ON b.book_id = o.book_id
GROUP BY b.genre;
```

2. **Average price of books in the "Fantasy" genre**

```sql
SELECT genre, AVG(price) AS Average_Price
FROM books
WHERE genre = 'Fantasy'
GROUP BY 1;
```

3. **Customers who placed at least 2 orders**

```sql
SELECT o.customer_id, c.name, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(order_id) >= 2;
```

4. **Most frequently ordered book**

```sql
SELECT b.book_id, b.title, COUNT(o.order_id) AS frequently_ordered
FROM books AS b
JOIN orders AS o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title
ORDER BY frequently_ordered DESC
LIMIT 1;
```

5. **Top 3 most expensive Fantasy books**

```sql
SELECT * FROM books
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;
```

6. **Total quantity of books sold by each author**

```sql
SELECT b.author, SUM(o.quantity) AS total_quantity
FROM books AS b
JOIN orders AS o ON b.book_id = o.book_id
GROUP BY b.author;
```

7. **Cities where customers spent over \$30**

```sql
SELECT DISTINCT c.city
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
WHERE o.total_amount > 30;
```

8. **Customer who spent the most**

```sql
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 1;
```

9. **Stock remaining after fulfilling all orders**

```sql
SELECT b.title, (b.stock - COALESCE(SUM(o.quantity), 0)) AS remaining_stock
FROM books AS b
LEFT JOIN orders AS o ON b.book_id = o.book_id
GROUP BY b.book_id;
```

---

## 🧩 Additional Practice Queries

1. **Retrieve the names and emails of all customers**

```sql
SELECT name, email FROM customers;
```

2. **Show the titles and prices of all books priced above \$15**

```sql
SELECT title, price FROM books WHERE price > 15;
```

3. **List all books sorted by published year in descending order**

```sql
SELECT * FROM books ORDER BY published_year DESC;
```

4. **Retrieve all orders placed by 'Christine Maldonado'**

```sql
SELECT o.*
FROM orders AS o
JOIN customers AS c ON o.customer_id = c.customer_id
WHERE c.name = 'Christine Maldonado';
```

5. **Find the number of customers in each country**

```sql
SELECT country, COUNT(*) FROM customers GROUP BY country;
```

6. **Customers who have not placed any orders**

```sql
SELECT c.name
FROM customers AS c
LEFT JOIN orders AS o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
```

7. **Books that are out of stock**

```sql
SELECT * FROM books WHERE stock = 0;
```

---

## 📊 Data Preview (Optional)

```sql
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;
```

---

## 🌟 Author

Project by **Shivam Ghodekar**
