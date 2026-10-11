
\pset pager off
SET search_path TO lista01;

SELECT u.id AS usuario_id, u.name, o.id AS pedido_id, o.order_date, o.status, o.total
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
ORDER BY u.id, o.order_date;
