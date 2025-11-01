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
