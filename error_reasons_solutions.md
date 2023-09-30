1. If using name instead of id as the final result, always assume there is some people having the same name.

2. When counting something, make sure:
   1) if we need to DISTINCT first before counting or not
   2) what is the field or the combination of fields needed to be counted

3. If there is no primary key or unique combination of fields in the source tables or in the result table, always remember to DISTINCT at the end.
