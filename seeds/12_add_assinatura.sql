DECLARE
  v_prod_vantagem NUMBER;
  v_prod_clube    NUMBER;
BEGIN
  SELECT pk_id_prod INTO v_prod_vantagem FROM PRODUTO WHERE titulo = 'Passe Vantagem - Cyberpunk 2077';
  SELECT pk_id_prod INTO v_prod_clube    FROM PRODUTO WHERE titulo = 'Clube dos Ocultos - AC Valhalla';

  INSERT ALL
    INTO ASSINATURA (pk_fk_id_prod, duracao) VALUES (v_prod_vantagem, 30)
    INTO ASSINATURA (pk_fk_id_prod, duracao) VALUES (v_prod_clube, 30)
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela ASSINATURA populada com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela ASSINATURA: ' || SQLERRM);
    ROLLBACK;
END;
/