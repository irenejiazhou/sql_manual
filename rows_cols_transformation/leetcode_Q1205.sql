-- MEDIUM Q1205: Monthly Transactions II
/*
Table: Transactions
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| id             | int     |  PK
| country        | varchar |
| state          | enum    |  ["approved", "declined"]
| amount         | int     |
| trans_date     | date    |
+----------------+---------+
The table has information about incoming transactions.
Table: Chargebacks
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| trans_id       | int     |  FK (Each chargeback corresponds to a transaction made previously even if they were not approved.)
| trans_date     | date    |
+----------------+---------+
Chargebacks contains basic information regarding incoming chargebacks from some transactions placed in Transactions table.

Write an SQL query to find for each month and country: 
the number of approved transactions and their total amount, the number of chargebacks, and their total amount.
Note: In your query, given the month and country, ignore rows with all zeros.
Return the result table in any order.

The query result format is in the following example.
Input: 
Transactions table:
+-----+---------+----------+--------+------------+
| id  | country | state    | amount | trans_date |
+-----+---------+----------+--------+------------+
| 101 | US      | approved | 1000   | 2019-05-18 |
| 102 | US      | declined | 2000   | 2019-05-19 |
| 103 | US      | approved | 3000   | 2019-06-10 |
| 104 | US      | declined | 4000   | 2019-06-13 |
| 105 | US      | approved | 5000   | 2019-06-15 |
+-----+---------+----------+--------+------------+
Chargebacks table:
+----------+------------+
| trans_id | trans_date |
+----------+------------+
| 102      | 2019-05-29 |
| 101      | 2019-06-30 |
| 105      | 2019-09-18 |
+----------+------------+
Output: 
+---------+---------+----------------+-----------------+------------------+-------------------+
| month   | country | approved_count | approved_amount | chargeback_count | chargeback_amount |
+---------+---------+----------------+-----------------+------------------+-------------------+
| 2019-05 | US      | 1              | 1000            | 1                | 2000              |
| 2019-06 | US      | 2              | 8000            | 1                | 1000              |
| 2019-09 | US      | 0              | 0               | 1                | 5000              |
+---------+---------+----------------+-----------------+------------------+-------------------+
*/
SELECT month, country, 
       -- Faster: COUNT(CASE WHEN state = 'approved' THEN 1 ELSE NULL END)
			 SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count, 
       SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_amount, 
			 -- Faster: COUNT(CASE WHEN state = 'chargeback' THEN 1 ELSE NULL END)
       SUM(CASE WHEN state = 'chargeback' THEN 1 ELSE 0 END) AS chargeback_count, 
       SUM(CASE WHEN state = 'chargeback' THEN amount ELSE 0 END) AS chargeback_amount
FROM
(
    SELECT LEFT(chargebacks.trans_date, 7) AS month, country, 'chargeback' AS state, amount
    FROM chargebacks
    JOIN transactions ON chargebacks.trans_id = transactions.id
    UNION ALL
    SELECT LEFT(trans_date, 7) AS month, country, state, amount
    FROM transactions
    WHERE state = "approved"
    /*
    | month   | country | state      | amount |
    | ------- | ------- | ---------- | ------ |
    | 2019-06 | US      | chargeback | 1000   |
    | 2019-05 | US      | chargeback | 2000   |
    | 2019-09 | US      | chargeback | 5000   |
    | 2019-05 | US      | approved   | 1000   |
    | 2019-05 | US      | declined   | 2000   |
    | 2019-06 | US      | approved   | 3000   |
    | 2019-06 | US      | declined   | 4000   |
    | 2019-06 | US      | approved   | 5000   |*/
) s
GROUP BY month, country;
