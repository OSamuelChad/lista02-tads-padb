
\pset pager off


DROP INDEX IF EXISTS idx_rental_em_aberto;

CREATE INDEX idx_rental_em_aberto
    ON rental (rental_date)
    WHERE return_date IS NULL;

ANALYZE rental;

EXPLAIN ANALYZE
SELECT rental_id, customer_id, inventory_id, rental_date
FROM rental
WHERE return_date IS NULL
ORDER BY rental_date;

SELECT relname, pg_size_pretty(pg_relation_size(oid)) AS tamanho
FROM pg_class
WHERE relname IN ('idx_rental_em_aberto', 'rental_pkey');
