-- 42
-- problem 38

CREATE TABLE Sales1 (
    sale_date DATE,
    fruit ENUM('apples', 'oranges'),
    sold_num INT,
    PRIMARY KEY (sale_date, fruit)
);

INSERT INTO Sales1 (sale_date, fruit, sold_num) VALUES
    ('2020-05-01', 'apples', 10),
    ('2020-05-01', 'oranges', 8),
    ('2020-05-02', 'apples', 15),
    ('2020-05-02', 'oranges', 15),
    ('2020-05-03', 'apples', 20),
    ('2020-05-03', 'oranges', 0),
    ('2020-05-04', 'apples', 15),
    ('2020-05-04', 'oranges', 16);

-- problem 
-- Write an SQL query to report the difference between the number of apples and oranges sold each day.
-- Return the result table ordered by sale_date.


-- approach 1
with fruits as (
	select sale_date, sum(case when fruit = "apples" then sold_num else 0 end) as apples,
					sum(case when fruit = "oranges" then sold_num else 0 end) as oranges
	from sales1
	group by sale_date
    )
select sale_date, apples-oranges as diff
from fruits;

-- approach 2
with fruits as (
	select distinct sale_Date,
				(select sold_num from sales1 k where fruit="apples" and sale_Date = s.sale_date) as apples,
				(select sold_num from sales1 where fruit="oranges" and sale_Date = s.sale_date) as oranges
	from sales1 s )
select sale_date, apples-oranges as diff
from fruits;
