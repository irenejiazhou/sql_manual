-- EASY Q1661: Average Time of Process per Machine
/*Input: 
Activity table:
+------------+------------+---------------+-----------+
| machine_id | process_id | activity_type | timestamp |
+------------+------------+---------------+-----------+
| 0          | 0          | start         | 0.712     |
| 0          | 0          | end           | 1.520     |
| 0          | 1          | start         | 3.140     |
| 0          | 1          | end           | 4.120     |
| 1          | 0          | start         | 0.550     |
| 1          | 0          | end           | 1.550     |
| 1          | 1          | start         | 0.430     |
| 1          | 1          | end           | 1.420     |
+------------+------------+---------------+-----------+
Output: 
+------------+-----------------+
| machine_id | processing_time |
+------------+-----------------+
| 0          | 0.894           |
| 1          | 0.995           |
+------------+-----------------+
Explanation: 
There are 2 machines running 2 processes each.
Machine 0's average time is ((1.520 - 0.712) + (4.120 - 3.140)) / 2 = 0.894
Machine 1's average time is ((1.550 - 0.550) + (1.420 - 0.430)) / 2 = 0.995*/

-- Solution 1: JOIN
-- Time Complexity: O(N^2) + O(M)
-- N为activity表的行数 = 8，M为activity表自关联以后的行数 = 4
SELECT s.machine_id, ROUND(AVG(e.timestamp-s.timestamp), 3) AS processing_time
FROM Activity s 
JOIN Activity e 
  ON s.machine_id = e.machine_id AND s.process_id = e.process_id AND
     s.activity_type = 'start' AND e.activity_type = 'end'
GROUP BY s.machine_id

-- Solution 2: CASE WHEN
-- Time Complexity: O(N) + O(P)
-- N为activity表的行数 = 8，P为activity表根据machine_id和process_id group by以后的行数 = 4
with temp as (
    select 
    machine_id, process_id, 
    max(case when activity_type = 'start' then timestamp end) as start_time,
    max(case when activity_type = 'end' then timestamp end) end_time
    from activity
    group by  machine_id, process_id
)
select machine_id, round(avg(end_time - start_time),3) as processing_time
from temp
group by machine_id
