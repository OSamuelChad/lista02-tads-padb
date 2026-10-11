# Lista de Exercícios 1 — Sistema de E-commerce

## Como executar

```bash
createdb ecommerce
cd lista01-ecommerce
psql -d ecommerce -f run_all.sql          # recria a base e roda todas as questões
psql -d ecommerce -f q06_pedidos_ultimos_30_dias.sql   # uma questão isolada
```

`00_schema_dados.sql` cria o schema `lista01`, as tabelas e os dados. Cada arquivo de questão
faz `SET search_path TO lista01;`, então pode ser rodado sozinho (depois do `00`).

## Questões

| Nº | Arquivo | Enunciado |
|---|---|---|
| 01 | `q01_produtos_acima_1000.sql` | Produtos com preço superior a R$ 1000 |
| 02 | `q02_produtos_por_preco_desc.sql` | Produtos ordenados pelo preço (maior → menor) |
| 03 | `q03_aumenta_preco_dell.sql` | Aumentar em 10% o preço dos produtos Dell |
| 04 | `q04_exclui_macbook.sql` | Excluir produtos do tipo Macbook |
| 05 | `q05_exclui_produto_sem_pedidos.sql` | Excluir um produto sem pedidos associados |
| 06 | `q06_pedidos_ultimos_30_dias.sql` | Pedidos dos últimos 30 dias |
| 07 | `q07_pedidos_com_usuario.sql` | Pedidos e nomes de usuário |
| 08 | `q08_usuarios_e_pedidos.sql` | Usuários e pedidos, inclusive sem pedidos |
| 09 | `q09_usuarios_com_pedido.sql` | Usuários com pelo menos um pedido |
| 10 | `q10_produtos_nunca_vendidos.sql` | Produtos nunca vendidos |
| 11 | `q11_usuarios_sem_pedidos.sql` | Usuários que nunca fizeram pedidos |
| 12 | `q12_produtos_acima_media.sql` | Produtos com preço acima da média |
| 13 | `q13_qtd_pedidos_por_usuario.sql` | Quantidade de pedidos por usuário |
| 14 | `q14_top3_produtos_mais_vendidos.sql` | Três produtos mais vendidos |
| 15 | `q15_relatorio_usuarios.sql` | Relatório: usuários, qtd. de pedidos e valor total |

## Observações

- **Q03–Q05 (UPDATE/DELETE)** rodam dentro de `BEGIN … ROLLBACK`, para que cada questão parta
  dos dados originais (sem isso, a Q04 já apagaria o Macbook e a Q05 não teria produto a excluir).
  Para gravar as alterações, troque `ROLLBACK` por `COMMIT`.
- **Q14:** há empate no 2º lugar (três produtos com 2 unidades). A primeira consulta usa `LIMIT 3`
  com desempate por nome; a segunda usa `FETCH FIRST 3 ROWS WITH TIES` e mostra todos os empatados.
- **Q14 e Q15:** pedidos `canceled` não contam como venda/compra.
