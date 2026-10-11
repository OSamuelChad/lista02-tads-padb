
\pset pager off


DROP INDEX IF EXISTS idx_payment_customer_date;

CREATE INDEX idx_payment_customer_date
    ON payment (customer_id, payment_date DESC);

ANALYZE payment;

EXPLAIN ANALYZE
SELECT *
FROM payment
WHERE customer_id = 341
ORDER BY payment_date DESC;

SET enable_bitmapscan = off;
EXPLAIN ANALYZE
SELECT *
FROM payment
WHERE customer_id = 341
ORDER BY payment_date DESC;
RESET enable_bitmapscan;
