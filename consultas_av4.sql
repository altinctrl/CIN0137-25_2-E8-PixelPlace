-- 1. ALTER TABLE
-- Adicionando uma coluna 'data_fundacao' à tabela PUBLICADORA
ALTER TABLE PUBLICADORA
ADD (data_fundacao DATE);

-- 2. CREATE INDEX
-- Criando um índice na chave estrangeira fk_id_produto da tabela ITEM
-- Isso otimiza consultas que buscam pedidos de um produto específico.
CREATE INDEX idx_item_produto
ON ITEM (fk_id_produto);

-- 25. CREATE VIEW
-- Criando uma visão que simplifica a consulta de jogos, seus gêneros e publicadoras.
CREATE OR REPLACE VIEW VW_JOGOS_DETALHADOS AS
SELECT
  p.pk_id_prod,
  p.titulo,
  p.data_lanc,
  j.class_indicativa,
  pub.nome AS publicadora,
  g.pk_nome AS genero
FROM
  PRODUTO p
  JOIN JOGO j ON p.pk_id_prod = j.pk_fk_id_prod
  JOIN PUBLICADORA pub ON p.fk_publicadora = pub.pk_id_pub
  JOIN JOGO_GENERO jg ON j.pk_fk_id_prod = jg.pk_fk_id_jogo
  JOIN GENERO g ON jg.pk_fk_nome_genero = g.pk_nome;

-- 3. INSERT INTO
-- Inserindo uma nova plataforma de hardware
INSERT INTO PLATAFORMA (nome, versao)
VALUES ('PlayStation', '5');

-- 4. UPDATE
-- Atualizando o país da publicadora 'FromSoftware'
UPDATE PUBLICADORA
SET pais = 'Japão'
WHERE nome = 'FromSoftware';

-- 5. DELETE
-- Deletando todas as sessões de jogo que duraram 1 hora ou menos (Ex: testes)
DELETE FROM SESSAO_JOGO
WHERE duracao <= 1.0;

SELECT
  p.nome AS publicadora,
  COUNT(DISTINCT i.pk_fk_id_pedido) AS total_pedidos, -- 15. COUNT
  SUM(i.quantidade * i.valor_unitario_pago) AS receita_total,
  AVG(i.valor_unitario_pago) AS ticket_medio_item, -- 14. AVG
  MAX(i.valor_unitario_pago) AS item_mais_caro_vendido, -- 12. MAX
  MIN(i.valor_unitario_pago) AS item_mais_barato_vendido -- 13. MIN
FROM
  PUBLICADORA p
  INNER JOIN PRODUTO prod ON p.pk_id_pub = prod.fk_publicadora -- 11. INNER JOIN
  INNER JOIN ITEM i ON prod.pk_id_prod = i.fk_id_produto -- 6. SELECT-FROM-WHERE
WHERE
  prod.tipo_prod = 'JOGO' -- Apenas jogos, não adicionais
GROUP BY -- 22. GROUP BY
  p.nome
HAVING -- 23. HAVING
  SUM(i.quantidade * i.valor_unitario_pago) > 500 -- Apenas publicadoras com receita significante
ORDER BY -- 21. ORDER BY
  receita_total DESC;

SELECT
  p.titulo,
  p.data_lanc,
  pe.data_hora AS data_pedido
FROM
  PRODUTO p
  JOIN ITEM i ON p.pk_id_prod = i.fk_id_produto
  JOIN PEDIDO pe ON i.pk_fk_id_pedido = pe.pk_id_pedido
WHERE
  p.titulo LIKE '%Cyberpunk%' -- 9. LIKE
  AND i.fk_id_promo IS NOT NULL -- 10. IS NOT NULL (foi vendido em promoção)
  AND pe.metodo_pag IN ('Pix', 'Cartão de Crédito') -- 8. IN
  AND pe.data_hora BETWEEN TO_TIMESTAMP('2023-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') -- 7. BETWEEN
                       AND TO_TIMESTAMP('2024-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS');

SELECT
  p.titulo,
  p.tipo_prod,
  COUNT(i.pk_fk_id_pedido) AS total_vendas
FROM
  PRODUTO p
  LEFT JOIN ITEM i ON p.pk_id_prod = i.fk_id_produto
GROUP BY
  p.titulo,
  p.tipo_prod
ORDER BY
  total_vendas ASC;

-- 24.1 (UNION): Lista de todos os títulos de Jogos e Expansões
(SELECT p.titulo FROM PRODUTO p JOIN JOGO j ON p.pk_id_prod = j.pk_fk_id_prod)
UNION
(SELECT p.titulo FROM PRODUTO p JOIN ADICIONAL a ON p.pk_id_prod = a.pk_fk_id_prod JOIN EXPANSAO e ON a.pk_fk_id_prod = e.pk_fk_id_prod);

-- 24.2 (MINUS): Lista de jogos que são 'Mundo Aberto', mas que NÃO SÃO 'RPG de Ação'
(SELECT pk_fk_id_jogo FROM JOGO_GENERO WHERE pk_fk_nome_genero = 'Mundo Aberto')
MINUS
(SELECT pk_fk_id_jogo FROM JOGO_GENERO WHERE pk_fk_nome_genero = 'RPG de Ação');

-- 17. SUBCONSULTA COM OPERADOR RELACIONAL 
SELECT titulo
FROM PRODUTO p
WHERE (
  SELECT valor
  FROM HISTORICO_VALOR hv
  WHERE hv.pk_fk_id_produto = p.pk_id_prod
  ORDER BY pk_data_inicio DESC
  FETCH FIRST 1 ROWS ONLY
) > ( -- 17. Operador >
  SELECT AVG(valor)
  FROM HISTORICO_VALOR hv_avg
  WHERE hv_avg.pk_data_inicio = (
    SELECT MAX(pk_data_inicio)
    FROM HISTORICO_VALOR hv_max
    WHERE hv_max.pk_fk_id_produto = hv_avg.pk_fk_id_produto
  )
);

-- 18. SUBCONSULTA COM IN
-- Encontra todos os usuários que compraram produtos da 'CD Projekt Red'
SELECT nome, email
FROM USUARIO
WHERE pk_id_usuario IN ( 
  SELECT DISTINCT pe.fk_id_usuario
  FROM PEDIDO pe
  JOIN ITEM i ON pe.pk_id_pedido = i.pk_fk_id_pedido
  JOIN PRODUTO pr ON i.fk_id_produto = pr.pk_id_prod
  JOIN PUBLICADORA pub ON pr.fk_publicadora = pub.pk_id_pub
  WHERE pub.nome = 'CD Projekt Red'
);

-- 19. SUBCONSULTA COM ANY
-- Encontra jogos que são mais caros (preço atual) que *QUALQUER* jogo da 'Nintendo'
SELECT p.titulo
FROM PRODUTO p
WHERE (
  SELECT valor FROM HISTORICO_VALOR hv
  WHERE hv.pk_fk_id_produto = p.pk_id_prod
  ORDER BY pk_data_inicio DESC FETCH FIRST 1 ROWS ONLY
) > ANY ( 
  SELECT hv_n.valor
  FROM HISTORICO_VALOR hv_n
  JOIN PRODUTO p_n ON hv_n.pk_fk_id_produto = p_n.pk_id_prod
  JOIN PUBLICADORA pub_n ON p_n.fk_publicadora = pub_n.pk_id_pub
  WHERE pub_n.nome = 'Nintendo'
);

-- 20. SUBCONSULTA COM ALL
-- Encontra o(s) jogo(s) mais caro(s) da 'Rockstar Games'
SELECT p.titulo
FROM PRODUTO p
JOIN PUBLICADORA pub ON p.fk_publicadora = pub.pk_id_pub
WHERE pub.nome = 'Rockstar Games' AND (
  SELECT valor FROM HISTORICO_VALOR hv
  WHERE hv.pk_fk_id_produto = p.pk_id_prod
  ORDER BY pk_data_inicio DESC FETCH FIRST 1 ROWS ONLY
) >= ALL ( 
  SELECT hv_r.valor
  FROM HISTORICO_VALOR hv_r
  JOIN PRODUTO p_r ON hv_r.pk_fk_id_produto = p_r.pk_id_prod
  JOIN PUBLICADORA pub_r ON p_r.fk_publicadora = pub_r.pk_id_pub
  WHERE pub_r.nome = 'Rockstar Games'
  AND hv_r.valor IS NOT NULL
);

-- 26. GRANT / REVOKE
-- Conforme a OBS, o Oracle Live SQL não suporta GRANT/REVOKE.
-- A sintaxe abaixo é o exemplo conceitual de como seria feito.

/*
GRANT SELECT ON VW_JOGOS_DETALHADOS TO IF685_ALUNO2;
REVOKE SELECT ON VW_JOGOS_DETALHADOS FROM IF685_ALUNO2;
*/