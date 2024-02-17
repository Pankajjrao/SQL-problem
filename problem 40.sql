
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



