-- EASY Q603
/*
Table: Cinema
+-------------+------+
| Column Name | Type |
+-------------+------+
| seat_id     | int  |  auto-increment PK
| free        | bool |  1 = free, 0 = occupied
+-------------+------+
Each row of this table indicates whether the ith seat is free or not. 

Write an SQL query to report all the consecutive available seats in the cinema.
Return the result table ordered by seat_id in ascending order.
The test cases are generated so that MORE THAN 2 SEATS are consecutively available.

The query result format is in the following example.
Input: 
Cinema table:
+---------+------+
| seat_id | free |
+---------+------+
| 1       | 1    |
| 2       | 0    |
| 3       | 1    |
| 4       | 1    |
| 5       | 1    |
+---------+------+
Output: 
+---------+
| seat_id |
+---------+
| 3       |
| 4       |
| 5       |
+---------+
*/

-- consecutive means the seat s1 1) s1.free = 1
--                               2) s0.free = 1 or s2.free = 1
SELECT DISTINCT c1.seat_id 
-- c1.*, c2.seat_id as last_seat_id, c2.free as last_free
FROM Q603_Cinema_test c1
LEFT JOIN Q603_Cinema_test c2
       ON c1.seat_id = c2.seat_id+1 OR c1.seat_id = c2.seat_id-1
WHERE c1.free = 1 and c2.free = 1
ORDER BY c1.seat_id;




