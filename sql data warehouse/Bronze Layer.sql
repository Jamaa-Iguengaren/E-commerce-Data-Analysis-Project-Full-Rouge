-- Bronze Layer

-- Création de la table Bronze:
-- Cette table stocke les données brutes provenant du fichier CSV.

CREATE TABLE bronze.orders_raw(
    Order_ID NVARCHAR(MAX),
    Customer_ID NVARCHAR(MAX),
    Order_Date NVARCHAR(MAX),

    Year NVARCHAR(MAX),
    Month NVARCHAR(MAX),
    Day NVARCHAR(MAX),
    Day_Of_Week NVARCHAR(MAX),
    Quarter NVARCHAR(MAX),

    Customer_Age NVARCHAR(MAX),
    Customer_Gender NVARCHAR(MAX),

    Country NVARCHAR(MAX),
    City NVARCHAR(MAX),

    Customer_Segment NVARCHAR(MAX),

    Product_ID NVARCHAR(MAX),
    Product_Category NVARCHAR(MAX),
    Product_Subcategory NVARCHAR(MAX),
    Brand NVARCHAR(MAX),

    Unit_Price NVARCHAR(MAX),
    Quantity NVARCHAR(MAX),

    Discount_Percent NVARCHAR(MAX),
    Discount_Amount NVARCHAR(MAX),

    Coupon_Used NVARCHAR(MAX),

    Shipping_Cost NVARCHAR(MAX),
    Tax_Amount NVARCHAR(MAX),

    Order_Amount NVARCHAR(MAX),

    Payment_Method NVARCHAR(MAX),

    Device_Type NVARCHAR(MAX),

    Traffic_Source NVARCHAR(MAX),

    Membership_Status NVARCHAR(MAX),

    Shipping_Method NVARCHAR(MAX),

    Warehouse_Region NVARCHAR(MAX),

    Delivery_Days NVARCHAR(MAX),

    Order_Status NVARCHAR(MAX),

    Returned NVARCHAR(MAX),

    Review_Rating NVARCHAR(MAX),

    Customer_Lifetime_Value NVARCHAR(MAX),

    Profit_Margin_Percent NVARCHAR(MAX),

    Profit_Amount NVARCHAR(MAX),

    Season NVARCHAR(MAX),

    Holiday_Season NVARCHAR(MAX),

    High_Value_Order NVARCHAR(MAX)

);
GO

-- Nombre total de colonnes:
SELECT COUNT(*) AS Total_Columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'bronze'
  AND TABLE_NAME = 'orders_raw';

-- Chargement des données CSV dans Bronze
BULK INSERT bronze.orders_raw
FROM 'C:\Users\dell\Documents\Full Rouge\data\ecommerce_orders_dataset.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
GO


-- Vérification du chargement

SELECT TOP (10) *
FROM bronze.orders_raw;
GO

-- Vérifier le nombre total des lignes importées

SELECT COUNT(*) AS Total_Rows
FROM bronze.orders_raw;
GO