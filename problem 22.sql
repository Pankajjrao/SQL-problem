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
