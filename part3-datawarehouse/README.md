Overview of the FlexiMart Data Warehouse Project

This project focuses on designing and implementing a sales data warehouse for FlexiMart in order to analyze historical sales trends and support business decision-making. The goal is to model sales data using a star schema, populate it with realistic sample data, and perform OLAP analytical queries for reporting.

The work is divided into three major tasks:

Task 3.1 — Star Schema Design Documentation

You will design and document a star schema centered around the fact table fact_sales. The schema will include:

one fact table capturing sales transactions at the order line-item grain

multiple dimension tables including:

dim_date

dim_product

dim_customer

The documentation will describe:

the grain and business process for the fact table

facts/measures and foreign keys

attributes of each dimension

rationale behind design choices such as:

transaction-level granularity

surrogate keys

support for drill-down and roll-up analysis

an example showing how a source transaction is transformed and loaded into the warehouse tables

 Task 3.2 — Star Schema Implementation and Data Population

You will use the provided SQL schema to implement the warehouse in MySQL. Then you will create a separate data script to populate the tables:

dim_date — at least 30 dates

dim_product — at least 15 products across multiple categories

dim_customer — at least 12 customers from multiple cities

fact_sales — at least 40 realistic sales transactions

The inserted data must:

respect foreign key relationships

include both weekdays and weekends

include realistic pricing and quantities

reflect believable purchasing behavior patterns

Task 3.3 — OLAP Analytical Queries

You will write SQL queries to answer key business questions:

Time-based drill-down analysis

year → quarter → month

compute total revenue and total quantity sold

Top-performing product analysis

rank products by revenue

show units sold and % revenue contribution

Customer value segmentation

classify customers as High, Medium, Low value

calculate revenue and counts per group

These queries demonstrate understanding of aggregation, grouping, joins, window functions, and CASE expressions.