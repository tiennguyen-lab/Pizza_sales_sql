# PIZZA SALES ANALYSIS USING SQL 
# 📝 Project Introduction

This project focuses on analyzing Year-to-Date (YTD) sales performance of a US-based e-commerce company using SQL.
Through SQL queries, key business metrics such as YTD Sales, Profit, Quantity Sold, and Profit Margin were calculated and compared with previous year data.

🎯 Key Tasks:
Created SQL queries to compute YTD and PYTD Sales for each category.
Calculated Year-over-Year (YoY) growth and trend indicators.
Identified Top 5 and Bottom 5 products by sales volume.
Analyzed sales by Region, State, and Shipping Type to determine performance patterns.

💡 Outcome:
Delivered a complete data-driven analysis that provided insights into regional performance, product trends, and profitability — supporting better business decision-making.


# 📂 Business Questions & SQL Queries
# 1.Calculate KPIs: revenue, quantity sold, orders.
```sql
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

```
# 2. Calculate the trend of total orders
```sql
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
```
# 3. Calculate percentage of Sales by Category, Size
```sql
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
```
# 4. Top 5 products by Sales, Quantity, Orders
```sql
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
```
# 5. Bottom 5 products by Sales, Quantity, Orders
```sql
-- Bottom 5 Sales
select top 5 
	pizza_name,
	cast(sum(total_price) as decimal(10,2)) as Total_Revenue 
from pizza_sales
Group by pizza_name
order by Total_Revenue

-- Bottom 5 Quantity
select top 5 
	pizza_name,
	cast(sum(quantity) as decimal(10,2)) as Total_Quantity
from pizza_sales
Group by pizza_name
order by Total_Quantity

-- Botttom 5 Orders
select top 5 
	pizza_name,
	count(distinct order_id) as Total_Orders 
from pizza_sales
Group by pizza_name
order by Total_Orders
```
