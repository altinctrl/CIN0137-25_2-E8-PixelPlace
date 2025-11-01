CREATE TABLE PROMOCAO (
  pk_id_promo
    NUMBER(10)
    DEFAULT seq_promocao.NEXTVAL
    NOT NULL,
  nome
    VARCHAR2(100 CHAR)
    NOT NULL,
  percentual
    NUMBER(5, 2)
    NOT NULL,
  data_inicio
    DATE
    NOT NULL,
  data_fim
    DATE
    NOT NULL,
  
  CONSTRAINT pk_promocao
    PRIMARY KEY (pk_id_promo),
  CONSTRAINT chk_percentual_valido
    CHECK (percentual > 0 AND percentual <= 100),
  CONSTRAINT chk_datas_validas
    CHECK (data_fim > data_inicio)
);
