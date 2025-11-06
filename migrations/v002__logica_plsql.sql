SET SERVEROUTPUT ON;

-- Define a "interface" (SPEC) do pacote de lógica de gerenciamento.
CREATE OR REPLACE PACKAGE pkg_pixelplace_gerenciamento AS

  FUNCTION f_calcular_preco_atual (
    p_id_produto IN PRODUTO.pk_id_prod%TYPE
  ) RETURN HISTORICO_VALOR.valor%TYPE;

  PROCEDURE p_gerar_relatorio_usuario (
    p_id_usuario IN USUARIO.pk_id_usuario%TYPE,
    p_relatorio  OUT CLOB
  );

  PROCEDURE p_classificar_horas_jogo;

END pkg_pixelplace_gerenciamento;
/

CREATE OR REPLACE PACKAGE BODY pkg_pixelplace_gerenciamento AS

  FUNCTION f_calcular_preco_atual (
    p_id_produto IN PRODUTO.pk_id_prod%TYPE
  ) RETURN HISTORICO_VALOR.valor%TYPE
  IS
    v_preco HISTORICO_VALOR.valor%TYPE;
  BEGIN
    SELECT valor INTO v_preco
    FROM HISTORICO_VALOR
    WHERE pk_fk_id_produto = p_id_produto
      AND pk_data_inicio <= SYSDATE
    ORDER BY pk_data_inicio DESC
    FETCH FIRST 1 ROWS ONLY;

    RETURN v_preco;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Erro ao calcular preço atual: ' || SQLERRM);
  END f_calcular_preco_atual;


  PROCEDURE p_gerar_relatorio_usuario (
    p_id_usuario IN USUARIO.pk_id_usuario%TYPE,
    p_relatorio  OUT CLOB
  )
  IS
    v_usuario_info USUARIO%ROWTYPE;
    v_linha VARCHAR2(1000);
    v_encontrou_sessoes BOOLEAN := FALSE; -- Flag para verificar se o cursor retornou linhas

    CURSOR c_sessoes_usuario (c_id_usuario NUMBER) IS
      SELECT PR.titulo, P.nome AS plataforma, S.data_hora_inicio, S.duracao
      FROM SESSAO_JOGO S
      JOIN PRODUTO PR ON S.fk_id_jogo = PR.pk_id_prod
      JOIN PLATAFORMA P ON S.fk_id_plataforma = P.pk_id_plataforma
      WHERE S.fk_id_usuario = c_id_usuario
      ORDER BY S.data_hora_inicio DESC;
      
  BEGIN
    SELECT * INTO v_usuario_info
    FROM USUARIO
    WHERE pk_id_usuario = p_id_usuario;
    
    p_relatorio := 'Relatório de Atividades para: ' || v_usuario_info.nome || CHR(10);
    p_relatorio := p_relatorio || 'Email: ' || v_usuario_info.email || CHR(10);
    p_relatorio := p_relatorio || '-------------------------------------' || CHR(10);
    p_relatorio := p_relatorio || 'SESSÕES DE JOGO:' || CHR(10);

    FOR r_sessao IN c_sessoes_usuario(p_id_usuario) LOOP
      v_encontrou_sessoes := TRUE;
      
      v_linha := '  - Jogo: ' || r_sessao.titulo || CHR(10) ||
                 '    Plataforma: ' || r_sessao.plataforma || CHR(10) ||
                 '    Início: ' || TO_CHAR(r_sessao.data_hora_inicio, 'DD/MM/YYYY HH24:MI') || CHR(10) ||
                 '    Duração: ' || r_sessao.duracao || ' horas' || CHR(10) || CHR(10);
      p_relatorio := p_relatorio || v_linha;
    END LOOP;
    
    IF NOT v_encontrou_sessoes THEN
       p_relatorio := p_relatorio || 'Nenhuma sessão de jogo encontrada.' || CHR(10);
    END IF;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      p_relatorio := 'Erro: Usuário com ID ' || p_id_usuario || ' não encontrado.';
    WHEN OTHERS THEN
      p_relatorio := 'Erro inesperado ao gerar relatório: ' || SQLERRM;
  END p_gerar_relatorio_usuario;


  PROCEDURE p_classificar_horas_jogo
  IS
    TYPE t_progresso_rec IS RECORD (
      nome_usuario USUARIO.nome%TYPE,
      titulo_jogo  PRODUTO.titulo%TYPE,
      horas_jogadas PROGRESSO.horas_jogadas%TYPE
    );
    
    TYPE t_tabela_progresso IS TABLE OF t_progresso_rec;
    
    v_progressos t_tabela_progresso;
    v_classificacao VARCHAR2(100);
    i NUMBER := 1;
    
  BEGIN
    -- Carrega todos os dados de progresso em uma tabela em memória
    SELECT U.nome, P.titulo, PR.horas_jogadas
    BULK COLLECT INTO v_progressos
    FROM PROGRESSO PR
    JOIN USUARIO U ON PR.fk_id_usuario = U.pk_id_usuario
    JOIN PRODUTO P ON PR.fk_id_jogo = P.pk_id_prod;

    DBMS_OUTPUT.PUT_LINE('--- Classificação de Horas Jogadas ---');

    WHILE i <= v_progressos.COUNT LOOP
      
      v_classificacao := CASE
        WHEN v_progressos(i).horas_jogadas < 10 THEN 'Iniciante'
        WHEN v_progressos(i).horas_jogadas >= 10 AND v_progressos(i).horas_jogadas < 30 THEN 'Regular'
        WHEN v_progressos(i).horas_jogadas >= 30 THEN 'Viciado(a)'
        ELSE 'N/A'
      END;
      
      DBMS_OUTPUT.PUT_LINE(
        v_progressos(i).nome_usuario || ' é ' || v_classificacao ||
        ' em ' || v_progressos(i).titulo_jogo || ' (' || v_progressos(i).horas_jogadas || 'h)'
      );
      
      i := i + 1;
    END LOOP;
    
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro ao classificar horas: ' || SQLERRM);
  END p_classificar_horas_jogo;

END pkg_pixelplace_gerenciamento;
/

-- Trigger de Linha (FOR EACH ROW) para validar o preço de um item antes de inseri-lo.
CREATE OR REPLACE TRIGGER trg_item_validar_preco
BEFORE INSERT ON ITEM
FOR EACH ROW
DECLARE
  v_preco_atual        HISTORICO_VALOR.valor%TYPE;
  v_percentual_promo   PROMOCAO.percentual%TYPE;
  v_preco_com_desconto NUMBER(10, 2);
  v_margem_erro        CONSTANT NUMBER(3, 2) := 0.01;
BEGIN
  v_preco_atual := pkg_pixelplace_gerenciamento.f_calcular_preco_atual(:new.fk_id_produto);

  IF v_preco_atual IS NULL THEN
    RAISE_APPLICATION_ERROR(-20005, 'Produto ' || :new.fk_id_produto || ' não possui histórico de preço.');
  END IF;

  IF :new.fk_id_promo IS NOT NULL THEN
    SELECT percentual INTO v_percentual_promo
    FROM PROMOCAO
    WHERE pk_id_promo = :new.fk_id_promo;
    
    v_preco_com_desconto := v_preco_atual * (1 - (v_percentual_promo / 100));
    
    IF ABS(:new.valor_unitario_pago - v_preco_com_desconto) > v_margem_erro THEN
      RAISE_APPLICATION_ERROR(-20006, 'Preço pago (' || :new.valor_unitario_pago || ') é inválido para a promoção. Esperado: ' || v_preco_com_desconto);
    END IF;
    
  ELSE
    IF ABS(:new.valor_unitario_pago - v_preco_atual) > v_margem_erro THEN
       RAISE_APPLICATION_ERROR(-20007, 'Preço pago (' || :new.valor_unitario_pago || ') é inválido. Preço cheio atual: ' || v_preco_atual);
    END IF;
  END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20008, 'Promoção (ID ' || :new.fk_id_promo || ') não encontrada.');
END;
/

CREATE OR REPLACE TRIGGER trg_produto_bloqueio_fds
BEFORE UPDATE OR INSERT ON PRODUTO
DECLARE
  v_dia_semana VARCHAR2(3);
BEGIN
  v_dia_semana := TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH');
  
  IF v_dia_semana IN ('SAT', 'SUN') THEN
    RAISE_APPLICATION_ERROR(-20010, 'Modificações na tabela PRODUTO não são permitidas nos fins de semana.');
  END IF;
END;
/

-- Recompila os triggers
-- caso o pacote 'pkg_pixelplace_gerenciamento' seja recriado.
ALTER TRIGGER trg_item_validar_preco COMPILE;
/
ALTER TRIGGER trg_produto_bloqueio_fds COMPILE;
/