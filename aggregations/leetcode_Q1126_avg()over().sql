-- MEDIUM Q1126: Active Businesses
/*
Table: Events
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| business_id   | int     |  PK
| event_type    | varchar |  PK
| occurences    | int     | 
+---------------+---------+
Each row in the table logs the info that an event of some type occurred at some business for a number of times.
 
The average activity for a particular event_type is 
the average occurences across all companies that have this event.

An active business is a business that has more than one event_type such that their occurences is strictly greater than the average activity for that event.

Write an SQL query to find all active businesses.
Return the result table in any order.

The query result format is in the following example.
Input: 
Events table:
+-------------+------------+------------+
| business_id | event_type | occurences |
+-------------+------------+------------+
| 1           | reviews    | 7          |
| 3           | reviews    | 3          |
| 1           | ads        | 11         |
| 2           | ads        | 7          |
| 3           | ads        | 6          |
| 1           | page views | 3          |
| 2           | page views | 12         |
+-------------+------------+------------+
Output: 
+-------------+
| business_id |
+-------------+
| 1           |
+-------------+
Explanation:  
The average activity for each event can be calculated as follows:
- 'reviews': (7+3)/2 = 5
- 'ads': (11+7+6)/3 = 8
- 'page views': (3+12)/2 = 7.5
The business with id=1 has 7 'reviews' events (more than 5) and 11 'ads' events (more than 8), so it is an active business.
*/
WITH e AS (SELECT business_id, event_type, occurences,
                  AVG(occurences) OVER(PARTITION BY event_type) AS avg_activity
           FROM events)
SELECT business_id
FROM e
-- STEP 1: Filter all businesses x events that meet the criteria
WHERE occurences > avg_activity
GROUP BY business_id
-- STEP 2: Filter all businesses that meet the criteria
HAVING COUNT(DISTINCT event_type) > 1;
