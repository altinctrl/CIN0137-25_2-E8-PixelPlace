
-- --------------------------------------------------
-- seeds/16_add_jogo_genero.sql
-- --------------------------------------------------

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

-- --------------------------------------------------
-- seeds/17_add_pedido_and_item.sql
-- --------------------------------------------------

BEGIN
  -- P1 (U1 - Natal 22 - 20%)
  -- Jogo: RDR 2 (ID 3) | Preço Cheio: 249.90
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2022-12-10 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Cartão de Crédito', 1);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 3, 1, 199.92);

  -- P2 (U2 - Natal 23 - 25%)
  -- Jogo: AC Valhalla (ID 2) | Preço Cheio: 149.90
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2023-12-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 2);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 2, 2, 112.42);

  -- P3 (U3 - Natal 23 - 25%)
  -- Jogo: Cyberpunk 2077 (ID 1) | Preço Cheio: 249.90
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2023-12-18 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 3);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 1, 2, 187.42);

  -- P4 (U4)
  -- Jogo: Elden Ring (ID 4)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2023-10-20 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Boleto', 4);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 4, NULL, 299.90);

  -- P5 (U5)
  -- Jogo: God of War (ID 5)
  -- Jogo: Mario Kart (ID 6)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2023-11-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Saldo Carteira', 5);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 5, NULL, 349.90);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 2, 1, 6, NULL, 299.90);

  -- P6 (U6 - Natal 24 - 30%)
  -- Jogo: Elden Ring (ID 4) | Preço Cheio: 299.90
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-12-02 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 6);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 4, 3, 209.93);

  -- P7 (U7)
  -- Jogo: Cyberpunk 2077 (ID 1) | Preço novo
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-05-15 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Cartão de Crédito', 7);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 1, NULL, 199.90);

  -- P8 (U8)
  -- Jogo: RDR 2 (ID 3)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-08-01 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 8);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 3, NULL, 249.90);

  -- P9 (U9)
  -- Jogo: God of War (ID 5)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-10-30 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Boleto', 9);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 5, NULL, 349.90);

  -- P10 (U10)
  -- Jogo: AC Valhalla (ID 2)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2025-01-10 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 10);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 2, NULL, 149.90);

  -- P11 (U3 - P3)
  -- Adicional: Phantom Liberty (ID 9)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-01-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 3);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 9, NULL, 149.90);

  -- P12 (U3 - P3)
  -- Adicional: Passe Vantagem (ID 7)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-02-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 3);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 7, NULL, 29.90);

  -- P13 (U8 - P8)
  -- Adicional: Barras de Ouro (ID 11)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-08-02 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Saldo Carteira', 8);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 11, NULL, 79.90);

  -- P14 (U4 - P4)
  -- Adicional: Shadow of Erdtree (ID 12)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-07-01 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Cartão de Crédito', 4);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 12, NULL, 199.90);

  -- P15 (U10 - P10)
  -- Adicional: Pacote Hélice (ID 10)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2025-01-11 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 10);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 10, NULL, 49.90);
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('15 Pedidos e seus Itens inseridos com sucesso.');

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir Pedidos e Itens: ' || SQLERRM);
    ROLLBACK;
END;
/

-- --------------------------------------------------
-- seeds/18_add_sessao_jogo.sql
-- --------------------------------------------------

DECLARE
  v_plat_win11 NUMBER;
  v_plat_linux NUMBER;
  v_plat_macos NUMBER;
  v_plat_win10 NUMBER;
BEGIN
  SELECT pk_id_plataforma INTO v_plat_win11 FROM PLATAFORMA WHERE nome = 'windows' AND versao = '11';
  SELECT pk_id_plataforma INTO v_plat_linux FROM PLATAFORMA WHERE nome = 'linux' AND versao = '6.9';
  SELECT pk_id_plataforma INTO v_plat_macos FROM PLATAFORMA WHERE nome = 'macos' AND versao = '14';
  SELECT pk_id_plataforma INTO v_plat_win10 FROM PLATAFORMA WHERE nome = 'windows' AND versao = '10';

  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (1, 3, v_plat_win11, TO_TIMESTAMP('2023-01-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4.5);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (1, 3, v_plat_win11, TO_TIMESTAMP('2023-01-11 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (1, 3, v_plat_win11, TO_TIMESTAMP('2023-01-13 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);

  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (2, 2, v_plat_win10, TO_TIMESTAMP('2024-01-20 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (2, 2, v_plat_win10, TO_TIMESTAMP('2024-01-22 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5.0);

  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (3, 1, v_plat_win11, TO_TIMESTAMP('2024-01-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5.5);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (3, 1, v_plat_win11, TO_TIMESTAMP('2024-01-21 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (3, 1, v_plat_win11, TO_TIMESTAMP('2024-01-22 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (3, 1, v_plat_win11, TO_TIMESTAMP('2024-01-25 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4.5);

  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-02 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5.5);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-03 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-04 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-05 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-08 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);

  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (7, 1, v_plat_win11, TO_TIMESTAMP('2024-06-01 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4.5);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (7, 1, v_plat_win11, TO_TIMESTAMP('2024-06-05 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);
  
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (5, 6, v_plat_macos, TO_TIMESTAMP('2023-11-12 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (5, 6, v_plat_macos, TO_TIMESTAMP('2023-11-13 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2.5);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (5, 6, v_plat_macos, TO_TIMESTAMP('2023-11-15 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2.5);

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela SESSAO_JOGO populada com sessões realistas.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela SESSAO_JOGO: ' || SQLERRM);
    ROLLBACK;
END;
/

-- --------------------------------------------------
-- seeds/19_add_progresso.sql
-- --------------------------------------------------

BEGIN
  INSERT INTO PROGRESSO (fk_id_usuario, fk_id_jogo, horas_jogadas)
  SELECT 
    fk_id_usuario,
    fk_id_jogo,
    SUM(duracao) AS total_horas
  FROM 
    SESSAO_JOGO
  GROUP BY 
    fk_id_usuario, fk_id_jogo;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela PROGRESSO populada com a soma das horas de sessão.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela PROGRESSO: ' || SQLERRM);
    ROLLBACK;
END;
/

-- --------------------------------------------------
-- seeds/20_add_conquistas.sql
-- --------------------------------------------------

BEGIN
  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (1, 3, 'FORASTEIRO', TO_TIMESTAMP('2023-01-11 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));
  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (1, 3, 'ESPIRITO_DO_OESTE', TO_TIMESTAMP('2023-01-14 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));

  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (2, 2, 'O_INICIO_DA_SAGA', TO_TIMESTAMP('2024-01-23 21:00:00', 'YYYY-MM-DD HH24:MI:SS'));

  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (3, 1, 'BEM_VINDO_A_NIGHT_CITY', TO_TIMESTAMP('2024-01-20 11:30:00', 'YYYY-MM-DD HH24:MI:SS'));
  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (3, 1, 'FANTASMA_DA_CIDADE', TO_TIMESTAMP('2024-01-23 15:00:00', 'YYYY-MM-DD HH24:MI:SS'));
  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (3, 1, 'LENDA_DO_AFTERLIFE', TO_TIMESTAMP('2024-01-26 17:00:00', 'YYYY-MM-DD HH24:MI:SS'));

  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (4, 4, 'MACULADO', TO_TIMESTAMP('2024-11-01 08:01:00', 'YYYY-MM-DD HH24:MI:SS'));
  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (4, 4, 'SENHOR_PRISTINO', TO_TIMESTAMP('2024-11-09 19:00:00', 'YYYY-MM-DD HH24:MI:SS'));

  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (7, 1, 'BEM_VINDO_A_NIGHT_CITY', TO_TIMESTAMP('2024-06-02 19:30:00', 'YYYY-MM-DD HH24:MI:SS'));

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela CONQUISTAS populada com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela CONQUISTAS: ' || SQLERRM);
    ROLLBACK;
END;
/
