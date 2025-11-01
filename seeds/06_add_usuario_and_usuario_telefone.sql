DECLARE
  v_total_usuarios NUMBER := 10;

  TYPE t_nomes IS TABLE OF VARCHAR2(50);
  TYPE t_sobrenomes IS TABLE OF VARCHAR2(50);
  TYPE t_ceps IS TABLE OF VARCHAR2(9);

  v_nomes      t_nomes;
  v_sobrenomes t_sobrenomes;
  v_ceps       t_ceps;
  
  v_nome_completo   VARCHAR2(255);
  v_email           VARCHAR2(255);
  v_data_nasc       DATE;
  v_numero_casa     VARCHAR2(20);
  v_cep_sorteado    VARCHAR2(9);
  v_novo_id_usuario NUMBER;
  v_telefone        VARCHAR2(20);

BEGIN
  v_nomes      := t_nomes('Ana', 'Bruno', 'Carla', 'Daniel', 'Elisa', 'Felipe', 'Gabriela', 'Hugo', 'Isabela', 'João', 'Laura', 'Marcos', 'Natália', 'Pedro', 'Sofia');
  v_sobrenomes := t_sobrenomes('Silva', 'Costa', 'Pereira', 'Oliveira', 'Santos', 'Dias', 'Rocha', 'Mendes', 'Alves', 'Ribeiro', 'Gomes', 'Martins', 'Lima', 'Araújo', 'Barbosa');

  SELECT pk_CEP 
  BULK COLLECT INTO v_ceps 
  FROM ENDERECO_CEP
  WHERE ROWNUM <= v_total_usuarios;
  
  IF v_ceps.COUNT < v_total_usuarios THEN
    RAISE_APPLICATION_ERROR(-20001, 'Não há CEPs suficientes na tabela ENDERECO_CEP para criar ' || v_total_usuarios || ' usuários.');
  END IF;

  FOR i IN 1..v_total_usuarios LOOP
    
    v_nome_completo := v_nomes(TRUNC(DBMS_RANDOM.VALUE(1, v_nomes.COUNT + 1))) || ' ' || v_sobrenomes(TRUNC(DBMS_RANDOM.VALUE(1, v_sobrenomes.COUNT + 1)));
    v_email         := LOWER(REPLACE(v_nome_completo, ' ', '.')) || i || '@emailficticio.com';
    v_data_nasc     := TO_DATE('1980-01-01', 'YYYY-MM-DD') + TRUNC(DBMS_RANDOM.VALUE(0, 365.25 * 25));
    v_numero_casa   := TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(1, 2000)));
    v_cep_sorteado  := v_ceps(i);
    
    INSERT INTO USUARIO (nome, email, data_nasc, numero, fk_CEP)
    VALUES (v_nome_completo, v_email, v_data_nasc, v_numero_casa, v_cep_sorteado);
    
    v_novo_id_usuario := seq_usuario.CURRVAL;
    
    v_telefone := '+55 (' || TRUNC(DBMS_RANDOM.VALUE(11, 99)) || ') 9' || TRUNC(DBMS_RANDOM.VALUE(8000, 9999)) || '-' || TRUNC(DBMS_RANDOM.VALUE(1000, 9999));
    
    INSERT INTO USUARIO_TELEFONE (pk_fk_id_usuario, pk_telefone)
    VALUES (v_novo_id_usuario, v_telefone);
    
    IF DBMS_RANDOM.VALUE < 0.3 THEN
      v_telefone := '+55 (' || TRUNC(DBMS_RANDOM.VALUE(11, 99)) || ') 9' || TRUNC(DBMS_RANDOM.VALUE(7000, 7999)) || '-' || TRUNC(DBMS_RANDOM.VALUE(1000, 9999));
      INSERT INTO USUARIO_TELEFONE (pk_fk_id_usuario, pk_telefone)
      VALUES (v_novo_id_usuario, v_telefone);
    END IF;
    
  END LOOP;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE(v_total_usuarios || ' usuários e seus telefones foram inseridos com sucesso.');
  
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir usuários: ' || SQLERRM);
    ROLLBACK;
END;
/