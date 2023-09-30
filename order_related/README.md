"O" refers to questions that order an entity (some entities) by an attribute (some attributes) which is continuous, like time, year, id, etc.

| SQL Script  | Order By | Special Join Cons: Comparison/col_x=col_x±n | LEAD()/LAG() | ROW_NUM/RANK | SUM()OVER() |
| ----------- | ---- | :------------------: | :----------: | :----------: | :----------: |
| [practice_1](https://github.com/irenejiazhou/sql_manual/blob/main/order_related/practice_1_yoy_continuous_revenue_growth.sql)|year||✅||
| [lc_2292](https://github.com/irenejiazhou/sql_manual/blob/main/order_related/leetcode_Q2292_purchase_in_consecutive_years.sql)|year|✅|||
| [lc_1454](https://github.com/irenejiazhou/sql_manual/blob/main/order_related/leetcode_Q1454_retention_active_users.sql)|date|||✅|
| [lc_2142](https://github.com/irenejiazhou/sql_manual/blob/main/order_related/leetcode_Q2142_order_by_time.sql)|time|✅|||
| [lc_1285](https://github.com/irenejiazhou/sql_manual/blob/main/order_related/leetcode_Q1285_continuous_ranges.sql)|id|✅||✅|
| [lc_603](https://github.com/irenejiazhou/sql_manual/blob/main/order_related/leetcode_Q603_consecutive_ranges.sql)|id|✅|✅||
| [lc_1811](https://github.com/irenejiazhou/sql_manual/blob/main/order_related/leetcode_Q1811_medals_in_continuous_contests.sql)|id|||✅|
