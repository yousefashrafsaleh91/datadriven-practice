CREATE TABLE dim_products (
    product_id INT,
    name VARCHAR,
    category VARCHAR,
    PRIMARY KEY (product_id)
);

CREATE TABLE dim_packages (
    package_id INT,
    time TIMESTAMP,
    order_id INT,
    location TEXT,  /* no type on the canvas */
    status TEXT,  /* no type on the canvas */
    PRIMARY KEY (package_id, time)
);

CREATE TABLE dim_customers (
    customer_id INT,
    Fname VARCHAR,
    Lname VARCHAR,
    age INT,
    PRIMARY KEY (customer_id)
);

CREATE TABLE dim_date (
    datekey INT,
    year INT,
    month INT,
    day INT,
    PRIMARY KEY (datekey)
);

CREATE TABLE fact_orders (
    order_id INT,
    package_id INT,
    customer_id TEXT,  /* no type on the canvas */
    product_id INT,
    datekey INT,
    price DECIMAL,
    quantitiy INT,
    total_sale DECIMAL,
    status VARCHAR,
    PRIMARY KEY (order_id, package_id)
);

ALTER TABLE fact_orders
    ADD FOREIGN KEY (package_id) REFERENCES dim_packages (package_id);

ALTER TABLE dim_packages
    ADD FOREIGN KEY (order_id) REFERENCES fact_orders (order_id);

ALTER TABLE dim_customers
    ADD FOREIGN KEY (customer_id) REFERENCES fact_orders (customer_id);

ALTER TABLE dim_products
    ADD FOREIGN KEY (product_id) REFERENCES fact_orders (product_id);

ALTER TABLE fact_orders
    ADD FOREIGN KEY (datekey) REFERENCES dim_date (datekey);
