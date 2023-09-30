"rows_cols_transformation" refers to the conversions between cols and rows based on some rules / categories (not simple pivot).

| SQL Script  | Desc | Related Function(s) / Method(s) |
| ----------- | ---- | ------------------- |
| [lc_1484](https://github.com/irenejiazhou/sql_manual/blob/main/rows_cols_transformation/leetcode_Q1484_group_list_by_date.sql)|rows → cols (cols ↑ rows ↓) | Aggregate + GROUP_CONCAT()|
| [lc_1661](https://github.com/irenejiazhou/sql_manual/blob/main/rows_cols_transformation/leetcode_Q1661_avg_of_2_categories.sql)|rows → cols (cols ↑ rows ↓) | JOIN or MAX(CASE WHEN) + a given enum field with <b>2</b> categories |
| [lc_1777](https://github.com/irenejiazhou/sql_manual/blob/main/rows_cols_transformation/leetcode_Q1777.sql)|rows → cols (cols ↑ rows ↓) | MAX(CASE WHEN) + a given enum field with <b>limited</b> categories |
| [lc_2252]()|rows → cols (cols ↑ rows ↓) | SUM(IF()) + a given enum field with <b>unfixed</b> categories |
| [lc_1783](https://github.com/irenejiazhou/sql_manual/blob/main/rows_cols_transformation/leetcode_Q1783_union_all.sql)|cols → rows (rows ↑ cols ↓) | UNION ALL + an user-defined enum field with <b>limited</b> categories |
