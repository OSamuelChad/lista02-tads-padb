
\pset pager off
SET search_path TO lista01;

SELECT u.id, u.name, COUNT(o.id) AS qtd_pedidos
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
GROUP BY u.id, u.name
ORDER BY qtd_pedidos DESC, u.name;
