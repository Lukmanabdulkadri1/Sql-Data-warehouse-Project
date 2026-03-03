--Check for Nulls or duplicates in Primary Key
-- Expectation: No result

SELECT
	cst_id,
	count(*) Count
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING count(*) > 1 OR cst_id IS NULL


--CHECK for UNWANTED SPACES
--Expectation: No Result

Select
cst_firstname
from silver.crm_cust_info
where cst_firstname != TRIM(cst_firstname)


--CHECK consistency in data

SELECT Distinct 
cst_gndr
FROM silver.crm_cust_info

--CHECK for invalid Date Orders
--(END DATE MUST NOT BE EARLIER THAN START DATE)
SELECT*
from silver.crm_prd_info
where prd_end_dt > prd_start_dt

SELECT
*
FROM silver.crm_prd_info
where end_date < start_date --(like order date shouldn't be more that shipping date )
--Check for negative or 0 dates, check legnth of date, or check the boundries
SELECT
NULLIF(date,0) date
FROM tablename
where date <= 0 
OR LEN(Date) < 8
OR date > (Highest date range) e.g 20250101
OR date < (Lowest date range) e.g 19990101


