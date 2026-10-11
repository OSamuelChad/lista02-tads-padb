
\pset pager off
SET search_path TO lista01;

SELECT p.id, p.name, SUM(op.quantity) AS qtd_vendida
FROM orders_products op
JOIN orders   o ON o.id = op.order_id
JOIN products p ON p.id = op.product_id
WHERE o.status <> 'canceled'
GROUP BY p.id, p.name
ORDER BY qtd_vendida DESC, p.name
LIMIT 3;

SELECT p.id, p.name, SUM(op.quantity) AS qtd_vendida
FROM orders_products op
JOIN orders   o ON o.id = op.order_id
JOIN products p ON p.id = op.product_id
WHERE o.status <> 'canceled'
GROUP BY p.id, p.name
ORDER BY qtd_vendida DESC
FETCH FIRST 3 ROWS WITH TIES;
