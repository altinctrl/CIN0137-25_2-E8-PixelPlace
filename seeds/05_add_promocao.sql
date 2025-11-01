BEGIN
  INSERT INTO PROMOCAO (nome, percentual, data_inicio, data_fim) 
  VALUES ('Promoção de Natal 2022', 20.00, TO_DATE('2022-12-01', 'YYYY-MM-DD'), TO_DATE('2022-12-26', 'YYYY-MM-DD'));
  
  INSERT INTO PROMOCAO (nome, percentual, data_inicio, data_fim) 
  VALUES ('Promoção de Natal 2023', 25.00, TO_DATE('2023-12-01', 'YYYY-MM-DD'), TO_DATE('2023-12-26', 'YYYY-MM-DD'));
  
  INSERT INTO PROMOCAO (nome, percentual, data_inicio, data_fim) 
  VALUES ('Promoção de Natal 2024', 30.00, TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-26', 'YYYY-MM-DD'));
  
  INSERT INTO PROMOCAO (nome, percentual, data_inicio, data_fim) 
  VALUES ('Promoção de Natal 2025', 35.00, TO_DATE('2025-12-01', 'YYYY-MM-DD'), TO_DATE('2025-12-26', 'YYYY-MM-DD'));
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Promoções inseridas com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir promoções: ' || SQLERRM);
    ROLLBACK;
END;
/