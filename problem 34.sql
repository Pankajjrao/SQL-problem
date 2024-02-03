-- problem 34

-- Create Movies table
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(255)
);

-- Create Users table
CREATE TABLE Users_movies (
    user_id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- Create MovieRating table
CREATE TABLE MovieRating (
    movie_id INT,
    user_id INT,
    rating INT,
    created_at DATE,
    PRIMARY KEY (movie_id, user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (user_id) REFERENCES Users_movies(user_id)
);

-- Insert data into Movies table
INSERT INTO Movies (movie_id, title) VALUES
    (1, 'Avengers'),
    (2, 'Frozen 2'),
    (3, 'Joker');

-- Insert data into Users table
INSERT INTO Users_movies (user_id, name) VALUES
    (1, 'Daniel'),
    (2, 'Monica'),
    (3, 'Maria'),
    (4, 'James');

-- Insert data into MovieRating table
INSERT INTO MovieRating (movie_id, user_id, rating, created_at) VALUES
    (1, 1, 3, '2020-01-12'),
    (1, 2, 4, '2020-02-11'),
    (1, 3, 2, '2020-02-12'),
    (1, 4, 1, '2020-01-01'),
    (2, 1, 5, '2020-02-17'),
    (2, 2, 2, '2020-02-01'),
    (2, 3, 2, '2020-03-01'),
    (3, 1, 3, '2020-02-22'),
    (3, 2, 4, '2020-02-25');
    
-- problem  
-- Write an SQL query to:
-- ● Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
-- ● Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.

-- finding the user wgo has rated most number of movies
select u.name,count(*) as rating_count
from movierating m
inner join users_movies u
on m.user_id = u.user_id
group by u.name
order by rating_count desc, u.name asc 
limit 1;

-- findind the movie which has highest avg rating
select mv.title, avg(rating) as avg_rating
from movierating m 
inner join movies mv
on m.movie_id = mv.movie_id
where month(created_at) = 2 and year(created_at) = 2020
group by mv.title
order by avg_rating desc, mv.title asc
limit 1;


-- ouput after doing union all
select x.name  as results
from (
		select u.name,count(*) as rating_count
		from movierating m
		inner join users_movies u
		on m.user_id = u.user_id
		group by u.name
		order by rating_count desc, u.name asc 
		limit 1
        ) x
Union all
select y.title
from (
		select mv.title, avg(rating) as avg_rating
		from movierating m 
		inner join movies mv
		on m.movie_id = mv.movie_id
		where month(created_at) = 2 and year(created_at) = 2020
		group by mv.title
		order by avg_rating desc, mv.title asc
		limit 1
        ) y;

