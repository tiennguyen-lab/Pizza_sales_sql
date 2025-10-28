-- Total Revenue 
select 
	round(sum(total_price),0) as Total_Revenue
from pizza_sales
-- Average Orders
select 
	sum(total_price)/count(distinct order_id) as Avg_Orders_Value
from pizza_sales 

-- Total Quantity Sold
select 
	count(quantity) as Total_Quantity_Sold
from pizza_sales

-- Total Orders 
select 
	count(distinct order_id) Total_Orders
from pizza_sales

-- Average Pizzas Per Order
select 
	cast(cast(sum(quantity) as decimal(10,2)) / 
		cast(count(distinct order_id)as decimal(10,2)) as decimal(10,2))
		Average_Pizzas_Per_Order
from pizza_sales

-- Daily Trend for Total orders 
select datename(weekday,order_date) as order_day,
		count(distinct order_id) as Total_orders
	from pizza_sales
	group by datename(weekday,order_date)

-- Monthly Trend for Total orders 
select datename(month,order_date) as Month_Name,
		count(distinct order_id) as Total_orders
	from pizza_sales
	group by datename(month,order_date)
	order by Total_orders desc

-- Percentage of Sales by Category 

select 
	pizza_category,
	sum(total_price) Total_sales,
	sum(total_price)*100/(select sum(total_price) from pizza_sales where month(order_date) = 1) as PCT_Category
from pizza_sales
where month(order_date) = 1
group by pizza_category

-- Percentage of Sales by Size 

select 
	pizza_size,
	cast(sum(total_price) as decimal(10,2)) Total_sales,
	cast(sum(total_price)*100/(select sum(total_price) from pizza_sales where month(order_date) = 1) as decimal(10,2)) as PCT_Size
from pizza_sales
where month(order_date) = 1
group by pizza_size
order by PCT_Size desc

-- top 5 Revenue 
select top 5 
	pizza_name,
	cast(sum(total_price) as decimal(10,2)) as Total_Revenue 
from pizza_sales
Group by pizza_name
order by Total_Revenue desc

-- top 5 Quantity
select top 5 
	pizza_name,
	cast(sum(quantity) as decimal(10,2)) as Total_Quantity
from pizza_sales
Group by pizza_name
order by Total_Quantity desc

-- top 5 Orders
select top 5 
	pizza_name,
	count(distinct order_id) as Total_Orders 
from pizza_sales
Group by pizza_name
order by Total_Orders desc