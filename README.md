
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
SELECT * FROM Books WHERE Genre = 'Fiction';
```

2. **Books published after 1950**

```sql
SELECT * FROM Books WHERE Published_Year > 1950;
```

3. **Customers from Canada**

```sql
SELECT * FROM Customers WHERE Country = 'Canada';
```

4. **Orders placed in November 2023**

```sql
SELECT * FROM Orders WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';
```

5. **Total stock of books**

```sql
SELECT SUM(Stock) AS Total_Stock FROM Books;
```

6. **Most expensive book**

```sql
SELECT * FROM Books ORDER BY Price DESC LIMIT 1;
```

7. **Customers who ordered more than 1 quantity**

```sql
SELECT c.Name, b.Title, o.Quantity
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
JOIN Books b ON o.Book_ID = b.Book_ID
WHERE o.Quantity > 1;
```

8. **Orders where total amount > \$20**

```sql
SELECT * FROM Orders WHERE Total_Amount > 20;
```

9. **List all genres**

```sql
SELECT DISTINCT Genre FROM Books;
```

10. **Book with lowest stock**

```sql
SELECT * FROM Books ORDER BY Stock ASC LIMIT 1;
```

11. **Total revenue**

```sql
SELECT SUM(Total_Amount) FROM Orders;
```

---

## 🔍 Advanced SQL Queries

1. **Total books sold per genre**

```sql
SELECT b.Genre, SUM(o.Quantity) AS Total_Sold
FROM Books b
JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Genre;
```

2. **Average price of 'Fantasy' books**

```sql
SELECT AVG(Price) AS Avg_Price FROM Books WHERE Genre = 'Fantasy';
```

3. **Customers with at least 2 orders**

```sql
SELECT c.Name, COUNT(*) AS Order_Count
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Name
HAVING COUNT(*) >= 2;
```

4. **Most frequently ordered book**

```sql
SELECT b.Title, COUNT(*) AS Order_Count
FROM Books b
JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Title
ORDER BY Order_Count DESC
LIMIT 1;
```

5. **Top 3 most expensive Fantasy books**

```sql
SELECT * FROM Books WHERE Genre = 'Fantasy'
ORDER BY Price DESC LIMIT 3;
```

6. **Total quantity sold by each author**

```sql
SELECT b.Author, SUM(o.Quantity) AS Total_Sold
FROM Books b
JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Author;
```

7. **Cities where customers spent over \$30**

```sql
SELECT DISTINCT c.City
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Total_Amount > 30;
```

8. **Customer who spent the most**

```sql
SELECT c.Name, SUM(o.Total_Amount) AS Total_Spent
FROM Customers c
JOIN Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Name
ORDER BY Total_Spent DESC
LIMIT 1;
```

9. **Stock remaining after all orders**

```sql
SELECT b.Title, (b.Stock - COALESCE(SUM(o.Quantity), 0)) AS Remaining_Stock
FROM Books b
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID;
```

---

## 🧩 Additional Practice Queries

1. **Customers with no orders**

```sql
SELECT c.Name FROM Customers c
LEFT JOIN Orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Order_ID IS NULL;
```

2. **Books out of stock**

```sql
SELECT * FROM Books WHERE Stock = 0;
```

3. **Orders by 'Christine Maldonado'**

```sql
SELECT o.* FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
WHERE c.Name = 'Christine Maldonado';
```

4. **Books priced above \$15**

```sql
SELECT Title, Price FROM Books WHERE Price > 15;
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
