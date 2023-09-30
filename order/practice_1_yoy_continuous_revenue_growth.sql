/* Practice 1
Year|Brand|Amount|
----+-----+------+
2018|A    | 45000|
2019|A    | 35000|
2020|A    | 75000|
2018|B    | 15000|
2019|B    | 20000|
2020|B    | 25000|
2018|C    | 21000|
2019|C    | 17000|
2020|C    | 14000|*/

-- Part 1: Identify Brands with Consistent Year-on-Year Growth
-- Solution: Filter out brands that have consistently grown in sales across all years.
/* Notes:
LEAD (value_expression [,offset] [,default]) OVER ([PARTITION BY partition_expression, ... ] ORDER BY sort_expression [ASC | DESC], ...)
LEAD(amount, 1, amount+1) means "give me the amount from the next row; if there is no next row, give me the current amount plus one".
*/
WITH temp AS (
	SELECT *, CASE WHEN amount < LEAD (amount, 1, amount+1) 
		  OVER(PARTITION BY brand ORDER BY year) THEN 1
		  ELSE 0 END AS if_increase
	FROM Practice1_Brands)
SELECT *
FROM Practice1_Brands
WHERE brand NOT IN (SELECT DISTINCT brand 
		    FROM temp 
		    WHERE if_increase = 0);

-- Part 2: Calculate Year-on-Year Growth Rate for Brands
-- Solution: Determine the year-on-year (YoY) growth rate for brands that have experienced growth.
-- Notes: A Brand has experienced growth for one or more years doesn't mean it has expereienced growth in every year (like part 1).
WITH temp AS (
    SELECT *, LAG(amount) OVER(PARTITION BY Brand ORDER BY year) as prev_amt
    FROM Practice1_Brands
)
SELECT *, concat(round((amount-prev_amt) / prev_amt,2)*100,'%') AS yoy
FROM temp
WHERE amount > prev_amt;
