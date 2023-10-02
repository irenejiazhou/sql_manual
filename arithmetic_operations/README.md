#### Fill the NULL: COALESCE() vs IFNULL()

COALESCE and IFNULL are both functions in MySQL designed to handle NULL values. Their primary purpose is to provide a default value when the original data is NULL. Though they can be interchangeably used in many scenarios, there are some key distinctions:

1. Number of Arguments:\
COALESCE can take two or more arguments. It returns the first non-NULL value in the list of arguments. If all arguments are NULL, then COALESCE will also return NULL. For instance, ``COALESCE(NULL, NULL, 'third', 'fourth')`` would return 'third'.
IFNULL only takes two arguments. It returns the second argument if the first one is NULL, and returns the first argument if it's not NULL.
2. Type Casting:\
IFNULL will automatically cast the second argument to the same type as the first one before returning a non-NULL value. This can lead to data type conversions or truncations in certain scenarios.
COALESCE, on the other hand, does not perform this type of casting. This can make COALESCE more flexible when dealing with an argument list containing different data types.

#### 
