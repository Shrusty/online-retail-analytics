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

WITH country_revenue AS (
    SELECT 
        Country,
        SUM(Quantity * UnitPrice) AS revenue
    FROM cleaned_ecommerse_sales
    WHERE Quantity > 0 AND UnitPrice > 0
    GROUP BY Country
)
SELECT 
    Country,
    revenue,
    ROUND(
        revenue / SUM(revenue) OVER () * 100, 2
    ) AS revenue_percentage
FROM country_revenue
ORDER BY revenue DESC;

#REVENUE CONTRIBUTION % BY COUNTRY
WITH country_revenue AS (
    SELECT Country,
    SUM(Quantity * UnitPrice) AS revenue
    FROM cleaned_ecommerse_sales
    WHERE Quantity > 0 AND UnitPrice > 0
    GROUP BY Country
)
SELECT 
Country,
revenue,
ROUND(
    revenue / SUM(revenue) OVER () * 100, 2
    ) AS revenue_percentage
FROM country_revenue
ORDER BY revenue DESC;

#RANKING PRODUCTS WITHIN EACH COUNTRY
WITH product_revenue AS (
    SELECT 
        Country,
        Description,
        SUM(Quantity * UnitPrice) AS revenue
    FROM cleaned_ecommerse_sales
    WHERE Quantity > 0 AND UnitPrice > 0
    GROUP BY Country, Description
)
SELECT *
FROM (
    SELECT 
        Country,
        Description,
        revenue,
        RANK() OVER (PARTITION BY Country ORDER BY revenue DESC) AS rank_in_country
    FROM product_revenue
) ranked
WHERE rank_in_country <= 3;

#CUSTOMER SEGMENTATION - HIGH/MEDIUM/LOW
WITH customer_spend AS (
    SELECT 
        CustomerID,
        SUM(Quantity * UnitPrice) AS total_spent
    FROM cleaned_ecommerse_sales
    WHERE CustomerID IS NOT NULL
      AND Quantity > 0 AND UnitPrice > 0
    GROUP BY CustomerID
)
SELECT 
    CustomerID,
    total_spent,
    CASE 
        WHEN total_spent >= 10000 THEN 'High Value'
        WHEN total_spent >= 3000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_spend;

#ROLLING 3MONTH REVENUE
WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(InvoiceDate, '%Y-%m') AS month,
        SUM(Quantity * UnitPrice) AS revenue
    FROM cleaned_ecommerse_sales
    WHERE Quantity > 0 AND UnitPrice > 0
    GROUP BY month
)
SELECT 
    month,
    revenue,
    ROUND(
        AVG(revenue) OVER (
            ORDER BY month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS rolling_3_month_avg
FROM monthly_revenue;
