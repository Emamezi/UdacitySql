#selecting the earliest 10 orders
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at DESC
LIMIT 10;
