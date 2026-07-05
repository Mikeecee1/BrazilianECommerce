# SQL #

## DB Creation Script ##

/*===========================================================
    Database: OlistECommerce
    Compatible with SQL Server Management Studio (SSMS)
===========================================================*/

IF DB_ID('OlistECommerce') IS NULL
    CREATE DATABASE OlistECommerce;
GO

USE OlistECommerce;
GO

/*===========================================================
    Customers
===========================================================*/

CREATE TABLE Customers
(
    customer_id                 NVARCHAR(50) NOT NULL,
    customer_unique_id          NVARCHAR(50) NOT NULL,
    customer_zip_code_prefix    INT,
    customer_city               NVARCHAR(100),
    customer_state              CHAR(2),

    CONSTRAINT PK_Customers
        PRIMARY KEY (customer_id)
);
GO


/*===========================================================
    Geolocation
    (Added PK because duplicate ZIP codes exist)
===========================================================*/

CREATE TABLE Geolocation
(
    geolocation_id              INT IDENTITY(1,1) PRIMARY KEY,
    geolocation_zip_code_prefix INT NOT NULL,
    geolocation_lat             DECIMAL(11,8),
    geolocation_lng             DECIMAL(11,8),
    geolocation_city            NVARCHAR(100),
    geolocation_state           CHAR(2)
);
GO

CREATE INDEX IX_Geolocation_Zip
ON Geolocation(geolocation_zip_code_prefix);
GO


/*===========================================================
    Products
===========================================================*/

CREATE TABLE Products
(
    product_id                      NVARCHAR(50) NOT NULL,
    product_category_name           NVARCHAR(100),
    product_name_lenght             INT,
    product_description_lenght      INT,
    product_photos_qty              INT,
    product_weight_g                DECIMAL(10,2),
    product_length_cm               DECIMAL(10,2),
    product_height_cm               DECIMAL(10,2),
    product_width_cm                DECIMAL(10,2),

    CONSTRAINT PK_Products
        PRIMARY KEY (product_id)
);
GO


/*===========================================================
    Sellers
===========================================================*/

CREATE TABLE Sellers
(
    seller_id                  NVARCHAR(50) NOT NULL,
    seller_zip_code_prefix     INT,
    seller_city                NVARCHAR(100),
    seller_state               CHAR(2),

    CONSTRAINT PK_Sellers
        PRIMARY KEY (seller_id)
);
GO


/*===========================================================
    Orders
===========================================================*/

CREATE TABLE Orders
(
    order_id                           NVARCHAR(50) NOT NULL,
    customer_id                        NVARCHAR(50) NOT NULL,
    order_status                       NVARCHAR(30),
    order_purchase_timestamp           DATETIME2,
    order_approved_at                  DATETIME2 NULL,
    order_delivered_carrier_date       DATETIME2 NULL,
    order_delivered_customer_date      DATETIME2 NULL,
    order_estimated_delivery_date      DATETIME2,

    CONSTRAINT PK_Orders
        PRIMARY KEY (order_id),

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
);
GO


/*===========================================================
    Order Items
===========================================================*/

CREATE TABLE Order_Items
(
    order_id               NVARCHAR(50) NOT NULL,
    order_item_id          INT NOT NULL,
    product_id             NVARCHAR(50) NOT NULL,
    seller_id              NVARCHAR(50) NOT NULL,
    shipping_limit_date    DATETIME2,
    price                  DECIMAL(10,2),
    freight_value          DECIMAL(10,2),

    CONSTRAINT PK_Order_Items
        PRIMARY KEY (order_id, order_item_id),

    CONSTRAINT FK_OrderItems_Orders
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),

    CONSTRAINT FK_OrderItems_Products
        FOREIGN KEY (product_id)
        REFERENCES Products(product_id),

    CONSTRAINT FK_OrderItems_Sellers
        FOREIGN KEY (seller_id)
        REFERENCES Sellers(seller_id)
);
GO


/*===========================================================
    Order Payments
===========================================================*/

CREATE TABLE Order_Payments
(
    order_id                    NVARCHAR(50) NOT NULL,
    payment_sequential          INT NOT NULL,
    payment_type                NVARCHAR(30),
    payment_installments        INT,
    payment_value               DECIMAL(10,2),

    CONSTRAINT PK_Order_Payments
        PRIMARY KEY (order_id, payment_sequential),

    CONSTRAINT FK_OrderPayments_Orders
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
);
GO


/*===========================================================
    Order Reviews
===========================================================*/

CREATE TABLE Order_Reviews
(
    review_id                   NVARCHAR(50) NOT NULL,
    order_id                    NVARCHAR(50) NOT NULL,
    review_score                INT,
    review_comment_title        NVARCHAR(500),
    review_comment_message      NVARCHAR(MAX),
    review_creation_date        DATETIME2,
    review_answer_timestamp     DATETIME2,

    CONSTRAINT PK_Order_Reviews
        PRIMARY KEY (review_id),

    CONSTRAINT FK_OrderReviews_Orders
        FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
);
GO


/*===========================================================
    Helpful Indexes
===========================================================*/

CREATE INDEX IX_Orders_Customer
ON Orders(customer_id);

CREATE INDEX IX_OrderItems_Product
ON Order_Items(product_id);

CREATE INDEX IX_OrderItems_Seller
ON Order_Items(seller_id);

CREATE INDEX IX_OrderPayments_Order
ON Order_Payments(order_id);

CREATE INDEX IX_OrderReviews_Order
ON Order_Reviews(order_id);

CREATE INDEX IX_Customers_Zip
ON Customers(customer_zip_code_prefix);

CREATE INDEX IX_Sellers_Zip
ON Sellers(seller_zip_code_prefix);

GO