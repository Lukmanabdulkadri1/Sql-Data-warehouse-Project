--MIN/MAX [Date Dimension]

--Find the date of the first and last order
--How many Years of sales are available
SELECT
MIN(order_date) AS First_Order_Date,
MAX(Order_date) AS Last_Order_Date,
Datediff(YEAR,MIN(order_date),MAX(Order_date)) AS Year_Interval
FROM gold.fact_sales


-- Find the youngest and the oldest customer

SELECT
MIN(birth_date) AS Oldest_Customer,
MAX(birth_date) AS Youngest_Customer,
DATEDIFF(YEAR,MIN(birth_date),GETDATE()) AS Age_of_Oldest_customer,
DATEDIFF(YEAR,MAX(birth_date),GETDATE()) AS Age_of_Youngest_Customer
FROM gold.dim_customers



