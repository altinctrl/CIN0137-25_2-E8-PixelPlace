CREATE SEQUENCE seq_plataforma
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_usuario
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_publicadora
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_produto
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_promocao
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_pedido
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_sessao_jogo
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE seq_conquistas
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE ENDERECO_CEP (
  pk_CEP
    VARCHAR2(9 CHAR)
    NOT NULL,
  logradouro
    VARCHAR2(255 CHAR)
    NOT NULL,
  cidade
    VARCHAR2(100 CHAR)
    NOT NULL,
  UF
    CHAR(2 CHAR)
    NOT NULL,
  
  CONSTRAINT pk_endereco_cep
    PRIMARY KEY (pk_CEP),
  CONSTRAINT chk_cep_formato
    CHECK (REGEXP_LIKE(pk_CEP, '^\d{5}-\d{3}$')),
  CONSTRAINT chk_uf_valido
    CHECK (UF IN ('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 
    'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 
    'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'))
);

CREATE TABLE PLATAFORMA (
  pk_id_plataforma
    NUMBER(10) 
    DEFAULT seq_plataforma.NEXTVAL
    NOT NULL,
  nome
    VARCHAR2(100 CHAR)
    NOT NULL,
  versao
    VARCHAR2(100 CHAR),
  
  CONSTRAINT pk_plataforma
    PRIMARY KEY (pk_id_plataforma),
  CONSTRAINT uq_plat_nome_versao
    UNIQUE (nome, versao)
);

CREATE TABLE PUBLICADORA (
  pk_id_pub
    NUMBER(10)
    DEFAULT seq_publicadora.NEXTVAL
    NOT NULL,
  nome
    VARCHAR2(100 CHAR)
    NOT NULL,
  pais
    VARCHAR2(100 CHAR)
    NOT NULL,
  
  CONSTRAINT pk_publicadora
    PRIMARY KEY (pk_id_pub),
  CONSTRAINT uq_publicadora_nome
    UNIQUE (nome)
);

CREATE TABLE GENERO (
  pk_nome
    VARCHAR2(100 CHAR)
    NOT NULL,
  fk_genero_pai
    VARCHAR2(100 CHAR),
  
  CONSTRAINT pk_genero
    PRIMARY KEY (pk_nome),
  CONSTRAINT fk_genero_pai
    FOREIGN KEY (fk_genero_pai)
    REFERENCES GENERO (pk_nome)
);

CREATE TABLE PROMOCAO (
  pk_id_promo
    NUMBER(10)
    DEFAULT seq_promocao.NEXTVAL
    NOT NULL,
  nome
    VARCHAR2(100 CHAR)
    NOT NULL,
  percentual
    NUMBER(5, 2)
    NOT NULL,
  data_inicio
    DATE
    NOT NULL,
  data_fim
    DATE
    NOT NULL,
  
  CONSTRAINT pk_promocao
    PRIMARY KEY (pk_id_promo),
  CONSTRAINT chk_percentual_valido
    CHECK (percentual > 0 AND percentual <= 100),
  CONSTRAINT chk_datas_validas
    CHECK (data_fim > data_inicio)
);

CREATE TABLE USUARIO (
  pk_id_usuario
    NUMBER(10)
    DEFAULT seq_usuario.NEXTVAL
    NOT NULL,
  nome
    VARCHAR2(255 CHAR)
    NOT NULL,
  email
    VARCHAR2(255 CHAR)
    NOT NULL,
  data_nasc
    DATE
    NOT NULL,
  numero
    VARCHAR2(20 CHAR),
  fk_CEP
    VARCHAR2(9 CHAR)
    NOT NULL,
  
  CONSTRAINT pk_usuario
    PRIMARY KEY (pk_id_usuario),
  CONSTRAINT uq_usuario_email
    UNIQUE (email),
  CONSTRAINT fk_usuario_cep
    FOREIGN KEY (fk_CEP)
    REFERENCES ENDERECO_CEP (pk_CEP)
);

CREATE TABLE USUARIO_TELEFONE (
  pk_fk_id_usuario
    NUMBER(10)
    NOT NULL,
  pk_telefone
    VARCHAR2(20 CHAR)
    NOT NULL,
  
  CONSTRAINT pk_usuario_telefone
    PRIMARY KEY (pk_fk_id_usuario, pk_telefone),
  CONSTRAINT fk_telefone_usuario
    FOREIGN KEY (pk_fk_id_usuario)
    REFERENCES USUARIO (pk_id_usuario)
);

CREATE TABLE PRODUTO (
  pk_id_prod
    NUMBER(10)
    DEFAULT seq_produto.NEXTVAL
    NOT NULL,
  tipo_prod
    VARCHAR2(50 CHAR)
    NOT NULL,
  descricao
    CLOB,
  titulo
    VARCHAR2(255 CHAR)
    NOT NULL,
  data_lanc
    DATE,
  fk_publicadora
    NUMBER(10)
    NOT NULL,
  
  CONSTRAINT pk_produto
    PRIMARY KEY (pk_id_prod),
  CONSTRAINT fk_prod_publicadora
    FOREIGN KEY (fk_publicadora)
    REFERENCES PUBLICADORA (pk_id_pub),
  CONSTRAINT chk_tipo_produto
    CHECK (tipo_prod IN ('JOGO', 'ADICIONAL'))
);

CREATE TABLE JOGO (
  pk_fk_id_prod
    NUMBER(10)
    NOT NULL,
  data_cad
    DATE
    DEFAULT SYSDATE,
  tamanho
    NUMBER(7, 2),
  requisitos
    CLOB,
  class_indicativa
    VARCHAR2(3 CHAR)
    NOT NULL,
  
  CONSTRAINT pk_jogo
    PRIMARY KEY (pk_fk_id_prod),
  CONSTRAINT fk_jogo_produto
    FOREIGN KEY (pk_fk_id_prod)
    REFERENCES PRODUTO (pk_id_prod),
  CONSTRAINT chk_class_indicativa
    CHECK (class_indicativa IN ('L', '10', '12', '14', '16', '18'))
);

CREATE TABLE ADICIONAL (
  pk_fk_id_prod
    NUMBER(10)
    NOT NULL,
  tipo_ad
    VARCHAR2(50 CHAR)
    NOT NULL,
  
  CONSTRAINT pk_adicional
    PRIMARY KEY (pk_fk_id_prod),
  CONSTRAINT fk_adicional_produto
    FOREIGN KEY (pk_fk_id_prod)
    REFERENCES PRODUTO (pk_id_prod),
  CONSTRAINT chk_tipo_adicional
    CHECK (tipo_ad IN ('EXPANSAO', 'MICROTRANSACAO', 'ASSINATURA'))
);

CREATE TABLE EXPANSAO (
  pk_fk_id_prod
    NUMBER(10)
    NOT NULL,
  tamanho
    NUMBER(7, 2),
  requisitos
    CLOB,
  
  CONSTRAINT pk_expansao
    PRIMARY KEY (pk_fk_id_prod),
  CONSTRAINT fk_expansao_adicional
    FOREIGN KEY (pk_fk_id_prod)
    REFERENCES ADICIONAL (pk_fk_id_prod)
);

CREATE TABLE MICROTRANSACAO (
  pk_fk_id_prod
    NUMBER(10)
    NOT NULL,
  tipo_microtrans
    VARCHAR2(100 CHAR),
  
  CONSTRAINT pk_microtransacao
    PRIMARY KEY (pk_fk_id_prod),
  CONSTRAINT fk_micro_adicional
    FOREIGN KEY (pk_fk_id_prod)
    REFERENCES ADICIONAL (pk_fk_id_prod)
);

CREATE TABLE ASSINATURA (
  pk_fk_id_prod
    NUMBER(10)
    NOT NULL,
  duracao
    NUMBER(10)
    NOT NULL,
  
  CONSTRAINT pk_assinatura
    PRIMARY KEY (pk_fk_id_prod),
  CONSTRAINT fk_assinatura_adicional
    FOREIGN KEY (pk_fk_id_prod)
    REFERENCES ADICIONAL (pk_fk_id_prod),
  CONSTRAINT chk_duracao_assinatura
    CHECK (duracao > 0)
);

CREATE TABLE HISTORICO_VALOR (
  pk_fk_id_produto
    NUMBER(10)
    NOT NULL,
  pk_data_inicio
    DATE
    NOT NULL,
  valor
    NUMBER(10, 2)
    NOT NULL,
  
  CONSTRAINT pk_historico_valor
    PRIMARY KEY (pk_fk_id_produto, pk_data_inicio),
  CONSTRAINT fk_historico_produto
    FOREIGN KEY (pk_fk_id_produto)
    REFERENCES PRODUTO (pk_id_prod),
  CONSTRAINT chk_valor_historico
    CHECK (valor >= 0)
);

CREATE TABLE PROMOCAO_PRODUTO (
  pk_fk_id_promo
    NUMBER(10)
    NOT NULL,
  pk_fk_id_produto
    NUMBER(10)
    NOT NULL,
  
  CONSTRAINT pk_promocao_produto
    PRIMARY KEY (pk_fk_id_promo, pk_fk_id_produto),
  CONSTRAINT fk_promoprod_promocao
    FOREIGN KEY (pk_fk_id_promo)
    REFERENCES PROMOCAO (pk_id_promo),
  CONSTRAINT fk_promoprod_produto
    FOREIGN KEY (pk_fk_id_produto)
    REFERENCES PRODUTO (pk_id_prod)
);

CREATE TABLE JOGO_IDIOMA (
  pk_fk_id_jogo
    NUMBER(10)
    NOT NULL,
  pk_idioma
    VARCHAR2(50 CHAR)
    NOT NULL,
  
  CONSTRAINT pk_jogo_idioma
    PRIMARY KEY (pk_fk_id_jogo, pk_idioma),
  CONSTRAINT fk_idioma_jogo
    FOREIGN KEY (pk_fk_id_jogo)
    REFERENCES JOGO (pk_fk_id_prod)
);

CREATE TABLE JOGO_GENERO (
  pk_fk_id_jogo
    NUMBER(10)
    NOT NULL,
  pk_fk_nome_genero
    VARCHAR2(100 CHAR)
    NOT NULL,
  
  CONSTRAINT pk_jogo_genero
    PRIMARY KEY (pk_fk_id_jogo, pk_fk_nome_genero),
  CONSTRAINT fk_jogogen_jogo
    FOREIGN KEY (pk_fk_id_jogo)
    REFERENCES JOGO (pk_fk_id_prod),
  CONSTRAINT fk_jogogen_genero
    FOREIGN KEY (pk_fk_nome_genero)
    REFERENCES GENERO (pk_nome)
);

CREATE TABLE PEDIDO (
  pk_id_pedido
    NUMBER(10)
    DEFAULT seq_pedido.NEXTVAL
    NOT NULL,
  data_hora
    TIMESTAMP
    DEFAULT SYSTIMESTAMP,
  metodo_pag
    VARCHAR2(50 CHAR)
    NOT NULL,
  fk_id_usuario
    NUMBER(10)
    NOT NULL,
  
  CONSTRAINT pk_pedido
    PRIMARY KEY (pk_id_pedido),
  CONSTRAINT fk_pedido_usuario
    FOREIGN KEY (fk_id_usuario)
    REFERENCES USUARIO (pk_id_usuario),
  CONSTRAINT chk_metodo_pag
    CHECK (metodo_pag IN ('Cartão de Crédito', 'Pix', 'Boleto', 'Saldo Carteira'))
);

CREATE TABLE ITEM (
  pk_fk_id_pedido
    NUMBER(10)
    NOT NULL,
  pk_num_item
    NUMBER(10)
    NOT NULL,
  quantidade
    NUMBER(10)
    DEFAULT 1
    NOT NULL,
  fk_id_produto
    NUMBER(10)
    NOT NULL,
  fk_id_promo
    NUMBER(10),
  valor_unitario_pago
    NUMBER(10, 2)
    NOT NULL,
  
  CONSTRAINT pk_item
    PRIMARY KEY (pk_fk_id_pedido, pk_num_item),
  CONSTRAINT fk_item_pedido
    FOREIGN KEY (pk_fk_id_pedido)
    REFERENCES PEDIDO (pk_id_pedido),
  CONSTRAINT fk_item_produto
    FOREIGN KEY (fk_id_produto)
    REFERENCES PRODUTO (pk_id_prod),
  CONSTRAINT fk_item_promocao
    FOREIGN KEY (fk_id_promo)
    REFERENCES PROMOCAO (pk_id_promo),
  CONSTRAINT chk_item_quantidade
    CHECK (quantidade > 0),
  CONSTRAINT chk_item_valor_pago
    CHECK (valor_unitario_pago >= 0)
);

CREATE TABLE PROGRESSO (
  fk_id_usuario
    NUMBER(10)
    NOT NULL,
  fk_id_jogo
    NUMBER(10)
    NOT NULL,
  horas_jogadas
    NUMBER(7, 1)
    DEFAULT 0,
  
  CONSTRAINT pk_progresso
    PRIMARY KEY (fk_id_usuario, fk_id_jogo),
  CONSTRAINT fk_progresso_usuario
    FOREIGN KEY (fk_id_usuario)
    REFERENCES USUARIO (pk_id_usuario),
  CONSTRAINT fk_progresso_jogo
    FOREIGN KEY (fk_id_jogo)
    REFERENCES JOGO (pk_fk_id_prod),
  CONSTRAINT chk_progresso_horas
    CHECK (horas_jogadas >= 0)
);

CREATE TABLE CONQUISTAS (
  pk_codigo_conquista
    NUMBER(10)
    DEFAULT seq_conquistas.NEXTVAL
    NOT NULL,
  fk_id_usuario
    NUMBER(10)
    NOT NULL,
  fk_id_jogo
    NUMBER(10)
    NOT NULL,
  conquistas
    VARCHAR2(100 CHAR)
    NOT NULL,
  data_obtencao
    TIMESTAMP
    DEFAULT SYSTIMESTAMP,
  
  CONSTRAINT pk_conquistas
    PRIMARY KEY (pk_codigo_conquista),
  CONSTRAINT fk_conquistas_progresso
    FOREIGN KEY (fk_id_usuario, fk_id_jogo)
    REFERENCES PROGRESSO (fk_id_usuario, fk_id_jogo),
  CONSTRAINT uq_conq_usr_jogo
    UNIQUE (fk_id_usuario, fk_id_jogo, conquistas)
);

CREATE TABLE SESSAO_JOGO (
  pk_id_sessao
    NUMBER(10)
    DEFAULT seq_sessao_jogo.NEXTVAL
    NOT NULL,
  fk_id_usuario
    NUMBER(10)
    NOT NULL,
  fk_id_jogo
    NUMBER(10)
    NOT NULL,
  fk_id_plataforma
    NUMBER(10)
    NOT NULL,
  data_hora_inicio
    TIMESTAMP
    DEFAULT SYSTIMESTAMP,
  duracao
    NUMBER(5, 1)
    NOT NULL,
  
  CONSTRAINT pk_sessao_jogo
    PRIMARY KEY (pk_id_sessao),
  CONSTRAINT fk_sessao_usuario
    FOREIGN KEY (fk_id_usuario)
    REFERENCES USUARIO (pk_id_usuario),
  CONSTRAINT fk_sessao_jogo
    FOREIGN KEY (fk_id_jogo)
    REFERENCES JOGO (pk_fk_id_prod),
  CONSTRAINT fk_sessao_plataforma
    FOREIGN KEY (fk_id_plataforma)
    REFERENCES PLATAFORMA (pk_id_plataforma),
  CONSTRAINT chk_sessao_duracao
    CHECK (duracao > 0)
);
