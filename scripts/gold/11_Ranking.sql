--Which 5 products generate the highest revenue?
SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) AS Total_Revenue,
	ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) DESC) Rank
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key=f.product_key
GROUP BY p.product_name
ORDER BY Total_Revenue DESC
--What are the worst performing products in terms of sales
SELECT TOP 5
	p.product_name,
	SUM(f.sales_amount) AS Total_Revenue,
	ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) ASC ) Rank
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key=f.product_key
GROUP BY p.product_name
ORDER BY Total_Revenue ASC

--Find the Top-10 customers who have generated the highest revenue And 3 customers with the fewest order placed

SELECT
	*
FROM
(
SELECT
	c.customer_key  AS Customer_key,
	SUM(f.sales_amount) AS Total_Sales,
	ROW_NUMBER() OVER(ORDER BY SUM(f.sales_amount) DESC ) AS Rank_No
FROM gold.dim_customers c
LEFT JOIN gold.fact_sales f
ON c.customer_key = f.customer_key
GROUP BY c.customer_key
)t
 WHERE Rank_No <=10;



SELECT TOP 3
	c.customer_key,
	c.first_name,
	c.last_name,
	count(DISTINCT order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY 
c.customer_key,
c.first_name,
c.last_name
ORDER BY total_orders

