
\pset pager off
SET search_path TO lista01;

BEGIN;

DELETE FROM products
WHERE name ILIKE '%macbook%'
RETURNING id, name, price;

ROLLBACK;
