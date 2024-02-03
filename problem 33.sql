-- problem 33

CREATE TABLE Products2 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    product_category VARCHAR(255)
);

CREATE TABLE Orders2 (
    product_id INT,
    order_date DATE,
    unit INT,
    FOREIGN KEY (product_id) REFERENCES Products2(product_id)
);

-- Insert data into Products table
INSERT INTO Products2 (product_id, product_name, product_category) VALUES
    (1, 'Leetcode Solutions Book', 'Books'),
    (2, 'Jewels of Stringology Book', 'Books'),
    (3, 'HP Laptop', 'Electronics'),
    (4, 'Lenovo Laptop', 'Electronics'),
    (5, 'Leetcode Kit T-shirt', 'Clothing');
    
-- Insert data into Orders table
INSERT INTO Orders2 (product_id, order_date, unit) VALUES
    (1, '2020-02-05', 60),
    (1, '2020-02-10', 70),
    (2, '2020-01-18', 30),
    (2, '2020-02-11', 80),
    (3, '2020-02-17', 2),
    (3, '2020-02-24', 3),
    (4, '2020-03-01', 20),
    (4, '2020-03-04', 30),
    (4, '2020-03-04', 60),
    (5, '2020-02-25', 50),
    (5, '2020-02-27', 50),
    (5, '2020-03-01', 50);
    
-- problem 
-- Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.

-- approach 1
select p.product_name, u.total_unit
from products2 p 
join  (
		select product_id,order_date,sum(unit) total_unit
		from orders2
		where month(order_date) = 2 and year(order_date) = 2020
		group by product_id
		having sum(unit) >= 100 
        ) u
on p.product_id = u.product_id;

-- approach 2
select p.product_name, sum(u.unit)
from products2 p
inner join orders2 u
on p.product_id = u.product_id
where month(order_date) = 2 and year(order_date) = 2020
group by p.product_id
having sum(u.unit) >= 100 ;

-- approach 3
with units AS (
    select product_id, SUM(unit) as total_unit
    from orders2
    where  month(order_date) = 2 and year(order_date) = 2020
    group by product_id
    having SUM(unit) >= 100 
)
select p.product_name, u.total_unit
from products2 p
join units u on p.product_id = u.product_id;
