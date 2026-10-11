
\pset pager off
SET search_path TO lista01;

BEGIN;

DELETE FROM products
WHERE id = (
    SELECT p.id
    FROM products p
    WHERE NOT EXISTS (
        SELECT 1 FROM orders_products op WHERE op.product_id = p.id
    )
    ORDER BY p.id
    LIMIT 1
)
RETURNING id, name;

ROLLBACK;
