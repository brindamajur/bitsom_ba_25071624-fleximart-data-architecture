FlexiMart Data Architecture Project

Student Name: Brinda Majur
Student ID: BITSOM-BA-25071624
Email: brindamajur247@gmail.com
Date: 08-01-2026

Project Overview

This project designs and implements an end-to-end data architecture for FlexiMart, an e-commerce company. It covers a complete data lifecycle: cleaning raw CSV data, loading it into a relational database, running business analytics queries, designing a NoSQL product catalog, and building a data warehouse using a star schema for OLAP analysis.

The solution includes ETL pipelines, SQL queries, MongoDB operations, star schema documentation, warehouse population scripts, and analytical reporting queries.

Repository Structure
├── data/
│   ├── customers_raw.csv
│   ├── products_raw.csv
│   └── sales_raw.csv
│
├── part1-database-etl/
│   ├── README.md
│   ├── etl_pipeline.py
│   ├── schema_documentation.md
│   ├── business_queries.sql
│   ├── data_quality_report.txt
│   └── requirements.txt
│
├── part2-nosql/
│   ├── README.md
│   ├── nosql_analysis.md
│   ├── mongodb_operations.js
│   └── products_catalog.json
│
└── part3-datawarehouse/
    ├── README.md
    ├── star_schema_design.md
    ├── warehouse_schema.sql
    ├── warehouse_data.sql
    └── analytics_queries.sql

Technologies Used

Python 3.x

pandas

mysql-connector-python

Relational Database

MySQL 8.0 / PostgreSQL 14

NoSQL Database

MongoDB 6.0

Concepts

ETL (Extract-Transform-Load)

Data Cleaning & Quality Reporting

OLTP vs OLAP

Star Schema & Dimensional Modeling

Aggregations & Window Functions

NoSQL Document Modeling

Setup Instructions
1) Database Setup (MySQL / PostgreSQL)
# Create databases
mysql -u root -p -e "CREATE DATABASE fleximart;"
mysql -u root -p -e "CREATE DATABASE fleximart_dw;"

2) Run Part 1 – ETL Pipeline
python part1-database-etl/etl_pipeline.py

3) Execute Business Queries
mysql -u root -p fleximart < part1-database-etl/business_queries.sql

4) Run Data Warehouse Scripts
# Create schema
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_schema.sql

# Load sample data
mysql -u root -p fleximart_dw < part3-datawarehouse/warehouse_data.sql

# Run OLAP analytical queries
mysql -u root -p fleximart_dw < part3-datawarehouse/analytics_queries.sql

MongoDB Setup
mongosh < part2-nosql/mongodb_operations.js


Key Learnings

Understood differences between OLTP systems and data warehouses

Implemented ETL workflows including cleaning, transformation, and loading

Practiced SQL joins, aggregations, window functions, CTEs, and constraints

Designed and justified a star schema for analytical processing

## Challenges Faced

1. Dirty and incomplete data
    I cleaned the data using Python and pandas. I removed duplicates, fixed dates, filled or dropped missing values, and converted data types before loading it into the database.
2. Foreign key errors while inserting data
     I followed the correct order:
    1) load dimension tables first
    2) then load fact table
    This made sure every foreign key pointed to an existing record.
3. Deciding how to design the star schema
    I chose a simple rule:
     "one row for each product in each order"
This avoided double counting and made reports easier to build.
