-- 43
-- problem 39

show tables;

-- script is same as problem 24

-- problem 
-- Write an SQL query to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. 
-- In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that
-- number by the total number of players.

update activity
set event_date = "2016-03-02"
where event_date = "2016-05-02";

select * from activity;


-- approach 1

with cte1 as(
	select player_id, event_date , lead(event_date,1,0) over(partition by player_id)  as  next_login
	from activity ),
countt as (
	select count(*) as consequetive_login
	from cte1 
	where datediff(next_login,event_date) = 1)
select round(c.consequetive_login / count(distinct player_id), 2) as fraction
from cte1 
join countt c;



-- appraoch 2

with cte as (
	select player_id, min(event_date) as first_login
    from activity
    group by player_id ),
next_date as
	(select *, date_add(first_login, interval 1 day) as next_date
	from cte )
select 
	round((select count(*)
	from activity 
	where (player_id, event_date) in (select player_id, next_date from next_date ))
	 / (select count(distinct player_id) from activity),2)
as fraction;
