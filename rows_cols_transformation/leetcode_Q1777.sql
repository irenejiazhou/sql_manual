-- EASY 1777: Product's Price for Each Store
/*
Table: Products
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_id  | int     |
| store       | enum    |
| price       | int     |
+-------------+---------+
(product_id, store) is the primary key for this table.
store is an ENUM of type ('store1', 'store2', 'store3') where each represents the store this product is available at.
price is the price of the product at this store.
 
Write an SQL query to find the price of each product in each store.
Return the result table in any order.

The query result format is in the following example.
Input: 
Products table:
+-------------+--------+-------+
| product_id  | store  | price |
+-------------+--------+-------+
| 0           | store1 | 95    |
| 0           | store3 | 105   |
| 0           | store2 | 100   |
| 1           | store1 | 70    |
| 1           | store3 | 80    |
+-------------+--------+-------+
Output: 
+-------------+--------+--------+--------+
| product_id  | store1 | store2 | store3 |
+-------------+--------+--------+--------+
| 0           | 95     | 100    | 105    |
| 1           | 70     | null   | 80     |
+-------------+--------+--------+--------+
Explanation: 
Product 0 price's are 95 for store1, 100 for store2 and, 105 for store3.
Product 1 price's are 70 for store1, 80 for store3 and, it's not sold in store2.
*/

/*
select distinct p.product_id, p1.price as store1, p2.price as store2, p3.price as store3
from products p
left join products p1
on p.product_id = p1.product_id and p1.store = 'store1'
left join products p2
on p.product_id = p2.product_id and p2.store = 'store2'
left join products p3
on p.product_id = p3.product_id and p3.store = 'store3'
*/

SELECT
  product_id,
  MAX(CASE WHEN store = 'store1' THEN price END) AS store1,
  MAX(CASE WHEN store = 'store2' THEN price END) AS store2,
  MAX(CASE WHEN store = 'store3' THEN price END) AS store3
FROM Products 
GROUP BY product_id;

-- The MAX function is used to aggregate the results by product_id and only keep the non-NULL value.
-- which means not only number but also string can be in the place of the price field above.
