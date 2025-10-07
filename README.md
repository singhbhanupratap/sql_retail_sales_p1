-----

# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis   
**Level**: Beginner

This project demonstrates foundational SQL skills for data analysis by exploring, cleaning, and analyzing a retail sales dataset. It covers the complete workflow from database setup and data exploration to answering key business questions with targeted SQL queries. This is an ideal portfolio project for anyone starting their journey in data analysis and looking to build a solid foundation in SQL.

-----

## Objectives

1.  **Database Setup**: Create a dedicated database and table to house the retail sales data.
2.  **Data Cleaning & Exploration**: Perform basic exploratory data analysis (EDA) to understand the dataset's structure, count key entities, and check for missing values.
3.  **Business Analysis**: Write SQL queries to answer 10 specific business questions and derive actionable insights from the sales data.

-----

## Project Structure

### 1\. Database and Table Setup

The project begins by creating a database named `sql_project_1` and a table named `retail_sales` with a schema designed to hold transactional sales data.

```sql
CREATE DATABASE sql_project_1;
USE sql_project_1;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(20),
    age INT,
    category VARCHAR(20),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2\. Data Exploration & Cleaning

Initial queries were run to understand the scope and integrity of the data. This step is crucial for ensuring the quality of subsequent analysis.

  - **Total Records**: `SELECT COUNT(*) FROM retail_sales;`
  - **Unique Customers**: `SELECT COUNT(DISTINCT customer_id) FROM retail_sales;`
  - **Product Categories**: `SELECT DISTINCT category FROM retail_sales;`
  - **Null Value Check**: A comprehensive check to count non-null values in each column.

<!-- end list -->

```sql
SELECT
    COUNT(*) AS total_rows,
    COUNT(transactions_id) AS count_transaction_ids,
    COUNT(sale_date) AS count_sale_dates,
    COUNT(sale_time) AS count_sale_times,
    COUNT(customer_id) AS count_customer_ids,
    COUNT(gender) AS count_genders,
    COUNT(age) AS count_ages,
    COUNT(category) AS count_categories,
    COUNT(quantiy) AS count_quantities,
    COUNT(price_per_unit) AS count_prices,
    COUNT(cogs) AS count_cogs,
    COUNT(total_sale) AS count_total_sales
FROM
    retail_sales;
```

### 3\. Data Analysis & Key Findings

The core of the project involves answering 10 business questions with SQL queries.

**1. Retrieve all sales made on '2022-11-05'.**

```sql
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
```

**2. Find 'Clothing' transactions with a quantity of 4 or more in Nov-2022.**

```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy >= 4
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
```

**3. Calculate total sales and order count for each category.**

```sql
SELECT
    category,
    SUM(total_sale) AS net_sales,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

**4. Find the average age of customers who purchased from the 'Beauty' category.**

```sql
SELECT
    ROUND(AVG(age), 2) AS average_age
FROM retail_sales
WHERE category = 'Beauty';
```

**5. Find all transactions where `total_sale` is greater than 1000.**

```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

**6. Find the total number of transactions by each gender in each category.**

```sql
SELECT
    category,
    gender,
    COUNT(transactions_id)
FROM retail_sales
GROUP BY gender, category
ORDER BY category;
```

**7. Find the best-selling month for each year.**

```sql
WITH sales_ranking AS (
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        ROUND(AVG(total_sale), 2) AS avg_sales,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rnk
    FROM retail_sales
    GROUP BY 1, 2
)
SELECT year, month, avg_sales
FROM sales_ranking
WHERE rnk = 1;
```

**8. Find the top 5 customers based on total sales.**

```sql
SELECT
    customer_id,
    SUM(total_sale)
FROM retail_sales
GROUP BY customer_id
ORDER BY 2 DESC
LIMIT 5;
```

**9. Find the number of unique customers for each category.**

```sql
SELECT
    category,
    COUNT(DISTINCT(customer_id))
FROM retail_sales
GROUP BY category;
```

**10. Calculate the number of orders in each time-of-day shift.**

```sql
WITH shift_wise_sales AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT
    shift,
    COUNT(*) AS no_of_orders
FROM shift_wise_sales
GROUP BY shift;
```

-----

## How to Use

1.  **Clone the Repository**: `git clone https://github.com/your-username/your-repo-name.git`
2.  **Set Up the Database**: Use a MySQL client to run the `CREATE DATABASE` and `CREATE TABLE` scripts.
3.  **Import Data**: Load the provided CSV data into the `retail_sales` table using a data import tool.
4.  **Run the Queries**: Execute the analysis queries to explore the dataset and replicate the findings.

-----
Thank You
