
\pset pager off


DROP INDEX IF EXISTS idx_customer_email_lower;

CREATE INDEX idx_customer_email_lower
    ON customer (LOWER(email));

ANALYZE customer;

EXPLAIN ANALYZE
SELECT customer_id, first_name, last_name, email
FROM customer
WHERE LOWER(email) = LOWER('MARY.SMITH@sakilacustomer.org');

SELECT customer_id, first_name, last_name, email
FROM customer
WHERE LOWER(email) = LOWER('MARY.SMITH@sakilacustomer.org');
