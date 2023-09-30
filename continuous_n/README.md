"Continous N" refers to questions that order an entity (some entities) by an attribute (some attributes) which is continuous, like time, year, id, etc.

| SQL Script  | desc | special join conditions: comparison / col_x=col_x±n | lead()/lag() | row_num/rank |
| ----------- | ---- | :------------------: | :----------: | :----------: |
| [practice_1](https://github.com/irenejiazhou/sql_manual/blob/main/continuous_n/practice_1_yoy_continuous_revenue_growth.sql)|order by year||✅||
| [leetcode_Q2292](https://github.com/irenejiazhou/sql_manual/blob/main/continuous_n/leetcode_Q2292_purchase_in_consecutive_years.sql)|order by year|✅|||
| [leetcode_Q1454](https://github.com/irenejiazhou/sql_manual/blob/main/continuous_n/leetcode_Q1454_retention_active_users.sql)|order by date|||✅|
| [leetcode_Q2142](https://github.com/irenejiazhou/sql_manual/blob/main/continuous_n/leetcode_Q2142_order_by_time.sql)|order by time|✅|||
| [leetcode_Q1285](https://github.com/irenejiazhou/sql_manual/blob/main/continuous_n/leetcode_Q1285_continuous_ranges.sql)|order by id|✅||✅|
| [leetcode_Q603](https://github.com/irenejiazhou/sql_manual/blob/main/continuous_n/leetcode_Q603_consecutive_ranges.sql)|order by id|✅|✅||
