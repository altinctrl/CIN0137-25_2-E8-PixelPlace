DECLARE
  v_prod_cyberpunk NUMBER;
  v_prod_valhalla  NUMBER;
  v_prod_rdr2      NUMBER;
  v_prod_elden     NUMBER;
  v_prod_gow       NUMBER;
  v_prod_mario     NUMBER;
  v_prod_phantom   NUMBER;
  v_prod_erdtree   NUMBER;
  v_prod_helice    NUMBER;
  v_prod_ouro      NUMBER;
  v_prod_vantagem  NUMBER;
  v_prod_clube     NUMBER;

BEGIN
  SELECT pk_id_prod INTO v_prod_cyberpunk FROM PRODUTO WHERE titulo = 'Cyberpunk 2077';
  SELECT pk_id_prod INTO v_prod_valhalla  FROM PRODUTO WHERE titulo = 'Assassin''s Creed Valhalla';
  SELECT pk_id_prod INTO v_prod_rdr2      FROM PRODUTO WHERE titulo = 'Red Dead Redemption 2';
  SELECT pk_id_prod INTO v_prod_elden     FROM PRODUTO WHERE titulo = 'Elden Ring';
  SELECT pk_id_prod INTO v_prod_gow       FROM PRODUTO WHERE titulo = 'God of War Ragnarök';
  SELECT pk_id_prod INTO v_prod_mario     FROM PRODUTO WHERE titulo = 'Mario Kart 8 Deluxe';
  SELECT pk_id_prod INTO v_prod_phantom   FROM PRODUTO WHERE titulo = 'Cyberpunk 2077: Phantom Liberty';
  SELECT pk_id_prod INTO v_prod_erdtree   FROM PRODUTO WHERE titulo = 'Elden Ring: Shadow of the Erdtree';
  SELECT pk_id_prod INTO v_prod_helice    FROM PRODUTO WHERE titulo = 'Pacote Hélice (Médio) - AC Valhalla';
  SELECT pk_id_prod INTO v_prod_ouro      FROM PRODUTO WHERE titulo = '25 Barras de Ouro - RDR2';
  SELECT pk_id_prod INTO v_prod_vantagem  FROM PRODUTO WHERE titulo = 'Passe Vantagem - Cyberpunk 2077';
  SELECT pk_id_prod INTO v_prod_clube     FROM PRODUTO WHERE titulo = 'Clube dos Ocultos - AC Valhalla';

  INSERT ALL
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_cyberpunk, TO_DATE('2020-12-10', 'YYYY-MM-DD'), 249.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_cyberpunk, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 199.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_valhalla, TO_DATE('2020-11-10', 'YYYY-MM-DD'), 229.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_valhalla, TO_DATE('2023-06-01', 'YYYY-MM-DD'), 149.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_rdr2, TO_DATE('2018-10-26', 'YYYY-MM-DD'), 249.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_elden, TO_DATE('2022-02-25', 'YYYY-MM-DD'), 299.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_gow, TO_DATE('2022-11-09', 'YYYY-MM-DD'), 349.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_mario, TO_DATE('2017-04-28', 'YYYY-MM-DD'), 299.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_phantom, TO_DATE('2023-09-26', 'YYYY-MM-DD'), 149.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_erdtree, TO_DATE('2024-06-21', 'YYYY-MM-DD'), 199.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_helice, TO_DATE('2020-11-10', 'YYYY-MM-DD'), 49.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_ouro, TO_DATE('2018-11-30', 'YYYY-MM-DD'), 79.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_vantagem, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 29.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_clube, TO_DATE('2021-05-01', 'YYYY-MM-DD'), 39.90)
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Histórico de valores inserido com sucesso para 12 produtos.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir histórico de valores: ' || SQLERRM);
    ROLLBACK;
END;
/