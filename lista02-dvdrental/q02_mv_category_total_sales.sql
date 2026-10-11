
\pset pager off


DROP MATERIALIZED VIEW IF EXISTS mv_category_total_sales;

CREATE MATERIALIZED VIEW mv_category_total_sales AS
SELECT
    c.category_id,
    c.name          AS categoria,
    SUM(p.amount)   AS receita_total
FROM category c
JOIN film_category fc ON fc.category_id = c.category_id
JOIN inventory     i  ON i.film_id      = fc.film_id
JOIN rental        r  ON r.inventory_id = i.inventory_id
JOIN payment       p  ON p.rental_id    = r.rental_id
GROUP BY c.category_id, c.name;

CREATE UNIQUE INDEX ux_mv_category_total_sales_category_id
    ON mv_category_total_sales (category_id);

REFRESH MATERIALIZED VIEW CONCURRENTLY mv_category_total_sales;

SELECT categoria, receita_total
FROM mv_category_total_sales
ORDER BY receita_total DESC;
