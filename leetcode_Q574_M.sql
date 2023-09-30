-- MEDIUM Q574
/*
Table: Candidate
+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| id          | int      |  PK
| name        | varchar  |
+-------------+----------+
Each row of this table contains information about the id and the name of a candidate.

Table: Vote
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |  PK
| candidateId | int  |  FK [Candidate]
+-------------+------+
Each row of this table determines the candidate who got the ith vote in the elections.

Write an SQL query to report the name of the winning candidate 
(i.e., the candidate who got the largest number of votes).

The test cases are generated so that exactly one candidate wins the elections.

The query result format is in the following example.
Input: 
Candidate table:
+----+------+
| id | name |
+----+------+
| 1  | A    |
| 2  | B    |
| 3  | C    |
| 4  | D    |
| 5  | E    |
+----+------+
Vote table:
+----+-------------+
| id | candidateId |
+----+-------------+
| 1  | 2           |
| 2  | 4           |
| 3  | 3           |
| 4  | 2           |
| 5  | 5           |
+----+-------------+
Output: 
+------+
| name |
+------+
| B    |
+------+
Explanation: 
Candidate B has 2 votes. Candidates C, D, and E have 1 vote each.
The winner is candidate B.
*/

WITH vote AS (SELECT candidateId, count(id) AS vote_cnt
			  FROM Q574_Vote
			  GROUP BY candidateId)
SELECT name
FROM vote v
LEFT JOIN Q574_Candidate c
	   ON c.id = v.candidateId
-- WHERE vote_cnt = (SELECT max(vote_cnt) FROM vote);
ORDER BY vote_cnt DESC
LIMIT 1;





















