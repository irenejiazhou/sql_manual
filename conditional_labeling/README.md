Q1484 in rows_cols_transformation


col_a IN (SELECT col_b FROM tbl)
-- the result of this expression is 1 or 0 which can be used like sum(col_a IN (SELECT col_b FROM tbl))
