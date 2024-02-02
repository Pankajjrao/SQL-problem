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

