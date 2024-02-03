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