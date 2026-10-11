
\pset pager off


CREATE TABLE IF NOT EXISTS film_cost_audit (
    audit_id   SERIAL PRIMARY KEY,
    film_id    INTEGER       NOT NULL REFERENCES film (film_id),
    old_cost   NUMERIC(5,2),
    new_cost   NUMERIC(5,2),
    changed_at TIMESTAMP     NOT NULL DEFAULT now()
);

CREATE OR REPLACE FUNCTION fn_audita_replacement_cost()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO film_cost_audit (film_id, old_cost, new_cost, changed_at)
    VALUES (NEW.film_id, OLD.replacement_cost, NEW.replacement_cost, now());

    RETURN NULL;  -- valor de retorno é ignorado em triggers AFTER
END;
$$;

DROP TRIGGER IF EXISTS trg_audita_replacement_cost ON film;

CREATE TRIGGER trg_audita_replacement_cost
AFTER UPDATE ON film
FOR EACH ROW
WHEN (OLD.replacement_cost IS DISTINCT FROM NEW.replacement_cost)
EXECUTE FUNCTION fn_audita_replacement_cost();

BEGIN;
UPDATE film SET rental_rate = rental_rate WHERE film_id = 1;
UPDATE film SET replacement_cost = replacement_cost WHERE film_id = 1;
UPDATE film SET replacement_cost = replacement_cost + 5 WHERE film_id = 1;

SELECT * FROM film_cost_audit WHERE film_id = 1;
ROLLBACK;
