CREATE TABLE ASSINATURA (
  pk_fk_id_prod
    NUMBER(10)
    NOT NULL,
  duracao
    NUMBER(10)
    NOT NULL,
  
  CONSTRAINT pk_assinatura
    PRIMARY KEY (pk_fk_id_prod),
  CONSTRAINT fk_assinatura_produto
    FOREIGN KEY (pk_fk_id_prod)
    REFERENCES PRODUTO (pk_id_prod),
  CONSTRAINT chk_duracao_assinatura
    CHECK (duracao > 0)
);
