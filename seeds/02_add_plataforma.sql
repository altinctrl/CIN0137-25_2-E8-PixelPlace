BEGIN
  INSERT INTO PLATAFORMA (nome, versao) VALUES ('windows', '11');
  INSERT INTO PLATAFORMA (nome, versao) VALUES ('windows', '10');
  INSERT INTO PLATAFORMA (nome, versao) VALUES ('macos', '14');
  INSERT INTO PLATAFORMA (nome, versao) VALUES ('macos', '13');
  INSERT INTO PLATAFORMA (nome, versao) VALUES ('linux', '6.9');
  INSERT INTO PLATAFORMA (nome, versao) VALUES ('linux', '6.8');
  INSERT INTO PLATAFORMA (nome, versao) VALUES ('linux', '6.6');
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Plataformas inseridas com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir plataformas: ' || SQLERRM);
    ROLLBACK;
END;
/