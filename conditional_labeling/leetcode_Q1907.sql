-- MEDIUM Q1907: Count Salary Categories
/*
Table: Accounts
+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |  PK
| income      | int  |
+-------------+------+
Each row contains information about the monthly income for one bank account.

Write an SQL query to report the number of bank accounts of each salary category. The salary categories are:
"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. 
If there are no accounts in a category, then report 0.
Return the result table in any order.

The query result format is in the following example.
Input: 
Accounts table:
+------------+--------+
| account_id | income |
+------------+--------+
| 3          | 108939 |
| 2          | 12747  |
| 8          | 87709  |
| 6          | 91796  |
+------------+--------+
Output: 
+----------------+----------------+
| category       | accounts_count |
+----------------+----------------+
| Low Salary     | 1              |
| Average Salary | 0              | -- There is no record in the source table under this category
| High Salary    | 3              |
+----------------+----------------+
Explanation: 
Low Salary: Account 2.
Average Salary: No accounts.
High Salary: Accounts 3, 6, and 8.
*/
-- Solution 1: Fastest
SELECT "Low Salary" AS category,
SUM(CASE WHEN income < 20000 THEN 1 ELSE 0 END) AS accounts_count
FROM Accounts

UNION

SELECT "Average Salary" AS category,
SUM(CASE WHEN income >= 20000 and income <= 50000 THEN 1 ELSE 0 END) AS accounts_count
FROM Accounts

UNION

SELECT "High Salary" AS category,
SUM(CASE WHEN income>50000 THEN 1 ELSE 0 END) AS accounts_count
FROM Accounts;

  
-- Solution 2
WITH t1 AS (
  SELECT account_id,
         CASE WHEN income < 20000 THEN 'Low Salary'
              WHEN income >= 20000 AND income <= 50000 THEN 'Average Salary'
              ELSE 'High Salary' END AS category
  FROM Accounts)
, category AS (
     SELECT 'Low Salary' AS category
     UNION
     SELECT 'Average Salary' 
     UNION
     SELECT 'High Salary'
)
SELECT c.category, COUNT(account_id) AS accounts_count
FROM category c
LEFT JOIN t1
       ON c.category = t1.category
GROUP BY c.category;
