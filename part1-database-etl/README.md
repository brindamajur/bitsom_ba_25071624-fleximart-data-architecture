----------------------------------------------------------------------------------------------
Overview (Database Design & ETL Pipeline)
-----------------------------------------------------------------------------------------------
Task 1.1 – ETL Pipeline (15 marks)

    Create a file: etl_pipeline.py
    The script must:

        Extract ->

            Read three CSV files:

            customers_raw.csv

            products_raw.csv

            sales_raw.csv

        Transform ->

          Fix the files:
            remove duplicate records

            drop or fill missing data (reasonable strategy)

            standardize phone numbers to +91-XXXXXXXXXX

            fix category text casing

            convert all dates to YYYY-MM-DD

            create surrogate primary keys (auto increment)

        Load ->

            Insert cleaned records into MySQL tables:

                customers

                products

                orders

                order_items

            using Python + mysql-connector 

    Output report
        data_quality_report.txt

Task 1.2 – Schema Documentation (5 marks)

    File:schema_documentation.md

    Contains three parts:

1) Entity-Relationship Description

    Explain all 4 tables:

        customers,products,orders,order_items

2) Normalization to 3NF (200–250 words)

    Explain:

        functional dependencies

3) Sample Data Table

    Show 2–3 example rows per table in table format.

Task 1.3 – Business Queries 

File:business_queries.sql


You must write 3 SQL queries.

1) Query 1 — Customer Purchase History

Find customers who:

placed ≥ 2 orders

spent > ₹5000

Output:

customer_name | email | total_orders | total_spent


Uses:

JOIN customers + orders + order_items

GROUP BY

HAVING

ORDER BY total_spent DESC

2) Query 2 — Product Sales Analysis

Per product category show:

category | num_products | total_quantity_sold | total_revenue


Include only revenue > ₹10000.

Uses:

JOIN products + order_items

COUNT(DISTINCT product)

SUM(qty), SUM(amount)

HAVING revenue > 10000

3) Query 3 — Monthly Sales Trend (2024)

Outputs:

month_name | total_orders | monthly_revenue | cumulative_revenue


You MUST:

group by month

sum revenue per month

compute running total using window function

Example function hints:

MONTH()

MONTHNAME()

SUM() OVER (ORDER BY month)