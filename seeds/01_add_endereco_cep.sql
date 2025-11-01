DECLARE
  TYPE t_cidades IS TABLE OF VARCHAR2(100);
  TYPE t_ufs IS TABLE OF CHAR(2);
  TYPE t_tipos_log IS TABLE OF VARCHAR2(20);
  TYPE t_nomes_log IS TABLE OF VARCHAR2(100);

  v_cidades t_cidades;
  v_ufs t_ufs;
  v_tipos t_tipos_log;
  v_nomes t_nomes_log;
  
  v_cep VARCHAR2(9);
  v_logradouro VARCHAR2(255);
  v_cidade VARCHAR2(100);
  v_uf CHAR(2);
  v_idx_cidade NUMBER;
  v_idx_tipo NUMBER;
  v_idx_nome NUMBER;

BEGIN
  v_cidades := t_cidades('São Paulo', 'Rio de Janeiro', 'Belo Horizonte', 'Porto Alegre', 'Curitiba', 'Recife', 'Salvador', 'Fortaleza', 'Manaus', 'Brasília', 'Goiânia', 'Belém', 'Florianópolis', 'Vitória', 'Campo Grande');
  v_ufs     := t_ufs('SP', 'RJ', 'MG', 'RS', 'PR', 'PE', 'BA', 'CE', 'AM', 'DF', 'GO', 'PA', 'SC', 'ES', 'MS');
  v_tipos   := t_tipos_log('Rua', 'Avenida', 'Praça', 'Travessa', 'Alameda');
  v_nomes   := t_nomes_log('Principal', 'das Flores', 'do Sol', 'Brasil', 'Sete de Setembro', 'XV de Novembro', 'da República', 'Barão do Rio Branco', 'Duque de Caxias', 'Tiradentes');

  FOR i IN 1..10 LOOP
    
    v_cep := TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(10000, 89999))) || '-' || TO_CHAR(TRUNC(DBMS_RANDOM.VALUE(100, 999)));
    
    v_idx_cidade := TRUNC(DBMS_RANDOM.VALUE(1, v_cidades.COUNT + 1));
    v_idx_tipo   := TRUNC(DBMS_RANDOM.VALUE(1, v_tipos.COUNT + 1));
    v_idx_nome   := TRUNC(DBMS_RANDOM.VALUE(1, v_nomes.COUNT + 1));

    v_cidade     := v_cidades(v_idx_cidade);
    v_uf         := v_ufs(v_idx_cidade);
    v_logradouro := v_tipos(v_idx_tipo) || ' ' || v_nomes(v_idx_nome) || ', ' || i;

    INSERT INTO ENDERECO_CEP (pk_CEP, logradouro, cidade, UF)
    VALUES (v_cep, v_logradouro, v_cidade, v_uf);
    
  END LOOP;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('100 endereços fictícios inseridos com sucesso.');
  
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir endereços: ' || SQLERRM);
    ROLLBACK;
END;
/