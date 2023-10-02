#### [leetcode_Q1364: Number of Trusted Contacts of a Customer](https://github.com/irenejiazhou/sql_manual/blob/main/conditional_labeling/leetcode_Q1364.sql)

1. `col_a IN (SELECT col_b FROM tbl)`\
The result of this expression is 1 or 0 which can be used like `sum(col_a IN (SELECT col_b FROM tbl))`.
2. `IFNULL(SUM(contact_email IN (SELECT email FROM customers)),0) AS trusted_contacts_cnt`


#### [leetcode_Q1907: Count Salary Categories](https://github.com/irenejiazhou/sql_manual/blob/main/conditional_labeling/leetcode_Q1907.sql)
#### [leetcode_Q1435: Create a Session Bar Chart](https://github.com/irenejiazhou/sql_manual/blob/main/conditional_labeling/leetcode_Q1435.sql)
Aggregate and label, then UNION to avoid no record in the source table meet the criteria of the label category.


