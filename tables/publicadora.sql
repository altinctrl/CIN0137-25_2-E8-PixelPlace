CREATE TABLE PUBLICADORA (
  pk_id_pub
    NUMBER(10)
    DEFAULT seq_publicadora.NEXTVAL
    NOT NULL,
  nome
    VARCHAR2(100 CHAR)
    NOT NULL,
  pais
    VARCHAR2(100 CHAR)
    NOT NULL,
  
  CONSTRAINT pk_publicadora
    PRIMARY KEY (pk_id_pub),
  CONSTRAINT uq_publicadora_nome
    UNIQUE (nome)
);
