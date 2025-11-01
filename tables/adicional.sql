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
