#### [leetcode_Q1322: Click-Through Rate (CTR)](https://github.com/irenejiazhou/sql_manual/blob/main/common_metrics/leetcode_Q1322_CTR.sql)
<b>ROUND(IFNULL(result*100,0))</b> \
For rates: <b>result * 100 before ROUND()</b>

<img src="https://github.com/irenejiazhou/sql_manual/blob/main/images/q1322_ctr.png"  width="80%" height="80%">


#### [leetcode_Q1142: User Activity for the Past 30 Days II](https://github.com/irenejiazhou/sql_manual/blob/main/aggregations/leetcode_Q1142_ifnull_for_0_in_denominator.sql)
CASE WHEN or IFNULL() \
For COUNT() in the denominator: always prevent the situation where COUNT() = 0.
