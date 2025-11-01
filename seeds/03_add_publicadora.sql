BEGIN
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('CD Projekt Red', 'Polônia');
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('Ubisoft', 'França');
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('Electronic Arts', 'EUA');
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('Rockstar Games', 'EUA');
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('FromSoftware', 'Japão');
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('Nintendo', 'Japão');
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('Sony Interactive Entertainment', 'Japão/EUA');
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('Microsoft', 'EUA');
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Publicadoras inseridas com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir publicadoras: ' || SQLERRM);
    ROLLBACK;
END;
/