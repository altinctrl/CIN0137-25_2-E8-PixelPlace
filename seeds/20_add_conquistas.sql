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