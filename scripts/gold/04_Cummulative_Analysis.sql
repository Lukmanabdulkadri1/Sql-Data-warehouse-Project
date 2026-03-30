--Calculate the total sales per month

SELECT
FORMAT(DATETRUNC(MONTH,order_date), 'yyyy-MMM') Months,
SUM(sales_amount) AS Total_Sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL 
GROUP BY DATETRUNC(MONTH,order_date)
ORDER BY DATETRUNC(MONTH,order_date)

-- Calculate the running Total Over Time

SELECT
Year,
Total_Sales,
SUM(Total_sales) OVER(ORDER BY Year) AS Running_Total_Sales,
AVG(AVG_Price) OVER(ORDER BY Year) AS Moving_AVG_Price
FROM(
SELECT 
	DATETRUNC(YEAR,order_date) as Year,
	SUM(sales_amount) AS Total_Sales,
	AVG(Price) AS AVG_Price
FROM gold.fact_sales
WHERE order_date IS NOT NULL 
GROUP BY DATETRUNC(YEAR,order_date))t

