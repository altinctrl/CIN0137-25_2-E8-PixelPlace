CREATE TABLE JOGO_IDIOMA (
  pk_fk_id_jogo
    NUMBER(10)
    NOT NULL,
  pk_idioma
    VARCHAR2(50 CHAR)
    NOT NULL,
  
  CONSTRAINT pk_jogo_idioma
    PRIMARY KEY (pk_fk_id_jogo, pk_idioma),
  CONSTRAINT fk_idioma_jogo
    FOREIGN KEY (pk_fk_id_jogo)
    REFERENCES JOGO (pk_fk_id_prod)
);
