SHOW TABLES;

USE ecommerce_analytics;
SELECT COUNT(*) AS total_transactions 
FROM raw_ecommerse_sales;

SELECT COUNT(*) as total_cleaned_transactions
FROM cleaned_ecommerse_sales;

SELECT MAX(InvoiceDate) AS latest_transaction_date,
MIN(InvoiceDate) AS earliest_transaction_date
FROM cleaned_ecommerse_sales;

SELECT TIMESTAMPDIFF(YEAR, MIN(InvoiceDate),MAX(InvoiceDate)) AS data_span_years
FROM cleaned_ecommerse_sales;

SELECT DISTINCT Country
FROM cleaned_ecommerse_sales
ORDER BY `Country`;
SELECT COUNT(DISTINCT Country) AS total_countries
FROM cleaned_ecommerse_sales;

#TOTAL REVENUE
SELECT SUM(Quantity * UnitPrice) AS total_revenue
FROM cleaned_ecommerse_sales;

#REVENUE BY COUNTRY
SELECT Country,
SUM(Quantity * UnitPrice) AS revenue
FROM cleaned_ecommerse_sales
GROUP BY Country
ORDER BY revenue DESC;

#TOP 10 PRODUCTS BY REVENUE
SELECT Description,
SUM(Quantity * UnitPrice) AS revenue
FROM cleaned_ecommerse_sales
GROUP BY Description
ORDER BY revenue DESC
LIMIT 10;

#MONTHLY REVENUE TREND
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS month,
SUM(Quantity * UnitPrice) AS monthly_revenue
FROM cleaned_ecommerse_sales
GROUP BY month
ORDER BY month;

#CUSTOMER ANALYSIS - TOP 10 CUSTOMERS BY SPEND
SELECT CustomerID,
SUM(Quantity * UnitPrice) AS total_spent
FROM cleaned_ecommerse_sales
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 10;



