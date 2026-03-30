
/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/
-- =============================================================================
-- Create Report: gold.report_products
-- =============================================================================

---Gathers essential fields such as product name, category, subcategory, and cost.
IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL
    DROP VIEW gold.report_products;
GO

CREATE VIEW gold.report_products AS
WITH base_query AS (
SELECT 
    f.order_number,
    f.customer_key,
    f.product_key,
    f.order_date,
    p.product_name,
    f.quantity,
    p.category,
    p.subcategory,
    p.cost,
    f.sales_amount
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key=f.product_key
WHERE f.order_date IS NOT NULL
)
, product_agg AS (
SELECT
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    sales_amount,
    MIN(Order_date) AS First_sale_Date,
    MAX(order_date) AS Last_Sales_Date,
    COUNT(DISTINCT order_number) AS Total_Order,
    SUM(sales_amount) AS Total_Sales,
    COUNT(DISTINCT customer_key) AS Total_Customers,
    DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS Span,
    SUM(quantity) AS Total_Quantity,
    ROUND(AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)),1) AS avg_selling_price
FROM base_query
GROUP BY
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    sales_amount
    )
    SELECT
        Product_key,
        product_name,
        category,
        subcategory,
        cost,
        Last_Sales_Date,
        sales_amount, 
        Span,
        DATEDIFF(MONTH,Last_Sales_Date,GETDATE()) AS Recency_In_Months,

        -- Product Segment by Revenue
        CASE
		    WHEN total_sales > 50000 THEN 'High-Performer'
		    WHEN total_sales >= 10000 THEN 'Mid-Range'
		    ELSE 'Low-Performer'
	    END AS product_segment,

        -- Average Order Value (AVO)
        CASE 
            WHEN Total_Sales = 0 THEN 0
            ELSE Total_Sales/Total_Order 
            END AS Avg_Order_REV,
       
       -- Average Monthly Spend 
        CASE
            WHEN Span = 0 THEN 0
            ELSE Total_Sales/Span
        END AS AVG_Monthly_REV,
        Total_Customers,
        Total_Sales,
        Total_Order,
        Total_Quantity
    FROM product_agg

 
 
