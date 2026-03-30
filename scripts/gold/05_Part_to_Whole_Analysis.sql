--Which Category contribute the most to Overall sales
WITH Percentage_Sale AS(
SELECT 
	category,
	sum(sales_amount) AS Total_Sales
FROM gold.fact_sales as f
LEFT JOIN gold.dim_products as p
ON f.product_key = p.product_key
GROUP BY category
)

SELECT 
 category,
 Total_Sales,
 SUM(Total_Sales) over() overall_sales,
 CONCAT(ROUND((CAST(Total_Sales AS FLOAT)/ SUM(Total_Sales) OVER()) * 100,2),'%' ) AS Percentage_of_Total
FROM Percentage_Sale
ORDER BY Total_Sales DESC

