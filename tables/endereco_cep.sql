CREATE TABLE ENDERECO_CEP (
  pk_CEP
    VARCHAR2(9 CHAR)
    NOT NULL,
  logradouro
    VARCHAR2(255 CHAR)
    NOT NULL,
  cidade
    VARCHAR2(100 CHAR)
    NOT NULL,
  UF
    CHAR(2 CHAR)
    NOT NULL,
  
  CONSTRAINT pk_endereco_cep
    PRIMARY KEY (pk_CEP),
  CONSTRAINT chk_cep_formato
    CHECK (REGEXP_LIKE(pk_CEP, '^\d{5}-\d{3}$')),
  CONSTRAINT chk_uf_valido
    CHECK (UF IN ('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 
    'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 
    'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'))
);
