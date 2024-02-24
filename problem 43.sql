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




