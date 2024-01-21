
CREATE TABLE Views (
    article_id INT,
    author_id INT,
    viewer_id INT,
    view_date DATE
);

-- Insert data into Views table
INSERT INTO Views (article_id, author_id, viewer_id, view_date) VALUES
(1, 3, 5, '2019-08-01'),
(1, 3, 6, '2019-08-02'),
(2, 7, 7, '2019-08-01'),
(2, 7, 6, '2019-08-02'),
(4, 7, 1, '2019-07-22'),
(3, 4, 4, '2019-07-21'),
(3, 4, 4, '2019-07-21');

-- problem 
-- There is no primary key for this table, it may have duplicate rows.
-- Each row of this table indicates that some viewer viewed an article (written by some author) on some date.
-- Note that equal author_id and viewer_id indicate the same person.
-- Write an SQL query to find all the authors that viewed at least one of their own articles.
-- Return the result table sorted by id in ascending order.
-- The query result format is in the following example.


-- approach 1
SELECT DISTINCT author_id 
FROM Views v
WHERE author_id = viewer_id
ORDER BY author_id;

-- approach 2
select author_id     -- u can also get the count of view with this approach  --- count(*) as author_view_count 
from views 
where author_id = viewer_id
group by author_id
order by author_id;