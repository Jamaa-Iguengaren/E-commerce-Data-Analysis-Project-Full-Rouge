-- Silver Layer
-- Nettoyage, transformation et structuration

USE EcommerceDW;
GO
---------------------------------------------------------------

-- Creation de Table 'dim_customer': Informations propres sur les clients
CREATE TABLE silver.dim_customer (
    Customer_ID NVARCHAR(50) PRIMARY KEY,
    Customer_Age INT,
    Customer_Gender NVARCHAR(20),
    Customer_Segment NVARCHAR(50),
    Membership_Status NVARCHAR(50),
    Customer_Lifetime_Value DECIMAL(18,2)
);
GO
drop table silver.dim_customer


---------------------------------------------------------------
-- Insertion dans la table dim_customer
WITH cte AS (
    SELECT
        Customer_ID,
        TRY_CAST(Customer_Age AS INT) AS Customer_Age,
        Customer_Gender,
        Customer_Segment,
        Membership_Status,
        TRY_CAST(Customer_Lifetime_Value AS DECIMAL(18,2)) AS Customer_Lifetime_Value,
        ROW_NUMBER() OVER (PARTITION BY Customer_ID ORDER BY TRY_CAST(Order_Date AS DATE) DESC) AS rn
    FROM bronze.orders_raw
    WHERE Customer_ID IS NOT NULL
)
INSERT INTO silver.dim_customer (Customer_ID, Customer_Age, Customer_Gender, Customer_Segment, Membership_Status, Customer_Lifetime_Value)
SELECT
    Customer_ID,
    Customer_Age,
    Customer_Gender,
    Customer_Segment,
    Membership_Status,
    Customer_Lifetime_Value
FROM cte
WHERE rn = 1;
GO

-- Vérification du l'insertion
select * from silver.dim_customer


---------------------------------------------------------------
-- Creation de Table 'dim_product': Informations propres sur les products

CREATE TABLE silver.dim_product (
    Product_ID NVARCHAR(50) PRIMARY KEY,
    Product_Category NVARCHAR(100),
    Product_Subcategory NVARCHAR(100),
    Brand NVARCHAR(100)
    );
GO

---------------------------------------------------------------
-- Insertion dans la table dim_product
INSERT INTO silver.dim_product
(
    Product_ID,
    Product_Category,
    Product_Subcategory,
    Brand
)
SELECT
    TRIM(Product_ID) AS Product_ID,
    MAX(TRIM(Product_Category)) AS Product_Category,
    MAX(TRIM(Product_Subcategory)) AS Product_Subcategory,
    MAX(TRIM(Brand)) AS Brand
FROM bronze.orders_raw
WHERE Product_ID IS NOT NULL
GROUP BY TRIM(Product_ID);
GO

drop table silver.dim_product

-- Vérification du l'insertion
select * from silver.dim_product

---------------------------------------------------------------
-- Creation de Table 'dim_date': Dimension temporelle

CREATE TABLE silver.dim_date (   
    Order_Date DATE PRIMARY KEY,
    Year INT,
    Month INT,
    Day INT,
    Day_Of_Week NVARCHAR(50),
    Quarter NVARCHAR(10),
    Season NVARCHAR(50),
    Holiday_Season NVARCHAR(50)
);
GO
select * from silver.dim_date
drop table silver.dim_date
---------------------------------------------------------------
-- Insertion dans la table dim_date
WITH cte_date AS (
    SELECT
        TRY_CAST(Order_Date AS DATE) AS Order_Date,
        TRY_CAST(Year AS INT) AS Year,
        TRY_CAST(Month AS INT) AS Month,
        TRY_CAST(Day AS INT) AS Day,
        TRIM(Day_Of_Week) AS Day_Of_Week,
        TRY_CAST(Quarter AS INT) AS Quarter,
        TRIM(Season) AS Season,
        TRIM(Holiday_Season) AS Holiday_Season,
        ROW_NUMBER() OVER (PARTITION BY Order_Date ORDER BY (SELECT NULL)
        ) AS rn
    FROM bronze.orders_raw
    WHERE Order_Date IS NOT NULL 
      AND TRY_CAST(Order_Date AS DATE) IS NOT NULL
)
INSERT INTO silver.dim_date
SELECT
    Order_Date,
    Year,
    Month,
    Day,
    Day_Of_Week,
    Quarter,
    Season,
    Holiday_Season
FROM cte_date
WHERE rn = 1;
GO


---------------------------------------------------------------
-- Creation de Table fact_sales la table centrale pour l'analyse BI (KPI)

CREATE TABLE silver.fact_sales (
    Order_ID NVARCHAR(50) NOT NULL,
    
    -- FOREIGN KEY
    Customer_ID NVARCHAR(50) NOT NULL FOREIGN KEY REFERENCES silver.dim_customer(Customer_ID),
    Product_ID NVARCHAR(50) NOT NULL FOREIGN KEY REFERENCES silver.dim_product(Product_ID),
    Order_Date DATE NOT NULL FOREIGN KEY REFERENCES silver.dim_date(Order_Date),

    Country NVARCHAR(100),
    City NVARCHAR(100),
    Warehouse_Region NVARCHAR(100),
    
    Payment_Method NVARCHAR(50),
    Device_Type NVARCHAR(50),
    Traffic_Source NVARCHAR(50),
    Shipping_Method NVARCHAR(50),
    Order_Status NVARCHAR(50),
    Coupon_Used NVARCHAR(10),
    Returned NVARCHAR(10),
    High_Value_Order NVARCHAR(10),
    Delivery_Days INT,
    Review_Rating DECIMAL(3,1),
    
    -- (Measures)
    Unit_Price DECIMAL(18,2),
    Quantity INT,
    Discount_Percent DECIMAL(5,2),
    Discount_Amount DECIMAL(18,2),
    Shipping_Cost DECIMAL(18,2),
    Tax_Amount DECIMAL(18,2),
    Order_Amount DECIMAL(18,2),
    Profit_Margin_Percent DECIMAL(5,2),
    Profit_Amount DECIMAL(18,2)
);
GO

drop table silver.fact_sales

---------------------------------------------------------------
-- Insertion dans la table FACT TABLE
---------------------------------------------------------------
INSERT INTO silver.fact_sales (
    Order_ID,
    Customer_ID,
    Product_ID,
    Order_Date,
    Country,
    City,
    Warehouse_Region,
    Payment_Method,
    Device_Type,
    Traffic_Source,
    Shipping_Method,
    Order_Status,
    Coupon_Used,
    Returned,
    High_Value_Order,
    Delivery_Days,
    Review_Rating,
    Unit_Price,
    Quantity,
    Discount_Percent,
    Discount_Amount,
    Shipping_Cost,
    Tax_Amount,
    Order_Amount,
    Profit_Margin_Percent,
    Profit_Amount
)
SELECT
    TRIM(o.Order_ID),
    TRIM(o.Customer_ID),
    TRIM(o.Product_ID),
    TRY_CAST(o.Order_Date AS DATE),
    TRIM(o.Country),
    TRIM(o.City),
    TRIM(o.Warehouse_Region),
    TRIM(o.Payment_Method),
    TRIM(o.Device_Type),
    TRIM(o.Traffic_Source),
    TRIM(o.Shipping_Method),
    TRIM(o.Order_Status),
    TRIM(o.Coupon_Used),
    TRIM(o.Returned),
    TRIM(o.High_Value_Order),
    TRY_CAST(o.Delivery_Days AS INT),
    TRY_CAST(o.Review_Rating AS DECIMAL(3,1)),
    TRY_CAST(o.Unit_Price AS DECIMAL(18,2)),
    TRY_CAST(o.Quantity AS INT),
    TRY_CAST(o.Discount_Percent AS DECIMAL(5,2)),
    TRY_CAST(o.Discount_Amount AS DECIMAL(18,2)),
    TRY_CAST(o.Shipping_Cost AS DECIMAL(18,2)),
    TRY_CAST(o.Tax_Amount AS DECIMAL(18,2)),
    TRY_CAST(o.Order_Amount AS DECIMAL(18,2)),
    TRY_CAST(o.Profit_Margin_Percent AS DECIMAL(5,2)),
    TRY_CAST(o.Profit_Amount AS DECIMAL(18,2))
FROM bronze.orders_raw o
WHERE o.Order_Date IS NOT NULL 
  AND TRY_CAST(o.Order_Date AS DATE) IS NOT NULL;
GO


---------------------------------------------------------------
-- QUALITY CHECKS (DATA VALIDATION)

-- Check duplicates
SELECT Customer_ID, COUNT(*)
FROM silver.dim_customer
GROUP BY Customer_ID
HAVING COUNT(*) > 1;

-- Check fact table size
SELECT COUNT(*) AS Total_Fact_Rows
FROM silver.fact_sales;

-- Check NULL values
SELECT *
FROM silver.fact_sales
WHERE Order_Amount IS NULL;
GO