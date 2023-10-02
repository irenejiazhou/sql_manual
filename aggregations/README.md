#### [leetcode_Q1322: Click-Through Rate (CTR)](https://github.com/irenejiazhou/sql_manual/blob/main/common_metrics/leetcode_Q1322_CTR.sql)
`ROUND(IFNULL(SUM()/SUM()*100,0),2)` \
For rates: <b>result * 100 before ROUND()</b>

<img src="https://github.com/irenejiazhou/sql_manual/blob/main/images/q1322_ctr.png"  width="80%" height="80%">


#### [leetcode_Q1142: User Activity for the Past 30 Days II](https://github.com/irenejiazhou/sql_manual/blob/main/aggregations/leetcode_Q1142_ifnull_for_0_in_denominator.sql)
`CASE WHEN` or `IFNULL()` \
For `COUNT()` in the denominator: always prevent the situation where COUNT() = 0.\
If there is a join between table A and B, sum(B.col) is very likely equal to 0 when there is a record in A but not in B.

#### [leetcode_Q1934: Confirmation Rate](https://github.com/irenejiazhou/sql_manual/blob/main/aggregations/leetcode_Q1934.sql)
`ROUND(IFNULL(SUM()/COUNT(),0),2)`

#### [leetcode_Q1193: Monthly Transactions I](https://github.com/irenejiazhou/sql_manual/blob/main/aggregations/leetcode_Q1193_sum(case%20when).sql)
1. SUM(CASE WHEN) can be used in SQL to get result of SUMIF() in Excel.

2. SUM(state='approved') vs COUNT(state='approved')
   1) When state = 'approved', SUM(state='approved') = 1, and COUNT(state='approved') = 1.
   2) When state != 'approved', SUM(state='approved') = 0, but COUNT(state='approved') = 1.
   3) COUNT() cannot be used in COUNT(condition) because no matter the condition works or not, COUNT(1) and COUNT(0) both equals to 1.

#### [leetcode_Q1511: Customer Order Frequency](https://github.com/irenejiazhou/sql_manual/blob/main/aggregations/leetcode_Q1511_SUM(IF())_in_HAVING.sql)
```
HAVING SUM(IF(LEFT(order_date, 7) = '2020-06', quantity, 0) * price) >= 100
```

#### [leetcode_Q1126: Active Businesses](https://github.com/irenejiazhou/sql_manual/blob/main/aggregations/leetcode_Q1126_avg()over().sql)
```
AVG(occurences) OVER(PARTITION BY event_type)
```

#### [leetcode_Q1070: Product Sales Analysis III](https://github.com/irenejiazhou/sql_manual/blob/main/aggregations/leetcode_Q1070_first_record_of_all_products.sql)
Find the earliest record of product col_a (col_b is year).
```
WHERE(col_a, col_b) IN (SELECT col_a, MIN(col_b) FROM table GROUP BY col_a)
```
Typo ❌
```
WHERE(col_a, col_b) IN (SELECT (col_a, MIN(col_b)) FROM table GROUP BY col_a)
```

#### [leetcode_Q1393: Capital Gain/Loss](https://github.com/irenejiazhou/sql_manual/blob/main/aggregations/leetcode_Q1393_sum_by_type.sql)
```
SUM(CASE WHEN operation = 'Buy' THEN -price ELSE price END) AS capital_gain_loss
```

### Others
#### AVG(rating < 3) = SUM(rating < 3) / COUNT(rating)
For example, if the ratings are [1, 2, 3, 4, 5]:
   1) `SUM(rating < 3)` = 2 (because there are two values less than 3: 1 and 2)
   2) `COUNT(rating)` = 5 (because there are five ratings)
   3) `AVG(rating < 3)` = 2/5 = 0.4
  
#### Fill the NULL: COALESCE() vs IFNULL()

COALESCE and IFNULL are both functions in MySQL designed to handle NULL values. Their primary purpose is to provide a default value when the original data is NULL. Though they can be interchangeably used in many scenarios, there are some key distinctions:

1. Number of Arguments:\
COALESCE can take two or more arguments. It returns the first non-NULL value in the list of arguments. If all arguments are NULL, then COALESCE will also return NULL. For instance, ``COALESCE(NULL, NULL, 'third', 'fourth')`` would return 'third'.
IFNULL only takes two arguments. It returns the second argument if the first one is NULL, and returns the first argument if it's not NULL.
2. Type Casting:\
IFNULL will automatically cast the second argument to the same type as the first one before returning a non-NULL value. This can lead to data type conversions or truncations in certain scenarios.
COALESCE, on the other hand, does not perform this type of casting. This can make COALESCE more flexible when dealing with an argument list containing different data types.
