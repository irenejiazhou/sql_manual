-- MEDIUM Q1393 Capital Gain/Loss
/*
Table: Stocks
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| stock_name    | varchar |  PK
| operation     | enum    |  ('Sell', 'Buy')
| operation_day | int     |  PK
| price         | int     |
+---------------+---------+
Each row of this table indicates that the stock which has stock_name had an operation on the day operation_day with the price.
It is guaranteed that each 'Sell' operation for a stock has a corresponding 'Buy' operation in a previous day. 
It is also guaranteed that each 'Buy' operation for a stock has a corresponding 'Sell' operation in an upcoming day.

Write an SQL query to report the Capital gain/loss for each stock.
The Capital gain/loss of a stock is the total gain or loss after buying and selling the stock one or many times.
Return the result table in any order.

The query result format is in the following example.
Input: 
Stocks table:
+---------------+-----------+---------------+--------+
| stock_name    | operation | operation_day | price  |
+---------------+-----------+---------------+--------+
| Leetcode      | Buy       | 1             | 1000   |
| Corona Masks  | Buy       | 2             | 10     |
| Leetcode      | Sell      | 5             | 9000   |
| Handbags      | Buy       | 17            | 30000  |
| Corona Masks  | Sell      | 3             | 1010   |
| Corona Masks  | Buy       | 4             | 1000   |
| Corona Masks  | Sell      | 5             | 500    |
| Corona Masks  | Buy       | 6             | 1000   |
| Handbags      | Sell      | 29            | 7000   |
| Corona Masks  | Sell      | 10            | 10000  |
+---------------+-----------+---------------+--------+
Output: 
+---------------+-------------------+
| stock_name    | capital_gain_loss |
+---------------+-------------------+
| Corona Masks  | 9500              |  (1010 - 10) + (500 - 1000) + (10000 - 1000)
| Leetcode      | 8000              |  9000 - 1000
| Handbags      | -23000            |  7000 - 30000
+---------------+-------------------+
*/
-- Solution 1: Simplest
SELECT stock_name, 
			 SUM(CASE WHEN operation = 'Buy' THEN -price
				        ELSE price
				        END) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name;

-- Solution 2: LAG()
WITH capital AS (
	SELECT stock_name, 
    		 CASE WHEN operation = 'Sell' 
    					THEN price - LAG(price,1) OVER(PARTITION BY stock_name ORDER BY operation_day)
        			ELSE NULL 
    					END AS capital_gain_loss
	FROM Q1393_Stocks)
SELECT stock_name, 
       SUM(capital_gain_loss) AS capital_gain_loss
FROM capital
GROUP BY stock_name;
