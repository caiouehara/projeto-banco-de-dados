-- -----------------------------------------------------
-- Table CEP
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS CEP (
  CEP INTEGER NOT NULL,
  estado VARCHAR(45) NULL,
  município VARCHAR(45) NULL,
  PRIMARY KEY (CEP))
;


-- -----------------------------------------------------
-- Table Funcionário
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Funcionário (
  idFuncionário INTEGER NOT NULL,
  email VARCHAR(80) NULL,
  senha VARCHAR(45) NULL,
  complemento VARCHAR(45) NULL,
  número INTEGER NULL,
  salário DECIMAL(12,2) NULL,
  horas_extras FLOAT NULL,
  produtividade INTEGER NULL,
  rua VARCHAR(45) NULL,
  bairro VARCHAR(45) NULL,
  cpf VARCHAR(45) NULL,
  nome VARCHAR(45) NULL,
  função VARCHAR(45) NULL,
  CEP INTEGER NOT NULL,
  tipo VARCHAR(10) NOT NULL,
  PRIMARY KEY (idFuncionário),
  CONSTRAINT fk_Funcionário_CEP1
    FOREIGN KEY (CEP)
    REFERENCES CEP (CEP)
    
    )
;

CREATE INDEX fk_Funcionário_CEP1_idx ON Funcionário (CEP ASC) ;


-- -----------------------------------------------------
-- Table Gestor_Compra
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Gestor_Compra (
  habilidade VARCHAR(45) NULL,
  idFuncionário INTEGER NOT NULL,
  PRIMARY KEY (idFuncionário),
  CONSTRAINT fk_Gestor_Compra_Funcionário1
    FOREIGN KEY (idFuncionário)
    REFERENCES Funcionário (idFuncionário)
    
    )
;


-- -----------------------------------------------------
-- Table Fornecedor
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Fornecedor (
  idFornecedor INTEGER NOT NULL,
  nome VARCHAR(45) NULL,
  email VARCHAR(45) NULL,
  bairro VARCHAR(45) NULL,
  rua VARCHAR(45) NULL,
  complemento VARCHAR(45) NULL,
  número INTEGER NULL,
  idFuncionário INTEGER NOT NULL,
  CEP INTEGER NOT NULL,
  CNPJ INTEGER NOT NULL,
  PRIMARY KEY (idFornecedor),
  CONSTRAINT fk_Fornecedor_Funcionário1
    FOREIGN KEY (idFuncionário)
    REFERENCES Funcionário (idFuncionário)
    
    ,
  CONSTRAINT fk_Fornecedor_CEP_Fornecedor1
    FOREIGN KEY (CEP)
    REFERENCES CEP (CEP)
    
    )
;

CREATE INDEX fk_Fornecedor_Funcionário1_idx ON Fornecedor (idFuncionário ASC) ;

CREATE INDEX fk_Fornecedor_CEP_Fornecedor1_idx ON Fornecedor (CEP ASC) ;


-- -----------------------------------------------------
-- Table Compra
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Compra (
  nota_fiscal INTEGER NOT NULL,
  data TIMESTAMP NULL,
  total_comprado DECIMAL(16,2) NULL,
  hora INTEGER NULL,
  idFuncionário INTEGER NOT NULL,
  idFornecedor INTEGER NOT NULL,
  PRIMARY KEY (nota_fiscal),
  CONSTRAINT fk_Compra_Gestor_Compra1
    FOREIGN KEY (idFuncionário)
    REFERENCES Gestor_Compra (idFuncionário)
    
    ,
  CONSTRAINT fk_Compra_Fornecedor1
    FOREIGN KEY (idFornecedor)
    REFERENCES Fornecedor (idFornecedor)
    
    )
;

CREATE INDEX fk_Compra_Gestor_Compra1_idx ON Compra (idFuncionário ASC) ;

CREATE INDEX fk_Compra_Fornecedor1_idx ON Compra (idFornecedor ASC) ;


-- -----------------------------------------------------
-- Table timestamps
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS timestamps (
  create_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  update_time TIMESTAMP NULL);


-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Cliente (
  idCliente INTEGER NOT NULL,
  nome VARCHAR(45) NULL,
  complemento VARCHAR(45) NULL,
  número VARCHAR(45) NULL,
  é_físico SMALLINT NULL,
  é_jurídico SMALLINT NULL,
  CEP INTEGER NOT NULL,
  PRIMARY KEY (idCliente),
  CONSTRAINT fk_Cliente_CEP1
    FOREIGN KEY (CEP)
    REFERENCES CEP (CEP)
    
    )
;

CREATE INDEX fk_Cliente_CEP1_idx ON Cliente (CEP ASC) ;


-- -----------------------------------------------------
-- Table Vendedor
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Vendedor (
  sommelies INTEGER NOT NULL,
  idFuncionário INTEGER NOT NULL,
  PRIMARY KEY (idFuncionário),
  CONSTRAINT fk_Vendedor_Funcionário1
    FOREIGN KEY (idFuncionário)
    REFERENCES Funcionário (idFuncionário)
    
    )
;


-- -----------------------------------------------------
-- Table Motorista
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Motorista (
  CNH INTEGER NOT NULL,
  nome VARCHAR(45) NULL,
  PRIMARY KEY (CNH))
;


-- -----------------------------------------------------
-- Table Trajeto
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Trajeto (
  cód_trajeto INTEGER NOT NULL,
  distância FLOAT NULL,
  PRIMARY KEY (cód_trajeto))
;


-- -----------------------------------------------------
-- Table Veículo
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Veículo (
  placa INTEGER NOT NULL,
  disbonibilidade SMALLINT NULL,
  capacidade_carga VARCHAR(45) NULL,
  consumo VARCHAR(45) NULL,
  km_rodado INTEGER NULL,
  fabricação VARCHAR(45) NULL,
  PRIMARY KEY (placa))
;


-- -----------------------------------------------------
-- Table Gestor_Entrega
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Gestor_Entrega (
  habilidade VARCHAR(45) NULL,
  idFuncionário INTEGER NOT NULL,
  PRIMARY KEY (idFuncionário),
  CONSTRAINT fk_Gestor_Compra_Funcionário101
    FOREIGN KEY (idFuncionário)
    REFERENCES Funcionário (idFuncionário)
    
    )
;


-- -----------------------------------------------------
-- Table Entrega
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Entrega (
  cód_entrega INTEGER NOT NULL,
  CNH INTEGER NOT NULL,
  cód_trajeto INTEGER NOT NULL,
  placa INTEGER NOT NULL,
  pto_saída VARCHAR(45) NULL,
  pto_chegada VARCHAR(45) NULL,
  idFuncionário INTEGER NOT NULL,
  horário_entrega TIMESTAMP NULL,
  PRIMARY KEY (cód_entrega),
  CONSTRAINT fk_Entrega_Motorista1
    FOREIGN KEY (CNH)
    REFERENCES Motorista (CNH)
    
    ,
  CONSTRAINT fk_Entrega_Trajeto1
    FOREIGN KEY (cód_trajeto)
    REFERENCES Trajeto (cód_trajeto)
    
    ,
  CONSTRAINT fk_Entrega_Veículo1
    FOREIGN KEY (placa)
    REFERENCES Veículo (placa)
    
    ,
  CONSTRAINT fk_Entrega_Gestor_Entrega1
    FOREIGN KEY (idFuncionário)
    REFERENCES Gestor_Entrega (idFuncionário)
    
    )
;

CREATE INDEX fk_Entrega_Motorista1_idx ON Entrega (CNH ASC) ;

CREATE INDEX fk_Entrega_Trajeto1_idx ON Entrega (cód_trajeto ASC) ;

CREATE INDEX fk_Entrega_Veículo1_idx ON Entrega (placa ASC) ;

CREATE INDEX fk_Entrega_Gestor_Entrega1_idx ON Entrega (idFuncionário ASC) ;


-- -----------------------------------------------------
-- Table Venda
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Venda (
  nota_fiscal INTEGER NOT NULL,
  data TIMESTAMP NULL,
  hora INTEGER NULL,
  total_compra DECIMAL NULL,
  idFuncionário INTEGER NOT NULL,
  idCliente INTEGER NOT NULL,
  cód_entrega INTEGER NOT NULL,
  PRIMARY KEY (nota_fiscal),
  CONSTRAINT fk_Venda_Vendedor1
    FOREIGN KEY (idFuncionário)
    REFERENCES Vendedor (idFuncionário)
    
    ,
  CONSTRAINT fk_Venda_Cliente1
    FOREIGN KEY (idCliente)
    REFERENCES Cliente (idCliente)
    
    ,
  CONSTRAINT fk_Venda_Entrega1
    FOREIGN KEY (cód_entrega)
    REFERENCES Entrega (cód_entrega)
    
    )
;

CREATE INDEX fk_Venda_Vendedor1_idx ON Venda (idFuncionário ASC) ;

CREATE INDEX fk_Venda_Cliente1_idx ON Venda (idCliente ASC) ;

CREATE INDEX fk_Venda_Entrega1_idx ON Venda (cód_entrega ASC) ;


-- -----------------------------------------------------
-- Table Pagamento
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Pagamento (
  cód_pagamento INTEGER NOT NULL,
  valor DECIMAL(10,2) NULL,
  data TIMESTAMP NULL,
  hora TIMESTAMP NULL,
  Funcionário INTEGER NOT NULL,
  PRIMARY KEY (cód_pagamento),
  CONSTRAINT fk_Pagamento_Funcionário1
    FOREIGN KEY (Funcionário)
    REFERENCES Funcionário (idFuncionário)
    
    )
;

CREATE INDEX fk_Pagamento_Funcionário1_idx ON Pagamento (Funcionário ASC) ;


-- -----------------------------------------------------
-- Table Gestor_Estoque
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Gestor_Estoque (
  habilidade VARCHAR(45) NULL,
  idFuncionário INTEGER NOT NULL,
  PRIMARY KEY (idFuncionário),
  CONSTRAINT fk_Gestor_Estoque_Funcionário1
    FOREIGN KEY (idFuncionário)
    REFERENCES Funcionário (idFuncionário)
    
    )
;

CREATE INDEX fk_Gestor_Estoque_Funcionário1_idx ON Gestor_Estoque (idFuncionário ASC) ;


-- -----------------------------------------------------
-- Table produto
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS produto (
  idproduto INTEGER NOT NULL,
  nome VARCHAR(45) NULL,
  lote INTEGER NULL,
  descrição VARCHAR(45) NULL,
  teor_alcóolico DECIMAL NULL,
  quantidade_estoque INTEGER NULL,
  unidade VARCHAR(45) NULL,
  tipo_alcoolico VARCHAR(45) NULL,
  categoria VARCHAR(45) NULL,
  idFuncionário INTEGER NOT NULL,
  idFornecedor INTEGER NOT NULL,
  PRIMARY KEY (idproduto),
  CONSTRAINT fk_produto_Gestor_Estoque1
    FOREIGN KEY (idFuncionário)
    REFERENCES Gestor_Estoque (idFuncionário)
    
    ,
  CONSTRAINT fk_produto_Fornecedor1
    FOREIGN KEY (idFornecedor)
    REFERENCES Fornecedor (idFornecedor)
    
    )
;

CREATE INDEX fk_produto_Gestor_Estoque1_idx ON produto (idFuncionário ASC) ;

CREATE INDEX fk_produto_Fornecedor1_idx ON produto (idFornecedor ASC) ;


-- -----------------------------------------------------
-- Table item_comprado
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS item_comprado (
  cont INTEGER NOT NULL,
  preço_unitário DECIMAL NULL,
  quantidade INTEGER NULL,
  nota_fiscal INTEGER NOT NULL,
  idProduto INTEGER NOT NULL,
  PRIMARY KEY (cont, nota_fiscal, idProduto),
  CONSTRAINT fk_item_comprado_Compra1
    FOREIGN KEY (nota_fiscal)
    REFERENCES Compra (nota_fiscal)
    
    ,
  CONSTRAINT fk_item_comprado_produto1
    FOREIGN KEY (idProduto)
    REFERENCES produto (idproduto)
    
    )
;

CREATE INDEX fk_item_comprado_Compra1_idx ON item_comprado (nota_fiscal ASC) ;

CREATE INDEX fk_item_comprado_produto1_idx ON item_comprado (idProduto ASC) ;


-- -----------------------------------------------------
-- Table item_vendido
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS item_vendido (
  cont INTEGER NOT NULL,
  quantidade INTEGER NULL,
  nota_fiscal INTEGER NOT NULL,
  idProduto INTEGER NOT NULL,
  preço_unitário DECIMAL NULL,
  PRIMARY KEY (cont, nota_fiscal, idProduto),
  CONSTRAINT fk_item_vendido_Venda1
    FOREIGN KEY (nota_fiscal)
    REFERENCES Venda (nota_fiscal)
    
    ,
  CONSTRAINT fk_item_vendido_produto1
    FOREIGN KEY (idProduto)
    REFERENCES produto (idproduto)
    
    )
;

CREATE INDEX fk_item_vendido_Venda1_idx ON item_vendido (nota_fiscal ASC) ;

CREATE INDEX fk_item_vendido_produto1_idx ON item_vendido (idProduto ASC) ;


-- -----------------------------------------------------
-- Table Paradas_trajeto
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Paradas_entrega (
  cont INTEGER NOT NULL,
  motivo VARCHAR(45) NULL,
  cód_entrega INTEGER NOT NULL,
  PRIMARY KEY (cont, cód_entrega),
  CONSTRAINT fk_Paradas_entrega_Entrega1
    FOREIGN KEY (cód_entrega)
    REFERENCES Entrega (cód_entrega)
    
    )
;

CREATE INDEX fk_Paradas_trajeto_Trajeto1_idx ON Paradas_trajeto (cód_trajeto ASC) ;


-- -----------------------------------------------------
-- Table Apoio_trajeto
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Apoio_trajeto (
  cont INTEGER NOT NULL,
  apoio_trajeto VARCHAR(45) NULL,
  cód_trajeto INTEGER NOT NULL,
  PRIMARY KEY (cont, cód_trajeto),
  CONSTRAINT fk_Paradas_trajeto_Trajeto10
    FOREIGN KEY (cód_trajeto)
    REFERENCES Trajeto (cód_trajeto)
    
    )
;

CREATE INDEX fk_Paradas_trajeto_Trajeto1_idx ON Apoio_trajeto (cód_trajeto ASC) ;


-- -----------------------------------------------------
-- Table produto_não_alcoolicos
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS produto_não_alcoolicos (
  aroma INTEGER NOT NULL,
  idProduto INTEGER NOT NULL,
  PRIMARY KEY (idProduto),
  CONSTRAINT fk_Produto_Não_Alcoolicos_produto1
    FOREIGN KEY (idProduto)
    REFERENCES produto (idproduto)
    
    )
;

CREATE INDEX fk_Produto_Não_Alcoolicos_produto1_idx ON produto_não_alcoolicos (idProduto ASC) ;


-- -----------------------------------------------------
-- Table Produto_Alcoolicos
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Produto_Alcoolicos (
  aroma INTEGER NOT NULL,
  idProduto INTEGER NOT NULL,
  PRIMARY KEY (idProduto),
  CONSTRAINT fk_Produto_Não_Alcoolicos_produto10
    FOREIGN KEY (idProduto)
    REFERENCES produto (idproduto)
    
    )
;

CREATE INDEX fk_Produto_Não_Alcoolicos_produto1_idx ON Produto_Alcoolicos (idProduto ASC) ;


-- -----------------------------------------------------
-- Table Pessoa Fisica
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Pessoa_Fisica (
  CPF VARCHAR(45) NOT NULL,
  idCliente INTEGER NOT NULL,
  PRIMARY KEY (idCliente),
  CONSTRAINT fk_Pessoa_Fisica_Cliente1
    FOREIGN KEY (idCliente)
    REFERENCES Cliente (idCliente)
    
    )
;

CREATE INDEX fk_Pessoa_Fisica_Cliente1_idx ON Pessoa_Fisica (idCliente ASC) ;


-- -----------------------------------------------------
-- Table Pessoa Jurídica
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Pessoa_Juridica  (
  CNPJ VARCHAR(45) NOT NULL,
  idCliente INTEGER NOT NULL,
  PRIMARY KEY (idCliente),
  CONSTRAINT fk_Pessoa_Fisica_Cliente10
    FOREIGN KEY (idCliente)
    REFERENCES Cliente (idCliente)
    
    )
;

CREATE INDEX fk_Pessoa_Fisica_Cliente1_idx ON Pessoa_Jurídica (idCliente ASC) ;


-- -----------------------------------------------------
-- Table Telefone_Func
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Telefone_Func (
  Telefone VARCHAR(45) NOT NULL,
  cont INTEGER NOT NULL,
  idFuncionário INTEGER NOT NULL,
  PRIMARY KEY (cont, idFuncionário, Telefone),
  CONSTRAINT fk_Telefone_Func_Funcionário1
    FOREIGN KEY (idFuncionário)
    REFERENCES Funcionário (idFuncionário)
    
    )
;

CREATE INDEX fk_Telefone_Func_Funcionário1_idx ON Telefone_Func (idFuncionário ASC) ;


-- -----------------------------------------------------
-- Table Telefone_Fornec
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Telefone_Fornec (
  Telefone VARCHAR(45) NOT NULL,
  cont INTEGER NOT NULL,
  idFornecedor INTEGER NOT NULL,
  PRIMARY KEY (cont, idFornecedor, Telefone),
  CONSTRAINT fk_Telefone_Fornec_Fornecedor1
    FOREIGN KEY (idFornecedor)
    REFERENCES Fornecedor (idFornecedor)
    
    )
;

CREATE INDEX fk_Telefone_Fornec_Fornecedor1_idx ON Telefone_Fornec (idFornecedor ASC) ;


-- -----------------------------------------------------
-- Table Telefone_Cliente
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Telefone_Cliente (
  Telefone VARCHAR(45) NOT NULL,
  cont INTEGER NOT NULL,
  idCliente INTEGER NOT NULL,
  PRIMARY KEY (cont, idCliente, Telefone),
  CONSTRAINT fk_Telefone_Fornec_copy1_Cliente1
    FOREIGN KEY (idCliente)
    REFERENCES Cliente (idCliente)
    
    )
;

CREATE INDEX fk_Telefone_Fornec_copy1_Cliente1_idx ON Telefone_Cliente (idCliente ASC) ;


-- -----------------------------------------------------
-- Table Gestor_Vendas
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS Gestor_Vendas (
  habilidade VARCHAR(45) NULL,
  idFuncionário INTEGER NOT NULL,
  idCliente INTEGER NOT NULL,
  PRIMARY KEY (idFuncionário, idCliente),
  CONSTRAINT fk_Gestor_Vendas_Funcionário1
    FOREIGN KEY (idFuncionário)
    REFERENCES Funcionário (idFuncionário)
    
    ,
  CONSTRAINT fk_Gestor_Vendas_Cliente1
    FOREIGN KEY (idCliente)
    REFERENCES Cliente (idCliente)
    
    )
;

CREATE INDEX fk_Gestor_Vendas_Cliente1_idx ON Gestor_Vendas (idCliente ASC) ;