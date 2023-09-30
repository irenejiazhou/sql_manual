1. If using name instead of id as the final result, always assume there is some people having the same name.

2. When counting something, make sure:
   1) if we need to DISTINCT first before counting or not
   2) what is the field or the combination of fields needed to be counted

3. If there is no primary key or unique combination of fields in the source tables or in the result table, always remember to DISTINCT at the end.
   
4. When using the same field (e.g. coupon code) to connect tables from different systems (databases), if there is any missing joins:
   1) one system added tab in front of or at the end of the field text. 
      ```
      SELECT *
      FROM a
      JOIN b ON REPLACE(b.coupon_code, CHR(9), '') = a.coupon_code
                -- Change tab CHR(9) to ''
      ```
   2) one system added space(s) in front of or at the end of the field text. 
      ```
      SELECT *
      FROM a
      JOIN b ON TRIM(b.coupon_code) = a.coupon_code
                -- Removes spaces from the start and end of the string
      ```

