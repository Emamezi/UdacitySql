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

/*Selecting designated columns from two tables*/
SELECT orders.standard_qty, orders.poster_qty, orders.gloss_qty,accounts.primary_poc, accounts.website
FROM orders
JOIN accounts ON orders.id=accounts.id;

/* Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each even*/
SELECT a.name, we.occurred_at, we.channel, a.primary_poc
FROM web_events we
JOIN accounts a ON a.id=we.account_id
WHERE a.name='Walmart';

/*Genrating a table that contains region for each sales_rep along with associated accounts*/
SELECT r.name as region, 
  sr.name AS rep_name, 
  a.name AS account_name
FROM sales_reps sr
JOIN region r ON r.id=sr.region_id
JOIN accounts a ON sr.id=a.sales_rep_id
  ORDER BY a.name;

/* Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region*/
SELECT r.name as region_name, sr.name AS sales_rep_name, a.name AS account_name
FROM accounts a
JOIN sales_reps sr 
ON a.sales_rep_id=sr.id
JOIN region r 
ON sr.region_id=r.id 
WHERE r.name='Midwest'
ORDER BY a.name ASC;

/* Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order.
However, you should only provide the results if the standard order quantity exceeds 100*/
SELECT r.name AS region_name, a.name AS account_name, (total_amt_usd/(total+0.01)) AS unit_price, o.standard_qty
FROM orders o                                                           
JOIN accounts a 
ON o.account_id=a.id
JOIN sales_reps sr 
ON a.sales_rep_id =sr.id
JOIN region r 
ON sr.region_id=r.id
WHERE o.standard_qty>100;  

/* Which account (by name) placed the earliest order?*/
SELECT a.name,o.occurred_at
FROM accounts a
JOIN orders o ON o.account_id=a.id
ORDER BY o.occurred_at ASC
LIMIT 1

/*Total sales for each account*/
SELECT a.name,SUM(o.total_amt_usd) total_sales
FROM accounts a
JOIN orders o ON o.account_id=a.id
GROUP BY a.name;

SELECT w.occurred_at latest, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id=a.id
ORDER BY latest DESC
LIMIT 1;

/*Whcih marketings channel brings in the most revenue and how often is it patronized*/
SELECT w.channel, COUNT(*) as count, SUM(o.total_amt_usd) AS revenue
FROM web_events w
JOIN accounts a
ON w.account_id=a.id
JOIN orders o
ON o.account_id=a.id
GROUP BY w.channel;

/* primary contact associated with the earliest web_event*/
select a.primary_poc
FROM accounts a
JOIN web_events w
ON w.account_id=a.id
ORDER BY w.occurred_at ASC
LIMIT 1;

/*Smallest order placed by each account*/
SELECT a.name, MIN(o.total_amt_usd) as smallest_order
FROM accounts a
JOIN orders o
ON o.account_id=a.id
GROUP BY a.name
ORDER BY smallest_order;

/*Number of sales reps in each region*/
SELECT r.name, COUNT(*) rep_count
FROM region r
JOIN sales_reps s
ON r.id=s.region_id
GROUP BY r.name
ORDER BY rep_count;

/* he number of times a particular channel was used in the web_events table for each sales rep*/
SELECT w.channel,s.name, count(*) num_events
FROM web_events w
JOIN accounts a ON w.account_id=a.id
JOIN sales_reps s ON a.sales_rep_id=s.id
GROUP BY w.channel, s.name
ORDER BY num_events DESC;

/*Have any sales reps worked on more than one account*/
SELECT  s.id sales_id, s.name sales_name, count(*) num_acc
FROM accounts a
JOIN sales_reps s ON a.sales_rep_id=s.id
GROUP BY sales_id,sales_name
ORDER BY num_acc ;

/*How many of the sales reps have more than 5 accounts that they manage*/
SELECT a.sales_rep_id sales, count(*) num_acc
FROM accounts a
JOIN sales_reps s ON a.sales_rep_id=s.id
GROUP BY sales 
HAVING count(*)>5
ORDER BY num_acc ASC;

/*Accounts that have more orders than 20*/
SELECT a.name, o.account_id, count(*)
FROM accounts a
JOIN orders o ON o.account_id=a.id
GROUP BY a.name, o.account_id
HAVING count(*)>20
ORDER BY a.name ASC;

/*Account witht the most orders*/
SELECT a.name, o.account_id, count(*) order_count
FROM accounts a
JOIN orders o ON o.account_id=a.id
GROUP BY a.name, o.account_id
ORDER BY order_count DESC
LIMIT 1;

/*How many account spend more than 30000 on orders*/
SELECT a.name, o.account_id, SUM(total_amt_usd) sum_amt
FROM accounts a
JOIN orders o ON o.account_id=a.id
GROUP BY a.name, o.account_id
HAVING SUM(total_amt_usd)>30000
ORDER BY sum_amt;

/*Which account has spent the most with the company*/
SELECT a.name, o.account_id, SUM(total_amt_usd) sum_amt
FROM accounts a
JOIN orders o ON o.account_id=a.id
GROUP BY a.name, o.account_id
ORDER BY sum_amt DESC
LIMIT 1;

/*which accounts used facebook as a channel to contact customers more than 6 times*/
SELECT a.name as name, w.channel chan, count(*) channel_count
FROM accounts a
JOIN web_events w  ON w.account_id=a.id
GROUP BY a.name, w.channel
HAVING count(*)>6 AND w.channel='facebook'
ORDER BY channel_count;
