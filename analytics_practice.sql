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
