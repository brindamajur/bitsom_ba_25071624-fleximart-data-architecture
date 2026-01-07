USE fleximart_dw;

-------------------------------------------------------------
-- Query 1: Monthly Sales Drill-Down (Year → Quarter → Month)
-- Business Scenario:
-- CEO wants sales performance broken down by
--  • year
--  • quarter
--  • month
-- showing total sales and total quantity sold.
-------------------------------------------------------------

SELECT
    d.year,
    d.quarter,
    d.month_name,
    SUM(f.total_amount) AS total_sales,
    SUM(f.quantity_sold) AS total_quantity
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
WHERE d.year = 2024
GROUP BY
    d.year,
    d.quarter,
    d.month,
    d.month_name
ORDER BY
    d.year,
    d.quarter,
    d.month;


-------------------------------------------------------------
-- Query 2: Top 10 Products by Revenue
-- Business Scenario:
-- Product manager needs top-performing products with
--  • category
--  • total units sold
--  • total revenue
--  • revenue contribution percentage
-------------------------------------------------------------

WITH product_revenue AS (
    SELECT
        p.product_name,
        p.category,
        SUM(f.quantity_sold) AS units_sold,
        SUM(f.total_amount) AS revenue
    FROM fact_sales f
    JOIN dim_product p
        ON f.product_key = p.product_key
    GROUP BY p.product_name, p.category
),
total_revenue AS (
    SELECT SUM(revenue) AS grand_total FROM product_revenue
)
SELECT
    pr.product_name,
    pr.category,
    pr.units_sold,
    pr.revenue,
    ROUND((pr.revenue / tr.grand_total) * 100, 2) AS revenue_percentage
FROM product_revenue pr
CROSS JOIN total_revenue tr
ORDER BY pr.revenue DESC
LIMIT 10;


-------------------------------------------------------------
-- Query 3: Customer Segmentation Analysis
-- Business Scenario:
-- Segment customers by total spend into:
--  • High Value  > 50,000
--  • Medium      20,000–50,000
--  • Low Value   < 20,000
-------------------------------------------------------------

WITH customer_totals AS (
    SELECT
        c.customer_key,
        c.customer_name,
        SUM(f.total_amount) AS total_spent
    FROM fact_sales f
    JOIN dim_customer c
        ON f.customer_key = c.customer_key
    GROUP BY c.customer_key, c.customer_name
),
segmented AS (
    SELECT
        CASE
            WHEN total_spent > 50000 THEN 'High Value'
            WHEN total_spent BETWEEN 20000 AND 50000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment,
        total_spent
    FROM customer_totals
)
SELECT
    customer_segment,
    COUNT(*) AS customer_count,
    SUM(total_spent) AS total_revenue,
    ROUND(AVG(total_spent),2) AS avg_revenue_per_customer
FROM segmented
GROUP BY customer_segment
ORDER BY total_revenue DESC;
