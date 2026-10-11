
\pset pager off
SET search_path TO lista01;

SELECT id, user_id,
       order_date AT TIME ZONE 'America/Fortaleza' AS order_date_local,
       status, total
FROM orders
WHERE order_date >= now() - interval '30 days'
ORDER BY order_date DESC;
