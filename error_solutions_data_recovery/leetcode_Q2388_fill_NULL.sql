-- MEDIUM Q2388: Change Null Values in a Table to the Previous Value
/*
Table: CoffeeShop
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |  PK
| drink       | varchar |
+-------------+---------+
Each row in this table shows the order id and the name of the drink ordered. Some drink rows are nulls.

Write an SQL query to replace the null values of drink with the name of the drink of the previous row that is not null. 
It is guaranteed that the drink of the first row of the table is not null.
Return the result table in the same order as the input.

The query result format is shown in the following example.
Input: 
CoffeeShop table:
+----+------------------+
| id | drink            |
+----+------------------+
| 9  | Mezcal Margarita |
| 6  | null             |
| 7  | null             |
| 3  | Americano        |
| 1  | Daiquiri         |
| 2  | null             |
+----+------------------+
Output: 
+----+------------------+
| id | drink            |
+----+------------------+
| 9  | Mezcal Margarita |
| 6  | Mezcal Margarita |
| 7  | Mezcal Margarita |
| 3  | Americano        |
| 1  | Daiquiri         |
| 2  | Daiquiri         |
+----+------------------+
Explanation: 
For ID 6, the previous value that is not null is from ID 9. We replace the null with "Mezcal Margarita".
For ID 7, the previous value that is not null is from ID 9. We replace the null with "Mezcal Margarita".
For ID 2, the previous value that is not null is from ID 1. We replace the null with "Daiquiri".
Note that the rows in the output are the same as in the input.
*/

WITH t AS (
  SELECT id, drink, ROW_NUMBER() OVER() AS rk
  FROM coffeeshop)
/* Step 1: Create a PK first
| id | drink            | rk |
| -- | ---------------- | -- |
| 9  | Mezcal Margarita | 1  |
| 6  | null             | 2  |
| 7  | null             | 3  |
| 3  | Americano        | 4  |
| 1  | Daiquiri         | 5  |
| 2  | null             | 6  |*/

, c AS (
  SELECT t1.*, t2.drink AS last_drink, 
         RANK() OVER(PARTITION BY t1.id ORDER BY t2.rk DESC) AS closest_last_drink
  FROM t t1
  LEFT JOIN t t2
         ON t2.drink IS NOT NULL
        AND t1.drink IS NULL
        AND t1.rk > t2.rk)
/* 
Step 2: 
  Perform a self-join on the table, with the join condition being that the drink from the main table is null, and the rank of the main table is after the rank of the joined table.
Step 3:
  Adding a sorting column, because t1.rk > t2.rk would associate both Mezcal Margarita and Americano to the drink of id=2, so we need to take the one closest to the null value (with the largest t2.rk).
| id | drink            | rk | last_drink       | top |
| -- | ---------------- | -- | ---------------- | --- |
| 1  | Daiquiri         | 5  | null             | 1   |
| 2  | null             | 6  | Daiquiri         | 1   |
| 2  | null             | 6  | Americano        | 2   |
| 2  | null             | 6  | Mezcal Margarita | 3   |
| 3  | Americano        | 4  | null             | 1   |
| 6  | null             | 2  | Mezcal Margarita | 1   |
| 7  | null             | 3  | Mezcal Margarita | 1   |
| 9  | Mezcal Margarita | 1  | null             | 1   |*/

SELECT DISTINCT id, 
       CASE WHEN drink IS NOT NULL THEN drink ELSE last_drink END AS drink
FROM c
WHERE closest_last_drink = 1
ORDER BY rk;
