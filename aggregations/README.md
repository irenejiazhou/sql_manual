#### [leetcode_Q1322: Click-Through Rate (CTR)](https://github.com/irenejiazhou/sql_manual/blob/main/common_metrics/leetcode_Q1322_CTR.sql)
<b>ROUND(IFNULL(SUM()/SUM()*100,0),2)</b> \
For rates: <b>result * 100 before ROUND()</b>

<img src="https://github.com/irenejiazhou/sql_manual/blob/main/images/q1322_ctr.png"  width="80%" height="80%">


#### [leetcode_Q1142: User Activity for the Past 30 Days II](https://github.com/irenejiazhou/sql_manual/blob/main/aggregations/leetcode_Q1142_ifnull_for_0_in_denominator.sql)
CASE WHEN or IFNULL() \
For COUNT() in the denominator: always prevent the situation where COUNT() = 0.\
If there is a join between table A and B, sum(B.col) is very likely equal to 0 when there is a record in A but not in B.

#### [leetcode_Q1934: Confirmation Rate](https://github.com/irenejiazhou/sql_manual/blob/main/aggregations/leetcode_Q1934.sql)
<b>ROUND(IFNULL(SUM()/COUNT(),0),2)</b>

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
