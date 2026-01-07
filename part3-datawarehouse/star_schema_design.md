Section 1: Schema Overview

This data warehouse follows a star schema with one central fact table (fact_sales) connected to three dimension tables (dim_date, dim_product, dim_customer). The business process modeled is sales transactions.

FACT TABLE – fact_sales

Grain:
One row per product per order line item (most atomic level)

Measures (numeric facts):

quantity_sold – number of units sold

unit_price – price per unit at time of sale

discount_amount – discount applied on line item

total_amount – (quantity × unit_price – discount)

Foreign Keys:

date_key → dim_date

product_key → dim_product

customer_key → dim_customer

DIMENSION – dim_date

Purpose: Enables analysis by time periods
Type: Conformed date dimension shared across facts

Attributes:

date_key (PK, surrogate, format YYYYMMDD)

full_date

day_of_week

day_of_month

month

month_name

quarter

year

is_weekend

DIMENSION – dim_product

Purpose: Describes product master information**

Attributes:

product_key (PK, surrogate)

product_id (natural business key from OLTP)

product_name

category

subcategory

unit_price

DIMENSION – dim_customer

Purpose: Stores information about purchasing customers**

Attributes:

customer_key (PK, surrogate)

customer_id (natural key from OLTP)

customer_name

city

state

customer_segment

Section 2: Design Decisions (≈150 words)

The chosen granularity is the order line-item level, meaning each row in the fact table represents one product within an order. This granularity is preferred because it preserves maximum detail, enabling flexible analysis such as product-level revenue, customer-level purchasing behavior, and date-wise trend analysis. Aggregations such as daily, monthly, or yearly revenue can later be derived from this atomic data.

Surrogate keys are used instead of natural keys because natural keys (like C001 or P001) may change over time, contain business meaning, or originate from multiple systems. Surrogate keys are integer identifiers that improve join performance and maintain consistency across slowly changing dimensions.

The star schema supports drill-down and roll-up analysis. Analysts can roll up from day → month → quarter → year, or from product → category. Similarly, customer segmentation can be viewed at city → state → national level. This schema reduces joins, improves query speed, and is highly suited for OLAP tools.

Section 3: Sample Data Flow
Source Transaction (OLTP System)

Order 101
Customer: John Doe
Product: Laptop
Quantity: 2
Unit Price: ₹50,000

Data Warehouse Representation

fact_sales

{
  date_key: 20240115,
  product_key: 5,
  customer_key: 12,
  quantity_sold: 2,
  unit_price: 50000,
  discount_amount: 0,
  total_amount: 100000
}


dim_date

{date_key: 20240115, full_date: '2024-01-15', month: 1, quarter: 'Q1', year: 2024}


dim_product

{product_key: 5, product_name: 'Laptop', category: 'Electronics', unit_price: 50000}


dim_customer

{customer_key: 12, customer_name: 'John Doe', city: 'Mumbai', state: 'Maharashtra'}


This demonstrates movement from operational database ➜ staging ➜ warehouse star schema.