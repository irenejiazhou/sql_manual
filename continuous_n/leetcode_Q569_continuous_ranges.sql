-- MEDIUM Q1285 Find the Start and End Number of Continuous Ranges
/*
Table: Logs
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| log_id        | int     |  PK
+---------------+---------+
Each row of this table contains the ID in a log Table.
 
Write an SQL query to find the start and end number of continuous ranges in the table Logs.
Return the result table ordered by start_id.

The query result format is in the following example.
Input: 
Logs table:
+------------+
| log_id     |
+------------+
| 1          |
| 2          |
| 3          |
| 7          |
| 8          |
| 10         |
+------------+
Output: 
+------------+--------------+
| start_id   | end_id       |
+------------+--------------+
| 1          | 3            |
| 7          | 8            |
| 10         | 10           |
+------------+--------------+
Explanation: 
The result table should contain all ranges in table Logs.
From 1 to 3 is contained in the table.
From 4 to 6 is missing in the table
From 7 to 8 is contained in the table.
Number 9 is missing from the table.
Number 10 is contained in the table.
*/

-- Solution 1
SELECT L1.log_id AS start_id, min(L2.log_id) AS end_id
FROM (	-- find all start logs: log_id-1 is not in the orginial table
	SELECT log_id FROM Q1285_Logs 
	WHERE log_id-1 NOT IN (SELECT log_id FROM Q1285_Logs)
	) L1	  
JOIN (  -- find all end logs: log_id+1 is not in the original table
	SELECT log_id FROM Q1285_Logs 
	WHERE log_id+1 NOT IN (SELECT log_id FROM Q1285_Logs)) L2
-- Compare start_id table L1 and end_id table L2，Find start_id <= end_id
ON L1.log_id <= L2.log_id
GROUP BY L1.log_id;

-- Solution 2
-- Find start_id：MIN in group log_id-rk
-- Find end_id：MAX in group log_id-rk
-- If the numbers are continuous, log_id-rk should be the same.
SELECT min(log_id) AS start_id, max(log_id) AS end_id
FROM (SELECT log_id, ROW_NUMBER() OVER(ORDER BY log_id) AS rk
      FROM Q1285_Logs) temp
GROUP BY log_id - rk;
