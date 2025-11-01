CREATE TABLE CONQUISTAS (
  pk_codigo_conquista
    NUMBER(10)
    DEFAULT seq_conquistas.NEXTVAL
    NOT NULL,
  fk_id_usuario
    NUMBER(10)
    NOT NULL,
  fk_id_jogo
    NUMBER(10)
    NOT NULL,
  conquistas
    VARCHAR2(100 CHAR)
    NOT NULL,
  data_obtencao
    TIMESTAMP
    DEFAULT SYSTIMESTAMP,
  
  CONSTRAINT pk_conquistas
    PRIMARY KEY (pk_codigo_conquista),
  CONSTRAINT fk_conquistas_progresso
    FOREIGN KEY (fk_id_usuario, fk_id_jogo)
    REFERENCES PROGRESSO (fk_id_usuario, fk_id_jogo),
  CONSTRAINT uq_conq_usr_jogo
    UNIQUE (fk_id_usuario, fk_id_jogo, conquistas)
);
