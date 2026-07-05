# Olist Data Engineering Project

## Project Overview

This project uses the Brazilian E-commerce Public Dataset by Olist to design, build and analyse a relational database using Microsoft SQL Server.

The objective is to demonstrate the complete data engineering workflow, including data exploration, cleaning, database design, SQL development, performance optimisation and analytical querying.

This project was completed as part of the Sparta Global Data Engineering programme.

---

## Dataset

Source:
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

The dataset contains over 100,000 e-commerce orders placed between 2016 and 2018 in Brazil.

The project uses the following datasets:

- Customers
- Orders
- Order Items
- Products
- Sellers
- Payments
- Reviews
- Geolocation
- Product Category Translation

---

## Technologies Used

- Python
- Pandas
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- Git
- GitHub
- VS Code

---

## Project Objectives

- Explore and understand the dataset
- Clean missing and inconsistent data
- Design a relational database
- Build tables using SQL
- Define Primary Keys and Foreign Keys
- Load CSV data into SQL Server
- Validate relationships
- Optimise query performance using indexes
- Perform business analysis using SQL

---

## Database Design

The relational database includes the following tables:

- Customers
- Orders
- Order Items
- Products
- Sellers
- Payments
- Reviews
- Geolocation
- Product Category Translation

Relationships are enforced using Primary Keys and Foreign Keys.

---

## Project Structure

```
olist-data-engineering-project/

│
├── data/
│   ├── olist_customers_dataset.csv
│   ├── olist_orders_dataset.csv
│   ├── olist_products_dataset.csv
│   ├── ...
│
├── sql/
│   ├── create_tables.sql
│   ├── insert_data.sql
│   ├── indexes.sql
│   ├── analysis_queries.sql
│
├── images/
│   ├── ERD.png
│
├── Olist.project.py
│
├── README.md
```

---

## Data Cleaning

The data was explored and cleaned before loading into SQL Server.

Cleaning included:

- Checking for missing values
- Removing duplicates
- Validating primary keys
- Standardising column formats
- Ensuring referential integrity

---

## SQL Features

The project demonstrates:

- CREATE DATABASE
- CREATE TABLE
- PRIMARY KEY
- FOREIGN KEY
- INSERT INTO
- INNER JOIN
- LEFT JOIN
- GROUP BY
- ORDER BY
- Aggregate Functions
- Indexes

---

## Example Analysis

Examples of business questions answered:

- Top customers by revenue
- Highest selling products
- Monthly sales trends
- Revenue by product category
- Average review scores
- Seller performance

---

## Performance Optimisation

Indexes were added on frequently used columns including:

- customer_id
- order_id
- product_id
- seller_id

Query performance was compared before and after indexing.

---

## Future Improvements

- Build an automated ETL pipeline
- Load data directly into SQL Server using Python
- Create interactive Power BI dashboards
- Deploy the project using Azure or AWS
- Add data quality validation scripts

---

## Collaborators

**Alina Arus**

GitHub:
https://github.com/alina951

LinkedIn:
https://www.linkedin.com/in/alina-arus-6a18a0319/

---

## Acknowledgements

Dataset provided by Olist and made available through Kaggle.

https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
