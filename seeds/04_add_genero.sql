BEGIN
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('RPG', NULL);
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Ação', NULL);
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Aventura', NULL);
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Simulação', NULL);
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('RPG de Ação', 'RPG');
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Plataforma', 'Ação');
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Tiro', 'Ação');
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Luta', 'Ação');
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Mundo Aberto', 'Aventura');
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Corrida', 'Simulação');
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Tiro em Primeira Pessoa (FPS)', 'Tiro');
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Gêneros inseridos com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir gêneros: ' || SQLERRM);
    ROLLBACK;
END;
/