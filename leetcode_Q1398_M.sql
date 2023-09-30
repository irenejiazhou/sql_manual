-- MEDIUM Q1398
/*
Table: Customers
+---------------------+---------+
| Column Name         | Type    |
+---------------------+---------+
| customer_id         | int     |  PK
| customer_name       | varchar |
+---------------------+---------+
Table: Orders
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |  PK
| customer_id   | int     |
| product_name  | varchar |
+---------------+---------+
customer_id is the id of the customer who bought the product "product_name".
 
Write an SQL query to report the customer_id and customer_name of customers who 
bought products "A", "B" but did not buy the product "C" 
since we want to recommend them to purchase this product.
Return the result table ordered by customer_id.

The query result format is in the following example.
Input: 
Customers table:
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
| 1           | Daniel        |
| 2           | Diana         |
| 3           | Elizabeth     |
| 4           | Jhon          |
+-------------+---------------+
Orders table:
+------------+--------------+---------------+
| order_id   | customer_id  | product_name  |
+------------+--------------+---------------+
| 10         |     1        |     A         |
| 20         |     1        |     B         |
| 30         |     1        |     D         |
| 40         |     1        |     C         |
| 50         |     2        |     A         |
| 60         |     3        |     A         |
| 70         |     3        |     B         |
| 80         |     3        |     D         |
| 90         |     4        |     C         |
+------------+--------------+---------------+
Output: 
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
| 3           | Elizabeth     |
+-------------+---------------+
Explanation: Only the customer_id with id 3 bought the product A and B but not the product C.
*/
select  a.customer_id, a.customer_name
from customers a
inner join orders b
on a.customer_id  = b.customer_id
group by a.customer_id
having sum(b.product_name='A') > 0 and sum(b.product_name='B') > 0 and sum(b.product_name="C") = 0;
/* 此处不需要考虑sum是否为null，因为sum的是一个condition
| customer_id | customer_name | sum(b.product_name='A') |
| ----------- | ------------- | ----------------------- |
| 1           | Daniel        | 1                       |
| 2           | Diana         | 1                       |
| 3           | Elizabeth     | 1                       |
| 4           | Jhon          | 0                       |
| 5           | Jhon          | 0                       |*/