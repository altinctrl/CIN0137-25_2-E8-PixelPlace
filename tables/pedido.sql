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
