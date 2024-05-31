--1)top 5 cities who have sold max no of categories
SELECT city, count(category) as total_no from orders
GROUP BY city
ORDER BY total_no desc
LIMIT 5


--2)top 10 cities who have made highest profit
SELECT city, sum(profit) as total_profit from orders
GROUP BY CITY 
ORDER BY total_profit desc
LIMIT 10


--3)top 10 city who have sold highest office supplies
SELECT city, sum(quantity) as total_quan from orders
WHERE category = 'Office Supplies'
GROUP BY city 
ORDER BY total_quan desc
LIMIT 10

--4)find top 10 highest reveue generating products 
select product_id,sum(sale_price) as sales from orders
group by product_id
order by sales desc
LIMIT 10


--5)find top 5 highest selling products in each region
with cte as (
	select region, product_id, sum(sale_price) as sales from orders
	group by region,product_id)
select * from (
	select * , row_number() over(partition by region order by sales desc) as r_num
	from cte) A
where r_num<=5


--6)for each category which month had highest sales 
with cte as (
	select category, TO_CHAR(order_date, 'YYYY-MM') as order_year_month, sum(sale_price) as sales 
	from orders
	group by category, TO_CHAR(order_date, 'YYYY-MM')
)
select * from (
	select *, row_number() over(partition by category order by sales desc) as r_num from cte
) a
where r_num=1




