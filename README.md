**Project Overview**

This project analyzes an ecommerce transactions dataset to uncover sales trends, customer behavior, and revenue drivers.

The goal is to demonstrate data analysis skills using SQL, along with clean project structure and business-focused insights.

**Dataset Description**

The dataset contains transactional-level ecommerce data with the following key fields:

-InvoiceNo – Invoice identifier

-StockCode – Product code

-Description – Product description

-Quantity – Quantity sold

-InvoiceDate – Date of transaction

-UnitPrice – Price per unit

-CustomerID – Unique customer identifier

-Country – Customer country  

The data is organized into:

-Raw table: raw_ecommerse_sales

-Cleaned table: cleaned_ecommerse_sales

**KEY INSIGHTS**

1. **Revenue concentration is high:** A small subset of countries contributes a majority of total revenue, as shown by revenue contribution percentages, indicating strong geographic dependence.

2. **Product revenue follows a Pareto pattern:** A limited number of products generate a disproportionately large share of revenue, reinforcing the importance of prioritizing high-performing SKUs.

3. **Country-level product dominance exists:** Top-ranked products vary by country, suggesting localized customer preferences and opportunities for region-specific assortment strategies.

4. **Clear seasonality in revenue trends:** Monthly revenue analysis and rolling 3-month averages reveal recurring seasonal peaks and dips, useful for demand forecasting and inventory planning.

5. **Customer spend is highly skewed:** Customer segmentation shows that high-value customers, while fewer in number, account for a significant portion of overall revenue.

6. **Repeat purchasing behavior is evident:** Several customers place multiple orders over time, indicating retention potential and opportunities for loyalty-based marketing.

7. **Revenue growth is uneven over time:** Month-over-month revenue changes highlight periods of accelerated growth and decline, emphasizing the need for time-aware performance monitoring.

8. **Advanced SQL techniques enable deeper insights:** Use of CTEs, window functions, ranking, and rolling averages allows analysis beyond basic aggregation, supporting more strategic business decisions.