
\pset pager off

ALTER TABLE film
    ADD COLUMN IF NOT EXISTS original_language_id SMALLINT
    REFERENCES language (language_id);

CREATE OR REPLACE FUNCTION fn_protege_language()
RETURNS trigger
LANGUAGE plpgsql
AS $$
DECLARE
    v_qtd_filmes INTEGER;
BEGIN
    SELECT COUNT(*)
      INTO v_qtd_filmes
      FROM film
     WHERE language_id          = OLD.language_id
        OR original_language_id = OLD.language_id;

    IF v_qtd_filmes > 0 THEN
        RAISE EXCEPTION
            'Não é possível excluir o idioma "%" (id %): existem % filme(s) vinculados a ele.',
            TRIM(OLD.name), OLD.language_id, v_qtd_filmes
            USING ERRCODE = 'foreign_key_violation',
                  HINT    = 'Reatribua os filmes a outro idioma antes de excluir.';
    END IF;

    RETURN OLD;  -- BEFORE DELETE: retornar OLD permite a exclusão
END;
$$;

DROP TRIGGER IF EXISTS trg_protege_language ON language;

CREATE TRIGGER trg_protege_language
BEFORE DELETE ON language
FOR EACH ROW
EXECUTE FUNCTION fn_protege_language();

BEGIN;
DELETE FROM language WHERE language_id = 1;
ROLLBACK;

BEGIN;
UPDATE film SET original_language_id = 2 WHERE film_id = 1;   -- 2 = Italian
DELETE FROM language WHERE language_id = 2;
ROLLBACK;

BEGIN;
INSERT INTO language (name) VALUES ('Klingon') RETURNING language_id;
DELETE FROM language WHERE name = 'Klingon';
ROLLBACK;
