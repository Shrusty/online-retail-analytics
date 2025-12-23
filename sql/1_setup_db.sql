CREATE DATABASE IF NOT EXISTS ecommerce_analytics;   
USE ecommerce_analytics;

CREATE Table raw_ecommerse_sales (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10, 2),
    CustomerID INT,
    Country VARCHAR(50)    

);

SHOW TABLES;

Load data LOCAL INFILE "D:/Online Retail/online_retail.csv"
INTO TABLE raw_ecommerse_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

USE ecommerce_analytics;
SELECT * FROM raw_ecommerse_sales LIMIT 10;
SELECT COUNT(*) AS total_records FROM raw_ecommerse_sales;

CREATE TABLE cleaned_ecommerse_sales AS
SELECT * 
FROM raw_ecommerse_sales
WHERE Quantity > 0 
  AND CustomerID IS NOT NULL;

SeLECT COUNT(*) AS cleaned_total_records FROM cleaned_ecommerse_sales;
SELECT COUNT(*) AS total_records FROM raw_ecommerse_sales;