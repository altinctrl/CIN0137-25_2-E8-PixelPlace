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
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_cyberpunk, 'Português (BR)')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_cyberpunk, 'Inglês')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_cyberpunk, 'Polonês')
    
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_valhalla, 'Português (BR)')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_valhalla, 'Inglês')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_valhalla, 'Francês')

    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_rdr2, 'Português (BR)')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_rdr2, 'Inglês')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_rdr2, 'Espanhol')

    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_elden, 'Português (BR)')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_elden, 'Inglês')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_elden, 'Japonês')

    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_gow, 'Português (BR)')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_gow, 'Inglês')
    
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_mario, 'Português (BR)')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_mario, 'Inglês')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_mario, 'Japonês')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_mario, 'Espanhol')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_mario, 'Francês')
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela JOGO_IDIOMA populada com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela JOGO_IDIOMA: ' || SQLERRM);
    ROLLBACK;
END;
/