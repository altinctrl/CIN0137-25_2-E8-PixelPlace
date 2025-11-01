CREATE TABLE PLATAFORMA (
  pk_id_plataforma
    NUMBER(10) 
    DEFAULT seq_plataforma.NEXTVAL
    NOT NULL,
  nome
    VARCHAR2(100 CHAR)
    NOT NULL,
  versao
    VARCHAR2(100 CHAR),
  
  CONSTRAINT pk_plataforma
    PRIMARY KEY (pk_id_plataforma),
  CONSTRAINT uq_plat_nome_versao
    UNIQUE (nome, versao)
);
