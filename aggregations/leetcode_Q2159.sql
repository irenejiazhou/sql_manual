-- EASY Q2159: Order Two Columns Independently
/*
Table: Data
+-------------+------+
| Column Name | Type |
+-------------+------+
| first_col   | int  |
| second_col  | int  |
+-------------+------+
There is no primary key for this table and it may contain duplicates.

Write an SQL query to independently:
order first_col in ascending order.
order second_col in descending order.
The query result format is in the following example.
Input: 
Data table:
+-----------+------------+
| first_col | second_col |
+-----------+------------+
| 4         | 2          |
| 2         | 3          |
| 3         | 1          |
| 1         | 4          |
+-----------+------------+
Output: 
+-----------+------------+
| first_col | second_col |
+-----------+------------+
| 1         | 4          |
| 2         | 3          |
| 3         | 2          |
| 4         | 1          |
+-----------+------------+
*/
SELECT t1.first_col, t2.second_col
FROM (
  SELECT first_col, row_number() OVER(ORDER BY first_col ASC) AS rk
  FROM data) t1
JOIN (  
  SELECT second_col, row_number() OVER(ORDER BY second_col DESC) AS rk
  FROM data) t2
ON t1.rk = t2.rk;
