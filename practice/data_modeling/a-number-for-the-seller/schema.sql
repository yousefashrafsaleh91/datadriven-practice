CREATE TABLE fact_sales (
    order_id INT,
    seller_id INT,
    date_key INT,
    product_id INT,
    price DECIMAL,
    quantity INT,
    gross_revenue DECIMAL,
    PRIMARY KEY (order_id)
);

CREATE TABLE dim_date (
    date_key INT,
    month INT,
    day INT,
    year INT,
    PRIMARY KEY (date_key)
);

CREATE TABLE dim_products (
    product_id INT,
    seller_id INT,
    product_name VARCHAR,
    listied_at TIMESTAMP,
    is_active BOOLEAN,
    PRIMARY KEY (product_id)
);

CREATE TABLE dim_sellers (
    seller_id INT,
    first_name VARCHAR,
    last_name VARCHAR,
    Country VARCHAR,
    joined_at TEXT,  /* no type on the canvas */
    PRIMARY KEY (seller_id)
);

ALTER TABLE fact_sales
    ADD FOREIGN KEY (date_key) REFERENCES dim_date (date_key);

ALTER TABLE dim_sellers
    ADD FOREIGN KEY (seller_id) REFERENCES fact_sales (seller_id);

ALTER TABLE dim_sellers
    ADD FOREIGN KEY (seller_id) REFERENCES dim_products (seller_id);
