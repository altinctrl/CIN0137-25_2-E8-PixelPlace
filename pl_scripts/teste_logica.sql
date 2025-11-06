SET SERVEROUTPUT ON;

DECLARE
  v_id_usuario_teste USUARIO.pk_id_usuario%TYPE;
  v_id_jogo_teste    PRODUTO.pk_id_prod%TYPE;
  v_preco_calculado  HISTORICO_VALOR.valor%TYPE;
  v_relatorio_gerado CLOB;
  
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- Iniciando Testes da Lógica PL/SQL ---');

  -- 1. Teste da Função: f_calcular_preco_atual
  DBMS_OUTPUT.PUT_LINE(CHR(10) || '1. Testando f_calcular_preco_atual...');
  BEGIN
    SELECT pk_id_prod INTO v_id_jogo_teste
    FROM PRODUTO
    WHERE titulo = 'Cyberpunk 2077';
    
    v_preco_calculado := pkg_pixelplace_gerenciamento.f_calcular_preco_atual(v_id_jogo_teste);
    
    DBMS_OUTPUT.PUT_LINE('Preço atual do Cyberpunk 2077 (ID ' || v_id_jogo_teste || '): R$ ' || v_preco_calculado);
    
    IF v_preco_calculado = 199.90 THEN
      DBMS_OUTPUT.PUT_LINE('Resultado: SUCESSO');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Resultado: FALHA (Esperado 199.90)');
    END IF;
    
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('FALHA no Teste 1: ' || SQLERRM);
  END;

  -- 2. Teste da Procedure: p_gerar_relatorio_usuario
  DBMS_OUTPUT.PUT_LINE(CHR(10) || '2. Testando p_gerar_relatorio_usuario...');
  BEGIN
    -- Usamos um ID fixo (4) que sabemos ter dados (do seed 18)
    v_id_usuario_teste := 4; 
    
    pkg_pixelplace_gerenciamento.p_gerar_relatorio_usuario(
      p_id_usuario => v_id_usuario_teste,
      p_relatorio  => v_relatorio_gerado
    );
    
    DBMS_OUTPUT.PUT_LINE('Relatório gerado (ID ' || v_id_usuario_teste || '):');
    DBMS_OUTPUT.PUT_LINE(v_relatorio_gerado);
    
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('FALHA no Teste 2: ' || SQLERRM);
  END;
  
  -- 3. Teste da Procedure: p_classificar_horas_jogo
  DBMS_OUTPUT.PUT_LINE(CHR(10) || '3. Testando p_classificar_horas_jogo...');
  BEGIN
    pkg_pixelplace_gerenciamento.p_classificar_horas_jogo;
    
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('FALHA no Teste 3: ' || SQLERRM);
  END;

  -- 4. Teste dos Triggers (trg_item_validar_preco)
  DBMS_OUTPUT.PUT_LINE(CHR(10) || '4. Testando Triggers (trg_item_validar_preco)...');
  BEGIN
    -- Tenta inserir um item com preço sabidamente errado
    INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
    VALUES (1, 10, 1, v_id_jogo_teste, NULL, 99.99);
    
    DBMS_OUTPUT.PUT_LINE('FALHA no Teste 4: Inserção com preço errado foi PERMITIDA.');
    ROLLBACK;
  EXCEPTION
    WHEN OTHERS THEN
      -- O teste espera que o Trigger lance o erro -20007
      -- Se receber esse erro, o teste foi um sucesso
      IF SQLCODE = -20007 THEN
        DBMS_OUTPUT.PUT_LINE('SUCESSO: Trigger bloqueou a inserção com preço errado.');
      ELSE
        DBMS_OUTPUT.PUT_LINE('FALHA no Teste 4: Erro inesperado. ' || SQLERRM);
      END IF;
      ROLLBACK;
  END;

  DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Testes Concluídos ---');

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro GERAL no bloco de teste: ' || SQLERRM);
    ROLLBACK;
END;
/