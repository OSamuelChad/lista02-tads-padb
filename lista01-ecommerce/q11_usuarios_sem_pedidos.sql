
\pset pager off
SET search_path TO lista01;

SELECT u.id, u.name, u.email
FROM users u
WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE o.user_id = u.id)
ORDER BY u.id;
