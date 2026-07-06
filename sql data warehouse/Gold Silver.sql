-- Gold Layer
USE EcommerceDW;
GO

-- view fact_orders
CREATE VIEW gold.fact_orders
AS
SELECT
    f.Order_ID,
    f.Order_Date,

    f.Customer_ID,
    f.Product_ID,

    f.Country,
    f.City,
    f.Warehouse_Region,

    -- Sales Measures
    f.Quantity,
    f.Unit_Price,
    f.Discount_Percent,
    f.Discount_Amount,
    f.Shipping_Cost,
    f.Tax_Amount,
    f.Order_Amount,
    f.Profit_Margin_Percent,
    f.Profit_Amount,

    f.Payment_Method,
    f.Device_Type,
    f.Traffic_Source,
    f.Shipping_Method,
    f.Order_Status,
    f.Coupon_Used,
    f.Returned,
    f.High_Value_Order,
    f.Delivery_Days,
    f.Review_Rating
FROM silver.fact_sales f
GO

-- view dim_customer

CREATE VIEW gold.dim_customer
AS
SELECT
    c.Customer_ID,
    c.Customer_Age,
    c.Customer_Gender,
    c.Customer_Segment,
    c.Membership_Status,
    c.Customer_Lifetime_Value
FROM silver.dim_customer c
GO

-- view dim_product

CREATE VIEW gold.dim_product
AS
SELECT
    p.Product_ID,
    p.Product_Category,
    p.Product_Subcategory,
    p.Brand
FROM silver.dim_product p
GO

-- view dim_date
CREATE VIEW gold.dim_date
AS
SELECT
    d.Order_Date,
    d.Year,
    d.Month,
    d.Day,
    d.Day_Of_Week,
    d.Quarter,
    d.Season,
    d.Holiday_Season
FROM silver.dim_date d
GO
