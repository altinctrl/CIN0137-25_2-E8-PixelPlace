BEGIN
  INSERT ALL
    INTO PUBLICADORA (nome, pais) VALUES ('CD Projekt Red', 'Polônia')
    INTO PUBLICADORA (nome, pais) VALUES ('Ubisoft', 'França')
    INTO PUBLICADORA (nome, pais) VALUES ('Electronic Arts', 'EUA')
    INTO PUBLICADORA (nome, pais) VALUES ('Rockstar Games', 'EUA')
    INTO PUBLICADORA (nome, pais) VALUES ('FromSoftware', 'Japão')
    INTO PUBLICADORA (nome, pais) VALUES ('Nintendo', 'Japão')
    INTO PUBLICADORA (nome, pais) VALUES ('Sony Interactive Entertainment', 'Japão/EUA')
    INTO PUBLICADORA (nome, pais) VALUES ('Microsoft', 'EUA')
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Publicadoras inseridas com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir publicadoras: ' || SQLERRM);
    ROLLBACK;
END;
/