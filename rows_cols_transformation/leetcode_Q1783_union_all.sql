-- MEDUIM Q1783: Grand Slam Titles
/*
Table: Players
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| player_id      | int     |  PK
| player_name    | varchar |
+----------------+---------+
Each row in this table contains the name and the ID of a tennis player.
Table: Championships
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| year          | int     |  PK
| Wimbledon     | int     |
| Fr_open       | int     |
| US_open       | int     |
| Au_open       | int     |
+---------------+---------+
Each row of this table contains the IDs of the players who won one each tennis tournament of the grand slam 大满贯.
 
Write an SQL query to report the number of grand slam tournaments won by each player. 
Do not include the players who did not win any tournament.
Return the result table in any order.

The query result format is in the following example.
Input: 
Players table:
+-----------+-------------+
| player_id | player_name |
+-----------+-------------+
| 1         | Nadal       |
| 2         | Federer     |
| 3         | Novak       |
+-----------+-------------+
Championships table:
+------+-----------+---------+---------+---------+
| year | Wimbledon | Fr_open | US_open | Au_open |
+------+-----------+---------+---------+---------+
| 2018 | 1         | 1       | 1       | 1       |
| 2019 | 1         | 1       | 2       | 2       |
| 2020 | 2         | 1       | 2       | 2       |
+------+-----------+---------+---------+---------+
Output: 
+-----------+-------------+-------------------+
| player_id | player_name | grand_slams_count |
+-----------+-------------+-------------------+
| 2         | Federer     | 5                 |
| 1         | Nadal       | 7                 |
+-----------+-------------+-------------------+
Explanation: 
Player 1 (Nadal) won 7 titles: 
Wimbledon (2018, 2019), Fr_open (2018, 2019, 2020), US_open (2018), and Au_open (2018).
Player 2 (Federer) won 5 titles: 
Wimbledon (2020), US_open (2019, 2020), and Au_open (2019, 2020).
Player 3 (Novak) did not win anything, we did not include them in the result table.
*/
WITH CTE AS 
   (
    SELECT Wimbledon AS player_id FROM Championships
    UNION ALL 
    -- Not UNION because UNION removes duplicates.
    SELECT Fr_open AS player_id FROM Championships
    UNION ALL
    SELECT US_open AS player_id FROM Championships
    UNION ALL 
    SELECT Au_open AS player_id FROM Championships)
SELECT Players.player_id, player_name, COUNT(*) AS grand_slams_count
FROM Players 
INNER JOIN CTE 
	ON Players.player_id = CTE.player_id
GROUP BY player_id, player_name;
