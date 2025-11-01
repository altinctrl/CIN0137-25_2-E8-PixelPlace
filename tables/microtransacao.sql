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
