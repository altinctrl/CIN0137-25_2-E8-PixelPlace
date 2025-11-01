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
    CHECK (tipo_prod IN ('JOGO', 'ADICIONAL', 'ASSINATURA'))
);
