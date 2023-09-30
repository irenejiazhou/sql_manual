-- MEDIUM Q1459
/*
Table: Points
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |  PK
| x_value       | int     |
| y_value       | int     |
+---------------+---------+
Each point is represented as a 2D coordinate (x_value, y_value).
 
Write an SQL query to report all possible axis-aligned rectangles with a non-zero area 
that can be formed by any two points from the Points table.

Each row in the result should contain three columns (p1, p2, area) where:
p1 and p2 are the id's of the two points that determine the opposite corners of a rectangle.
area is the area of the rectangle and must be non-zero.
Return the result table ordered by 1) area in descending order, 
								   2) p1 in ascending order
								   3) p2 in ascending order.

The query result format is in the following table.
Input: 
Points table:
+----------+-------------+-------------+
| id       | x_value     | y_value     |
+----------+-------------+-------------+
| 1        | 2           | 7           |
| 2        | 4           | 8           |
| 3        | 2           | 10          |
+----------+-------------+-------------+
Output: 
+----------+-------------+-------------+
| p1       | p2          | area        |
+----------+-------------+-------------+
| 2        | 3           | 4           |  |4-2| * |8-10|
| 1        | 2           | 2           |  |2-4| * |7-8|
+----------+-------------+-------------+
Explanation: 
The rectangle formed by p1 = 1 and p2 = 3 is invalid because the area is 0.
*/

SELECT pt1.id AS p1, pt2.id AS p2, 
	   ABS(pt2.x_value - pt1.x_value) * ABS(pt2.y_value-pt1.y_value) as area
FROM Q1459_Points pt1 
JOIN Q1459_Points pt2 
  ON pt1.id < pt2.id
 AND pt1.x_value != pt2.x_value 
 AND pt2.y_value != pt1.y_value
ORDER BY AREA DESC, p1 ASC, p2 ASC;





