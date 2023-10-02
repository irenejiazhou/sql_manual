SELECT 
  ROW_NUMBER() OVER(ORDER BY your_order_column) AS row_num, 
  FLOOR((ROW_NUMBER() OVER(ORDER BY your_order_column) - 1) / 7) AS group_num, 
  your_columns 
FROM 
  your_table;

/*
FLOOR():
FLOOR() is a mathematical function in SQL used to round down to the nearest whole number. 
FLOOR((ROW_NUMBER() OVER(ORDER BY your_order_column) - 1) / 7):
This expression is utilized to categorize every row into groups of 7. 
Let's understand this step-by-step:
- Subtract 1 from the row number.
- Divide the result by 7.
- Round down to get the group number.
This means every set of 7 rows will belong to the same group. The grouping starts at 0 and increases by 1 for every 7 row.
*/
