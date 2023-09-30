-- MEDIUM Q1045
/*
Table: Customer
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |  NOT NULL
| product_key | int     |  FK
+-------------+---------+
There is no primary key for this table. It may contain duplicates.
Table: Product
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |  PK
+-------------+---------+
 
Write an SQL query to report the customer ids from the Customer table that bought all the products in the Product table.
Return the result table in any order.

The query result format is in the following example.
Input: 
Customer table:
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+
Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+
Output: 
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
Explanation: 
The customers who bought all the products (5 and 6) are customers with IDs 1 and 3.*/

-- Follow-up 1
-- when product_key is not the foreign key in customer table
-- 条件由bought all the products in the Product table变成bought all the common products in both customer and the Product table
SELECT customer_id
FROM Q1045_customer c
WHERE product_key IN (SELECT product_key FROM q1045_Product)
GROUP BY customer_id
HAVING count(DISTINCT product_key) = (SELECT count(DISTINCT product_key)
									  FROM Q1045_product 
									  WHERE product_key IN (SELECT product_key FROM q1045_customer))
-- Follow-up 2
-- when product_key is not the foreign key in customer table
-- 假设customer表和product表的数据都不完整，实际上每个顾客都买了所有出现在两个表的产品，求customer表丢失的数据
WITH product AS (SELECT product_key 
								 FROM Q1045_Product
							 	 UNION
								 SELECT product_key 
								 FROM Q1045_Customer)
				  ,f AS (SELECT customer_id, p.product_key
					       FROM product p, (SELECT DISTINCT customer_id FROM Q1045_customer) c)
SELECT customer_id, product_key
FROM f
WHERE (customer_id, product_key) NOT IN (SELECT * FROM q1045_customer)
ORDER BY customer_id, product_key;
