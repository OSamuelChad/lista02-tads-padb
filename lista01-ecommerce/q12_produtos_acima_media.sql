
\pset pager off
SET search_path TO lista01;

SELECT id, name, price,
       (SELECT ROUND(AVG(price), 2) FROM products) AS preco_medio
FROM products
WHERE price > (SELECT AVG(price) FROM products)
ORDER BY price DESC;
