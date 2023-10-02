-- MEDIUM Q1070: Product Sales Analysis III
/*
Table: Sales
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |  PK
| product_id  | int   |  FK
| year        | int   |  PK
| quantity    | int   |
| price       | int   |  per unit
+-------------+-------+
Each row of this table shows a sale on the product product_id in a certain year.
Table: Product
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |  PK
| product_name | varchar |
+--------------+---------+
Each row of this table indicates the product name of each product.

Write an SQL query that selects the product id, year, quantity, and price for the first year of every product sold.
Return the resulting table in any order.

The query result format is in the following example.
Input: 
Sales table:
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+ 
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+
Product table:
+------------+--------------+
| product_id | product_name |
+------------+--------------+
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |
+------------+--------------+
Output: 
+------------+------------+----------+-------+
| product_id | first_year | quantity | price |
+------------+------------+----------+-------+ 
| 100        | 2008       | 10       | 5000  |
| 200        | 2011       | 15       | 9000  |
+------------+------------+----------+-------+*/

-- Solution 1: Fastest
SELECT product_id, year AS first_year, quantity, price
FROM Sales
WHERE (product_id, year) IN (SELECT product_id, MIN(year) as year
														 FROM Sales
														 GROUP BY product_id);

-- Solution 2
WITH temp AS (
    SELECT product_id, year, quantity, price, DENSE_RANK() OVER(PARTITION BY product_id ORDER BY year ASC) AS rk
    FROM sales)
SELECT product_id, year AS first_year, quantity, price
FROM temp
WHERE rk = 1;
