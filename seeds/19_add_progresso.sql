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