/* This SQL script creates three analytics-ready views in the Gold layer of a data warehouse using a star schema design.

gold.dim_customers builds a customer dimension by combining CRM and ERP customer data, cleaning gender values, and generating a surrogate customer key.

gold.dim_products creates a product dimension by joining product information with category data and filtering out inactive (historical) products.

gold.fact_sales creates a sales fact view that links sales transactions with the customer and product dimensions to support analytical queries.

Together, these views transform cleaned Silver layer data into business-ready datasets for reporting, dashboards, and analytics.

*/

--TO CREATE GOLD_DIM_CUSTOMERS
CREATE VIEW gold.dim_customers AS
SELECT 
	ROW_NUMBER() OVER(ORDER BY cst_id) AS Customer_Key,
	ci.cst_id AS Customer_ID,
	ci.cst_key AS Customer_Number,
	ci.cst_firstname AS First_Name,
	ci.cst_lastname AS Last_Name,
	la.CNTRY AS Country,
	ci.cst_marital_status AS Marital_Status,
	CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr 
			ELSE COALESCE(ca.GEN,'n/a')
	END AS Gender,
	ca.BDATE AS Birth_Date,
	ci.cst_create_date AS Created_Date	
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_CUST_A12 ca
ON        ci.cst_key = ca.CID
LEFT JOIN silver.erp_LOC_A101 la
ON        ca.CID = la.CID
WHERE ci.cst_id IS NOT NULL


--TO CREATE GOLD_DIM_PRODUCTS
CREATE VIEW gold.dim_products AS
SELECT
	ROW_NUMBER() OVER(ORDER BY pn.prd_start_dt, pn.prd_key) AS Product_key,
	pn.prd_id AS Product_ID,
	pn.prd_key AS Product_Number,
	pn.prd_nm AS Product_Name,
	pn.cat_id AS Category_ID,
	pc.CAT AS Category,
	pc.SUBCAT AS Sub_Category,
	pc.MAINTENANCE AS Maintenance,
	pn.prd_cost AS Production_Cost,
	pn.prd_line AS Production_Line,
	pn.prd_start_dt AS Production_Start_Date	
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_PX_CAT_G1V2 pc
ON pn.cat_id = pc.ID
WHERE pn.prd_end_dt IS NULL  --Filter out all historical data


--TO CREATE GOLD.FACT_SALES
CREATE VIEW gold.fact_sales AS
SELECT
	sd.sls_ord_num AS Order_Number,
	p.Product_key,
	c.Customer_Key,
	p.Product_Name AS Product_Name,
	sd.sls_order_dt AS Order_Date,
	sd.sls_ship_dt AS Shipping_Date,
	sd.sls_due_dt AS Due_Date,
	sd.sls_sales AS Sales_Amount,
	sd.sls_quantity AS Sales_Quantity,
	sd.sls_price AS Price
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_customers c
ON c.Customer_ID=sd.sls_cust_id
LEFT JOIN gold.dim_products p
ON sd.sls_prd_key=p.Product_Number
