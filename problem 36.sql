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