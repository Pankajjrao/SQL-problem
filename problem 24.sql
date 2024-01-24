-- problem 24

CREATE TABLE Activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT,
    PRIMARY KEY (player_id, event_date)
);

INSERT INTO Activity (player_id, device_id, event_date, games_played)
VALUES
    (1, 2, '2016-03-01', 5),
    (1, 2, '2016-05-02', 6),
    (2, 3, '2017-06-25', 1),
    (3, 1, '2016-03-02', 0),
    (3, 4, '2018-07-03', 5);
    
-- problem
-- Write an SQL query to report the first login date for each player.
-- Return the result table in any order.

-- approach 1
select player_id,min(event_date) as first_login
from Activity
group by player_id;

-- approcah 2
select player_id, event_date
from activity a
where a.event_date = (select min(event_date) from activity b where b.player_id = a.player_id);

-- approach 3
select a.player_id, a.event_date as first_login
from activity a
left join activity b 
on a.player_id = b.player_id and a.event_date > b.event_date
where b.player_id is null;

select b.player_id, b.event_date as first_login
from activity a
right join activity b 
on a.player_id = b.player_id and a.event_date < b.event_date
where a.player_id is null;