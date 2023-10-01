-- MEDIUM Q1511: Customer Order Frequency
/*
Table: Customers
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |  PK
| name          | varchar |
| country       | varchar |
+---------------+---------+
This table contains information about the customers in the company.
Table: Product
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |  PK
| description   | varchar |
| price         | int     |
+---------------+---------+
This table contains information on the products in the company.
price is the product cost.
Table: Orders
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |  PK
| customer_id   | int     |
| product_id    | int     |
| order_date    | date    |
| quantity      | int     |
+---------------+---------+
This table contains information on customer orders.
customer_id is the id of the customer who bought "quantity" products with id "product_id".
Order_date is the date in format ('YYYY-MM-DD') when the order was shipped.
 
Write an SQL query to report the customer_id and customer_name of customers 
who have spent at least $100 in each month of June and July 2020.
Return the result table in any order.

The query result format is in the following example.
Input: 
Customers table:
+--------------+-----------+-------------+
| customer_id  | name      | country     |
+--------------+-----------+-------------+
| 1            | Winston   | USA         |
| 2            | Jonathan  | Peru        |
| 3            | Moustafa  | Egypt       |
+--------------+-----------+-------------+
Product table:
+--------------+-------------+-----------+
| product_id   | description | price     |
+--------------+-------------+-----------+
| 10           | LC Phone    | 300       |
| 20           | LC T-Shirt  | 10        |
| 30           | LC Book     | 45        |
| 40           | LC Keychain | 2         |
+--------------+-------------+-----------+
Orders table:
+-----------+-------------+-------------+-------------+-----------+
| order_id  | customer_id | product_id  | order_date  | quantity  |
+-----------+-------------+-------------+-------------+-----------+
| 1         | 1           | 10          | 2020-06-10  | 1         |
| 2         | 1           | 20          | 2020-07-01  | 1         |
| 3         | 1           | 30          | 2020-07-08  | 2         |
| 4         | 2           | 10          | 2020-06-15  | 2         |
| 5         | 2           | 40          | 2020-07-01  | 10        |
| 6         | 3           | 20          | 2020-06-24  | 2         |
| 7         | 3           | 30          | 2020-06-25  | 2         |
| 9         | 3           | 30          | 2020-05-08  | 3         |
+-----------+-------------+-------------+-------------+-----------+
Output: 
+--------------+------------+
| customer_id  | name       |  
+--------------+------------+
| 1            | Winston    |
+--------------+------------+
Explanation: 
Winston spent $300 (300 * 1) in June and $100 ( 10 * 1 + 45 * 2) in July 2020.
Jonathan spent $600 (300 * 2) in June and $20 ( 2 * 10) in July 2020.
Moustafa spent $110 (10 * 2 + 45 * 2) in June and $0 in July 2020.
*/
-- Solution 1: Fastest
SELECT customer_id, name
FROM Customers 
JOIN Orders USING(customer_id) 
JOIN Product USING(product_id)
GROUP BY customer_id
HAVING SUM(IF(LEFT(order_date, 7) = '2020-06', quantity, 0) * price) >= 100
   AND SUM(IF(LEFT(order_date, 7) = '2020-07', quantity, 0) * price) >= 100

-- Solution 2: My Solution, Slow
WITH o AS (
    SELECT o.customer_id, name,
           SUM(CASE WHEN LEFT(order_date,7) = ('2020-06') THEN price * quantity ELSE 0 END) AS jun,
           SUM(CASE WHEN LEFT(order_date,7) = ('2020-07') THEN price * quantity ELSE 0 END) AS july
    FROM orders o
    JOIN product p
      ON o.product_id = p.product_id
    JOIN customers c
      ON o.customer_id = c.customer_id
    WHERE LEFT(order_date,7) IN ('2020-06', '2020-07')
    GROUP BY o.customer_id, name)
SELECT customer_id, name
FROM o
WHERE jun >= 100 AND july >= 100;
