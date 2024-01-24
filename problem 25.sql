-- problem 25

-- table is same as problem 24

INSERT INTO Activity (player_id, device_id, event_date, games_played)
VALUES
(5,9,'2019-01-01', 3),
(5,10,'2018-02-02', 5);
 
-- problem
-- Write an SQL query to report the device that is first logged in for each player.
-- Return the result table in any order.

select * from activity;

-- approach 1
select player_id , device_id from (
					select player_id, device_id,min(event_date) as first_login
					from Activity
					group by player_id) x;
## the subquery finds the minimum event date as we will find the device which was logged in first to that date

-- approach 2
select a.player_id, a.device_id
from  activity a
where  a.event_date = (select min(event_date) from Activity b where b.player_id = a.player_id);

-- approach 3
select a.player_id, a.device_id
from activity a
left join activity b 
on a.player_id = b.player_id and a.event_date > b.event_date 
where b.player_id is null;

