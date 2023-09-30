-- MEDIUM Q1454: Active Users
/*
Table: Accounts
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |  PK
| name          | varchar |
+---------------+---------+
This table contains the account id and the user name of each account.
 
Table: Logins
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| login_date    | date    |
+---------------+---------+
There is no primary key for this table, it may contain duplicates.
This table contains the account id of the user who logged in and the login date. 
A user may log in multiple times in the day.
 
Write an SQL query to find the id and the name of active users.
Active users are those who logged in to their accounts for five or more consecutive days.
Return the result table ordered by id.

The query result format is in the following example.
Input: 
Accounts table:
+----+----------+
| id | name     |
+----+----------+
| 1  | Winston  |
| 7  | Jonathan |
+----+----------+
Logins table:
+----+------------+
| id | login_date |
+----+------------+
| 7  | 2020-05-30 |
| 1  | 2020-05-30 |
| 7  | 2020-05-31 |
| 7  | 2020-06-01 |
| 7  | 2020-06-02 |
| 7  | 2020-06-02 |
| 7  | 2020-06-03 |
| 1  | 2020-06-07 |
| 7  | 2020-06-10 |
+----+------------+
Output: 
+----+----------+
| id | name     |
+----+----------+
| 7  | Jonathan |
+----+----------+
Explanation: 
User Winston with id = 1 logged in 2 times only in 2 different days, so, Winston is not an active user.
User Jonathan with id = 7 logged in 7 times in 6 different days, five of them were consecutive days, 
so, Jonathan is an active user.
*/

-- Solution
WITH t1 AS (
	SELECT DISTINCT id, login_date, dense_rank() OVER(PARTITION BY id ORDER BY login_date) as rk
	-- Deduplicate same-day logins and assign continuous rank numbers to login dates.
	-- Notes: Must use dense_rank() to make sure all the rank numbers are continuous after the final distinct.
	FROM Logins)
, t2 AS (
	SELECT id, login_date, rk, DATE_ADD(login_date, INTERVAL - rk DAY) as grouping_date
	-- Generate a unique grouping_date for continuous logins, grouping_date = login_date - rk. 
	-- Consecutive logins will have the same grouping_date.
	-- if grouping_date=x and rk=n，when rk=n+1，grouping_date=x+1
	-- Thus, it doesn't matter what is rk, what's important is grouping_date is increased by 1 when rk is increased by 1.
	FROM t1)
, t3 AS (
	SELECT id, grouping_date,
		min(login_date) as group_start_date,
                max(login_date) as group_end_date,
                count(id) AS continuous_days -- continuous login days for this group
                -- datediff(max(login_date), min(login_date)) as duration
	FROM t2
	GROUP BY id, grouping_date
	HAVING count(id) >= 5 -- At least 5 continuous logins for one group
	       -- datediff(MAX(login_date), MIN(login_date)) >= 4
	ORDER BY id, group_start_date)
SELECT DISTINCT t3.id, t4.name
FROM t3
INNER JOIN Accounts t4
	ON t3.id = t4.id
ORDER BY t3.id;
