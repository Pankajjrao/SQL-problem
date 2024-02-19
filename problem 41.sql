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
