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