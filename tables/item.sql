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
