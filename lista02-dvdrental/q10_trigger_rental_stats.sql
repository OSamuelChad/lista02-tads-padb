
\pset pager off


CREATE TABLE IF NOT EXISTS customer_rental_stats (
    customer_id   INTEGER PRIMARY KEY REFERENCES customer (customer_id),
    total_rentals INT NOT NULL DEFAULT 0
);

INSERT INTO customer_rental_stats (customer_id, total_rentals)
SELECT c.customer_id, COUNT(r.rental_id)
FROM customer c
LEFT JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id
ON CONFLICT (customer_id)
DO UPDATE SET total_rentals = EXCLUDED.total_rentals;

CREATE OR REPLACE FUNCTION fn_incrementa_customer_rental_stats()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO customer_rental_stats (customer_id, total_rentals)
    VALUES (NEW.customer_id, 1)
    ON CONFLICT (customer_id)
    DO UPDATE SET total_rentals = customer_rental_stats.total_rentals + 1;

    RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS trg_incrementa_customer_rental_stats ON rental;

CREATE TRIGGER trg_incrementa_customer_rental_stats
AFTER INSERT ON rental
FOR EACH ROW
EXECUTE FUNCTION fn_incrementa_customer_rental_stats();

SELECT COUNT(*) AS divergencias
FROM customer_rental_stats s
JOIN (SELECT customer_id, COUNT(*) AS qtd FROM rental GROUP BY customer_id) r
  ON r.customer_id = s.customer_id
WHERE r.qtd <> s.total_rentals;

BEGIN;
SELECT customer_id, total_rentals AS antes
FROM customer_rental_stats WHERE customer_id = 1;

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (now(), 1, 1, 1);

SELECT customer_id, total_rentals AS depois
FROM customer_rental_stats WHERE customer_id = 1;
ROLLBACK;

BEGIN;
INSERT INTO customer (store_id, first_name, last_name, email, address_id)
VALUES (1, 'Novo', 'Cliente', 'novo.cliente@sakilacustomer.org', 1)
RETURNING customer_id AS novo_customer_id \gset

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (now(), 1, :novo_customer_id, 1);

SELECT * FROM customer_rental_stats WHERE customer_id = :novo_customer_id;
ROLLBACK;
