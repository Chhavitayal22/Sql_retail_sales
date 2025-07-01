SELECT * FROM public.retail_sales

limit 100

Select * from retail_sales
limit 10

select 
count (*)
from retail_sales

Select * from retail_sales
where transaction_id is null

Select * from retail_sales
where sale_time is null



Select * from retail_sales
where transaction_id is null
or
sale_time is null
or
sale_date is null 

or 
gender is null 
or 
category is null 
or
quantity is null
or 
cogs is null
or 
total_sales is null;

--
delete from retail_sales

where transaction_id is null
or
sale_time is null
or
sale_date is null 

or 
gender is null 
or 
category is null 
or
quantity is null
or 
cogs is null
or 
total_sales is null;


select 
count (*)
from retail_sales

--
data exploration
--How many sales we have?
select count (customer_id) as total_sales from retail_sales

-- how many unique customers do we have?
select count (distinct customer_id) as total_sales from retail_sales
select distinct category from retail_sales

-- Data analysis &business key problems and answers


select *
from retail_sales
where sale_date= '2022-11-05'

select category

from retail_sales
where category = 'clothing'
and 
To_char(sale_date,'YYYY-MM')= '2022-11'



and 
quantity>= 4

--

select *
from retail_sales

select category,
sum(total_sales) as net_sales,
count(*) as total_orders
from retail_sales
group by 1

--

select round(AVG(age),2)as avg_age 
from retail_sales
where category= 'Beauty'

--
select * 
from retail_sales
where total_sales> 1000
--

select category,
gender,
count(*) as total_sales
from retail_sales
group by 
category,gender
order by 1
--

select year, month,avg_sales  from 
(
select
extract(year from sale_date)as year,
extract(month from sale_date)as month,
avg(total_sales)as avg_sales,
rank()over (partition by extract(year from sale_date) order by avg(total_sales)desc) as rank
from retail_sales
group by 1,2
) as t1
where rank = 1
order by 1,2,3 desc

--

select customer_id,
sum(total_sales)as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5
--




 
select category,
count(distinct customer_id) as unique_cs
from retail_sales
group by category
order by 2 desc
limit 5

--
with hourly_sale
as
(
select *,
case
when extract (hour from sale_time)< 12 then 'morning'
when extract(hour from sale_time) between 12 and 17 then 'afternoon'
else 'evening'
end as shift 
from retail_sales
)

select shift ,
count(*)as total_orders
from hourly_sale
group by shift
--select extract (hour from current_time)
