-- PROBLEM 19

CREATE TABLE Delivery (
    delivery_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    customer_pref_delivery_date DATE
);
INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date)
VALUES
    (1, 1, '2019-08-01', '2019-08-02'),
    (2, 5, '2019-08-02', '2019-08-02'),
    (3, 1, '2019-08-11', '2019-08-11'),
    (4, 3, '2019-08-24', '2019-08-26'),
    (5, 4, '2019-08-21', '2019-08-22'),
    (6, 2, '2019-08-11', '2019-08-13');
    

-- problem  
-- If the customer's preferred delivery date is the same as the order date, then the order is called immediately; otherwise, it is called scheduled.
-- Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.
-- The query result format is in the following example.


-- Approch 1
select round((x.no_scheduled_orders * 100)  / count(*), 2) as immediate_percentage
from delivery
inner join ( select count(*) as no_scheduled_orders 
			 from delivery 
			 where order_date = customer_pref_delivery_date) x;


-- approach 2
SELECT
    ROUND(SUM(CASE 
				WHEN order_date = customer_pref_delivery_date THEN 1 
                ELSE 0 
			  END) * 100 / COUNT(*), 2) AS immediate_percentage
FROM
    Delivery;
    
SELECT
    ROUND(SUM(CASE 
				WHEN order_date = customer_pref_delivery_date THEN 1 
                ELSE 0 
			  END) * 100 / COUNT(*), 2) AS immediate_percentage
FROM
    Delivery;
