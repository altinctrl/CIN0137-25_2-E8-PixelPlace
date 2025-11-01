CREATE TABLE USUARIO_TELEFONE (
  pk_fk_id_usuario
    NUMBER(10)
    NOT NULL,
  pk_telefone
    VARCHAR2(20 CHAR)
    NOT NULL,
  
  CONSTRAINT pk_usuario_telefone
    PRIMARY KEY (pk_fk_id_usuario, pk_telefone),
  CONSTRAINT fk_telefone_usuario
    FOREIGN KEY (pk_fk_id_usuario)
    REFERENCES USUARIO (pk_id_usuario)
);
