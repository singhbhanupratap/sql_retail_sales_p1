create database sql_project_1;
use sql_project_1;

create table  retail_sales
	(
    transactions_id int primary key,
	sale_date	date,
    sale_time	time,
    customer_id	int,
    gender	varchar(20),
    age	int,
    category varchar(20),
    quantiy	int,
    price_per_unit	float,
    cogs	float,
    total_sale float

    );
    
   -- Data Exploration & Cleaning---------------------------------------------------------------------------------------------------------------------
   
    -- How many sales we have 
   select count(*) from retail_sales;
   
   -- How many different customers we have ?
   
   select  count(distinct customer_id) as number_of_customers from retail_sales ;
   
   -- Different categories that we have 
   select distinct category from retail_sales;
   
   
		 SELECT
    COUNT(*) AS total_rows,
    COUNT(transactions_id) AS count_transaction_ids,
    COUNT(sale_date) AS count_sale_dates,
    COUNT(sale_time) AS count_sale_times,
    COUNT(customer_id) AS count_customer_ids,
    COUNT(gender) AS count_genders,
    COUNT(age) AS count_ages,
    COUNT(category) AS count_categories,
    COUNT(quantity) AS count_quantities,
    COUNT(price_per_unit) AS count_prices,
    COUNT(cogs) AS count_cogs,
    COUNT(total_sale) AS count_total_sales
FROM
    retail_sales;
   
   
    
   -- Data Analysis & Buisness Key Problems & Answers ---------------------------------------------------------------------------------------------------------------------
   -- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select *
from retail_sales 
where sale_date= '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select * 
from retail_sales
where category ='Clothing'
	  and quantity >=4
      and date_format(sale_date,'%Y-%m')='2022-11';
      
      
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category,
sum(total_sale) as net_sales,
count(*) as total_orders
from retail_sales
group by category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
 
 select 
	round(avg(age),2) as average_age 
    from retail_sales
    where category = 'Beauty';
    
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
 
select * 
	from retail_sales
	where total_sale > 1000;
    
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

	select 
    category,
	gender,
    count(transactions_id)
    from retail_sales
    group by gender , category
    order by 1;
    
    

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

	with sales_ranking as(
    select 
		extract(year from sale_date) as year,
        extract(month from sale_date) as month,
        round(avg(total_sale),2) as avg_sales,
        rank()over(partition by extract(year from sale_date) order by avg(total_sale)desc) as rnk
        from retail_sales
        group by 1,2
        )
        select year,month,avg_sales
        from sales_ranking
        where rnk=1;
        
        
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

	select 
    customer_id,
    sum(total_sale)
    from retail_sales
    group by customer_id
    order by 2 desc
    limit 5;
    
    
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

	select 
    category,
    count(distinct(customer_id))
    from retail_sales
    group by category;
    
    
    
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

	with shift_wise_sales as(
		select * ,
        case when(extract(hour from sale_time))  < 12 then 'Morning'
			 when(extract(hour from sale_time)) between 12 and 17 then 'Afternoon'
             else 'Evening'
		end as shift
        from retail_sales
        )
        select shift, count(*) as no_of_orders
        from shift_wise_sales
        group by shift;
        
        
        
-- End of project
        
 
