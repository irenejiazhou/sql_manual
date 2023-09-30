-- MEDIUM Q2142: The Number of Passengers in Each Bus I
/*
Table: Buses 
+--------------+------+
| Column Name  | Type |
+--------------+------+
| bus_id       | int  |  PK
| arrival_time | int  |
+--------------+------+
Each row of this table contains information about the arrival time of a bus at the LeetCode station.
No two buses will arrive at the same time.

Table: Passengers
+--------------+------+
| Column Name  | Type |
+--------------+------+
| passenger_id | int  |  PK
| arrival_time | int  |
+--------------+------+
Each row of this table contains information about the arrival time of a passenger at the LeetCode station.
 
Buses and passengers arrive at the LeetCode station. 
If a bus arrives at the station at time tbus and a passenger arrived at time tpassenger where tpassenger <= tbus and the passenger did not catch any bus, the passenger will use that bus.

Write an SQL query to report the number of users that used each bus.
Return the result table ordered by bus_id in ascending order.

The query result format is in the following example.
Input: 
Buses table:
+--------+--------------+
| bus_id | arrival_time |
+--------+--------------+
| 1      | 2            |
| 2      | 4            |
| 3      | 7            |
+--------+--------------+
Passengers table:
+--------------+--------------+
| passenger_id | arrival_time |
+--------------+--------------+
| 11           | 1            |
| 12           | 5            |
| 13           | 6            |
| 14           | 7            |
+--------------+--------------+
Output: 
+--------+----------------+
| bus_id | passengers_cnt |
+--------+----------------+
| 1      | 1              |
| 2      | 0              |
| 3      | 3              |
+--------+----------------+
Explanation: 
- Passenger 11 arrives at time 1.
- Bus 1 arrives at time 2 and collects passenger 11.
- Bus 2 arrives at time 4 and does not collect any passengers.
- Passenger 12 arrives at time 5.
- Passenger 13 arrives at time 6.
- Passenger 14 arrives at time 7.
- Bus 3 arrives at time 7 and collects passengers 12, 13, and 14.
*/

-- Notes:
-- Start with passenger's arrival time, and then find the latest bus after that.
-- If starting with bus' arrial time, one passenger will be joined with all buses arriving after the passenger.

-- Solution
with temp as (select passenger_id, min(b.arrival_time) as latest_bus_time
              from buses b
              inner join passengers p
                      on b.arrival_time >= p.arrival_time
              group by passenger_id)
select bus_id, count(passenger_id) as passengers_cnt
from buses b
left join temp t
       on b.arrival_time = t.latest_bus_time
group by bus_id
order by bus_id asc;
