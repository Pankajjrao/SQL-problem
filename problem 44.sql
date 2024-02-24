-- 48
-- problem 44

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    name VARCHAR(255),
    available_from DATE
);

CREATE TABLE Orders_books (
    order_id INT PRIMARY KEY,
    book_id INT,
    quantity INT,
    dispatch_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);


-- Inserting data into the Books table
INSERT INTO Books (book_id, name, available_from) VALUES
(1, 'Kalila And Demna', '2010-01-01'),
(2, '28 Letters', '2012-05-12'),
(3, 'The Hobbit', '2019-06-10'),
(4, '13 Reasons Why', '2019-06-01'),
(5, 'The Hunger Games', '2008-09-21');

-- Inserting data into the Orders table
INSERT INTO Orders_books (order_id, book_id, quantity, dispatch_date) VALUES
(1, 1, 2, '2018-07-26'),
(2, 1, 1, '2018-11-05'),
(3, 3, 8, '2019-06-11'),
(4, 4, 6, '2019-06-05'),
(5, 4, 5, '2019-06-20'),
(6, 5, 9, '2009-02-02'),
(7, 5, 8, '2010-04-13');


-- 2019-06-23
-- problem
-- Write an SQL query that reports the books that have sold less than 10 copies in the last year,
-- excluding books that have been available for less than one month from today. Assume today is 2019-06-23.

select b.book_id, b.name 
from orders_books o
right join Books b
	on o.book_id = b.book_id
where available_from <= date_sub('2019-06-23', interval 1 month)
group by book_id
having sum(case when dispatch_date >= date_sub('2019-06-23', interval 1 year) then quantity else 0 end) < 10;
