col_a IN (SELECT col_b FROM tbl)
-- the result is 1 or 0 which can be used like sum(col_a IN (SELECT col_b FROM tbl))

-- MEDIUM Q1364: Number of Trusted Contacts of a Customer
/*
Table: Customers
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |  PK
| customer_name | varchar |
| email         | varchar |
+---------------+---------+
Each row of this table contains the name and the email of a customer of an online shop.
Table: Contacts
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | id      |  PK
| contact_name  | varchar |
| contact_email | varchar |  PK
+---------------+---------+
Each row of this table contains the name and email of one contact of customer with user_id.
This table contains information about people each customer trust. 
The contact may or may not exist in the Customers table.
Table: Invoices
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| invoice_id   | int     |  PK
| price        | int     |
| user_id      | int     |
+--------------+---------+
Each row of this table indicates that user_id has an invoice with invoice_id and a price.
 
Write an SQL query to find the following for each invoice_id:
1. customer_name: The name of the customer the invoice is related to.
2. price: The price of the invoice.
3. contacts_cnt: The number of contacts related to the customer.
4. trusted_contacts_cnt: The number of contacts related to the customer and at the same time they are customers to the shop. 
   (i.e their email exists in the Customers table.)
Return the result table ordered by invoice_id.

The query result format is in the following example.
Input: 
Customers table:
+-------------+---------------+--------------------+
| customer_id | customer_name | email              |
+-------------+---------------+--------------------+
| 1           | Alice         | alice@leetcode.com |
| 2           | Bob           | bob@leetcode.com   |
| 13          | John          | john@leetcode.com  |
| 6           | Alex          | alex@leetcode.com  |
+-------------+---------------+--------------------+
Contacts table:
+-------------+--------------+--------------------+
| user_id     | contact_name | contact_email      |
+-------------+--------------+--------------------+
| 1           | Bob          | bob@leetcode.com   |
| 1           | John         | john@leetcode.com  |
| 1           | Jal          | jal@leetcode.com   |
| 2           | Omar         | omar@leetcode.com  |
| 2           | Meir         | meir@leetcode.com  |
| 6           | Alice        | alice@leetcode.com |
+-------------+--------------+--------------------+
Invoices table:
+------------+-------+---------+
| invoice_id | price | user_id |
+------------+-------+---------+
| 77         | 100   | 1       |
| 88         | 200   | 1       |
| 99         | 300   | 2       |
| 66         | 400   | 2       |
| 55         | 500   | 13      |
| 44         | 60    | 6       |
+------------+-------+---------+
Output: 
+------------+---------------+-------+--------------+----------------------+
| invoice_id | customer_name | price | contacts_cnt | trusted_contacts_cnt |
+------------+---------------+-------+--------------+----------------------+
| 44         | Alex          | 60    | 1            | 1                    |
| 55         | John          | 500   | 0            | 0                    |
| 66         | Bob           | 400   | 2            | 0                    |
| 77         | Alice         | 100   | 3            | 2                    |
| 88         | Alice         | 200   | 3            | 2                    |
| 99         | Bob           | 300   | 2            | 0                    |
+------------+---------------+-------+--------------+----------------------+
Explanation: 
Alice has three contacts, two of them are trusted contacts (Bob and John).
Bob has two contacts, none of them is a trusted contact.
Alex has one contact and it is a trusted contact (Alice).
John doesn't have any contacts.
*/
WITH c AS (
  SELECT customer_id, customer_name, COUNT(user_id) AS contacts_cnt, 
         IFNULL(SUM(contact_email IN (SELECT email FROM customers)),0) AS trusted_contacts_cnt
  FROM customers cu
  LEFT JOIN contacts c1
         ON cu.customer_id = c1.user_id
  GROUP BY customer_id, customer_name)
/*
| customer_id | customer_name | contacts_cnt | trusted_contacts_cnt |
| ----------- | ------------- | ------------ | -------------------- |
| 1           | Alice         | 3            | 2                    |
| 2           | Bob           | 2            | 0                    |
| 13          | John          | 0            | 0                    |
| 6           | Alex          | 1            | 1                    |*/
SELECT invoice_id, customer_name, price, contacts_cnt, trusted_contacts_cnt
FROM invoices i
LEFT JOIN c
       ON i.user_id = c.customer_id
ORDER BY invoice_id;
