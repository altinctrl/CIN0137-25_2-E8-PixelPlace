DECLARE
  v_prod_helice NUMBER;
  v_prod_ouro   NUMBER;
BEGIN
  SELECT pk_id_prod INTO v_prod_helice FROM PRODUTO WHERE titulo = 'Pacote Hélice (Médio) - AC Valhalla';
  SELECT pk_id_prod INTO v_prod_ouro   FROM PRODUTO WHERE titulo = '25 Barras de Ouro - RDR2';

  INSERT ALL
    INTO MICROTRANSACAO (pk_fk_id_prod, tipo_microtrans) VALUES (v_prod_helice, 'Moeda Virtual')
    INTO MICROTRANSACAO (pk_fk_id_prod, tipo_microtrans) VALUES (v_prod_ouro, 'Moeda Virtual')
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela MICROTRANSACAO populada com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela MICROTRANSACAO: ' || SQLERRM);
    ROLLBACK;
END;
/