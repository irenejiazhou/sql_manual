-- MEDIUM Q1285
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

-- Method 1
SELECT L1.log_id AS start_id, min(L2.log_id) AS end_id
	  -- find all start logs
FROM (SELECT log_id FROM Q1285_Logs 
	  WHERE log_id-1 NOT IN (SELECT log_id FROM Q1285_Logs)) L1
	  -- find all end logs
JOIN (SELECT log_id FROM Q1285_Logs 
	  WHERE log_id+1 NOT IN (SELECT log_id FROM Q1285_Logs)) L2
ON L1.log_id <= L2.log_id
GROUP BY L1.log_id;

-- Method 2
SELECT min(log_id) as start_id, max(log_id) as end_id
FROM (SELECT log_id, ROW_NUMBER() OVER(ORDER BY log_id) as rk
	  FROM Q1285_Logs) temp
GROUP BY log_id - rk;






