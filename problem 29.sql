
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







