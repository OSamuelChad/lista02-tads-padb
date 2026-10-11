
\pset pager off
SET search_path TO lista01;

SELECT
    u.id,
    u.name,
    COUNT(o.id)                                                    AS qtd_pedidos,
    COALESCE(SUM(o.total) FILTER (WHERE o.status <> 'canceled'), 0) AS valor_total_comprado
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
GROUP BY u.id, u.name
ORDER BY valor_total_comprado DESC, u.name;
