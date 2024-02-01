-- problem 28
    
CREATE TABLE customers(
        customer_id INT,
        name VARCHAR(20),
        country VARCHAR(20),
        CONSTRAINT prime_key PRIMARY KEY(customer_id)
	);


CREATE TABLE orders(
        order_id INT,
        customer_id INT,
        product_id INT,
        order_date DATE,
        quantity INT,
        CONSTRAINT prime_key PRIMARY KEY(order_id)
	);


CREATE TABLE products1(
        product_id INT,
        description VARCHAR(20),
        price INT,
        CONSTRAINT prime_key PRIMARY KEY(product_id)
	);


INSERT INTO customers VALUES 
        (1,'WINSTON','USA'),
        (2,'JONATHON','PERU'),
        (3,'MOUSTAFA','EGYPT');


INSERT INTO products1 VALUES 
        (10,'LC PHONE',300),
        (20,'LC T-SHIRT',10),
        (30,'LC BOOK',45),
        (40,'LC KEYCHAIN',2);


INSERT INTO orders VALUES 
        (1,1,10,'2020-06-10',1),
        (2,1,20,'2020-07-01',1),
        (3,1,30,'2020-07-08',2),
        (4,2,10,'2020-06-15',2),
        (5,2,40,'2020-07-01',10),
        (6,3,20,'2020-06-24',2),
        (7,3,30,'2020-06-25',2),
        (9,3,30,'2020-05-08',3);
	
-- write an SQL query to report the customer_id and customer_name of customers who have spent at least $100 in each month of June and July 2020.
-- Return the result table in any order.

-- approach 1
with MonthlySpending as (
	select c.customer_id, c.name, o.order_date, month(o.order_date) as month,sum(o.quantity * p.price) as spent
	from customers c
	inner join orders o 
		on c.customer_id = o.customer_id
	inner join products1 p
		on o.product_id = p.product_id
	where month(o.order_date) in (6,7) 
	group by c.customer_id, c.name , month(o.order_date)
    having spent >= 100
        )
select customer_id, name 
from MonthlySpending
group by customer_id, name
having count(distinct month)  = 2;

-- approach 2
select customer_id,name 
from (
		select c.customer_id,c.name,
				sum(case when  month(o.order_date) = 6 then o.quantity * p.price else 0 end) as june_spent,
				sum(case when  month(o.order_date) = 7 then o.quantity * p.price else 0 end) as july_spent
		from Customers c 
		inner join Orders o 
			ON c.customer_id = o.customer_id
		inner join Products1 p 
			ON o.product_id = p.product_id
		where month(o.order_Date) = 6 or  month(o.order_Date) = 7
		group by c.customer_id
		having june_spent >= 100 and july_spent >= 100 
        ) monthlySpending ;







