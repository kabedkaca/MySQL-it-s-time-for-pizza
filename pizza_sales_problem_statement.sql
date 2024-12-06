SELECT * FROM pizza_sales;

-- WE WILL FIRST MAKE CALCULATION FOR KPI
-- KPI
-- 1. find the total revenue and save the tempcplumnunder that name
SELECT SUM(total_price) AS total_revenue FROM pizza_sales;

-- 2. find the avg order
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS avg_order_value FROM pizza_sales; -- why distinct,bcos we want to count each row,and we want to consider each row as unique,we can see fromorder_id,there are repetitive value

-- 3. total pizza quantity sold (how much pizza are there)
SELECT SUM(quantity) AS total_pizza_sold FROM pizza_sales;

-- 4. total orders quantity (how much order are placed)
SELECT COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales;

-- 5.avg pizza per order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS avg_pizzas_per_order
FROM pizza_sales;


-- NOW WE CAN MAKE CALCULATION TO SEE TREND IN DAILY,MONTH AND COMPARISON
-- 1. Daily Trend for Total Orders
SELECT 
    DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y'))
LIMIT 1000;

-- SELECT order_date FROM pizza_sales LIMIT 10; to check what format the date is

-- 2.Monthly Trend for Orders 
SELECT 
    MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS Month_Name, 
    COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y'));

-- 3.  % of Sales by Pizza Category
SELECT 
    pizza_category, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(SUM(total_price) * 100 / 
        (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS percentage_revenue
FROM pizza_sales
GROUP BY pizza_category;

-- 4. % of Sales by Pizza Size
SELECT 
    pizza_size, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS percentage_of_total_revenue
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- 5.Total Pizzas Sold by Pizza Category by quantity
SELECT pizza_category, 
       SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- 6. Top 5 Pizzas by Revenue
SELECT pizza_name, 
       SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
LIMIT 5;

-- 7. the lowest 5 pizza by revenue
SELECT pizza_name, 
       SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
LIMIT 5;

-- 8. top 5 pizza by pizza category by quantity
SELECT pizza_name, 
       SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;

-- 9.top 5 lowest pizza by category by quantity
SELECT pizza_name, 
       SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;

-- 10. Top 5 Pizzas by Total Orders
SELECT pizza_name, 
       COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
LIMIT 5;

-- 11.top worst 5 pizza by total order
SELECT pizza_name, 
       COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC
LIMIT 5;


-- now done