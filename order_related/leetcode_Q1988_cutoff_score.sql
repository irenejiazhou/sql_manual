-- MEDIUM Q1988: Find Cutoff Score for Each School
/*
Table: Schools
+-------------+------+
| Column Name | Type |
+-------------+------+
| school_id   | int  |  PK
| capacity    | int  |
+-------------+------+
This table contains information about the capacity of some schools. The capacity is the maximum number of students the school can accept.
Table: Exam
+---------------+------+
| Column Name   | Type |
+---------------+------+
| score         | int  |  PK
| student_count | int  |
+---------------+------+
Each row in this table indicates that there are student_count students that got AT LEAST score points in the exam.
The data in this table will be logically correct, meaning a row recording a higher score will have the same or smaller student_count compared to a row recording a lower score. More formally, for every two rows i and j in the table, if scorei > scorej then student_counti <= student_countj.
 

Every year, each school announces a minimum score requirement that a student needs to apply to it. The school chooses the minimum score requirement based on the exam results of all the students:

They want to ensure that even if every student meeting the requirement applies, the school can accept everyone. They also want to maximize the possible number of students that can apply.
They must use a score that is in the Exam table.
Write an SQL query to report the minimum score requirement for each school. 
If there are multiple score values satisfying the above conditions, choose the smallest one. 
If the input data is not enough to determine the score, report -1.

Return the result table in any order.

The query result format is in the following example.
Input:
Schools table:
+-----------+----------+
| school_id | capacity |
+-----------+----------+
| 11        | 151      |
| 5         | 48       |
| 9         | 9        |
| 10        | 99       |
+-----------+----------+
Exam table:
+-------+---------------+
| score | student_count |
+-------+---------------+
| 975   | 10            |
| 966   | 60            |
| 844   | 76            |
| 749   | 76            |
| 744   | 100           |
+-------+---------------+
Output:
+-----------+-------+
| school_id | score |
+-----------+-------+
| 5         | 975   |
| 9         | -1    |
| 10        | 749   |
| 11        | 744   |
+-----------+-------+
Explanation: 
- School 5: The school's capacity is 48. Choosing 975 as the min score requirement, the school will get at most 10 applications, which is within capacity.
- School 10: The school's capacity is 99. Choosing 844 or 749 as the min score requirement, the school will get at most 76 applications, which is within capacity. We choose the smallest of them, which is 749.
- School 11: The school's capacity is 151. Choosing 744 as the min score requirement, the school will get at most 100 applications, which is within capacity.
- School 9: The data given is not enough to determine the min score requirement. Choosing 975 as the min score, the school may get 10 requests while its capacity is 9. We do not have information about higher scores, hence we report -1.
*/
/*
Exam table 实际上是一个accumulated_student_count，
因为每一个student_count都是students that got AT LEAST this score。
也就是说，这个表并不是score的分布情况，而是一个按分数累计的汇总表。
+------------+---------------+-----------------+
| score_rank | student_count | acc_student_cnt |
+------------+---------------+-----------------+
| [975,966)  | 10            | 10              |
| [966,844)  | 50            | 60              |
| [844,749)  | 16            | 76              |
| [749,744)  | 0             | 76              |
| [744,0]    | 24            | 100             |
+------------+---------------+-----------------+
*/
SELECT school_id, IFNULL(MIN(score),-1) AS score
FROM schools s
LEFT JOIN exam e
			 ON s.capacity >= student_count
GROUP BY school_id
ORDER BY score DESC;
