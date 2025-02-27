SELECT * FROM pizza_sales
SELECT SUM(total_price) AS Total_Revenue from pizza_sales;
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value from pizza_sales;
SELECT SUM(quantity) AS Total_Pizzas_Sold from pizza_sales;
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order FROM pizza_sales;

SELECT * FROM pizza_sales
--Daily Trend
SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY DATENAME(DW, order_date);

--Hourly Trend
SELECT DATEPART(HOUR, order_time) AS order_hours, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

SELECT * FROM pizza_sales

SELECT pizza_category, SUM(total_price) AS Total_Sales, SUM(total_price) * 100 /
(SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS PCT
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category
  
SELECT pizza_size, CAST(SUM(total_price)  AS DECIMAL(10,2)) AS Total_Sales, CAST(SUM(total_price) * 100 /
(SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(quarter, order_date)=1) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
WHERE DATEPART(quarter, order_date)=1
GROUP BY pizza_size
ORDER BY PCT DESC

SELECT * FROM pizza_sales

SELECT pizza_category, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_category;

SELECT * FROM pizza_sales

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC