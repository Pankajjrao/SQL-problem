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
