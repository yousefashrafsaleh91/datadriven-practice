CREATE TABLE Sellers (
    seller_id INT,
    first_name VARCHAR,
    last_name VARCHAR,
    age INT,
    location VARCHAR,
    PRIMARY KEY (seller_id)
);

CREATE TABLE Products (
    product_id INT,
    user_id TEXT,
    status VARCHAR,
    publish_date TIMESTAMP,
    PRIMARY KEY (product_id)
);

CREATE TABLE Sales (
    sale_id INT,
    product_id INT,
    seller_id INT,
    price DECIMAL,
    quantity INT,
    total_price DECIMAL,
    discount DECIMAL,
    revenue DECIMAL,
    occur_at TIMESTAMP,
    PRIMARY KEY (sale_id)
);

ALTER TABLE Sellers
    ADD FOREIGN KEY (seller_id) REFERENCES Products (user_id);

ALTER TABLE Sales
    ADD FOREIGN KEY (product_id) REFERENCES Products (product_id);

ALTER TABLE Sales
    ADD FOREIGN KEY (seller_id) REFERENCES Sellers (seller_id);
