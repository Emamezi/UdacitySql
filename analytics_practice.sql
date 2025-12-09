/*selecting the earliest 10 orders*/
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at DESC
LIMIT 10;

/*Top 5 orders in terms of largest total_amt_usd*/
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

/*Lowest 20 orders in terms of total amount in usd*/
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY total_amt_usd 
LIMIT 20;

/*Filerting the orders table for the first 5 entries where glooss amount is grater than or equal to 1000*/
SELECT *
FROM orders
WHERE gloss_amt_usd>=1000
LIMIT 5;


SELECT id, account_id,standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;

/*percentage of revenue that comes from poster paper for each order*/
SELECT id, account_id, (poster_amt_usd/total_amt_usd)*100 AS percentage_revenue
FROM orders
LIMIT 10;

/*Filtering the accounts table for compnany names that have one included*/
SELECT * 
FROM accounts
WHERE name LIKE '%one%';

/*Filtering the accounts table for compnany names that dont start with C and end with and S*/
SELECT *
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%S';

/*Finding all web events in the year 2016 which channel is organic or adwords*/
SELECT *
FROM web_events
WHERE channel IN ('organic','adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01' 
ORDER BY occurred_at DESC;

/* list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000 */
SELECT *
FROM orders
WHERE standard_qty=0 AND (gloss_qty>1000 OR poster_qty>1000);

/* Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'*/
SELECT name
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') 
AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND primary_poc NOT LIKE '%eana%');
