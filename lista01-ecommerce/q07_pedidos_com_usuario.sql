
\pset pager off
SET search_path TO lista01;

SELECT o.id AS pedido_id, u.name AS usuario, o.order_date, o.status, o.total
FROM orders o
JOIN users u ON u.id = o.user_id
ORDER BY o.id;
