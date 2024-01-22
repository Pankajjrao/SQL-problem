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


