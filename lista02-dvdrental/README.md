# Lista de Exercícios 2 — Views, Indexes e Triggers (dvdrental)

## Como executar

Requer a base de exemplo `dvdrental` restaurada
([download](https://neon.com/postgresqltutorial/dvdrental.zip)):

```bash
createdb dvdrental
pg_restore -d dvdrental dvdrental.tar
cd lista02-dvdrental
psql -d dvdrental -f run_all.sql                       # todas as questões
psql -d dvdrental -f q03_indice_parcial_rental.sql     # uma questão isolada
```

Os scripts podem ser executados mais de uma vez (usam `CREATE OR REPLACE` / `DROP … IF EXISTS`).
Os testes que alteram dados rodam em `BEGIN … ROLLBACK`, deixando a base intacta.

## Questões

| Nº | Arquivo | Objeto criado | Validação |
|---|---|---|---|
| 01 | `q01_view_staff_performance.sql` | View `v_staff_performance` | SELECT na view |
| 02 | `q02_mv_category_total_sales.sql` | MV `mv_category_total_sales` + índice único | `REFRESH … CONCURRENTLY` |
| 03 | `q03_indice_parcial_rental.sql` | Índice parcial `WHERE return_date IS NULL` | `EXPLAIN ANALYZE` → Index Scan |
| 04 | `q04_fts_descricao_film.sql` | Índice GIN em `to_tsvector(description)` | `EXPLAIN ANALYZE` → Bitmap Index Scan |
| 05 | `q05_indice_payment_cliente.sql` | Índice `(customer_id, payment_date DESC)` | `EXPLAIN ANALYZE` |
| 06 | `q06_indice_email_lower.sql` | Índice funcional `LOWER(email)` | `EXPLAIN ANALYZE` → Index Scan |
| 07 | `q07_trigger_valida_datas.sql` | Trigger `BEFORE INSERT OR UPDATE` em `rental` | 2 sucessos + 2 falhas |
| 08 | `q08_trigger_auditoria_precos.sql` | Tabela `film_cost_audit` + trigger `AFTER UPDATE … WHEN` | Só audita mudança real |
| 09 | `q09_trigger_protege_language.sql` | Trigger `BEFORE DELETE` em `language` | 2 falhas + 1 sucesso |
| 10 | `q10_trigger_rental_stats.sql` | Tabela `customer_rental_stats` + trigger `AFTER INSERT` | Carga confere; +1 por locação |

## Observações

- **Q04:** a consulta principal busca `documentary | drama` (207 filmes). A busca com `&`
  (as duas palavras juntas) retorna 0, porque cada sinopse cita um único gênero; isso está
  demonstrado no script. Como `film` tem só 1000 linhas, usa-se `SET enable_seqscan = off`
  para evidenciar o índice no plano.
- **Q05:** a coluna `customer_id` vem primeiro (filtro de igualdade); dentro de cada cliente
  as entradas já ficam ordenadas por `payment_date`. Justificativa completa no script.
  Com só ~22 linhas por cliente o planner prefere Bitmap + Sort; com `enable_bitmapscan = off`
  aparece o Index Scan sem Sort.
- **Q07 e Q09:** as mensagens `ERROR` em `resultados/` são os testes de falha esperados.
- **Q09:** o dump do dvdrental para PostgreSQL não tem `film.original_language_id`;
  o script cria a coluna (`ADD COLUMN IF NOT EXISTS`) antes da trigger.
