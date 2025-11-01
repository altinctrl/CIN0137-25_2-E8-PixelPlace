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

  INSERT ALL
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (1, 3, v_plat_win11, TO_TIMESTAMP('2023-01-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4.5)
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (1, 3, v_plat_win11, TO_TIMESTAMP('2023-01-11 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2.0)
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (1, 3, v_plat_win11, TO_TIMESTAMP('2023-01-13 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0)

    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (2, 2, v_plat_win10, TO_TIMESTAMP('2024-01-20 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4.0)
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (2, 2, v_plat_win10, TO_TIMESTAMP('2024-01-22 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5.0)

    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (3, 1, v_plat_win11, TO_TIMESTAMP('2024-01-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5.5)
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (3, 1, v_plat_win11, TO_TIMESTAMP('2024-01-21 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0)
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (3, 1, v_plat_win11, TO_TIMESTAMP('2024-01-22 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4.0)
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (3, 1, v_plat_win11, TO_TIMESTAMP('2024-01-25 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4.5)

    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0)
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-02 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5.5)
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-03 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0)
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-04 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0)
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-05 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0)
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-08 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0)

    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (7, 1, v_plat_win11, TO_TIMESTAMP('2024-06-01 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4.5)
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (7, 1, v_plat_win11, TO_TIMESTAMP('2024-06-05 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0)
    
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (5, 6, v_plat_macos, TO_TIMESTAMP('2023-11-12 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3.0)
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (5, 6, v_plat_macos, TO_TIMESTAMP('2023-11-13 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2.5)
    INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
    VALUES (5, 6, v_plat_macos, TO_TIMESTAMP('2023-11-15 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2.5)
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela SESSAO_JOGO populada com sessões realistas.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela SESSAO_JOGO: ' || SQLERRM);
    ROLLBACK;
END;
/