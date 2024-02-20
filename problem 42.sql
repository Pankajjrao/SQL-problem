-- 46
-- problem 42

use pratice_problems;

CREATE TABLE Customer (
    customer_id INT,
    product_key INT,
    FOREIGN KEY (product_key) REFERENCES Product1(product_key)
);

CREATE TABLE Product1 (
    product_key INT PRIMARY KEY
);

-- Inserting data into the Product table
INSERT INTO Product1 (product_key) VALUES
(5),
(6);

-- Inserting data into the Customer table
INSERT INTO Customer (customer_id, product_key) VALUES
(1, 5),
(2, 6),
(3, 5),
(3, 6),
(1, 6);


-- problem
-- Write an SQL query to report the customer ids from the Customer table that bought all the products in the Product table

select customer_id
from Customer
group by customer_id
having count(distinct product_key) = (select count(*) from product1);

