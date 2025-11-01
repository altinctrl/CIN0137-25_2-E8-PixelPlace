DECLARE
  v_pub_cdpr     PUBLICADORA.pk_id_pub%TYPE;
  v_pub_ubisoft  PUBLICADORA.pk_id_pub%TYPE;
  v_pub_ea       PUBLICADORA.pk_id_pub%TYPE;
  v_pub_rockstar PUBLICADORA.pk_id_pub%TYPE;
  v_pub_fromsw   PUBLICADORA.pk_id_pub%TYPE;
  v_pub_nintendo PUBLICADORA.pk_id_pub%TYPE;
  v_pub_sony     PUBLICADORA.pk_id_pub%TYPE;
  v_pub_ms       PUBLICADORA.pk_id_pub%TYPE;

BEGIN
  SELECT pk_id_pub INTO v_pub_cdpr     FROM PUBLICADORA WHERE nome = 'CD Projekt Red';
  SELECT pk_id_pub INTO v_pub_ubisoft  FROM PUBLICADORA WHERE nome = 'Ubisoft';
  SELECT pk_id_pub INTO v_pub_ea       FROM PUBLICADORA WHERE nome = 'Electronic Arts';
  SELECT pk_id_pub INTO v_pub_rockstar FROM PUBLICADORA WHERE nome = 'Rockstar Games';
  SELECT pk_id_pub INTO v_pub_fromsw   FROM PUBLICADORA WHERE nome = 'FromSoftware';
  SELECT pk_id_pub INTO v_pub_nintendo FROM PUBLICADORA WHERE nome = 'Nintendo';
  SELECT pk_id_pub INTO v_pub_sony     FROM PUBLICADORA WHERE nome = 'Sony Interactive Entertainment';
  SELECT pk_id_pub INTO v_pub_ms       FROM PUBLICADORA WHERE nome = 'Microsoft';

  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('JOGO', 'Um RPG de ação e aventura em mundo aberto.', 'Cyberpunk 2077', TO_DATE('2020-12-10', 'YYYY-MM-DD'), v_pub_cdpr);
  
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('JOGO', 'Explore a era dos Vikings.', 'Assassin''s Creed Valhalla', TO_DATE('2020-11-10', 'YYYY-MM-DD'), v_pub_ubisoft);
  
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('JOGO', 'Uma aventura de faroeste em mundo aberto.', 'Red Dead Redemption 2', TO_DATE('2018-10-26', 'YYYY-MM-DD'), v_pub_rockstar);
  
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('JOGO', 'RPG de ação aclamado em um mundo de fantasia sombria.', 'Elden Ring', TO_DATE('2022-02-25', 'YYYY-MM-DD'), v_pub_fromsw);
  
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('JOGO', 'A jornada de Kratos e Atreus pelos reinos nórdicos.', 'God of War Ragnarök', TO_DATE('2022-11-09', 'YYYY-MM-DD'), v_pub_sony);
  
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('JOGO', 'O jogo de corrida definitivo do Mario.', 'Mario Kart 8 Deluxe', TO_DATE('2017-04-28', 'YYYY-MM-DD'), v_pub_nintendo);

  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('ADICIONAL', 'Assinatura mensal com bônus e itens exclusivos em Night City.', 'Passe Vantagem - Cyberpunk 2077', TO_DATE('2024-01-01', 'YYYY-MM-DD'), v_pub_cdpr);

  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('ADICIONAL', 'Acesso mensal ao Clube dos Ocultos, com recompensas semanais.', 'Clube dos Ocultos - AC Valhalla', TO_DATE('2021-05-01', 'YYYY-MM-DD'), v_pub_ubisoft);

  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('ADICIONAL', 'Expansão de história para Cyberpunk 2077.', 'Cyberpunk 2077: Phantom Liberty', TO_DATE('2023-09-26', 'YYYY-MM-DD'), v_pub_cdpr);
  
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('ADICIONAL', 'Expansão de história para Elden Ring.', 'Elden Ring: Shadow of the Erdtree', TO_DATE('2024-06-21', 'YYYY-MM-DD'), v_pub_fromsw);
    
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('ADICIONAL', 'Pacote de moedas do jogo.', 'Pacote Hélice (Médio) - AC Valhalla', TO_DATE('2020-11-10', 'YYYY-MM-DD'), v_pub_ubisoft);
  
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('ADICIONAL', 'Barras de Ouro para Red Dead Online.', '25 Barras de Ouro - RDR2', TO_DATE('2018-11-30', 'YYYY-MM-DD'), v_pub_rockstar);

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Produtos inseridos com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir produtos: ' || SQLERRM);
    ROLLBACK;
END;
/