-- HARD Q579
/*
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |  PK
| month       | int  |  PK
| salary      | int  |
+-------------+------+
Each row in the table indicates the salary of an employee in one month during the year 2020.
Write an SQL query to calculate the cumulative salary summary for every employee in a single unified table.

The cumulative salary summary for an employee can be calculated as follows:
1. For each month that the employee worked, sum up the salaries in that month and the previous two months. 
   This is their 3-month sum for that month. 
   If an employee did not work for the company in previous months, their effective salary for those months is 0.
2. Do not include the 3-month sum for the most recent month that the employee worked for in the summary.
3. Do not include the 3-month sum for any month the employee did not work.

Return the result table ordered by id in ascending order. In case of a tie, order it by month in descending order.

The query result format is in the following example.
Input: 
Employee table:
+----+-------+--------+
| id | month | salary |
+----+-------+--------+
| 1  | 1     | 20     |
| 2  | 1     | 20     |
| 1  | 2     | 30     |
| 2  | 2     | 30     |
| 3  | 2     | 40     |
| 1  | 3     | 40     |
| 3  | 3     | 60     |
| 1  | 4     | 60     |
| 3  | 4     | 70     |
| 1  | 7     | 90     |
| 1  | 8     | 90     |
+----+-------+--------+
Output: 
+----+-------+--------+
| id | month | Salary |
+----+-------+--------+
| 1  | 7     | 90     |
| 1  | 4     | 130    |
| 1  | 3     | 90     |
| 1  | 2     | 50     |
| 1  | 1     | 20     |
| 2  | 1     | 20     |
| 3  | 3     | 100    |
| 3  | 2     | 40     |
+----+-------+--------+
Explanation: 
Employee '1' has five salary records excluding their most recent month '8':
- 90 for month '7'.
- 60 for month '4'.
- 40 for month '3'.
- 30 for month '2'.
- 20 for month '1'.
So the cumulative salary summary for this employee is:
+----+-------+--------+
| id | month | salary |
+----+-------+--------+
| 1  | 7     | 90     |  (90 + 0 + 0)
| 1  | 4     | 130    |  (60 + 40 + 30)
| 1  | 3     | 90     |  (40 + 30 + 20)
| 1  | 2     | 50     |  (30 + 20 + 0)
| 1  | 1     | 20     |  (20 + 0 + 0)
+----+-------+--------+
Note that the 3-month sum for month '7' is 90 because they did not work during month '6' or month '5'.

Employee '2' only has one salary record (month '1') excluding their most recent month '2'.
+----+-------+--------+
| id | month | salary |
+----+-------+--------+
| 2  | 1     | 20     |  (20 + 0 + 0)
+----+-------+--------+

Employee '3' has two salary records excluding their most recent month '4':
- 60 for month '3'.
- 40 for month '2'.
So the cumulative salary summary for this employee is:
+----+-------+--------+
| id | month | salary |
+----+-------+--------+
| 3  | 3     | 100    |  (60 + 40 + 0)
| 3  | 2     | 40     |  (40 + 0 + 0)
+----+-------+--------+
*/

-- My Answer
WITH temp AS (SELECT *, 
				  -- 为了排除 the most recent month that the employee worked for
				  LAG(month) OVER (PARTITION BY id ORDER BY month DESC) AS next_month
			 	  -- ,LEAD(month) OVER (PARTITION BY id ORDER BY month DESC) AS last_month
		   FROM  Q579_Employee)
SELECT t1.id, t1.month, 
	   (t1.salary +
	   CASE WHEN t2.salary IS NULL THEN 0 ELSE t2.salary END + 
	   CASE WHEN t3.salary IS NULL THEN 0 ELSE t3.salary END) AS salary
FROM temp t1
LEFT JOIN temp t2
	   ON t1.month = (t2.month + 1) AND t1.id = t2.id
LEFT JOIN temp t3
	   ON t1.month = (t3.month + 2) AND t1.id = t3.id
WHERE t1.next_month IS NOT NULL
ORDER BY t1.id, t1.month DESC;

-- https://leetcode.com/problems/find-cumulative-salary-of-an-employee/solutions/409499/simple-mysql/?orderBy=hot
-- 和上面的答案思路类似，但是上面的是加列然后横向相加，这个答案是加行然后竖向group by
SELECT e1.id, e1.month, sum(e2.salary) AS salary
FROM Q579_Employee e1 
INNER JOIN Q579_Employee e2 
		ON e1.id=e2.id AND (e1.month - e2.month) BETWEEN 0 AND 2
-- 排除 the most recent month that the employee worked for
WHERE (e1.id, e1.month) not in (SELECT id, max(month) 
							   FROM Q579_Employee 
							   GROUP BY id)
GROUP BY e1.id, e1.month
ORDER BY e1.id, e1.month DESC;






