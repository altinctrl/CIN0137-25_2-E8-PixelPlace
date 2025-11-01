CREATE TABLE SESSAO_JOGO (
  pk_id_sessao
    NUMBER(10)
    DEFAULT seq_sessao_jogo.NEXTVAL
    NOT NULL,
  fk_id_usuario
    NUMBER(10)
    NOT NULL,
  fk_id_jogo
    NUMBER(10)
    NOT NULL,
  fk_id_plataforma
    NUMBER(10)
    NOT NULL,
  data_hora_inicio
    TIMESTAMP
    DEFAULT SYSTIMESTAMP,
  duracao
    NUMBER(5, 1)
    NOT NULL,
  
  CONSTRAINT pk_sessao_jogo
    PRIMARY KEY (pk_id_sessao),
  CONSTRAINT fk_sessao_usuario
    FOREIGN KEY (fk_id_usuario)
    REFERENCES USUARIO (pk_id_usuario),
  CONSTRAINT fk_sessao_jogo
    FOREIGN KEY (fk_id_jogo)
    REFERENCES JOGO (pk_fk_id_prod),
  CONSTRAINT fk_sessao_plataforma
    FOREIGN KEY (fk_id_plataforma)
    REFERENCES PLATAFORMA (pk_id_plataforma),
  CONSTRAINT chk_sessao_duracao
    CHECK (duracao > 0)
);
