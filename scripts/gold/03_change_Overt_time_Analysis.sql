/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Analyse sales performance over time
-- Quick Date Functions

SELECT 
	YEAR(order_date) AS Year,
	DATENAME(MONTH,order_date) AS Month,
	SUM(sales_amount) AS Total_Sales,
	COUNT(DISTINCT customer_key) AS Total_customer,
	SUM(quantity) AS Total_Quantity
From gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATENAME(MONTH,order_date),YEAR(order_date)
ORDER BY YEAR(order_date)


SELECT 
	FORMAT(DATETRUNC(MONTH,order_date),'yyyy-MMM') AS Month,
	SUM(sales_amount) AS Total_Sales,
	COUNT(DISTINCT customer_key) AS Total_customer,
	SUM(quantity) AS Total_Quantity
From gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
ORDER BY DATETRUNC(MONTH,order_date)



SELECT 
	FORMAT(order_date, 'yyyy-MMM') AS Date,
	SUM(sales_amount) AS Total_Sales,
	COUNT(DISTINCT customer_key) AS Total_customer,
	SUM(quantity) AS Total_Quantity
From gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM')


