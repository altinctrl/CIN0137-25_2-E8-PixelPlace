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
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_cyberpunk, 'RPG de Ação')
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_cyberpunk, 'Mundo Aberto')
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_cyberpunk, 'Tiro em Primeira Pessoa (FPS)')
    
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_valhalla, 'RPG de Ação')
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_valhalla, 'Mundo Aberto')
    
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_rdr2, 'Ação')
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_rdr2, 'Aventura')
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_rdr2, 'Mundo Aberto')
    
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_elden, 'RPG de Ação')
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_elden, 'Mundo Aberto')
    
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_gow, 'Ação')
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_gow, 'Aventura')
    
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_mario, 'Corrida')
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela JOGO_GENERO populada com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela JOGO_GENERO: ' || SQLERRM);
    ROLLBACK;
END;
/