--CREATE TABLE

DROP TABLE IF EXISTS  retail_sales;
CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);

select * from retail_sales
limit 10

SELECT
   COUNT(*)
FROM RETAIL_SALES

--DATA CLEANING

SELECT * FROM ratail_sales
where
   transaction_id is null
   or
   sale_date is null
   or
   sale_time is null
   or
   customer_id is null
   or
   gender is null
   or
   age is null
   or 
   category is null
   or 
   quantiy is null
   or 
   price_per_unit is null
   or 
   cogs is null
   or
   total_sale is null;

--DELETE
DELETE FROM retail_sales
WHERE
   transaction_id is null
   or
   sale_date is null
   or
   sale_time is null
   or
   customer_id is null
   or
   gender is null
   or
   age is null
   or 
   category is null
   or 
   quantiy is null
   or 
   price_per_unit is null
   or 
   cogs is null
   or
   total_sale is null;

--DATA EXPLORATION

--HOW MANY SALES WE HAVE?
SELECT COUNT(*) AS TOTAL_SALES FROM RETAIL_SALES

--HOW MANY CUSTOMERS WEW HAVE?

SELECT COUNT(DISTINCT customer_id) AS TOTAL_SALES FROM RETAIL_SALES

SELECT COUNT(DISTINCT category) AS TOTAL_SALES FROM RETAIL_SALES

select distinct category from retail_sales

--DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS

--Q.1 Write a sql query to retrieve all columns for sales made on '2022-11-05'

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

--Q.2 write a sql query to retrieve all transaction where the category is 'clothing' and the quantity sold is more than 4 in the month of nov-2022 

SELECT * FROM retail_sales
WHERE   
  category = 'Clothing'
  AND
  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND
  quantiy >= 4

--Q.3 write a sql query to calculate the total sales (total_sale) for each category.

SELECT
  category,
  sum(total_sale) as net_sale,
  count(*) as total_orders
From retail_sales
group by 1

--Q.4 write a sql query to find the average age of customers who purchased items from the 'Beauty' category?

select
     ROUND(AVG(age),2) AS Avg_age 
from retail_sales
where category = 'Beauty'

--Q.5 write a sql query all transaction where the total_sale is greater than 1000?

SELECT * FROM retail_sales
where total_sale > 1000

--Q.6 To find out the total no of transaction (transaction_id)made by each gender in each category?

SELECT 
    category,
	gender,
	count(*) as total_trans
from retail_sales
GROUP
    BY 
	category,
	gender

--Q.7 To calculate to average sale for each month find out best selling month to each year?

SELECT 
    EXTRACT(year from sale_date) as year,
	EXTRACT(month from sale_date) as month,
	avg(total_sale) as avg_sale
from retail_sales
Group by 1,2
Order by 1,3 desc

--Ranking function

SELECT 
    EXTRACT(year from sale_date) as year,
	EXTRACT(month from sale_date) as month,
	avg(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(year from sale_date) Order by avg(total_sale) desc)
from retail_sales
Group by 1,2

--ANOTHER WAY

SELECT 
   YEAR,
   MONTH,
   AVG_SALE
FROM
(
SELECT
   EXTRACT(year from sale_date) as year,
   EXTRACT(month from sale_date) as month,
   avg(total_sale) as avg_sale,
   RANK() OVER(PARTITION BY EXTRACT(year from sale_date) Order by avg(total_sale) desc) AS RANK
from retail_sales
Group by 1,2
) as t1
where rank =1

--Q.8 write a sql query to find the top 5 customer's based on the highest total sales;

SELECT 
    customer_id,
	sum(total_sale) as total_sales
from retail_sales
group by 1
limit 5

--Q.9 find the number of unique customer who purchased item from each category;

SELECT
   CATEGORY,
   count(distinct CUSTOMER_ID) as unique_cs
FROM retail_sales
Group by category

--Q.10 To create each shift and number of orders (ex: morning <=12 ,afternoon between 12 & 17, evening >17)

SELECT * ,
  CASE
  WHEN extract (hour from sale_time)<12 THEN 'MORNING'
  WHEN extract (hour from sale_time)BETWEEN 12 AND 17 THEN 'AFTERNOON'
  ELSE 'EVENING'
END AS Shift
FROM retail_sales

(OR)

WITH HOURLY_SALE 
AS 
(
SELECT * ,
  CASE
  WHEN extract (hour from sale_time)<12 THEN 'MORNING'
  WHEN extract (hour from sale_time)BETWEEN 12 AND 17 THEN 'AFTERNOON'
  ELSE 'EVENING'
END AS Shift
FROM retail_sales
)
SELECT
   SHIFT,
   COUNT(*)AS TOTAL_ORDERS
FROM hourly_sale
group by shift

--END OF THE PROJECT--
   
   
   
