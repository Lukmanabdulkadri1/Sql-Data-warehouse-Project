--Find the total Sales
--Find How many items sold
--Find average selling price
--Find the Total number of Orders
--Find the total number of Products
--Find the total number of Customers
--Find the total number of customers that has placed an order


--Find the total Sales
SELECT
	SUM(sales_amount) Total_sales
FROM gold.fact_sales


--Find How many items sold
SELECT 
SUM(quantity)
FROM gold.fact_sales

--Find average selling price
SELECT 
	AVG(Price)
FROM gold.fact_sales

--Find the Total number of Orders
SELECT
 COUNT(order_number) Total_Orders
FROM gold.fact_sales

--Find the total number of Products
SELECT 
	COUNT(product_key) Total_Product
FROM gold.dim_products

--Find the total number of Customers
SELECT 
	Count(customer_key)
FROM gold.dim_customers

--Find the total number of customers that has placed an order

SELECT COUNT(DISTINCT customer_key) FROM gold.fact_sales

SELECT
	COUNT(customer_key) AS Total_customer
FROM gold.dim_customers
WHERE EXISTS(SELECT product_key from gold.fact_sales)


--Generate a Report that Sholws all key metrics of the business
SELECT 'Total Sales' as Measure_name,
	SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' as Measure_name,
	SUM(quantity) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Customer',
	Count(customer_key) AS measure_value
FROM gold.dim_customers
UNION ALL
SELECT 'Total Orders', count(DISTINCT order_number) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Product', count(product_key) AS measure_value FROM gold.dim_products
UNION ALL
SELECT 'Average Price', AVG(Price) AS measure_value FROM gold.fact_sales
