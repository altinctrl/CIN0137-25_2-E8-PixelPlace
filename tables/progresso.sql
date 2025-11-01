CREATE TABLE PROGRESSO (
  fk_id_usuario
    NUMBER(10)
    NOT NULL,
  fk_id_jogo
    NUMBER(10)
    NOT NULL,
  horas_jogadas
    NUMBER(7, 1)
    DEFAULT 0,
  
  CONSTRAINT pk_progresso
    PRIMARY KEY (fk_id_usuario, fk_id_jogo),
  CONSTRAINT fk_progresso_usuario
    FOREIGN KEY (fk_id_usuario)
    REFERENCES USUARIO (pk_id_usuario),
  CONSTRAINT fk_progresso_jogo
    FOREIGN KEY (fk_id_jogo)
    REFERENCES JOGO (pk_fk_id_prod),
  CONSTRAINT chk_progresso_horas
    CHECK (horas_jogadas >= 0)
);
