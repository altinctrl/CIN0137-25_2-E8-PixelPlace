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
