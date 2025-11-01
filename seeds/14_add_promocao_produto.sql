DECLARE
  v_promo_2022 NUMBER;
  v_promo_2023 NUMBER;
  v_promo_2024 NUMBER;
  v_promo_2025 NUMBER;
  
  v_prod_cyberpunk NUMBER;
  v_prod_valhalla  NUMBER;
  v_prod_rdr2      NUMBER;
  v_prod_elden     NUMBER;
  v_prod_phantom   NUMBER;

BEGIN
  SELECT pk_id_promo INTO v_promo_2022 FROM PROMOCAO WHERE nome = 'Promoção de Natal 2022';
  SELECT pk_id_promo INTO v_promo_2023 FROM PROMOCAO WHERE nome = 'Promoção de Natal 2023';
  SELECT pk_id_promo INTO v_promo_2024 FROM PROMOCAO WHERE nome = 'Promoção de Natal 2024';
  SELECT pk_id_promo INTO v_promo_2025 FROM PROMOCAO WHERE nome = 'Promoção de Natal 2025';

  SELECT pk_id_prod INTO v_prod_cyberpunk FROM PRODUTO WHERE titulo = 'Cyberpunk 2077';
  SELECT pk_id_prod INTO v_prod_valhalla  FROM PRODUTO WHERE titulo = 'Assassin''s Creed Valhalla';
  SELECT pk_id_prod INTO v_prod_rdr2      FROM PRODUTO WHERE titulo = 'Red Dead Redemption 2';
  SELECT pk_id_prod INTO v_prod_elden     FROM PRODUTO WHERE titulo = 'Elden Ring';
  SELECT pk_id_prod INTO v_prod_phantom   FROM PRODUTO WHERE titulo = 'Cyberpunk 2077: Phantom Liberty';

  INSERT ALL
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2022, v_prod_rdr2)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2022, v_prod_valhalla)
    
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2023, v_prod_rdr2)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2023, v_prod_valhalla)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2023, v_prod_cyberpunk)

    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2024, v_prod_rdr2)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2024, v_prod_valhalla)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2024, v_prod_cyberpunk)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2024, v_prod_elden)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2024, v_prod_phantom)
    
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2025, v_prod_rdr2)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2025, v_prod_valhalla)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2025, v_prod_cyberpunk)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2025, v_prod_elden)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2025, v_prod_phantom)
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela PROMOCAO_PRODUTO populada com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela PROMOCAO_PRODUTO: ' || SQLERRM);
    ROLLBACK;
END;
/