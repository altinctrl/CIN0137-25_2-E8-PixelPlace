DECLARE
  v_prod_phantom NUMBER;
  v_prod_erdtree NUMBER;
BEGIN
  SELECT pk_id_prod INTO v_prod_phantom FROM PRODUTO WHERE titulo = 'Cyberpunk 2077: Phantom Liberty';
  SELECT pk_id_prod INTO v_prod_erdtree FROM PRODUTO WHERE titulo = 'Elden Ring: Shadow of the Erdtree';

  INSERT ALL
    INTO EXPANSAO (pk_fk_id_prod, tamanho, requisitos) 
    VALUES (v_prod_phantom, 35.00, 'Requer o jogo base Cyberpunk 2077')
    
    INTO EXPANSAO (pk_fk_id_prod, tamanho, requisitos) 
    VALUES (v_prod_erdtree, 16.50, 'Requer o jogo base Elden Ring')
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela EXPANSAO populada com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela EXPANSAO: ' || SQLERRM);
    ROLLBACK;
END;
/