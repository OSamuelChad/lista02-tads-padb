
\pset pager off


CREATE OR REPLACE FUNCTION fn_valida_datas_rental()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.return_date IS NOT NULL AND NEW.return_date < NEW.rental_date THEN
        RAISE EXCEPTION
            'Data de devolução (%) não pode ser anterior à data de locação (%).',
            NEW.return_date, NEW.rental_date
            USING ERRCODE = 'check_violation';
    END IF;

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_valida_datas_rental ON rental;

CREATE TRIGGER trg_valida_datas_rental
BEFORE INSERT OR UPDATE ON rental
FOR EACH ROW
EXECUTE FUNCTION fn_valida_datas_rental();

BEGIN;
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES ('2026-10-01 10:00', 1, 1, '2026-10-05 10:00', 1)
RETURNING rental_id, rental_date, return_date;
ROLLBACK;

BEGIN;
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES ('2026-10-01 10:00', 1, 1, NULL, 1)
RETURNING rental_id, rental_date, return_date;
ROLLBACK;

BEGIN;
INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES ('2026-10-05 10:00', 1, 1, '2026-10-01 10:00', 1);
ROLLBACK;

BEGIN;
UPDATE rental
SET return_date = rental_date - INTERVAL '1 day'
WHERE rental_id = 1;
ROLLBACK;
