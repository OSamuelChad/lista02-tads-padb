
\pset pager off


DROP INDEX IF EXISTS idx_film_description_fts;

CREATE INDEX idx_film_description_fts
    ON film USING GIN (to_tsvector('english', description));

ANALYZE film;

SET enable_seqscan = off;

EXPLAIN ANALYZE
SELECT film_id, title, description
FROM film
WHERE to_tsvector('english', description)
      @@ to_tsquery('english', 'documentary | drama');

RESET enable_seqscan;

SELECT film_id, title, description
FROM film
WHERE to_tsvector('english', description)
      @@ to_tsquery('english', 'documentary | drama')
ORDER BY title;

SELECT COUNT(*) AS documentary_e_drama
FROM film
WHERE to_tsvector('english', description)
      @@ to_tsquery('english', 'documentary & drama');
