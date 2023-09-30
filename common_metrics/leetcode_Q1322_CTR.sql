-- EASY Q1322: Ads Performance
/*
Table: Ads
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| ad_id         | int     |  PK
| user_id       | int     |  PK
| action        | enum    |  ('Clicked', 'Viewed', 'Ignored')
+---------------+---------+
Each row of this table contains the ID of an Ad, the ID of a user, and the action taken by this user regarding this Ad.
 
A company is running Ads and wants to calculate the performance of each Ad using Click-Through Rate.
Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
Return the result table ordered by ctr in descending order and ad_id in ascending order.

The query result format is in the following example.
Input: 
Ads table:
+-------+---------+---------+
| ad_id | user_id | action  |
+-------+---------+---------+
| 1     | 1       | Clicked |
| 2     | 2       | Clicked |
| 3     | 3       | Viewed  |
| 5     | 5       | Ignored |
| 1     | 7       | Ignored |
| 2     | 7       | Viewed  |
| 3     | 5       | Clicked |
| 1     | 4       | Viewed  |
| 2     | 11      | Viewed  |
| 1     | 2       | Clicked |
+-------+---------+---------+
Output: 
+-------+-------+
| ad_id | ctr   |
+-------+-------+
| 1     | 66.67 |
| 3     | 50.00 |
| 2     | 33.33 |
| 5     | 0.00  |
+-------+-------+
Explanation: 
for ad_id = 1, ctr = (2/(2+1)) * 100 = 66.67
for ad_id = 2, ctr = (1/(1+2)) * 100 = 33.33
for ad_id = 3, ctr = (1/(1+1)) * 100 = 50.00
for ad_id = 5, ctr = 0.00, Note that ad_id = 5 has no clicks or views.
Note that we do not care about Ignored Ads.
*/

SELECT ad_id, 
-- Must use SUM() rather than COUNT() 
-- because action='Clicked' either equals to 1 or 0, but COUNT() is used for NULL or NOT NULL.
ROUND(IFNULL(SUM(action='Clicked') / (SUM(action='Clicked') + SUM(action='Viewed')), 0) * 100, 2) as ctr
FROM ads
GROUP BY ad_id
ORDER BY ctr DESC, ad_id ASC;
