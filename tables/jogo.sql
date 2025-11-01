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
