
/* ===========================================================
   OlistECommerce - SQL Server 2022 Setup Script
   =========================================================== */

IF DB_ID('OlistECommerce') IS NOT NULL
BEGIN
    ALTER DATABASE OlistECommerce SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE OlistECommerce;
END
GO

CREATE DATABASE OlistECommerce;
GO
USE OlistECommerce;
GO

/*========================
  GEOLOCATION
=========================
CREATE TABLE Geolocation
(
    geolocation_id INT IDENTITY(1,1) NOT NULL,
    geolocation_zip_code_prefix INT NOT NULL,
    geolocation_lat DECIMAL(11,8),
    geolocation_lng DECIMAL(11,8),
    geolocation_city NVARCHAR(100),
    geolocation_state CHAR(2),
    CONSTRAINT PK_Geolocation PRIMARY KEY (geolocation_id)
);
GO

CREATE INDEX IX_Geolocation_Zip
ON Geolocation(geolocation_zip_code_prefix);
GO
EDITED OUT FOR NOW */

/*========================
  CUSTOMERS
=========================*/
CREATE TABLE Customers
(
    customer_id NVARCHAR(50) NOT NULL,
    customer_unique_id NVARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city NVARCHAR(100),
    customer_state CHAR(2),
    CONSTRAINT PK_Customers PRIMARY KEY(customer_id)
);
GO

/*========================
  PRODUCTS
  (matches cleaned CSV)
=========================*/
CREATE TABLE Products
(
    product_id NVARCHAR(50) NOT NULL,
    product_name_lenght FLOAT,
    product_description_lenght FLOAT,
    product_photos_qty FLOAT,
    product_weight_g FLOAT,
    product_length_cm FLOAT,
    product_height_cm FLOAT,
    product_width_cm FLOAT,
    product_category_name NVARCHAR(100),
    CONSTRAINT PK_Products PRIMARY KEY(product_id)
);
GO

/*========================
  SELLERS
=========================*/
CREATE TABLE Sellers
(
    seller_id NVARCHAR(50) NOT NULL,
    seller_zip_code_prefix INT,
    seller_city NVARCHAR(100),
    seller_state CHAR(2),
    CONSTRAINT PK_Sellers PRIMARY KEY(seller_id)
);
GO

/*========================
  ORDERS
=========================*/
CREATE TABLE Orders
(
    order_id NVARCHAR(50) NOT NULL,
    customer_id NVARCHAR(50) NOT NULL,
    order_status NVARCHAR(30),
    order_purchase_timestamp DATETIME2,
    order_approved_at DATETIME2 NULL,
    order_delivered_carrier_date DATETIME2 NULL,
    order_delivered_customer_date DATETIME2 NULL,
    order_estimated_delivery_date DATETIME2,
    CONSTRAINT PK_Orders PRIMARY KEY(order_id),
    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);
GO

/*========================
  ORDER ITEMS
=========================*/
CREATE TABLE Order_Items
(
    order_id NVARCHAR(50) NOT NULL,
    order_item_id INT NOT NULL,
    product_id NVARCHAR(50) NOT NULL,
    seller_id NVARCHAR(50) NOT NULL,
    shipping_limit_date DATETIME2,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    CONSTRAINT PK_Order_Items PRIMARY KEY(order_id,order_item_id),
    CONSTRAINT FK_OI_Order FOREIGN KEY(order_id) REFERENCES Orders(order_id),
    CONSTRAINT FK_OI_Product FOREIGN KEY(product_id) REFERENCES Products(product_id),
    CONSTRAINT FK_OI_Seller FOREIGN KEY(seller_id) REFERENCES Sellers(seller_id)
);
GO

/*========================
  ORDER PAYMENTS
=========================*/
CREATE TABLE Order_Payments
(
    order_id NVARCHAR(50) NOT NULL,
    payment_sequential INT NOT NULL,
    payment_type NVARCHAR(30),
    payment_installments INT,
    payment_value DECIMAL(10,2),
    CONSTRAINT PK_Order_Payments PRIMARY KEY(order_id,payment_sequential),
    CONSTRAINT FK_OP_Order FOREIGN KEY(order_id) REFERENCES Orders(order_id)
);
GO

/*========================
  ORDER REVIEWS
=========================*/
CREATE TABLE Order_Reviews
(
    review_key INT IDENTITY(1,1) NOT NULL,

    review_id NVARCHAR(50),
    order_id NVARCHAR(50) NOT NULL,
    review_score INT NULL,
    review_comment_title NVARCHAR(500) NULL,
    review_comment_message NVARCHAR(4000) NULL,
    review_creation_date DATETIME2 NULL,
    review_answer_timestamp DATETIME2 NULL,

    CONSTRAINT PK_Order_Reviews
        PRIMARY KEY(review_key),

    CONSTRAINT FK_OR_Order
        FOREIGN KEY(order_id)
        REFERENCES Orders(order_id)
);
GO

CREATE INDEX IX_Customers_Zip ON Customers(customer_zip_code_prefix);
CREATE INDEX IX_Sellers_Zip ON Sellers(seller_zip_code_prefix);
CREATE INDEX IX_Orders_Customer ON Orders(customer_id);
CREATE INDEX IX_OrderItems_Product ON Order_Items(product_id);
CREATE INDEX IX_OrderItems_Seller ON Order_Items(seller_id);
GO

/*========================
  IMPORT ORDER
=========================*/

/* Geolocation:
   Use Import Flat File Wizard because of IDENTITY column
   OR import into a staging table then:
   INSERT INTO Geolocation
   (geolocation_zip_code_prefix,geolocation_lat,geolocation_lng,
    geolocation_city,geolocation_state)
   SELECT ... FROM staging;
*/

BULK INSERT Customers
FROM 'C:\Users\mikee\Desktop\BrazilianECommerce\Data\Cleaned\customers.csv'
WITH (FORMAT='CSV',FIRSTROW=2,CODEPAGE='65001');
GO

BULK INSERT Products
FROM 'C:\Users\mikee\Desktop\BrazilianECommerce\Data\Cleaned\products.csv'
WITH (FORMAT='CSV',FIRSTROW=2,CODEPAGE='65001');
GO

BULK INSERT Sellers
FROM 'C:\Users\mikee\Desktop\BrazilianECommerce\Data\Cleaned\sellers.csv'
WITH (FORMAT='CSV',FIRSTROW=2,CODEPAGE='65001');
GO

BULK INSERT Orders
FROM 'C:\Users\mikee\Desktop\BrazilianECommerce\Data\Cleaned\orders.csv'
WITH (FORMAT='CSV',FIRSTROW=2,CODEPAGE='65001');
GO

BULK INSERT Order_Items
FROM 'C:\Users\mikee\Desktop\BrazilianECommerce\Data\Cleaned\order_items.csv'
WITH (FORMAT='CSV',FIRSTROW=2,CODEPAGE='65001');
GO

BULK INSERT Order_Payments
FROM 'C:\Users\mikee\Desktop\BrazilianECommerce\Data\Cleaned\order_payments.csv'
WITH (FORMAT='CSV',FIRSTROW=2,CODEPAGE='65001');
GO
/* Imported As flat file */
BULK INSERT Order_Reviews
FROM 'C:\Users\mikee\Desktop\BrazilianECommerce\Data\Cleaned\order_reviews.csv'
WITH (FORMAT='CSV',FIRSTROW=2,CODEPAGE='65001');
GO
