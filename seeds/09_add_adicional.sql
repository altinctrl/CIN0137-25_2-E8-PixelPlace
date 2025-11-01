DECLARE
  v_prod_phantom  NUMBER;
  v_prod_helice   NUMBER;
  v_prod_ouro     NUMBER;
  v_prod_erdtree  NUMBER;
  v_prod_vantagem NUMBER;
  v_prod_clube    NUMBER;
BEGIN
  SELECT pk_id_prod INTO v_prod_phantom FROM PRODUTO WHERE titulo = 'Cyberpunk 2077: Phantom Liberty';
  SELECT pk_id_prod INTO v_prod_helice  FROM PRODUTO WHERE titulo = 'Pacote Hélice (Médio) - AC Valhalla';
  SELECT pk_id_prod INTO v_prod_ouro    FROM PRODUTO WHERE titulo = '25 Barras de Ouro - RDR2';
  SELECT pk_id_prod INTO v_prod_erdtree FROM PRODUTO WHERE titulo = 'Elden Ring: Shadow of the Erdtree';
  SELECT pk_id_prod INTO v_prod_vantagem FROM PRODUTO WHERE titulo = 'Passe Vantagem - Cyberpunk 2077';
  SELECT pk_id_prod INTO v_prod_clube    FROM PRODUTO WHERE titulo = 'Clube dos Ocultos - AC Valhalla';
  
  INSERT ALL
    INTO ADICIONAL (pk_fk_id_prod, tipo_ad) VALUES (v_prod_phantom, 'EXPANSAO')
    INTO ADICIONAL (pk_fk_id_prod, tipo_ad) VALUES (v_prod_erdtree, 'EXPANSAO')
    
    INTO ADICIONAL (pk_fk_id_prod, tipo_ad) VALUES (v_prod_helice, 'MICROTRANSACAO')
    INTO ADICIONAL (pk_fk_id_prod, tipo_ad) VALUES (v_prod_ouro, 'MICROTRANSACAO')

    INTO ADICIONAL (pk_fk_id_prod, tipo_ad) VALUES (v_prod_vantagem, 'ASSINATURA')
    INTO ADICIONAL (pk_fk_id_prod, tipo_ad) VALUES (v_prod_clube, 'ASSINATURA')
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela ADICIONAL populada com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela ADICIONAL: ' || SQLERRM);
    ROLLBACK;
END;
/