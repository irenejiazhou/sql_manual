count(case when xxx then 1 else null end) is faster than sum(case when xxx then 1 else 0 end)
