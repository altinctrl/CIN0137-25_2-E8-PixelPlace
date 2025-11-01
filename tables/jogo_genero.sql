CREATE TABLE JOGO_GENERO (
  pk_fk_id_jogo
    NUMBER(10)
    NOT NULL,
  pk_fk_nome_genero
    VARCHAR2(100 CHAR)
    NOT NULL,
  
  CONSTRAINT pk_jogo_genero
    PRIMARY KEY (pk_fk_id_jogo, pk_fk_nome_genero),
  CONSTRAINT fk_jogogen_jogo
    FOREIGN KEY (pk_fk_id_jogo)
    REFERENCES JOGO (pk_fk_id_prod),
  CONSTRAINT fk_jogogen_genero
    FOREIGN KEY (pk_fk_nome_genero)
    REFERENCES GENERO (pk_nome)
);
