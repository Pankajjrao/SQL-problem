-- 41
-- problem 37

-- Warehouse table
CREATE TABLE Warehouse (
    name VARCHAR(255),
    product_id INT,
    units INT,
    PRIMARY KEY (name, product_id)
);

-- Products table
CREATE TABLE Products_warehouse (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    Width INT,
    Length INT,
    Height INT
);

-- Insert data into Warehouse table
INSERT INTO Warehouse (name, product_id, units) VALUES
    ('LCHouse1', 1, 1),
    ('LCHouse1', 2, 10),
    ('LCHouse1', 3, 5),
    ('LCHouse2', 1, 2),
    ('LCHouse2', 2, 2),
    ('LCHouse3', 4, 1);

-- Insert data into Products table
INSERT INTO Products_warehouse (product_id, product_name, Width, Length, Height) VALUES
    (1, 'LC-TV', 5, 50, 40),
    (2, 'LC-KeyChain', 5, 5, 5),
    (3, 'LC-Phone', 2, 10, 10),
    (4, 'LC-T-Shirt', 4, 10, 20);


-- problem
-- Write an SQL query to report the number of cubic feet of volume the inventory occupies in eachwarehouse.
-- use pratice_problems;


select w.name, sum((width*length*height)* w.units)  as volume
from warehouse w
inner join Products_warehouse p 
	on w.product_id = p.product_id
group by w.name;
    
