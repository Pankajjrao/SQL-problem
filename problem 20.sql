-- PROBLEM 20

CREATE TABLE Ads (
    ad_id INT,
    user_id INT,
    action ENUM('Clicked', 'Viewed', 'Ignored'),
    PRIMARY KEY (ad_id, user_id)
);

INSERT INTO Ads (ad_id, user_id, action)
VALUES
    (1, 1, 'Clicked'),
    (2, 2, 'Clicked'),
    (3, 3, 'Viewed'),
    (5, 5, 'Ignored'),
    (1, 7, 'Ignored'),
    (2, 7, 'Viewed'),
    (3, 5, 'Clicked'),
    (1, 4, 'Viewed'),
    (2, 11, 'Viewed'),
    (1, 2, 'Clicked');
    
-- Problem 
 -- A company is running Ads and wants to calculate the performance of each Ad.
--  Performance of the Ad is measured using Click-Through Rate (CTR) where:   ((total_clicks) / (total_clicks + total_views) ) * 100 
--  Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
--  Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie

-- Approch 1
select ad_id,round( 
				ifnull( 
                    sum(action = "Clicked") / (sum(action="Viewed") + sum(action = "Clicked")) * 100, 
                    0) 
				, 2) as CTR
from ads
group by ad_id
order by CTR desc;

-- Approach 2
select ad_id, round(
					ifnull(
                         (clicks/(clicks+views)*100),
					  0),
                    2)  as ctr
from
	(select ad_id,
	sum(case when action='Clicked' then 1 else 0 end) as clicks,
	sum(case when action='Viewed' then 1 else 0 end) as views
	from Ads
	group by ad_id) as t
order by ctr desc;

-- Approch  3
select ad_id, ifnull( round( avg(
							case
								when action = "Clicked" then 1
								when action = "Viewed" then 0
								else null
							end 
				) * 100, 2), 0)
as ctr
from Ads
group by ad_id
order by ctr desc, ad_id asc;




