-- problem 23
CREATE TABLE Prices (
    product_id INT,
    start_date DATE,
    end_date DATE,
    price INT,
    PRIMARY KEY (product_id, start_date, end_date)
);

CREATE TABLE UnitsSold (
    product_id INT,
    purchase_date DATE,
    units INT
);

INSERT INTO Prices (product_id, start_date, end_date, price)
VALUES
    (1, '2019-02-17', '2019-02-28', 5),
    (1, '2019-03-01', '2019-03-22', 20),
    (2, '2019-02-01', '2019-02-20', 15),
    (2, '2019-02-21', '2019-03-31', 30);
    
INSERT INTO UnitsSold (product_id, purchase_date, units)
VALUES
    (1, '2019-02-25', 100),
    (1, '2019-03-01', 15),
    (2, '2019-02-10', 200),
    (2, '2019-03-22', 30);


-- problem
-- Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places.
-- Return the result table in any order


select p.product_id, sum(p.price * u.units)/ sum(u.units) as avg_price
from Prices p 
inner join UnitsSold u
on p.product_id = u.product_id AND (u.purchase_date BETWEEN p.start_date AND p.end_date)
group by p.product_id;
