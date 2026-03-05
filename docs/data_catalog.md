**Gold Layer Schema Documentation**

The Gold Layer contains analytics-ready tables designed using a Star Schema. These tables support reporting, dashboards, and business analytics.

The Gold Layer contains the following objects:

| Table           | Type      | Description                              |
| --------------- | --------- | ---------------------------------------- |
| `dim_customers` | Dimension | Customer demographic and profile data    |
| `dim_products`  | Dimension | Product catalog and category information |
| `fact_sales`    | Fact      | Sales transaction records                |

----------------------------------------------------------------------------------------------------------

**Customer Dimension**.
**gold.dim_customers**

This table stores customer attributes and demographic data.
It integrates data from CRM and ERP systems.
| Column            | Data Type    | Description                                                          |
| ----------------- | ------------ | -------------------------------------------------------------------- |
| `Customer_Key`    | INT          | Surrogate key generated using `ROW_NUMBER()` for the dimension table |
| `Customer_ID`     | INT          | Unique identifier of the customer from the CRM system                |
| `Customer_Number` | NVARCHAR(50) | Business identifier for the customer                                 |
| `First_Name`      | NVARCHAR(50) | Customer's first name                                                |
| `Last_Name`       | NVARCHAR(50) | Customer's last name                                                 |
| `Country`         | NVARCHAR(50) | Country where the customer resides                                   |
| `Marital_Status`  | NVARCHAR(20) | Customer marital status                                              |
| `Gender`          | NVARCHAR(10) | Customer gender derived from CRM or ERP data                         |
| `Birth_Date`      | DATE         | Customer date of birth                                               |
| `Created_Date`    | DATETIME     | Date the customer was created in the CRM system                      |



---------------------------------------------------------------------------------------------------------------

**Product Dimension**.

**gold.dim_products**

This table stores product information and classification data.

It combines product information with category data to enable product performance analysis.
| Column                  | Data Type     | Description                                       |
| ----------------------- | ------------- | ------------------------------------------------- |
| `Product_Key`           | INT           | Surrogate key generated for the product dimension |
| `Product_ID`            | INT           | Unique identifier for the product                 |
| `Product_Number`        | NVARCHAR(50)  | Business key identifying the product              |
| `Product_Name`          | NVARCHAR(100) | Name of the product                               |
| `Category_ID`           | NVARCHAR(50)  | Identifier of the product category                |
| `Category`              | NVARCHAR(50)  | Product category                                  |
| `Sub_Category`          | NVARCHAR(50)  | Product subcategory                               |
| `Maintenance`           | NVARCHAR(50)  | Product maintenance classification                |
| `Production_Cost`       | DECIMAL(10,2) | Cost of producing the product                     |
| `Production_Line`       | NVARCHAR(50)  | Product line or manufacturing group               |
| `Production_Start_Date` | DATE          | Date the product became active for production     |

-----------------------------------------------------------------------------------------------------------------


**Sales Fact Table.**

**gold.fact_sales**

The fact table stores transaction-level sales data.

It connects customers and products to sales transactions.
| Column           | Data Type     | Description                             |
| ---------------- | ------------- | --------------------------------------- |
| `Order_Number`   | NVARCHAR(50)  | Unique identifier for each sales order  |
| `Product_Key`    | INT           | Foreign key referencing `dim_products`  |
| `Customer_Key`   | INT           | Foreign key referencing `dim_customers` |
| `Product_Name`   | NVARCHAR(100) | Name of the product sold                |
| `Order_Date`     | DATE          | Date when the order was placed          |
| `Shipping_Date`  | DATE          | Date when the order was shipped         |
| `Due_Date`       | DATE          | Expected delivery date                  |
| `Sales_Amount`   | DECIMAL(12,2) | Total value of the sale                 |
| `Sales_Quantity` | INT           | Number of units sold                    |
| `Price`          | DECIMAL(10,2) | Unit price of the product               |

------------------------------------------------------------------------------------------------------------
**Table Relationships**

The data warehouse uses a Star Schema to simplify analytics queries.

dim_customers
      |
      |
fact_sales
      |
      |
dim_products

| Fact Table Column         | Dimension Table              | Relationship |
| ------------------------- | ---------------------------- | ------------ |
| `fact_sales.Customer_Key` | `dim_customers.Customer_Key` | Many-to-One  |
| `fact_sales.Product_Key`  | `dim_products.Product_Key`   | Many-to-One  |

Key Design Features
| Feature              | Description                                              |
| -------------------- | -------------------------------------------------------- |
| Surrogate Keys       | Generated using `ROW_NUMBER()` for stable dimension keys |
| Star Schema          | Optimized for analytical queries                         |
| Data Integration     | Combines CRM and ERP data                                |
| Data Cleaning        | Handles missing values using `CASE` and `COALESCE`       |
| Historical Filtering | Filters inactive products using `prd_end_dt IS NULL`     |
