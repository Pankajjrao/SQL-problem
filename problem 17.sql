-- Question 17

-- Create Product table
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    unit_price INT
);

-- Insert data into Product table
INSERT INTO Product (product_id, product_name, unit_price) VALUES
(1, 'S8', 1000),
(2, 'G4', 800),
(3, 'iPhone', 1400);

-- Create Sales table
CREATE TABLE Sales (
    seller_id INT,
    product_id INT,
    buyer_id INT,
    sale_date DATE,
    quantity INT,
    price INT,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);


-- Insert data into Sales table
INSERT INTO Sales (seller_id, product_id, buyer_id, sale_date, quantity, price) VALUES
(1, 1, 1, '2019-01-21', 2, 2000),
(1, 2, 2, '2019-02-17', 1, 800),
(2, 2, 3, '2019-06-02', 1, 800),
(3, 3, 4, '2019-05-13', 2, 2800);


-- Problem 
-- Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is,
-- between 2019-01-01 and 2019-03-31 inclusive.
-- Return the result table in any order.
-- The query result format is in the following example.

-- solution
select p.product_id, p.product_name,s.sale_date
from product p
inner join sales s
on p.product_id = s.product_id
where "2019-03-31" >= s.sale_date and s.sale_date >= "2019-01-01" ;
