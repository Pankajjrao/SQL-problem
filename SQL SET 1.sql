create database pratice_problems;
use pratice_problems;
-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

CREATE TABLE city(
        id INT,
        name VARCHAR(17),
        countrycode VARCHAR(3),
        district VARCHAR(20),
        population INT

	);


INSERT INTO city VALUES 
        (6,'Rotterdam','NLD','Zuid-Holland',593321),
        (3878,'Scottsdale','USA','Arizona',202705),
        (3965,'Corona','USA','California',124966),
        (3973,'Concord','USA','California',121780),
        (3977,'Cedar Rapids','USA','Iowa',120758),
        (3982,'Coral Springs','USA','Florida',117549),
        (4054,'Fairfield','USA','California',92256),
        (4058,'Boulder','USA','Colorado',91238),
        (4061,'Fall River','USA','Massachusetts',90555),
        (1661,'NYC','USA','Newyork',90525),
        (4333,'Mitaka','JPN','Tokyo',91155),
        (4551,'Hino','JPN','Tokyo',45678);
        
        
-- problem1
-- . Query all columns for all American cities in the CITY table with populations larger than 100000.
-- The CountryCode for America is USA.

select * from city 
where countrycode = "USA" and population > 100000;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- problem 2
-- Query the NAME field for all American cities in the CITY table with populations larger than 120000.
-- The CountryCode for America is USA.

select name 
from city 
where countrycode = "USA" and population  > 120000;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- problem 3
-- . Query all columns (attributes) for every row in the CITY table

select * from city;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- problem 4
-- Query all columns for a city in CITY with the ID 1661

select * from city where Id = 1661;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- problem 5
-- Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN

select * from city 
where COUNTRYCODE = "JPN";

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- problem 6
-- Query name of every Japanese city in the CITY table.

select name from city 
where COUNTRYCODE = "JPN";

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- problem 7
-- Query a list of CITY and STATE from the STATION table

CREATE TABLE station(
        id INT,
        city VARCHAR(21),
        state VARCHAR(2),
        lat_n INT,
        long_w INT

	);


INSERT INTO station VALUES 
        (794,'Kissee Mills','MO',139,73),
        (824,'Loma Mar','CA',48,130),
        (603,'Sandy Hook','CT',72,148),
        (478,'Tipton','IN',33,97),
        (619,'Arlington','CO',75,92),
        (711,'Turner','AR',50,101),
        (839,'Slidell','LA',85,151),
        (411,'Negreet','LA',98,105),
        (588,'Glencoe','KY',46,136),
        (665,'Chelsea','IA',98,59),
        (342,'Chignik Lagoon','AK',103,153),
        (733,'Pelahatchie','MS',38,28),
        (441,'Hanna,City','IL',50,136),
        (811,'Dorrance','KS',102,121),
        (698,'Albany','CA',49,80),
        (325,'Monument','KS',70,141),
        (414,'Manchester','MD',73,37),
        (113,'Prescott','IA',39,65),
        (971,'Graettinger','IA',94,150),
        (266,'Cahone','CO',116,127);
        
 -- solution 
 select city, state 
 from station;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- problem 8
-- Query a list of CITY names from STATION for cities that have an even ID number. Print the results
-- in any order, but exclude duplicates from the answer.

select distinct city 
from station 
where id % 2 = 0;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- problem 9
-- Find the difference between the total number of CITY entries in the table and the number of
-- distinct CITY entries in the table.

select (count(city) - count(distinct city)) as diff
from station;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- problem 10
-- Q.10 Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths 
-- (i.e.: number of characters in the name). If there is more than one smallest or largest city, 
-- choose the one that comes first when ordered alphabetically.

-- approach 1
with min_city as (
	select city 
    from station
    where length(city) = (select min(length(city)) from station) order by city asc limit 1
    ),
max_city as (
	select city 
    from station
    where length(city) = (select max(length(city)) from station) order by city asc limit 1
    )
select * from min_city
union all
select * from max_city;

-- approach 2
with cte1 as (
	select city , 
				row_number() over(order by length(city) asc, city asc)  as min_rankk,
				row_number() over(order by length(city) desc, city asc)  as max_rankk
	from station 
 )
select city from cte1 
where min_rankk = 1 or max_rankk = 1
order by city;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- problem 11
-- Q11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from station. Your result cannot contain duplicates.

select distinct city
from station 
where city regexp "^[AEIOU]";

select city 
from station 
where city RLIKE '^[AEIOU]';

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- problem 12
-- . Query the list of CITY names from STATION that do not start with vowels. Your result cannot
-- contain duplicates

select distinct city
from station 
where city regexp "^[^AEIOU]";

select distinct city
from station 
where city not regexp "^[AEIOU]";

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- problem 13
-- . Query the list of CITY names from STATION that do not end with vowels. 

select distinct city
from station
where city not regexp "[AEIOU]$";

select distinct city
from station
where substr(city,-1,1) not in ('A','E','I','O','U');

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- problem 14
-- Query the list of CITY names from STATION that either do not start with vowels or do not end
-- with vowels

select distinct city
from station 
where city not regexp "^[AEIOU]" or city not regexp "[AEIOU]$";

select  distinct city from station 
where city not rlike '^[AEIOU]' OR city not rlike '[aeiou]$';

select distinct city 
from station 
where substr(city,1,1) not in ('A','E','I','O','U') 
        or
	  substr(city,-1,1) not in ('A','E','I','O','U');

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- problem 16
-- Query the list of CITY names from STATION that do not start with vowels and do not end with
-- vowels. Your result cannot contain duplicates

select city 
from station 
where city not regexp "^[AEIOU]" and city not regexp '[AEIOU]$';

select distinct city 
from station 
where substr(city,1,1) not in ('A','E','I','O','U') 
        and
	  substr(city,-1,1) not in ('A','E','I','O','U');

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

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

select p.product_id, p.product_name,s.sale_date
from product p
inner join sales s
on p.product_id = s.product_id
where "2019-03-31" >= s.sale_date and s.sale_date >= "2019-01-01" ;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- problem 18

CREATE TABLE Views (
    article_id INT,
    author_id INT,
    viewer_id INT,
    view_date DATE
);

-- Insert data into Views table
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES
(1, 3, 5, '2019-08-01'),
(1, 3, 6, '2019-08-02'),
(2, 7, 7, '2019-08-01'),
(2, 7, 6, '2019-08-02'),
(4, 7, 1, '2019-07-22'),
(3, 4, 4, '2019-07-21'),
(3, 4, 4, '2019-07-21');

select * from views;

-- problem 
-- There is no primary key for this table, it may have duplicate rows.
-- Each row of this table indicates that some viewer viewed an article (written by some author) on some date.
-- Note that equal author_id and viewer_id indicate the same person.
-- Write an SQL query to find all the authors that viewed at least one of their own articles.
-- Return the result table sorted by id in ascending order.
-- The query result format is in the following example.

select u.author_id
from views v
inner join views u 
on v.author_id = u.author_id and v.viewer_id = u.author_id
group by 1 
having count(*) > 0
order by u.author_id ;

SELECT u.author_id, COUNT(*) AS author_view_count
FROM Views v
INNER JOIN Views u ON v.author_id = u.author_id AND v.viewer_id = u.author_id
GROUP BY 1
HAVING COUNT(*) > 0  -- You want to find authors who viewed at least one of their own articles
ORDER BY u.author_id;

SELECT DISTINCT author_id -- 1 AS author_view_count
FROM Views v
WHERE author_id = viewer_id
ORDER BY author_id;

select author_id 
from views 
where author_id = viewer_id
group by author_id
order by author_id;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================
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
    
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- problem 20 

CREATE TABLE Ads (
    ad_id INT,
    user_id INT,
    action ENUM('Clicked', 'Viewed', 'Ignored'),
    PRIMARY KEY (ad_id, user_id)
);

INSERT INTO Ads (ad_id, user_id, action)
VALUES
    (1, 1, 'Clicked'),
    (2, 2, 'Clicked'),
    (3, 3, 'Viewed'),
    (5, 5, 'Ignored'),
    (1, 7, 'Ignored'),
    (2, 7, 'Viewed'),
    (3, 5, 'Clicked'),
    (1, 4, 'Viewed'),
    (2, 11, 'Viewed'),
    (1, 2, 'Clicked');
    
-- Problem 
 -- A company is running Ads and wants to calculate the performance of each Ad.
--  Performance of the Ad is measured using Click-Through Rate (CTR) where:   ((total_clicks) / (total_clicks + total_views) ) * 100 
--  Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
--  Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie

-- Approch 1
select ad_id,round( 
				ifnull( 
                    sum(action = "Clicked") / (sum(action="Viewed") + sum(action = "Clicked")) * 100, 
                    0) 
				, 2) as CTR
from ads
group by ad_id
order by CTR desc;

-- Approach 2
select ad_id, round(
					ifnull(
                         (clicks/(clicks+views)*100),
					  0),
                    2)  as ctr
from
	(select ad_id,
	sum(case when action='Clicked' then 1 else 0 end) as clicks,
	sum(case when action='Viewed' then 1 else 0 end) as views
	from Ads
	group by ad_id) as t
order by ctr desc;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- problem 21

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    team_id INT
);

INSERT INTO Employee (employee_id, team_id)
VALUES
    (1, 8),
    (2, 8),
    (3, 8),
    (4, 7),
    (5, 9),
    (6, 9);
    
-- problem
-- Write an SQL query to find the team size of each of the employees.
-- Return result table in any order.

-- approach 1
select e.employee_id, x.no_of_players 
from employee e
inner join (select team_id, count(*) as no_of_players
				from employee
				group by team_id) x
on e.team_id = x.team_id;

-- approach 2
select
    employee_id,
    (select COUNT(*) from employee where team_id = e.team_id) as no_of_players
from
    Employee e;

-- approach 3
select
    employee_id,
    count(*) over(partition by team_id) as no_of_players
from
    Employee
order by employee_id;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================
-- problem 22

CREATE TABLE Countries (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(255) -- Adjust the size according to your needs
);

CREATE TABLE Weather (
    country_id INT,
    weather_state INT,
    day DATE,
    PRIMARY KEY (country_id, day),
    FOREIGN KEY (country_id) REFERENCES Countries(country_id)
);

INSERT INTO Countries (country_id, country_name)
VALUES
    (2, 'USA'),
    (3, 'Australia'),
    (7, 'Peru'),
    (5, 'China'),
    (8, 'Morocco'),
    (9, 'Spain');
    
INSERT INTO Weather (country_id, weather_state, day)
VALUES
    (2, 15, '2019-11-01'),
    (2, 12, '2019-10-28'),
    (2, 12, '2019-10-27'),
    (3, -2, '2019-11-10'),
    (3, 0, '2019-11-11'),
    (3, 3, '2019-11-12'),
    (5, 16, '2019-11-07'),
    (5, 18, '2019-11-09'),
    (5, 21, '2019-11-23'),
    (7, 25, '2019-11-28'),
    (7, 22, '2019-12-01'),
    (7, 20, '2019-12-02'),
    (8, 25, '2019-11-05'),
    (8, 27, '2019-11-15'),
    (8, 31, '2019-11-25'),
    (9, 7, '2019-10-23'),
    (9, 3, '2019-12-23');
    
-- problem 
-- Write an SQL query to find the type of weather in each country for November 2019.
-- The type of weather is:
-- ● Cold if the average weather_state is less than or equal 15,
-- ● Hot if the average weather_state is greater than or equal to 25, and
-- ● Warm otherwise.
-- Return result table in any order.


-- approch 1
select c.country_name, 
		case
			 when avg_weather_state <= 15 then "cold"
			 when avg_weather_state >= 25 then "Hot"
			 else "Warm"
		  end as weather_type
from Countries c
inner join ( select country_id, avg(weather_state) as avg_weather_state
			from weather
            where month(day) = 11
			group by country_id) x
on c.country_id = x.country_id;

-- approach 2
select c.country_name,
    case
        when avg(w.weather_state) <= 15 then 'Cold'
        when avg(w.weather_state) >= 25 then 'Hot'
        else 'Warm'
    end as weather_type
from Weather w
join Countries c on w.country_id = c.country_id
where month(day) = 11
group by country_name;

-- approach 3    
select distinct c.country_name,  
		case 
        when AVG(w.weather_state) OVER (PARTITION BY w.country_id) <=15 then "COLD" 
        when AVG(w.weather_state) OVER (PARTITION BY w.country_id) >=25 then "HOT" 
        else "Warm"
        end as weather_type
FROM
    Weather w
join Countries c on w.country_id = c.country_id
where month(day) = 11;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

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

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================
-- problem 24

CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT,
    PRIMARY KEY (player_id, event_date)
);

INSERT INTO Activity (player_id, device_id, event_date, games_played)
VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);
    
-- problem
-- Write an SQL query to report the first login date for each player.
-- Return the result table in any order.

-- approach 1
select player_id,min(event_date) as first_login
from Activity
group by player_id;

-- approcah 2
select player_id, event_date
from activity a
where a.event_date = (select min(event_date) from activity b where b.player_id = a.player_id);

-- approach 3
select a.player_id, a.event_date as first_login
from activity a
left join activity b 
on a.player_id = b.player_id and a.event_date > b.event_date
where b.player_id is null;

select b.player_id, b.event_date as first_login
from activity a
right join activity b 
on a.player_id = b.player_id and a.event_date < b.event_date
where a.player_id is null;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================
-- problem 25

-- table is same as problem 24

INSERT INTO Activity (player_id, device_id, event_date, games_played)
VALUES
(5,9,'2019-01-01', 3),
(5,10,'2018-02-02', 5);
 
-- problem
-- Write an SQL query to report the device that is first logged in for each player.
-- Return the result table in any order.

select * from activity;

-- approach 1
select player_id , device_id from (
					select player_id, device_id,min(event_date) as first_login
					from Activity
					group by player_id) x;
## the subquery finds the minimum event date as we will find the device which was logged in first to that date

-- approach 2
select a.player_id, a.device_id
from  activity a
where  a.event_date = (select min(event_date) from Activity b where b.player_id = a.player_id);

-- approach 3
select a.player_id, a.device_id
from activity a
left join activity b 
on a.player_id = b.player_id and a.event_date > b.event_date 
where b.player_id is null;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- problem 26

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    product_category VARCHAR(255)
);

CREATE TABLE Orders (
    product_id INT,
    order_date DATE,
    unit INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Products (product_id, product_name, product_category)
VALUES
    (1, 'Leetcode Solutions Book', 'Book'),
    (2, 'Jewels of Stringology Book', 'Book'),
    (3, 'HP Laptop', 'Laptop'),
    (4, 'Lenovo Laptop', 'Laptop'),
    (5, 'Leetcode Kit T-shirt', 'T-shirt');
    
INSERT INTO Orders (product_id, order_date, unit)
VALUES
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
-- Return result table in any order

-- approach 1 

select p.product_name,sum(unit)
from products p 
inner join orders o
on p.product_id = o.product_id
where month(o.order_date) = 2
group by 1
having sum(unit) >=100;
 
 
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================
-- problem 27

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(255),
    mail VARCHAR(255) -- Assuming emails can be of variable length
);

INSERT INTO Users (user_id, name, mail)
VALUES
    (1, 'Winston', 'winston@leetcode.com'),
    (2, 'Jonathan', 'jonathanisgreat'),
    (3, 'Annabelle', 'bella-@leetcode.com'),
    (4, 'Sally', 'sally.come@leetcode.com'),
    (5, 'Marwan', 'quarz#2020@leetcode.com'),
    (6, 'David', 'david69@gmail.com'),
    (7, 'Shapiro', 'shapo@leetcode.com');
    
-- problem 
-- Write an SQL query to find the users who have valid emails.
-- A valid e-mail has a prefix name and a domain where:
-- ● The prefix name is a string that may contain letters (upper or lower case), digits, underscore
-- '_', period '.', and/or dash '-'. The prefix name must start with a letter.
-- ● The domain is '@leetcode.com'.
 
select * from Users
where mail regexp '^[a-zA-Z]+[a-zA-Z0-9_\\./\\-]{0,}@leetcode.com$'
order by user_id;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================
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
        
        
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- problem 29

CREATE TABLE TVProgram (
    program_date DATE,
    content_id INT,
    channel VARCHAR(255),
    PRIMARY KEY (program_date, content_id)
);

CREATE TABLE Content (
    content_id VARCHAR(255) PRIMARY KEY,
    title VARCHAR(255),
    Kids_content ENUM('Y', 'N'),
    content_type VARCHAR(255)
);

INSERT INTO TVProgram (program_date, content_id, channel)
VALUES
    ('2020-06-10 08:00', 1, 'LC-Channel'),
    ('2020-05-11 12:00', 2, 'LC-Channel'),
    ('2020-05-12 12:00', 3, 'LC-Channel'),
    ('2020-05-13 14:00', 4, 'Disney Ch'),
    ('2020-06-18 14:00', 4, 'Disney Ch'),
    ('2020-07-15 16:00', 5, 'Disney Ch');
    

INSERT INTO Content (content_id, title, Kids_content, content_type)
VALUES
    ('1', 'Leetcode Movie', 'N', 'Movies'),
    ('2', 'Alg. for Kids', 'Y', 'Series'),
    ('3', 'Database Sols', 'N', 'Series'),
    ('4', 'Aladdin', 'Y', 'Movies'),
    ('5', 'Cinderella', 'Y', 'Movies');
    

-- problem
-- Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.
-- Return the result table in any order


-- approach 1
select  x.title
from TVProgram t
inner join (
	select content_id,title from
	content where kids_Content = "Y" and content_type = "Movies"
    ) x
on t.content_id = x.content_id
where month(t.program_date) = 6;

-- approach 2
select c.title
from Content c
inner join TVProgram t on c.content_id = t.content_id
where c.Kids_content = 'Y' and month(t.program_date) = 6 and c.content_type = "Movies";

-- approach 3
select distinct c.title
from Content c
where c.Kids_content = 'Y' and c.content_type = "Movies" and c.content_id IN (
    select distinct content_id
    from TVProgram
    where month(program_date) = 6
);



-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- problem 30

CREATE TABLE npv(
        id INT,
        year INT,
        npv INT,
        CONSTRAINT PRIMARY KEY(id, year)
	);


CREATE TABLE queries(
        id INT,
        year INT,
        CONSTRAINT PRIMARY KEY(id, year)
	);


INSERT INTO npv VALUES
		(1,2018,100),
        (7,2020,30),
        (13,2019,40),
        (1,2019,113),
        (2,2008,121),
        (3,2009,12),
        (11,2020,99),
        (7,2019,0);


INSERT INTO queries VALUES
        (1,2019),
        (2,2008),
        (3,2009),
        (7,2018),
        (7,2019),
        (7,2020),
        (13,2019);
        
-- problem
-- Write an SQL query to find the npv of each query of the Queries table.
-- Return the result table in any order

SELECT 
    n.id, n.year, n.npv
FROM
    npv n
        INNER JOIN
    queries q ON n.id = q.id AND n.year = q.year;
    
SELECT
    q.id,
    q.year,
    SUM(n.npv) AS npv
FROM
    queries q
LEFT JOIN
    npv n ON q.id = n.id AND q.year = n.year
GROUP BY
    q.id, q.year
    ;
    

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- problem 31
CREATE TABLE Employees (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE EmployeeUNI (
    id INT PRIMARY KEY,
    unique_id INT,
    FOREIGN KEY (id) REFERENCES Employees(id)
);

-- Insert data into Employees table
INSERT INTO Employees (id, name) VALUES
    (1, 'Alice'),
    (7, 'Bob'),
    (11, 'Meir'),
    (90, 'Winston'),
    (3, 'Jonathan');

-- Insert data into EmployeeUNI table
INSERT INTO EmployeeUNI (id, unique_id) VALUES
    (3, 1),
    (11, 2),
    (90, 3);
    
-- problem 
-- Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null.

-- approach 1
select u.unique_id, e.name
from employeeuni u
right join employees e
on u.id = e.id;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- problem 32

CREATE TABLE Users1 (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE Rides (
    id INT PRIMARY KEY,
    user_id INT,
    distance INT,
    FOREIGN KEY (user_id) REFERENCES Users1(id)
);

-- Insert data into Users table
INSERT INTO Users1 (id, name) VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Alex'),
    (4, 'Donald'),
    (7, 'Lee'),
    (13, 'Jonathan'),
    (19, 'Elvis');

-- Insert data into Rides table
INSERT INTO Rides (id, user_id, distance) VALUES
    (1, 1, 120),
    (2, 2, 317),
    (3, 3, 222),
    (4, 7, 100),
    (5, 13, 312),
    (6, 19, 50),
    (7, 7, 120),
    (8, 19, 400),
    (9, 7, 230);
    
-- problem 
-- Write an SQL query to report the distance travelled by each user.
-- Return the result table ordered by travelled_distance in descending order, if two or more users
-- travelled the same distance, order them by their name in ascending order.

-- approach 1
select u.name , sum(distance) as distance
from users1 u
left join rides r
	on u.id = r.user_id
group by u.name
order by distance desc, name asc;

-- approach 2
select u.name,
    (  
		select SUM(distance)
        from Rides r
        where r.user_id = u.id
    ) as travelled_distance
from
    Users1 u
order by
    travelled_distance desc, u.name asc;
    
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================
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

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- problem 34

-- Create Movies table
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255)
);

-- Create Users table
CREATE TABLE Users_movies (
    user_id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- Create MovieRating table
CREATE TABLE MovieRating (
    movie_id INT,
    user_id INT,
    rating INT,
    created_at DATE,
    PRIMARY KEY (movie_id, user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (user_id) REFERENCES Users_movies(user_id)
);

-- Insert data into Movies table
INSERT INTO Movies (movie_id, title) VALUES
    (1, 'Avengers'),
    (2, 'Frozen 2'),
    (3, 'Joker');

-- Insert data into Users table
INSERT INTO Users_movies (user_id, name) VALUES
    (1, 'Daniel'),
    (2, 'Monica'),
    (3, 'Maria'),
    (4, 'James');

-- Insert data into MovieRating table
INSERT INTO MovieRating (movie_id, user_id, rating, created_at) VALUES
    (1, 1, 3, '2020-01-12'),
    (1, 2, 4, '2020-02-11'),
    (1, 3, 2, '2020-02-12'),
    (1, 4, 1, '2020-01-01'),
    (2, 1, 5, '2020-02-17'),
    (2, 2, 2, '2020-02-01'),
    (2, 3, 2, '2020-03-01'),
    (3, 1, 3, '2020-02-22'),
    (3, 2, 4, '2020-02-25');
    
-- problem  
-- Write an SQL query to:
-- ● Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
-- ● Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.

-- finding the user wgo has rated most number of movies
select u.name,count(*) as rating_count
from movierating m
inner join users_movies u
on m.user_id = u.user_id
group by u.name
order by rating_count desc, u.name asc 
limit 1;

-- findind the movie which has highest avg rating
select mv.title, avg(rating) as avg_rating
from movierating m 
inner join movies mv
on m.movie_id = mv.movie_id
where month(created_at) = 2 and year(created_at) = 2020
group by mv.title
order by avg_rating desc, mv.title asc
limit 1;


-- ouput after doing union all
select x.name  as results
from (
		select u.name,count(*) as rating_count
		from movierating m
		inner join users_movies u
		on m.user_id = u.user_id
		group by u.name
		order by rating_count desc, u.name asc 
		limit 1
        ) x
Union all
select y.title
from (
		select mv.title, avg(rating) as avg_rating
		from movierating m 
		inner join movies mv
		on m.movie_id = mv.movie_id
		where month(created_at) = 2 and year(created_at) = 2020
		group by mv.title
		order by avg_rating desc, mv.title asc
		limit 1
        ) y;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- problem 35 

-- Create Departments table
CREATE TABLE Departments (
    id INT ,
    name VARCHAR(255)
);

-- Create Students table
CREATE TABLE Students (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    department_id INT    
);

-- Insert data into Departments table
INSERT INTO Departments (id, name) VALUES
    (1, 'Electrical Engineering'),
    (7, 'Computer Engineering'),
    (13, 'Business Administration');

-- Insert data into Students table
INSERT INTO Students (id, name, department_id) VALUES
    (23, 'Alice', 1),
    (1, 'Bob', 7),
    (5, 'Jennifer', 13),
    (2, 'John', 14),  -- Note: This department_id does not exist in the Departments table
    (4, 'Jasmine', 77),  -- Note: This department_id does not exist in the Departments table
    (3, 'Steve', 74),  -- Note: This department_id does not exist in the Departments table
    (6, 'Luis', 1),
    (8, 'Jonathan', 7),
    (7, 'Daiana', 33),  -- Note: This department_id does not exist in the Departments table
    (11, 'Madelynn', 1);
    

-- problem
-- find the id and name of students who are enrolled in departments which no longer exists

-- approach 1
select id, name 
from students 
where department_id not in ( select id from departments);

-- approach 2
select s.id, s.name
from students s
left join departments d 
on s.department_id = d.id
where d.id is null;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- 39
-- problem 36

CREATE TABLE Calls (
    from_id INT,
    to_id INT,
    duration INT
);


INSERT INTO Calls (from_id, to_id, duration) VALUES
    (1, 2, 59),
    (2, 1, 11),
    (1, 3, 20),
    (3, 4, 100),
    (3, 4, 200),
    (3, 4, 200),
    (4, 3, 499);
    
-- problem
-- Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2


-- approach 1
with cte as (
	select * 
      from Calls 
      union all
      select to_id, from_id, duration 
      from Calls)
select  from_id,to_id,count(*) as number_of_calls, sum(duration) as total_time
from cte
where from_id > to_id
group by 1,2;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

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
    
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

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
            

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- 43
-- problem 39

show tables;

-- script is same as problem 24

-- problem 
-- Write an SQL query to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. 
-- In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that
-- number by the total number of players.

update activity
set event_date = "2016-03-02"
where event_date = "2016-05-02";

select * from activity;


-- approach 1

with cte1 as(
	select player_id, event_date , lead(event_date,1,0) over(partition by player_id)  as  next_login
	from activity ),
countt as (
	select count(*) as consequetive_login
	from cte1 
	where datediff(next_login,event_date) = 1)
select round(c.consequetive_login / count(distinct player_id), 2) as fraction
from cte1 
join countt c;



-- appraoch 2

with cte as (
	select player_id, min(event_date) as first_login
    from activity
    group by player_id ),
next_date as
	(select *, date_add(first_login, interval 1 day) as next_date
	from cte )
select 
	round((select count(*)
	from activity 
	where (player_id, event_date) in (select player_id, next_date from next_date ))
	 / (select count(distinct player_id) from activity),2)
as fraction;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- 44
-- problem 40

CREATE TABLE Employee2 (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    department VARCHAR(255),
    managerId INT
);

INSERT INTO Employee2 (id, name, department, managerId) VALUES
(101, 'John', 'A', NULL),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101);

select * from employee2;

-- problem
-- Write an SQL query to report the managers with at least five direct reports.
-- Return the result table in any order.


-- approach 1
select e.name 
from employee2 e
inner join employee2 f
on e.id = f.managerid
group by e.id
having count(f.managerid) = 5;

-- approch 2
select name from Employee2 where id in 
(select managerId
 from Employee2
 group by managerId 
 having count(distinct id) >= 5
 );


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- 45
-- problem 41


-- Creating the Department table
CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(255)
);

-- Creating the Student table
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255),
    gender VARCHAR(10),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

-- Inserting data into the Department table
INSERT INTO Department (dept_id, dept_name) VALUES
(1, 'Engineering'),
(2, 'Science'),
(3, 'Law');

-- Inserting data into the Student table
INSERT INTO Student (student_id, student_name, gender, dept_id) VALUES
(1, 'Jack', 'M', 1),
(2, 'Jane', 'F', 1),
(3, 'Mark', 'M', 2);


-- problem
-- Write an SQL query to report the respective department name and number of students majoring in ,
--  each department for all departments in the Department table (even ones with no current students).
-- Return the result table ordered by student_number in descending order. In case of a tie, order them by dept_name alphabetically.

-- approach 1

select dept_name, count(student_name) student_number
from department d
left join student s
	on d.dept_id = s.dept_id
group by dept_name
order by student_number desc, dept_name asc;


-- approach 2

select dept_name,
	(select count(*) from student s where s.dept_id = d.dept_id) student_number
from department d
order by student_number desc, dept_name asc;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- 46
-- problem 42


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


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- 47
-- problem 43

use pratice_problems;

CREATE TABLE Project (
    project_id INT,
    employee_id INT,
    PRIMARY KEY (project_id, employee_id),
    FOREIGN KEY (employee_id) REFERENCES Employee_project(employee_id)
);

CREATE TABLE Employee_project (
    employee_id INT,
    name VARCHAR(255),
    experience_years INT,
    PRIMARY KEY (employee_id)
);

-- Inserting data into the Employee table
INSERT INTO Employee_project (employee_id, name, experience_years) VALUES
(1, 'Khaled', 3),
(2, 'Ali', 2),
(3, 'John', 3),
(4, 'Doe', 2);

-- Inserting data into the Project table
INSERT INTO Project (project_id, employee_id) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1),
(2, 4);


-- problem 
-- Write an SQL query that reports the most experienced employees in each project. In case of a tie,
-- report all employees with the maximum number of experience years.

with cte1 as (
	select project_id,e.employee_id, experience_years,
			rank() over(partition by project_id order by experience_years desc) as rankk
	from project p
    inner join employee_project e 
		on p.employee_id = e.employee_id
	)
select project_id , employee_id
from cte1
where rankk = 1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================

-- 48
-- problem 44

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    name VARCHAR(255),
    available_from DATE
);

CREATE TABLE Orders_books (
    order_id INT PRIMARY KEY,
    book_id INT,
    quantity INT,
    dispatch_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);


-- Inserting data into the Books table
INSERT INTO Books (book_id, name, available_from) VALUES
(1, 'Kalila And Demna', '2010-01-01'),
(2, '28 Letters', '2012-05-12'),
(3, 'The Hobbit', '2019-06-10'),
(4, '13 Reasons Why', '2019-06-01'),
(5, 'The Hunger Games', '2008-09-21');

-- Inserting data into the Orders table
INSERT INTO Orders_books (order_id, book_id, quantity, dispatch_date) VALUES
(1, 1, 2, '2018-07-26'),
(2, 1, 1, '2018-11-05'),
(3, 3, 8, '2019-06-11'),
(4, 4, 6, '2019-06-05'),
(5, 4, 5, '2019-06-20'),
(6, 5, 9, '2009-02-02'),
(7, 5, 8, '2010-04-13');


-- 2019-06-23
-- problem
-- Write an SQL query that reports the books that have sold less than 10 copies in the last year,
-- excluding books that have been available for less than one month from today. Assume today is 2019-06-23.

select b.book_id, b.name 
from orders_books o
right join Books b
	on o.book_id = b.book_id
where available_from <= date_sub('2019-06-23', interval 1 month)
group by book_id
having sum(case when dispatch_date >= date_sub('2019-06-23', interval 1 year) then quantity else 0 end) < 10;



-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================


-- 49
-- problem 45

CREATE TABLE enrollments(
		student_id INT,
		course_id INT,
		grade INT,
		CONSTRAINT prime_key PRIMARY KEY(student_id,course_id)
    );


INSERT INTO enrollments VALUES 
		(2,2,95),
		(2,3,95),
		(1,1,90),
		(1,2,99),
		(3,1,80),
		(3,2,75),
		(3,3,82);
        
        
-- Write a SQL query to find the highest grade with its corresponding course for each student. In case of
-- a tie, you should find the course with the smallest course_id.
-- Return the result table ordered by student_id in ascending order.

with cte1 as (
	select * , rank() over(partition by student_id order by grade desc, course_id asc) as rankk 
	from enrollments
    )
select student_id ,course_id ,grade from cte1
where rankk = 1;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================


-- 50
-- problem 45

CREATE TABLE matches(
		match_id INT,
		first_player INT,
		second_player INT,
		first_player_goals INT,
		second_player_goals INT,
		CONSTRAINT prime_key PRIMARY KEY(match_id)
	);


CREATE TABLE teams(
		player_id INT,
		team_id INT,
		CONSTRAINT prime_key PRIMARY KEY(player_id)
    );


INSERT INTO matches VALUES 
		(1,15,45,3,0),
		(2,30,25,1,2),
		(3,30,15,2,0),
		(4,40,20,5,2),
		(5,35,50,1,1);


INSERT INTO teams VALUES 
		(15,1),
		(25,1),
		(30,1),
		(45,1),
		(10,2),
		(35,2),
		(50,2),
		(20,3),
		(40,3);
        
        
-- problem 
-- The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, the lowest player_id wins.
-- Write an SQL query to find the winner in each group.



-- solution 

with player_scores as (
	select first_player as player, first_player_goals as points from matches
	union all
	select second_player as player, second_player_goals as points from matches
    ), 
rankings as (
	select t.team_id, player, sum(points) as total_points,
			rank() over(partition by team_id order by sum(points) desc, player_id asc) as rankk
	from player_scores ps
	inner join teams t
		on ps.player = t.player_id
	group by player
 )
select team_id, player 
from rankings 
where rankk = 1;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- =======================================================================================================================================================================




