#### [leetcode_Q1205: Monthly Transactions II](https://github.com/irenejiazhou/sql_manual/blob/main/rows_cols_transformation/leetcode_Q1205.sql)
count(case when xxx then 1 else null end) is faster than sum(case when xxx then 1 else 0 end)
