-- MEDIUM Q1321: Restaurant Growth
/*
Table: Customer
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |  PK
| name          | varchar |
| visited_on    | date    |  PK, the date on which the customer visited.
| amount        | int     |  total paid by a customer
+---------------+---------+
This table contains data about customer transactions in a restaurant.

You are the restaurant owner and you want to analyze a possible expansion 
(there will be at least one customer every day).
Write an SQL query to compute the moving average of how much the customer paid in a seven days window 
(i.e., current day + 6 days before). 
average_amount should be rounded to two decimal places.
Return result table ordered by visited_on in ascending order.

The query result format is in the following example.
Input: 
Customer table:
+-------------+--------------+--------------+-------------+
| customer_id | name         | visited_on   | amount      |
+-------------+--------------+--------------+-------------+
| 1           | Jhon         | 2019-01-01   | 100         |
| 2           | Daniel       | 2019-01-02   | 110         |
| 3           | Jade         | 2019-01-03   | 120         |
| 4           | Khaled       | 2019-01-04   | 130         |
| 5           | Winston      | 2019-01-05   | 110         | 
| 6           | Elvis        | 2019-01-06   | 140         | 
| 7           | Anna         | 2019-01-07   | 150         |
| 8           | Maria        | 2019-01-08   | 80          |
| 9           | Jaze         | 2019-01-09   | 110         | 
| 1           | Jhon         | 2019-01-10   | 130         | 
| 3           | Jade         | 2019-01-10   | 150         | 
+-------------+--------------+--------------+-------------+
Output: 
+--------------+--------------+----------------+
| visited_on   | amount       | average_amount |
+--------------+--------------+----------------+
| 2019-01-07   | 860          | 122.86         |
| 2019-01-08   | 840          | 120            |
| 2019-01-09   | 840          | 120            |
| 2019-01-10   | 1000         | 142.86         |
+--------------+--------------+----------------+
Explanation: 
1st moving average from 2019-01-01 to 2019-01-07 has an average_amount of 
(100 + 110 + 120 + 130 + 110 + 140 + 150)/7 = 122.86
2nd moving average from 2019-01-02 to 2019-01-08 has an average_amount of 
(110 + 120 + 130 + 110 + 140 + 150 + 80)/7 = 120
3rd moving average from 2019-01-03 to 2019-01-09 has an average_amount of 
(120 + 130 + 110 + 140 + 150 + 80 + 110)/7 = 120
4th moving average from 2019-01-04 to 2019-01-10 has an average_amount of 
(130 + 110 + 140 + 150 + 80 + 110 + 130 + 150)/7 = 142.86
*/

-- Solution 1: Fastest，只能应用于不存在缺失日期的情况，比如连续的7个business day

-- Granularity: customer_id+visited_on -> visited_on
WITH t1 AS (SELECT visited_on, 
									 SUM(amount) AS amount								   
		  			FROM Customer
		  			GROUP BY visited_on)
	 , t2 AS (SELECT visited_on, 
									 ROW_NUMBER() OVER(ORDER BY visited_on) AS row_num,
					    		 SUM(amount) OVER(ORDER BY visited_on
				                        		ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount, 
																		-- 计算当前行和前六行
		               AVG(amount) OVER (ORDER BY visited_on
				                        		 ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS average_amount
						FROM t1)
SELECT visited_on, amount, ROUND(average_amount, 2) average_amount
FROM t2
WHERE row_num >= 7; 
			-- 一定要在t2外进行>=7的筛选，sum()over()是在where条件之后进行
			-- 所以如果在t2内筛选，就会变成对01-07及之后的amount进行rolling sum()
/*
t1
| visited_on | amount |
| ---------- | ------ |
| 2019-01-01 | 100    |
| 2019-01-02 | 110    |
| 2019-01-03 | 120    |
| 2019-01-04 | 130    |
| 2019-01-05 | 110    |
| 2019-01-06 | 140    |
| 2019-01-07 | 150    |
| 2019-01-08 | 80     | 
| 2019-01-09 | 110    |
| 2019-01-10 | 280    | 
t2
| visited_on | row_num | amount | average_amount |
| ---------- | ------- | ------ | -------------- |
| 2019-01-01 | 1       | 100    | 100            |
| 2019-01-02 | 2       | 210    | 105            |
| 2019-01-03 | 3       | 330    | 110            |
| 2019-01-04 | 4       | 460    | 115            |
| 2019-01-05 | 5       | 570    | 114            |
| 2019-01-06 | 6       | 710    | 118.3333       |
| 2019-01-07 | 7       | 860    | 122.8571       |
| 2019-01-08 | 8       | 840    | 120            |
| 2019-01-09 | 9       | 840    | 120            |
| 2019-01-10 | 10      | 1000   | 142.8571       |
*/

-- Solution 2
-- 相比于method 1慢一些，但可以应用于缺失日期的情况，也就是不区分是否为business day，如果休息日的记录在表中没有的话，也不影响进行包含该日期下amount=0的聚合
									-- 通过distinct将原表的颗粒度变成visited_on
WITH t AS (SELECT DISTINCT visited_on, 
								  SUM(amount) OVER (ORDER BY visited_on 
																		RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW) AS amount,
																		-- 计算当前日期和前六天的所有行
								  DENSE_RANK() OVER (ORDER BY visited_on) AS rk
           FROM Customer)
SELECT visited_on, amount, ROUND(amount/7, 2) AS average_amount
FROM t
WHERE rk >= 7;
/*
t 
| visited_on | amount | rk |
| ---------- | ------ | -- |
| 2019-01-01 | 100    | 1  |
| 2019-01-02 | 210    | 2  |
| 2019-01-03 | 330    | 3  |
| 2019-01-04 | 460    | 4  |
| 2019-01-05 | 570    | 5  |
| 2019-01-06 | 710    | 6  |
| 2019-01-07 | 860    | 7  |
| 2019-01-08 | 840    | 8  |
| 2019-01-09 | 840    | 9  |
| 2019-01-10 | 1000   | 10 |
*/

-- Solution 1和2的区别原因：一个用的是ROWS一个用的是RANGE
/*
ROWS和RANGE都用于定义窗口的大小，但它们的计算方式有所不同：
1. ROWS: 这个关键字使窗口函数在物理行的基础上进行计算。
				 例如，ROWS BETWEEN 1 PRECEDING AND CURRENT ROW会使窗口函数计算当前行和前一行。
2. RANGE: 这个关键字使窗口函数在逻辑行（即具有相同排序键的行）的基础上进行计算。
				  例如，RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW会使窗口函数计算从分区的开始到具有与当前行相同排序键的最后一行的所有行。

PRECEDING用在窗口函数的上下文中，表示"之前"或"在...之前"：
1. 2 PRECEDING表示当前行的前两行。
2. UNBOUNDED PRECEDING的意思是“从分区(窗口)的最开始处”，如果窗口函数中没有定义PARTITION BY子句，那么整个结果集被视为一个单一的分区。
*/

-- Solution 3
-- 可以应用于缺失日期的情况
SELECT a.visited_on AS visited_on, SUM(b.day_sum) AS amount,
       ROUND(sum(b.day_sum)/7, 2) AS average_amount
FROM
  (SELECT visited_on, SUM(amount) AS day_sum FROM Customer GROUP BY visited_on) a,  -- 处理原表颗粒度
  (SELECT visited_on, SUM(amount) AS day_sum FROM Customer GROUP BY visited_on) b
WHERE DATEDIFF(a.visited_on, b.visited_on) BETWEEN 0 AND 6  -- a.visited_on当天及之前的6天内
GROUP BY a.visited_on
HAVING COUNT(b.visited_on) = 7;
/* group by 之前的表
| visited_on | day_sum | b.visited_on | day_sum |
| ---------- | ------- | ------------ | ------- |
| 2019-01-10 | 280     |  2019-01-04  | 130     |
| 2019-01-10 | 280     |  2019-01-05  | 110     |
| 2019-01-10 | 280     |  2019-01-06  | 140     |
| 2019-01-10 | 280     |  2019-01-07  | 150     |
| 2019-01-10 | 280     |  2019-01-08  | 80      |
| 2019-01-10 | 280     |  2019-01-09  | 110     |
| 2019-01-10 | 280     |  2019-01-10  | 280     |
| 2019-01-09 | 110     |  2019-01-03  | 120     |
| 2019-01-09 | 110     |  2019-01-04  | 130     |
| 2019-01-09 | 110     |  2019-01-05  | 110     |
| 2019-01-09 | 110     |  2019-01-06  | 140     |
| 2019-01-09 | 110     |  2019-01-07  | 150     |
| 2019-01-09 | 110     |  2019-01-08  | 80      |
| 2019-01-09 | 110     |  2019-01-09  | 110     |
| 2019-01-08 ...*/
