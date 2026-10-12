CREATE TABLE Customer_Address (
    cus_id INT,
    Add_id INT,
    moved_on DATE,
    moved_out DATE
);

CREATE TABLE Address (
    id INT,
    zipcode INT,
    street VARCHAR,
    PRIMARY KEY (id)
);

CREATE TABLE Customer (
    id INT,
    name VARCHAR,
    PRIMARY KEY (id)
);

ALTER TABLE Customer_Address
    ADD FOREIGN KEY (Add_id) REFERENCES Address (id);

ALTER TABLE Customer_Address
    ADD FOREIGN KEY (cus_id) REFERENCES Customer (id);
