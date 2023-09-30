-- MEDIUM 1613: Find the Missing IDs
/*
Table: Customers
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |  PK
| customer_name | varchar |
+---------------+---------+
Each row of this table contains the name and the id customer.
 
Write an SQL query to find the missing customer IDs. 
The missing IDs are ones that are not in the Customers table but are in the range between 1 and the maximum customer_id present in the table.
Notice that the maximum customer_id will not exceed 100.
Return the result table ordered by ids in ascending order.

The query result format is in the following example.
Input: 
Customers table:
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
| 1           | Alice         |
| 4           | Bob           |
| 5           | Charlie       |
+-------------+---------------+
Output: 
+-----+
| ids |
+-----+
| 2   |
| 3   |
+-----+
Explanation: 
The maximum customer_id present in the table is 5, so in the range [1,5], IDs 2 and 3 are missing from the table.
*/

WITH RECURSIVE seq AS (SELECT 1 AS num 
											 
                       UNION ALL 
											 
                       SELECT num + 1 
		       FROM seq 
		       WHERE num < 100) -- The maximum customer_id will not exceed 100.
SELECT num AS ids
FROM seq
WHERE num NOT IN (SELECT customer_id FROM customers)
  AND num <= (SELECT MAX(customer_id) FROM customers);
