-- MEDIUM Q1841

/*
Table: Teams
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| team_id        | int     |  PK
| team_name      | varchar |
+----------------+---------+
team_id is the primary key for this table.
Each row contains information about one team in the league.
 
Table: Matches
+-----------------+---------+
| Column Name     | Type    |
+-----------------+---------+
| home_team_id    | int     |  PK
| away_team_id    | int     |  PK
| home_team_goals | int     |
| away_team_goals | int     |
+-----------------+---------+
Each row contains information about one match.
team_goals is the number of goals scored by the team.
The winner of the match is the team with the higher number of goals.
 
Write an SQL query to report the statistics of the league. 
The statistics should be built using the played matches where 
	1) the winning team gets three points and 
	2) the losing team gets no points. 
	3) If a match ends with a draw, both teams get one point.

Each row of the result table should contain:
team_name - The name of the team in the Teams table.
matches_played - The number of matches played as either a home or away team.
points - The total points the team has so far.
goal_for - The total number of goals scored by the team across all matches.
goal_against - The total number of goals scored by opponent teams against this team across all matches.
goal_diff - The result of goal_for - goal_against.

Return the result table ordered by 
1) points in descending order, 
2) goal_diff in descending order, 
3) team_name in lexicographical order.

The query result format is in the following example.
Input: 
Teams table:
+---------+-----------+
| team_id | team_name |
+---------+-----------+
| 1       | Ajax      |
| 4       | Dortmund  |
| 6       | Arsenal   |
+---------+-----------+
Matches table:
+--------------+--------------+-----------------+-----------------+
| home_team_id | away_team_id | home_team_goals | away_team_goals |
+--------------+--------------+-----------------+-----------------+
| 1            | 4            | 0               | 1               |
| 1            | 6            | 3               | 3               |
| 4            | 1            | 5               | 2               |
| 6            | 1            | 0               | 0               |
+--------------+--------------+-----------------+-----------------+
Output: 
+-----------+----------------+--------+----------+--------------+-----------+
| team_name | matches_played | points | goal_for | goal_against | goal_diff |
+-----------+----------------+--------+----------+--------------+-----------+
| Dortmund  | 2              | 6      | 6        | 2            | 4         | Dortmund (team_id=4) played 2 matches: 2 wins.
| Arsenal   | 2              | 2      | 3        | 3            | 0         | Arsenal (team_id=6) played 2 matches: 2 draws. 
| Ajax      | 4              | 2      | 5        | 9            | -4        | Ajax (team_id=1) played 4 matches: 2 losses and 2 draws.
+-----------+----------------+--------+----------+--------------+-----------+
*/

WITH team_match_info AS (
with m as (
select *, case when home_team_goals > away_team_goals then 3
               when home_team_goals = away_team_goals then 1
               when home_team_goals < away_team_goals then 0
               end as home_team_points,
          case when home_team_goals > away_team_goals then 0
               when home_team_goals = away_team_goals then 1
               when home_team_goals < away_team_goals then 3
               end as away_team_points
from q1841_matches)
select home_team_id as team_id, 
		home_team_points as team_points,
		home_team_goals AS goal_for,
		away_team_goals AS goal_against
from m
UNION all
select away_team_id as team_id, 
		away_team_points as team_points,
		away_team_goals AS goal_for,
		home_team_goals AS goal_against
from m)
SELECT t.team_name, 
count(team_points) AS matches_played, 
sum(team_points) AS points,
sum(goal_for) AS goal_for,
sum(goal_against) AS goal_against,
sum(goal_for) - sum(goal_against) AS goal_diff
FROM team_match_info m
LEFT JOIN Q1841_Teams t
ON m.team_id = t.team_id 
GROUP BY t.team_name
ORDER BY points DESC, goal_diff DESC, team_name ASC;
