#Repeat Customers vs One-Time Customers
WITH customer_orders AS (
    SELECT 
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS order_count
    FROM cleaned_ecommerse_sales
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
)
SELECT
    CASE 
        WHEN order_count = 1 THEN 'One-time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM customer_orders
GROUP BY customer_type;

#Repeat Customers vs One-Time Customers
SELECT
    CustomerID,
    SUM(Quantity * UnitPrice) AS lifetime_value
FROM cleaned_ecommerse_sales
WHERE CustomerID IS NOT NULL
  AND Quantity > 0 AND UnitPrice > 0
GROUP BY CustomerID
ORDER BY lifetime_value DESC
LIMIT 20;

#Month-over-Month (MoM) Revenue Growth %
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
        (revenue - LAG(revenue) OVER (ORDER BY month))
        / LAG(revenue) OVER (ORDER BY month) * 100, 2
    ) AS mom_growth_percentage
FROM monthly_revenue;

#Revenue Concentration (Top 10 Customers % of Revenue)
WITH customer_revenue AS (
    SELECT
        CustomerID,
        SUM(Quantity * UnitPrice) AS revenue
    FROM cleaned_ecommerse_sales
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
),
top_customers AS (
    SELECT *
    FROM customer_revenue
    ORDER BY revenue DESC
    LIMIT 10
)
SELECT
    ROUND(
        SUM(revenue) /
        (SELECT SUM(revenue) FROM customer_revenue) * 100, 2
    ) AS top_10_customer_revenue_percentage
FROM top_customers;

#Product Sales Velocity (Avg Units per Invoice)
SELECT
    Description,
    ROUND(AVG(Quantity), 2) AS avg_units_per_invoice
FROM cleaned_ecommerse_sales
WHERE Quantity > 0
GROUP BY Description
ORDER BY avg_units_per_invoice DESC
LIMIT 20;

#Inactive Customers (Churn Proxy)
WITH last_purchase AS (
    SELECT
        CustomerID,
        MAX(InvoiceDate) AS last_purchase_date
    FROM cleaned_ecommerse_sales
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
)
SELECT
    COUNT(*) AS inactive_customers
FROM last_purchase
WHERE last_purchase_date < DATE_SUB(
    (SELECT MAX(InvoiceDate) FROM cleaned_ecommerse_sales),
    INTERVAL 6 MONTH
);


