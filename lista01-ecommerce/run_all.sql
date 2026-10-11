
\set ON_ERROR_STOP on
\pset pager off

\echo '>>> 00_schema_dados.sql'
\i 00_schema_dados.sql
\echo '>>> q01_produtos_acima_1000.sql'
\i q01_produtos_acima_1000.sql
\echo '>>> q02_produtos_por_preco_desc.sql'
\i q02_produtos_por_preco_desc.sql
\echo '>>> q03_aumenta_preco_dell.sql'
\i q03_aumenta_preco_dell.sql
\echo '>>> q04_exclui_macbook.sql'
\i q04_exclui_macbook.sql
\echo '>>> q05_exclui_produto_sem_pedidos.sql'
\i q05_exclui_produto_sem_pedidos.sql
\echo '>>> q06_pedidos_ultimos_30_dias.sql'
\i q06_pedidos_ultimos_30_dias.sql
\echo '>>> q07_pedidos_com_usuario.sql'
\i q07_pedidos_com_usuario.sql
\echo '>>> q08_usuarios_e_pedidos.sql'
\i q08_usuarios_e_pedidos.sql
\echo '>>> q09_usuarios_com_pedido.sql'
\i q09_usuarios_com_pedido.sql
\echo '>>> q10_produtos_nunca_vendidos.sql'
\i q10_produtos_nunca_vendidos.sql
\echo '>>> q11_usuarios_sem_pedidos.sql'
\i q11_usuarios_sem_pedidos.sql
\echo '>>> q12_produtos_acima_media.sql'
\i q12_produtos_acima_media.sql
\echo '>>> q13_qtd_pedidos_por_usuario.sql'
\i q13_qtd_pedidos_por_usuario.sql
\echo '>>> q14_top3_produtos_mais_vendidos.sql'
\i q14_top3_produtos_mais_vendidos.sql
\echo '>>> q15_relatorio_usuarios.sql'
\i q15_relatorio_usuarios.sql
