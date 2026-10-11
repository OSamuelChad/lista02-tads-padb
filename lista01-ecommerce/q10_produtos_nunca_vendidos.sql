
\pset pager off
SET search_path TO lista01;

SELECT p.id, p.name, p.price
FROM products p
WHERE NOT EXISTS (
    SELECT 1 FROM orders_products op WHERE op.product_id = p.id
)
ORDER BY p.id;
