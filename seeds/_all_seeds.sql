-- for f in seeds/*.sql; do echo -e "\n\n-- --------------------------------------------------\n-- $f\n-- --------------------------------------------------\n"; cat "$f"; done > _all_seeds.sql

-- --------------------------------------------------
-- seeds/01_add_endereco_cep.sql
-- --------------------------------------------------

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

-- --------------------------------------------------
-- seeds/02_add_plataforma.sql
-- --------------------------------------------------

BEGIN
  INSERT INTO PLATAFORMA (nome, versao) VALUES ('windows', '11');
  INSERT INTO PLATAFORMA (nome, versao) VALUES ('windows', '10');
  INSERT INTO PLATAFORMA (nome, versao) VALUES ('macos', '14');
  INSERT INTO PLATAFORMA (nome, versao) VALUES ('macos', '13');
  INSERT INTO PLATAFORMA (nome, versao) VALUES ('linux', '6.9');
  INSERT INTO PLATAFORMA (nome, versao) VALUES ('linux', '6.8');
  INSERT INTO PLATAFORMA (nome, versao) VALUES ('linux', '6.6');
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Plataformas inseridas com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir plataformas: ' || SQLERRM);
    ROLLBACK;
END;
/

-- --------------------------------------------------
-- seeds/03_add_publicadora.sql
-- --------------------------------------------------

BEGIN
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('CD Projekt Red', 'Polônia');
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('Ubisoft', 'França');
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('Electronic Arts', 'EUA');
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('Rockstar Games', 'EUA');
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('FromSoftware', 'Japão');
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('Nintendo', 'Japão');
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('Sony Interactive Entertainment', 'Japão/EUA');
  INSERT INTO PUBLICADORA (nome, pais) VALUES ('Microsoft', 'EUA');
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Publicadoras inseridas com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir publicadoras: ' || SQLERRM);
    ROLLBACK;
END;
/

-- --------------------------------------------------
-- seeds/04_add_genero.sql
-- --------------------------------------------------

BEGIN
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('RPG', NULL);
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Ação', NULL);
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Aventura', NULL);
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Simulação', NULL);
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('RPG de Ação', 'RPG');
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Plataforma', 'Ação');
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Tiro', 'Ação');
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Luta', 'Ação');
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Mundo Aberto', 'Aventura');
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Corrida', 'Simulação');
  INSERT INTO GENERO (pk_nome, fk_genero_pai) VALUES ('Tiro em Primeira Pessoa (FPS)', 'Tiro');
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Gêneros inseridos com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir gêneros: ' || SQLERRM);
    ROLLBACK;
END;
/

-- --------------------------------------------------
-- seeds/05_add_promocao.sql
-- --------------------------------------------------

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

-- --------------------------------------------------
-- seeds/06_add_usuario_and_usuario_telefone.sql
-- --------------------------------------------------

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

-- --------------------------------------------------
-- seeds/07_add_produto.sql
-- --------------------------------------------------

DECLARE
  v_pub_cdpr     PUBLICADORA.pk_id_pub%TYPE;
  v_pub_ubisoft  PUBLICADORA.pk_id_pub%TYPE;
  v_pub_ea       PUBLICADORA.pk_id_pub%TYPE;
  v_pub_rockstar PUBLICADORA.pk_id_pub%TYPE;
  v_pub_fromsw   PUBLICADORA.pk_id_pub%TYPE;
  v_pub_nintendo PUBLICADORA.pk_id_pub%TYPE;
  v_pub_sony     PUBLICADORA.pk_id_pub%TYPE;
  v_pub_ms       PUBLICADORA.pk_id_pub%TYPE;

BEGIN
  SELECT pk_id_pub INTO v_pub_cdpr     FROM PUBLICADORA WHERE nome = 'CD Projekt Red';
  SELECT pk_id_pub INTO v_pub_ubisoft  FROM PUBLICADORA WHERE nome = 'Ubisoft';
  SELECT pk_id_pub INTO v_pub_ea       FROM PUBLICADORA WHERE nome = 'Electronic Arts';
  SELECT pk_id_pub INTO v_pub_rockstar FROM PUBLICADORA WHERE nome = 'Rockstar Games';
  SELECT pk_id_pub INTO v_pub_fromsw   FROM PUBLICADORA WHERE nome = 'FromSoftware';
  SELECT pk_id_pub INTO v_pub_nintendo FROM PUBLICADORA WHERE nome = 'Nintendo';
  SELECT pk_id_pub INTO v_pub_sony     FROM PUBLICADORA WHERE nome = 'Sony Interactive Entertainment';
  SELECT pk_id_pub INTO v_pub_ms       FROM PUBLICADORA WHERE nome = 'Microsoft';

  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('JOGO', 'Um RPG de ação e aventura em mundo aberto.', 'Cyberpunk 2077', TO_DATE('2020-12-10', 'YYYY-MM-DD'), v_pub_cdpr);
  
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('JOGO', 'Explore a era dos Vikings.', 'Assassin''s Creed Valhalla', TO_DATE('2020-11-10', 'YYYY-MM-DD'), v_pub_ubisoft);
  
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('JOGO', 'Uma aventura de faroeste em mundo aberto.', 'Red Dead Redemption 2', TO_DATE('2018-10-26', 'YYYY-MM-DD'), v_pub_rockstar);
  
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('JOGO', 'RPG de ação aclamado em um mundo de fantasia sombria.', 'Elden Ring', TO_DATE('2022-02-25', 'YYYY-MM-DD'), v_pub_fromsw);
  
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('JOGO', 'A jornada de Kratos e Atreus pelos reinos nórdicos.', 'God of War Ragnarök', TO_DATE('2022-11-09', 'YYYY-MM-DD'), v_pub_sony);
  
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('JOGO', 'O jogo de corrida definitivo do Mario.', 'Mario Kart 8 Deluxe', TO_DATE('2017-04-28', 'YYYY-MM-DD'), v_pub_nintendo);

  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('ADICIONAL', 'Assinatura mensal com bônus e itens exclusivos em Night City.', 'Passe Vantagem - Cyberpunk 2077', TO_DATE('2024-01-01', 'YYYY-MM-DD'), v_pub_cdpr);

  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('ADICIONAL', 'Acesso mensal ao Clube dos Ocultos, com recompensas semanais.', 'Clube dos Ocultos - AC Valhalla', TO_DATE('2021-05-01', 'YYYY-MM-DD'), v_pub_ubisoft);

  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('ADICIONAL', 'Expansão de história para Cyberpunk 2077.', 'Cyberpunk 2077: Phantom Liberty', TO_DATE('2023-09-26', 'YYYY-MM-DD'), v_pub_cdpr);
  
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('ADICIONAL', 'Expansão de história para Elden Ring.', 'Elden Ring: Shadow of the Erdtree', TO_DATE('2024-06-21', 'YYYY-MM-DD'), v_pub_fromsw);
    
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('ADICIONAL', 'Pacote de moedas do jogo.', 'Pacote Hélice (Médio) - AC Valhalla', TO_DATE('2020-11-10', 'YYYY-MM-DD'), v_pub_ubisoft);
  
  INSERT INTO PRODUTO (tipo_prod, descricao, titulo, data_lanc, fk_publicadora)
  VALUES ('ADICIONAL', 'Barras de Ouro para Red Dead Online.', '25 Barras de Ouro - RDR2', TO_DATE('2018-11-30', 'YYYY-MM-DD'), v_pub_rockstar);

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Produtos inseridos com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir produtos: ' || SQLERRM);
    ROLLBACK;
END;
/

-- --------------------------------------------------
-- seeds/08_add_jogo.sql
-- --------------------------------------------------

DECLARE
  v_prod_cyberpunk NUMBER;
  v_prod_valhalla  NUMBER;
  v_prod_rdr2      NUMBER;
  v_prod_elden     NUMBER;
  v_prod_gow       NUMBER;
  v_prod_mario     NUMBER;

BEGIN
  SELECT pk_id_prod INTO v_prod_cyberpunk FROM PRODUTO WHERE titulo = 'Cyberpunk 2077';
  SELECT pk_id_prod INTO v_prod_valhalla  FROM PRODUTO WHERE titulo = 'Assassin''s Creed Valhalla';
  SELECT pk_id_prod INTO v_prod_rdr2      FROM PRODUTO WHERE titulo = 'Red Dead Redemption 2';
  SELECT pk_id_prod INTO v_prod_elden     FROM PRODUTO WHERE titulo = 'Elden Ring';
  SELECT pk_id_prod INTO v_prod_gow       FROM PRODUTO WHERE titulo = 'God of War Ragnarök';
  SELECT pk_id_prod INTO v_prod_mario     FROM PRODUTO WHERE titulo = 'Mario Kart 8 Deluxe';

  INSERT ALL
    INTO JOGO (pk_fk_id_prod, tamanho, requisitos, class_indicativa)
    VALUES (v_prod_cyberpunk, 110.50, 'NVIDIA GTX 1060, 16GB RAM', '18')
    
    INTO JOGO (pk_fk_id_prod, tamanho, requisitos, class_indicativa)
    VALUES (v_prod_valhalla, 130.20, 'NVIDIA GTX 960, 8GB RAM', '18')
    
    INTO JOGO (pk_fk_id_prod, tamanho, requisitos, class_indicativa)
    VALUES (v_prod_rdr2, 150.00, 'NVIDIA GTX 1060 6GB, 12GB RAM', '18')
    
    INTO JOGO (pk_fk_id_prod, tamanho, requisitos, class_indicativa)
    VALUES (v_prod_elden, 60.00, 'NVIDIA GTX 1060 3GB, 12GB RAM', '16')
    
    INTO JOGO (pk_fk_id_prod, tamanho, requisitos, class_indicativa)
    VALUES (v_prod_gow, 84.00, 'Exclusivo PlayStation 5', '18')
    
    INTO JOGO (pk_fk_id_prod, tamanho, requisitos, class_indicativa)
    VALUES (v_prod_mario, 14.30, 'Exclusivo Nintendo Switch', 'L')
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela JOGO populada com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela JOGO: ' || SQLERRM);
    ROLLBACK;
END;
/

-- --------------------------------------------------
-- seeds/09_add_adicional.sql
-- --------------------------------------------------

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

-- --------------------------------------------------
-- seeds/10_add_expansao.sql
-- --------------------------------------------------

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

-- --------------------------------------------------
-- seeds/11_add_microtransacao.sql
-- --------------------------------------------------

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

-- --------------------------------------------------
-- seeds/12_add_assinatura.sql
-- --------------------------------------------------

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

-- --------------------------------------------------
-- seeds/13_add_historico_valor.sql
-- --------------------------------------------------

DECLARE
  v_prod_cyberpunk NUMBER;
  v_prod_valhalla  NUMBER;
  v_prod_rdr2      NUMBER;
  v_prod_elden     NUMBER;
  v_prod_gow       NUMBER;
  v_prod_mario     NUMBER;
  v_prod_phantom   NUMBER;
  v_prod_erdtree   NUMBER;
  v_prod_helice    NUMBER;
  v_prod_ouro      NUMBER;
  v_prod_vantagem  NUMBER;
  v_prod_clube     NUMBER;

BEGIN
  SELECT pk_id_prod INTO v_prod_cyberpunk FROM PRODUTO WHERE titulo = 'Cyberpunk 2077';
  SELECT pk_id_prod INTO v_prod_valhalla  FROM PRODUTO WHERE titulo = 'Assassin''s Creed Valhalla';
  SELECT pk_id_prod INTO v_prod_rdr2      FROM PRODUTO WHERE titulo = 'Red Dead Redemption 2';
  SELECT pk_id_prod INTO v_prod_elden     FROM PRODUTO WHERE titulo = 'Elden Ring';
  SELECT pk_id_prod INTO v_prod_gow       FROM PRODUTO WHERE titulo = 'God of War Ragnarök';
  SELECT pk_id_prod INTO v_prod_mario     FROM PRODUTO WHERE titulo = 'Mario Kart 8 Deluxe';
  SELECT pk_id_prod INTO v_prod_phantom   FROM PRODUTO WHERE titulo = 'Cyberpunk 2077: Phantom Liberty';
  SELECT pk_id_prod INTO v_prod_erdtree   FROM PRODUTO WHERE titulo = 'Elden Ring: Shadow of the Erdtree';
  SELECT pk_id_prod INTO v_prod_helice    FROM PRODUTO WHERE titulo = 'Pacote Hélice (Médio) - AC Valhalla';
  SELECT pk_id_prod INTO v_prod_ouro      FROM PRODUTO WHERE titulo = '25 Barras de Ouro - RDR2';
  SELECT pk_id_prod INTO v_prod_vantagem  FROM PRODUTO WHERE titulo = 'Passe Vantagem - Cyberpunk 2077';
  SELECT pk_id_prod INTO v_prod_clube     FROM PRODUTO WHERE titulo = 'Clube dos Ocultos - AC Valhalla';

  INSERT ALL
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_cyberpunk, TO_DATE('2020-12-10', 'YYYY-MM-DD'), 249.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_cyberpunk, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 199.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_valhalla, TO_DATE('2020-11-10', 'YYYY-MM-DD'), 229.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_valhalla, TO_DATE('2023-06-01', 'YYYY-MM-DD'), 149.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_rdr2, TO_DATE('2018-10-26', 'YYYY-MM-DD'), 249.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_elden, TO_DATE('2022-02-25', 'YYYY-MM-DD'), 299.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_gow, TO_DATE('2022-11-09', 'YYYY-MM-DD'), 349.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_mario, TO_DATE('2017-04-28', 'YYYY-MM-DD'), 299.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_phantom, TO_DATE('2023-09-26', 'YYYY-MM-DD'), 149.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_erdtree, TO_DATE('2024-06-21', 'YYYY-MM-DD'), 199.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_helice, TO_DATE('2020-11-10', 'YYYY-MM-DD'), 49.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_ouro, TO_DATE('2018-11-30', 'YYYY-MM-DD'), 79.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_vantagem, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 29.90)
    INTO HISTORICO_VALOR (pk_fk_id_produto, pk_data_inicio, valor) VALUES (v_prod_clube, TO_DATE('2021-05-01', 'YYYY-MM-DD'), 39.90)
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Histórico de valores inserido com sucesso para 12 produtos.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir histórico de valores: ' || SQLERRM);
    ROLLBACK;
END;
/

-- --------------------------------------------------
-- seeds/14_add_promocao_produto.sql
-- --------------------------------------------------

DECLARE
  v_promo_2022 NUMBER;
  v_promo_2023 NUMBER;
  v_promo_2024 NUMBER;
  v_promo_2025 NUMBER;
  
  v_prod_cyberpunk NUMBER;
  v_prod_valhalla  NUMBER;
  v_prod_rdr2      NUMBER;
  v_prod_elden     NUMBER;
  v_prod_phantom   NUMBER;

BEGIN
  SELECT pk_id_promo INTO v_promo_2022 FROM PROMOCAO WHERE nome = 'Promoção de Natal 2022';
  SELECT pk_id_promo INTO v_promo_2023 FROM PROMOCAO WHERE nome = 'Promoção de Natal 2023';
  SELECT pk_id_promo INTO v_promo_2024 FROM PROMOCAO WHERE nome = 'Promoção de Natal 2024';
  SELECT pk_id_promo INTO v_promo_2025 FROM PROMOCAO WHERE nome = 'Promoção de Natal 2025';

  SELECT pk_id_prod INTO v_prod_cyberpunk FROM PRODUTO WHERE titulo = 'Cyberpunk 2077';
  SELECT pk_id_prod INTO v_prod_valhalla  FROM PRODUTO WHERE titulo = 'Assassin''s Creed Valhalla';
  SELECT pk_id_prod INTO v_prod_rdr2      FROM PRODUTO WHERE titulo = 'Red Dead Redemption 2';
  SELECT pk_id_prod INTO v_prod_elden     FROM PRODUTO WHERE titulo = 'Elden Ring';
  SELECT pk_id_prod INTO v_prod_phantom   FROM PRODUTO WHERE titulo = 'Cyberpunk 2077: Phantom Liberty';

  INSERT ALL
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2022, v_prod_rdr2)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2022, v_prod_valhalla)
    
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2023, v_prod_rdr2)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2023, v_prod_valhalla)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2023, v_prod_cyberpunk)

    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2024, v_prod_rdr2)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2024, v_prod_valhalla)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2024, v_prod_cyberpunk)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2024, v_prod_elden)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2024, v_prod_phantom)
    
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2025, v_prod_rdr2)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2025, v_prod_valhalla)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2025, v_prod_cyberpunk)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2025, v_prod_elden)
    INTO PROMOCAO_PRODUTO (pk_fk_id_promo, pk_fk_id_produto) VALUES (v_promo_2025, v_prod_phantom)
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela PROMOCAO_PRODUTO populada com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela PROMOCAO_PRODUTO: ' || SQLERRM);
    ROLLBACK;
END;
/

-- --------------------------------------------------
-- seeds/15_add_jogo_idioma.sql
-- --------------------------------------------------

DECLARE
  v_prod_cyberpunk NUMBER;
  v_prod_valhalla  NUMBER;
  v_prod_rdr2      NUMBER;
  v_prod_elden     NUMBER;
  v_prod_gow       NUMBER;
  v_prod_mario     NUMBER;

BEGIN
  SELECT pk_id_prod INTO v_prod_cyberpunk FROM PRODUTO WHERE titulo = 'Cyberpunk 2077';
  SELECT pk_id_prod INTO v_prod_valhalla  FROM PRODUTO WHERE titulo = 'Assassin''s Creed Valhalla';
  SELECT pk_id_prod INTO v_prod_rdr2      FROM PRODUTO WHERE titulo = 'Red Dead Redemption 2';
  SELECT pk_id_prod INTO v_prod_elden     FROM PRODUTO WHERE titulo = 'Elden Ring';
  SELECT pk_id_prod INTO v_prod_gow       FROM PRODUTO WHERE titulo = 'God of War Ragnarök';
  SELECT pk_id_prod INTO v_prod_mario     FROM PRODUTO WHERE titulo = 'Mario Kart 8 Deluxe';

  INSERT ALL
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_cyberpunk, 'Português (BR)')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_cyberpunk, 'Inglês')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_cyberpunk, 'Polonês')
    
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_valhalla, 'Português (BR)')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_valhalla, 'Inglês')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_valhalla, 'Francês')

    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_rdr2, 'Português (BR)')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_rdr2, 'Inglês')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_rdr2, 'Espanhol')

    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_elden, 'Português (BR)')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_elden, 'Inglês')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_elden, 'Japonês')

    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_gow, 'Português (BR)')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_gow, 'Inglês')
    
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_mario, 'Português (BR)')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_mario, 'Inglês')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_mario, 'Japonês')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_mario, 'Espanhol')
    INTO JOGO_IDIOMA (pk_fk_id_jogo, pk_idioma) VALUES (v_prod_mario, 'Francês')
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela JOGO_IDIOMA populada com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela JOGO_IDIOMA: ' || SQLERRM);
    ROLLBACK;
END;
/

-- --------------------------------------------------
-- seeds/16_add_jogo_genero.sql
-- --------------------------------------------------

DECLARE
  v_prod_cyberpunk NUMBER;
  v_prod_valhalla  NUMBER;
  v_prod_rdr2      NUMBER;
  v_prod_elden     NUMBER;
  v_prod_gow       NUMBER;
  v_prod_mario     NUMBER;
BEGIN
  SELECT pk_id_prod INTO v_prod_cyberpunk FROM PRODUTO WHERE titulo = 'Cyberpunk 2077';
  SELECT pk_id_prod INTO v_prod_valhalla  FROM PRODUTO WHERE titulo = 'Assassin''s Creed Valhalla';
  SELECT pk_id_prod INTO v_prod_rdr2      FROM PRODUTO WHERE titulo = 'Red Dead Redemption 2';
  SELECT pk_id_prod INTO v_prod_elden     FROM PRODUTO WHERE titulo = 'Elden Ring';
  SELECT pk_id_prod INTO v_prod_gow       FROM PRODUTO WHERE titulo = 'God of War Ragnarök';
  SELECT pk_id_prod INTO v_prod_mario     FROM PRODUTO WHERE titulo = 'Mario Kart 8 Deluxe';

  INSERT ALL
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_cyberpunk, 'RPG de Ação')
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_cyberpunk, 'Mundo Aberto')
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_cyberpunk, 'Tiro em Primeira Pessoa (FPS)')
    
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_valhalla, 'RPG de Ação')
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_valhalla, 'Mundo Aberto')
    
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_rdr2, 'Ação')
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_rdr2, 'Aventura')
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_rdr2, 'Mundo Aberto')
    
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_elden, 'RPG de Ação')
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_elden, 'Mundo Aberto')
    
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_gow, 'Ação')
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_gow, 'Aventura')
    
    INTO JOGO_GENERO (pk_fk_id_jogo, pk_fk_nome_genero) VALUES (v_prod_mario, 'Corrida')
  SELECT 1 FROM dual;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela JOGO_GENERO populada com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela JOGO_GENERO: ' || SQLERRM);
    ROLLBACK;
END;
/

-- --------------------------------------------------
-- seeds/17_add_pedido_and_item.sql
-- --------------------------------------------------

BEGIN
  -- P1 (U1 - Natal 22 - 20%)
  -- Jogo: RDR 2 (ID 3) | Preço Cheio: 249.90
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2022-12-10 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Cartão de Crédito', 1);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 3, 1, 199.92);

  -- P2 (U2 - Natal 23 - 25%)
  -- Jogo: AC Valhalla (ID 2) | Preço Cheio: 149.90
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2023-12-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 2);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 2, 2, 112.42);

  -- P3 (U3 - Natal 23 - 25%)
  -- Jogo: Cyberpunk 2077 (ID 1) | Preço Cheio: 249.90
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2023-12-18 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 3);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 1, 2, 187.42);

  -- P4 (U4)
  -- Jogo: Elden Ring (ID 4)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2023-10-20 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Boleto', 4);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 4, NULL, 299.90);

  -- P5 (U5)
  -- Jogo: God of War (ID 5)
  -- Jogo: Mario Kart (ID 6)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2023-11-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Saldo Carteira', 5);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 5, NULL, 349.90);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 2, 1, 6, NULL, 299.90);

  -- P6 (U6 - Natal 24 - 30%)
  -- Jogo: Elden Ring (ID 4) | Preço Cheio: 299.90
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-12-02 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 6);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 4, 3, 209.93);

  -- P7 (U7)
  -- Jogo: Cyberpunk 2077 (ID 1) | Preço novo
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-05-15 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Cartão de Crédito', 7);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 1, NULL, 199.90);

  -- P8 (U8)
  -- Jogo: RDR 2 (ID 3)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-08-01 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 8);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 3, NULL, 249.90);

  -- P9 (U9)
  -- Jogo: God of War (ID 5)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-10-30 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Boleto', 9);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 5, NULL, 349.90);

  -- P10 (U10)
  -- Jogo: AC Valhalla (ID 2)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2025-01-10 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 10);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 2, NULL, 149.90);

  -- P11 (U3 - P3)
  -- Adicional: Phantom Liberty (ID 9)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-01-15 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 3);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 9, NULL, 149.90);

  -- P12 (U3 - P3)
  -- Adicional: Passe Vantagem (ID 7)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-02-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 3);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 7, NULL, 29.90);

  -- P13 (U8 - P8)
  -- Adicional: Barras de Ouro (ID 11)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-08-02 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Saldo Carteira', 8);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 11, NULL, 79.90);

  -- P14 (U4 - P4)
  -- Adicional: Shadow of Erdtree (ID 12)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2024-07-01 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Cartão de Crédito', 4);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 12, NULL, 199.90);

  -- P15 (U10 - P10)
  -- Adicional: Pacote Hélice (ID 10)
  INSERT INTO PEDIDO (pk_id_pedido, data_hora, metodo_pag, fk_id_usuario) 
  VALUES (seq_pedido.NEXTVAL, TO_TIMESTAMP('2025-01-11 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Pix', 10);
  INSERT INTO ITEM (pk_fk_id_pedido, pk_num_item, quantidade, fk_id_produto, fk_id_promo, valor_unitario_pago)
  VALUES (seq_pedido.CURRVAL, 1, 1, 10, NULL, 49.90);
  
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('15 Pedidos e seus Itens inseridos com sucesso.');

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao inserir Pedidos e Itens: ' || SQLERRM);
    ROLLBACK;
END;
/

-- --------------------------------------------------
-- seeds/18_add_sessao_jogo.sql
-- --------------------------------------------------

DECLARE
  v_plat_win11 NUMBER;
  v_plat_linux NUMBER;
  v_plat_macos NUMBER;
  v_plat_win10 NUMBER;
BEGIN
  SELECT pk_id_plataforma INTO v_plat_win11 FROM PLATAFORMA WHERE nome = 'windows' AND versao = '11';
  SELECT pk_id_plataforma INTO v_plat_linux FROM PLATAFORMA WHERE nome = 'linux' AND versao = '6.9';
  SELECT pk_id_plataforma INTO v_plat_macos FROM PLATAFORMA WHERE nome = 'macos' AND versao = '14';
  SELECT pk_id_plataforma INTO v_plat_win10 FROM PLATAFORMA WHERE nome = 'windows' AND versao = '10';

  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (1, 3, v_plat_win11, TO_TIMESTAMP('2023-01-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4.5);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (1, 3, v_plat_win11, TO_TIMESTAMP('2023-01-11 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (1, 3, v_plat_win11, TO_TIMESTAMP('2023-01-13 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);

  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (2, 2, v_plat_win10, TO_TIMESTAMP('2024-01-20 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (2, 2, v_plat_win10, TO_TIMESTAMP('2024-01-22 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5.0);

  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (3, 1, v_plat_win11, TO_TIMESTAMP('2024-01-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5.5);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (3, 1, v_plat_win11, TO_TIMESTAMP('2024-01-21 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (3, 1, v_plat_win11, TO_TIMESTAMP('2024-01-22 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (3, 1, v_plat_win11, TO_TIMESTAMP('2024-01-25 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4.5);

  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-02 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5.5);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-03 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-04 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-05 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (4, 4, v_plat_linux, TO_TIMESTAMP('2024-11-08 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);

  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (7, 1, v_plat_win11, TO_TIMESTAMP('2024-06-01 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4.5);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (7, 1, v_plat_win11, TO_TIMESTAMP('2024-06-05 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6.0);
  
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (5, 6, v_plat_macos, TO_TIMESTAMP('2023-11-12 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3.0);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (5, 6, v_plat_macos, TO_TIMESTAMP('2023-11-13 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2.5);
  INSERT INTO SESSAO_JOGO (fk_id_usuario, fk_id_jogo, fk_id_plataforma, data_hora_inicio, duracao)
  VALUES (5, 6, v_plat_macos, TO_TIMESTAMP('2023-11-15 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2.5);

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela SESSAO_JOGO populada com sessões realistas.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela SESSAO_JOGO: ' || SQLERRM);
    ROLLBACK;
END;
/

-- --------------------------------------------------
-- seeds/19_add_progresso.sql
-- --------------------------------------------------

BEGIN
  INSERT INTO PROGRESSO (fk_id_usuario, fk_id_jogo, horas_jogadas)
  SELECT 
    fk_id_usuario,
    fk_id_jogo,
    SUM(duracao) AS total_horas
  FROM 
    SESSAO_JOGO
  GROUP BY 
    fk_id_usuario, fk_id_jogo;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela PROGRESSO populada com a soma das horas de sessão.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela PROGRESSO: ' || SQLERRM);
    ROLLBACK;
END;
/

-- --------------------------------------------------
-- seeds/20_add_conquistas.sql
-- --------------------------------------------------

BEGIN
  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (1, 3, 'FORASTEIRO', TO_TIMESTAMP('2023-01-11 11:00:00', 'YYYY-MM-DD HH24:MI:SS'));
  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (1, 3, 'ESPIRITO_DO_OESTE', TO_TIMESTAMP('2023-01-14 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));

  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (2, 2, 'O_INICIO_DA_SAGA', TO_TIMESTAMP('2024-01-23 21:00:00', 'YYYY-MM-DD HH24:MI:SS'));

  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (3, 1, 'BEM_VINDO_A_NIGHT_CITY', TO_TIMESTAMP('2024-01-20 11:30:00', 'YYYY-MM-DD HH24:MI:SS'));
  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (3, 1, 'FANTASMA_DA_CIDADE', TO_TIMESTAMP('2024-01-23 15:00:00', 'YYYY-MM-DD HH24:MI:SS'));
  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (3, 1, 'LENDA_DO_AFTERLIFE', TO_TIMESTAMP('2024-01-26 17:00:00', 'YYYY-MM-DD HH24:MI:SS'));

  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (4, 4, 'MACULADO', TO_TIMESTAMP('2024-11-01 08:01:00', 'YYYY-MM-DD HH24:MI:SS'));
  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (4, 4, 'SENHOR_PRISTINO', TO_TIMESTAMP('2024-11-09 19:00:00', 'YYYY-MM-DD HH24:MI:SS'));

  INSERT INTO CONQUISTAS (fk_id_usuario, fk_id_jogo, conquistas, data_obtencao) 
  VALUES (7, 1, 'BEM_VINDO_A_NIGHT_CITY', TO_TIMESTAMP('2024-06-02 19:30:00', 'YYYY-MM-DD HH24:MI:SS'));

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Tabela CONQUISTAS populada com sucesso.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erro ao popular tabela CONQUISTAS: ' || SQLERRM);
    ROLLBACK;
END;
/