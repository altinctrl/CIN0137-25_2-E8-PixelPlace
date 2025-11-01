BEGIN
  INSERT ALL
    INTO GENERO (pk_nome, fk_genero_pai) VALUES ('RPG', NULL)
    INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Ação', NULL)
    INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Aventura', NULL)
    INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Simulação', NULL)
    INTO GENERO (pk_nome, fk_genero_pai) VALUES ('RPG de Ação', 'RPG')
    INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Plataforma', 'Ação')
    INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Tiro', 'Ação')
    INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Luta', 'Ação')
    INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Mundo Aberto', 'Aventura')
    INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Corrida', 'Simulação')
    INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Tiro em Primeira Pessoa (FPS)', 'Tiro')
  SELECT 1 FROM dual;
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Gêneros inseridos com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir gêneros: ' || SQLERRM);
    ROLLBACK;
END;
/