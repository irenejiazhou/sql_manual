-- MEDIUM Q626
/*
Table: Seat
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |  PK (continuous increment)
| student     | varchar |
+-------------+---------+
Each row of this table indicates the name and the ID of a student.
 
Write an SQL query to swap the seat id of every two consecutive students. 
If the number of students is odd, the id of the last student is not swapped.
Return the result table ordered by id in ascending order.

The query result format is in the following example.
Input: 
Seat table:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
Output: 
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
Explanation: 
Note that if the number of students is odd, there is no need to change the last one's seat.
*/
-- odd
SELECT s1.id AS id, s2.student 
FROM Q626_Seat s1, Q626_Seat s2 
WHERE s1.id % 2 = 1 AND s1.id + 1 = s2.id
UNION 
-- even
SELECT s1.id AS id, s2.student 
FROM Q626_Seat s1, Q626_Seat s2 
WHERE s1.id % 2 = 0 AND s1.id - 1 = s2.id
UNION 
-- last id (if odd number of students)
SELECT s.id AS id, s.student AS student 
FROM Q626_Seat s 
WHERE s.id % 2 = 1 AND s.id = (SELECT count(*) FROM Q626_Seat)
ORDER BY id;

-- FASTEST
-- https://leetcode.com/problems/exchange-seats/solutions/902506/simple-3-line-mysql-beats-99/?orderBy=hot
SELECT ROW_NUMBER() OVER() AS id, 
	   id AS original_id,
	   student
FROM Q626_Seat
-- ORDER BY IF(id%2 = 0, id-1, id+1)
ORDER BY IF(MOD(id, 2) = 0, id-1, id+1);
/*
如果 id 除以 2 的余数是 0（也就是说，如果 id 是一个偶数），那么它会被当作 id-1 来排序；
否则，如果 id 不是偶数（也就是说，id 是一个奇数），那么它会被当作 id+1 来排序。
原本的奇数 ID 和偶数 ID 会相互交换位置。
例如，如果原本的 ID 顺序是 1,2,3,4,5，那么排序后的 ID 顺序就会是 2,1,4,3,5。
 */

























