DECLARE
  v_prod_cyberpunk NUMBER;
  v_prod_valhalla  NUMBER;
  v_prod_rdr2      NUMBER;
  v_prod_elden     NUMBER;
  v_prod_gow       NUMBER;
  v_prod_mario     NUMBER;

BEGIN
  SELECT pk_id_prod INTO v_prod_cyberpunk FROM PRODUTO WHERE titulo = 'Cyberpunk 2077';
  SELECT pk_id_prod INTO v_prod_valhalla  FROM PRODUTO WHERE titulo = 'Assassin''s Creed Valhalla';
  SELECT pk_id_prod INTO v_prod_rdr2      FROM PRODUTO WHERE titulo = 'Red Dead Redemption 2';
  SELECT pk_id_prod INTO v_prod_elden     FROM PRODUTO WHERE titulo = 'Elden Ring';
  SELECT pk_id_prod INTO v_prod_gow       FROM PRODUTO WHERE titulo = 'God of War Ragnarök';
  SELECT pk_id_prod INTO v_prod_mario     FROM PRODUTO WHERE titulo = 'Mario Kart 8 Deluxe';

  INSERT ALL
    INTO JOGO (pk_fk_id_prod, tamanho, requisitos, class_indicativa)
    VALUES (v_prod_cyberpunk, 110.50, 'NVIDIA GTX 1060, 16GB RAM', '18')
    
    INTO JOGO (pk_fk_id_prod, tamanho, requisitos, class_indicativa)
    VALUES (v_prod_valhalla, 130.20, 'NVIDIA GTX 960, 8GB RAM', '18')
    
    INTO JOGO (pk_fk_id_prod, tamanho, requisitos, class_indicativa)
    VALUES (v_prod_rdr2, 150.00, 'NVIDIA GTX 1060 6GB, 12GB RAM', '18')
    
    INTO JOGO (pk_fk_id_prod, tamanho, requisitos, class_indicativa)
    VALUES (v_prod_elden, 60.00, 'NVIDIA GTX 1060 3GB, 12GB RAM', '16')
    
    INTO JOGO (pk_fk_id_prod, tamanho, requisitos, class_indicativa)
    VALUES (v_prod_gow, 84.00, 'Exclusivo PlayStation 5', '18')
    
    INTO JOGO (pk_fk_id_prod, tamanho, requisitos, class_indicativa)
    VALUES (v_prod_mario, 14.30, 'Exclusivo Nintendo Switch', 'L')
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela JOGO (especialização) populada com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela JOGO: ' || SQLERRM);
    ROLLBACK;
END;
/