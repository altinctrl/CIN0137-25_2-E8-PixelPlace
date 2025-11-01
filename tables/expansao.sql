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
