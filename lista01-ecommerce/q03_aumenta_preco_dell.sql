
\pset pager off
SET search_path TO lista01;

BEGIN;

SELECT id, name, price AS preco_antes
FROM products
WHERE name ILIKE '%dell%';

UPDATE products
SET price = ROUND(price * 1.10, 2)
WHERE name ILIKE '%dell%'
RETURNING id, name, price AS preco_depois;

ROLLBACK;
