-- 50
-- problem 45

CREATE TABLE matches(
		match_id INT,
		first_player INT,
		second_player INT,
		first_player_goals INT,
		second_player_goals INT,
		CONSTRAINT prime_key PRIMARY KEY(match_id)
	);


CREATE TABLE teams(
		player_id INT,
		team_id INT,
		CONSTRAINT prime_key PRIMARY KEY(player_id)
    );


INSERT INTO matches VALUES 
		(1,15,45,3,0),
		(2,30,25,1,2),
		(3,30,15,2,0),
		(4,40,20,5,2),
		(5,35,50,1,1);


INSERT INTO teams VALUES 
		(15,1),
		(25,1),
		(30,1),
		(45,1),
		(10,2),
		(35,2),
		(50,2),
		(20,3),
		(40,3);
        
        
-- problem 
-- The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, the lowest player_id wins.
-- Write an SQL query to find the winner in each group.



-- solution 

with player_scores as (
	select first_player as player, first_player_goals as points from matches
	union all
	select second_player as player, second_player_goals as points from matches
    ), 
rankings as (
	select t.team_id, player, sum(points) as total_points,
			rank() over(partition by team_id order by sum(points) desc, player_id asc) as rankk
	from player_scores ps
	inner join teams t
		on ps.player = t.player_id
	group by player
 )
select team_id, player 
from rankings 
where rankk = 1;



