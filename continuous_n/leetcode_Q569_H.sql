-- HARD Q569
/*
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| company      | varchar |
| salary       | int     |
+--------------+---------+
id is the primary key column for this table.
Each row of this table indicates the company and the salary of one employee.

Write an SQL query to find the rows that contain the median salary of each company. 
While calculating the median, when you sort the salaries of the company, break the ties by id.
Return the result table in any order.

Input: 
Employee table:
+----+---------+--------+
| id | company | salary |
+----+---------+--------+
| 1  | A       | 2341   |
| 2  | A       | 341    |
| 3  | A       | 15     |
| 4  | A       | 15314  |
| 5  | A       | 451    |
| 6  | A       | 513    |
| 7  | B       | 15     |
| 8  | B       | 13     |
| 9  | B       | 1154   |
| 10 | B       | 1345   |
| 11 | B       | 1221   |
| 12 | B       | 234    |
| 13 | C       | 2345   |
| 14 | C       | 2645   |
| 15 | C       | 2645   |
| 16 | C       | 2652   |
| 17 | C       | 65     |
+----+---------+--------+
Output: 
+----+---------+--------+
| id | company | salary |
+----+---------+--------+
| 5  | A       | 451    |
| 6  | A       | 513    |
| 12 | B       | 234    |
| 9  | B       | 1154   |
| 14 | C       | 2645   |
+----+---------+--------+
Explanation: 
For company A, the rows sorted are as follows:
+----+---------+--------+
| id | company | salary |
+----+---------+--------+
| 3  | A       | 15     |
| 2  | A       | 341    |
| 5  | A       | 451    | <-- median
| 6  | A       | 513    | <-- median
| 1  | A       | 2341   |
| 4  | A       | 15314  |
+----+---------+--------+
For company B, the rows sorted are as follows:
+----+---------+--------+
| id | company | salary |
+----+---------+--------+
| 8  | B       | 13     |
| 7  | B       | 15     |
| 12 | B       | 234    | <-- median
| 11 | B       | 1221   | <-- median
| 9  | B       | 1154   |
| 10 | B       | 1345   |
+----+---------+--------+
For company C, the rows sorted are as follows:
+----+---------+--------+
| id | company | salary |
+----+---------+--------+
| 17 | C       | 65     |
| 13 | C       | 2345   |
| 14 | C       | 2645   | <-- median
| 15 | C       | 2645   | 
| 16 | C       | 2652   |
+----+---------+--------+
*/

-- 以公司为单位按照工资对员工进行排序
WITH A AS (SELECT *, 
		   ROW_NUMBER() OVER (PARTITION BY company 
		   					  ORDER BY salary) AS row_num
		   FROM Q569_Employee),
-- 以公司为颗粒度，找到每个公司有median工资的员工序号（新的排序，不是员工id）
B AS (SELECT company, AVG(row_num) AS row_num_avg
	  FROM A 
	  GROUP BY company),
-- 在以员工为颗粒度的表中加上B表的字段
C AS (SELECT a.*, b.row_num_avg
FROM A a
LEFT JOIN B b 
       ON a.company = b.company)
-- 筛选出来每个公司对应员工序号row_num的工资
SELECT DISTINCT id, company, salary
FROM C
WHERE row_num = row_num_avg 
   OR row_num = row_num_avg + 0.5 
   OR row_num = row_num_avg - 0.5
ORDER BY company, salary;

-- https://leetcode.com/problems/median-employee-salary/solutions/3061419/window-function-super-easy-logic/?languageTags=mysql
with temp as (
    select *,
    row_number() over(partition by company order by salary) as orders,
    count(*) over(partition by company) as counts 
    from q569_employee
)
select id, company, salary
from temp
where (counts%2 = 0 and orders = (counts/2) + 1) -- even total, take two values
   or (counts%2 = 0 and orders = counts/2)      -- even total, take two values
   or (counts%2 = 1 and orders = (counts+1)/2); -- odd total, take one value

/*
aggregate functions + over(partition by)
SELECT COUNT(*) OVER (PARTITION BY company) AS count_per_company,
       MIN(column_name) OVER (PARTITION BY company) AS min_per_company,
       AVG(column_name) OVER (PARTITION BY company) AS avg_per_company
FROM q569_employee;
*/
















