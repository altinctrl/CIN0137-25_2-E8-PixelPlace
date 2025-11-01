CREATE TABLE GENERO (
  pk_nome
    VARCHAR2(100 CHAR)
    NOT NULL,
  fk_genero_pai
    VARCHAR2(100 CHAR),
  
  CONSTRAINT pk_genero
    PRIMARY KEY (pk_nome),
  CONSTRAINT fk_genero_pai
    FOREIGN KEY (fk_genero_pai)
    REFERENCES GENERO (pk_nome)
);
