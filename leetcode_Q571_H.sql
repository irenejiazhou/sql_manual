-- HARD Q571
/*
+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |  primary key
| frequency   | int  |
+-------------+------+
Each row of this table shows the frequency of a number in the database.
The median is the value separating the higher half from the lower half of a data sample.
Write an SQL query to report the median of all the numbers in the database after decompressing the Numbers table. 
Round the median to one decimal point.

The query result format is in the following example.
Input: 
Numbers table:
+-----+-----------+
| num | frequency |
+-----+-----------+
| 0   | 7         |
| 1   | 1         |
| 2   | 3         |
| 3   | 1         |
+-----+-----------+
Output: 
+--------+
| median |
+--------+
| 0.0    |
+--------+
Explanation: 
If we decompress the Numbers table, 
we will get [0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3], so the median is (0 + 0) / 2 = 0.
*/

WITH temp AS (SELECT *,
        			SUM(frequency) OVER (ORDER BY num ASC) AS accumulated_sum,
        			SUM(frequency) OVER () / 2 as medium_num
	 				FROM Q571_Numbers)
SELECT round(avg(num),1) AS median
FROM temp
WHERE accumulated_sum - frequency <= medium_num 
-- 确保不会考虑到超过中位数位置的数字, The accumulated frequency of the previous num should <= medium_num
AND accumulated_sum >= medium_num; -- 确保不会考虑到低于中位数位置的数字

	

WITH t1 AS (SELECT *, sum(frequency) OVER(ORDER BY num) AS cumsum
			FROM Q571_Numbers)
SELECT round(avg(num),1) AS median
FROM t1
WHERE num = (SELECT min(num) 
			 FROM t1 
			 WHERE cumsum = (SELECT sum(frequency)/2 
			 			     FROM t1))
   OR num = (SELECT min(num) 
   			 FROM t1 
   			 WHERE cumsum > (SELECT sum(frequency)/2 
   			 			     FROM t1));
  
  

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	