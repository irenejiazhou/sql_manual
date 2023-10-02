
#### [leetcode_Q1322: Click-Through Rate (CTR)](https://github.com/irenejiazhou/sql_manual/blob/main/common_metrics/leetcode_Q1322_CTR.sql)

<img src="https://github.com/irenejiazhou/sql_manual/blob/main/images/q1322_ctr.png"  width="80%" height="80%">

#### Three Types of Sales Funnels

Taking the sales process of `Opportunity → Store Visit → Test Drive → Order → Delivery` as an example:

1. <b>Top-Down</b>: Linking an opportunity from March to its corresponding store visit in April and so forth.
2. <b>Bottom-Up</b>: Given a delivery record in April, trace it back to find the corresponding store visit, test drive, and opportunity.
3. <b>Overall View for a Specific Time Period</b>: Look at all the data for a specific period, e.g., all opportunities in April, all test drives in April, etc.

For the first two types, some logic is required to associate each stage in the sales funnel to track the downstream impact of an opportunity accurately. In contrast, the third type focuses on aggregate-level data, not requiring tracking with granularity down to each individual opportunity; hence, there's no need to detail the data.
