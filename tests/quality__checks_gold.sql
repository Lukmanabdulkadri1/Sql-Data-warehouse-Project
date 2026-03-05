/*These queries perform data quality checks on the Gold layer of the data warehouse.
They verify that dimension keys (Customer_Key, Product_Key) are unique and ensure that all records in fact_sales correctly 
reference existing records in the customer and product dimension tables.
*/
--Gold layer check
--**DUPLICATE CHECKS
--*RESULT SHOULD BE EMPTY
--======================================================================================
--Uniqness Check for customer_key in (gold.dim_customers)
--=======================================================================================
SELECT 
	 Customer_Key,
	 COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY Customer_Key
HAVING COUNT(*) > 1

--======================================================================================
--Uniqness Check for Product_key in (gold.dim_products)
--EXPECTATION: No Result
--=======================================================================================
SELECT 
	 Product_Key,
	 COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY Product_Key
HAVING COUNT(*) > 1


-- =========================================================================================
--Checking 'gold_fact_sales
-- ========================================================================================
-- Check the data Model connectivity between Fact and Dimensions

SELECT*
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.Customer_Key = f.Customer_Key
LEFT JOIN gold.dim_products p
ON f.Product_key=p.Product_key
WHERE p.Product_key  IS NULL




