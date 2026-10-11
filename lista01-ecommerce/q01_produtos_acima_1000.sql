
\pset pager off
SET search_path TO lista01;

SELECT id, name, price
FROM products
WHERE price > 1000
ORDER BY price;
