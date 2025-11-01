CREATE TABLE USUARIO (
  pk_id_usuario
    NUMBER(10)
    DEFAULT seq_usuario.NEXTVAL
    NOT NULL,
  nome
    VARCHAR2(255 CHAR)
    NOT NULL,
  email
    VARCHAR2(255 CHAR)
    NOT NULL,
  data_nasc
    DATE
    NOT NULL,
  numero
    VARCHAR2(20 CHAR),
  fk_CEP
    VARCHAR2(9 CHAR)
    NOT NULL,
  
  CONSTRAINT pk_usuario
    PRIMARY KEY (pk_id_usuario),
  CONSTRAINT uq_usuario_email
    UNIQUE (email),
  CONSTRAINT fk_usuario_cep
    FOREIGN KEY (fk_CEP)
    REFERENCES ENDERECO_CEP (pk_CEP)
);
