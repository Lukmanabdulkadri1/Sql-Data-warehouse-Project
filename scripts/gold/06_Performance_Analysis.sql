/*Analyse the Yearly Performance of the Products by comparing each Product's 
sales to both its average sales performance and the previous year's sales */

WITH Yearly_product_sales AS( 
	SELECT
		p.product_name AS Product_Name,
		YEAR(f.Order_date) AS Order_Year,
		SUM(sales_amount) AS Current_sales
	FROM gold.fact_sales f
	LEFT JOIN gold.dim_products p
	ON f.product_key=p.product_key
	WHERE YEAR(f.Order_date) IS NOT NULL
	GROUP BY p.product_name,YEAR(f.Order_date)
)

SELECT
	Product_Name,
    Order_Year,
	Current_sales,
	AVG(Current_sales) OVER(PARTITION BY Product_name) AS AVG_Sales,
	Current_sales - AVG(Current_sales) OVER(PARTITION BY Product_name) AS Diff_AVG,
	CASE 
		WHEN Current_sales - AVG(Current_sales) OVER(PARTITION BY Product_name) > 0
		THEN 'Above Avg'
		WHEN Current_sales - AVG(Current_sales) OVER(PARTITION BY Product_name) < 0
		THEN 'Below Avg'
		ELSE 'Avg'
	END AVG_Change,
	LAG(Current_sales) OVER(PARTITION BY Product_name ORDER BY order_year) AS PY_Sales,
	Current_sales - LAG(Current_sales) OVER(PARTITION BY Product_name ORDER BY order_year) AS diff_PY,
	CASE 
		WHEN Current_sales - LAG(Current_sales) OVER(PARTITION BY Product_name ORDER BY order_year) > 0
		THEN 'Increase'
		WHEN Current_sales - LAG(Current_sales) OVER(PARTITION BY Product_name ORDER BY order_year) < 0
		THEN 'Decrease'
		ELSE 'No Change'
	END PY_Change
FROM Yearly_product_sales
ORDER BY Product_Name, Order_Year

