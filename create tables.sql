CREATE TABLE Cliente (
	id 		INT NOT NULL AUTO_INCREMENT,
    nome	VARCHAR(64),
    cpf		CHAR(11),
    
    PRIMARY KEY (id)
);

CREATE TABLE TipoFuncionario (
	-- tabela de dominio
	id 			INT NOT NULL AUTO_INCREMENT,
    descricao	VARCHAR(64),
    
    PRIMARY KEY (id)
);

CREATE TABLE Filial (
	id 		INT NOT NULL AUTO_INCREMENT,
    nome	VARCHAR(32),
    
    PRIMARY KEY (id)
);


CREATE TABLE Funcionario (
	id 		INT NOT NULL AUTO_INCREMENT,
    nome 	VARCHAR(64),
    filial	INT NOT NULL,
    tipo	INT NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (filial) REFERENCES Filial(id),
    FOREIGN KEY (tipo) REFERENCES TipoFuncionario(id)
);


CREATE TABLE Produto (
	-- tabela de dominio
	id 			INT NOT NULL AUTO_INCREMENT,
	descricao	VARCHAR(64),
    
    PRIMARY KEY (id)
);

CREATE TABLE Item (
	-- item da venda
	id 			INT NOT NULL AUTO_INCREMENT,
    id_produto 	INT NOT NULL,
    qtd			INT,
    preco		DECIMAL(10,2),
    
    PRIMARY KEY (id)
);

CREATE TABLE Estoque (
	id 			INT NOT NULL AUTO_INCREMENT,
	id_produto	INT NOT NULL,
    qtd			INT,
    
    PRIMARY KEY(id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);

CREATE TABLE Venda (
	id	 		INT NOT NULL AUTO_INCREMENT,
    id_item 	INT NOT NULL,
    data_venda	DATE NOT NULL,
    valor_total	DECIMAL(10,2) NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_item) REFERENCES Item(id)
);

CREATE TABLE MateriaPrima (
	id	 		INT NOT NULL AUTO_INCREMENT,
    nome 		VARCHAR(32),
    validade 	VARCHAR(32),
    
    PRIMARY KEY(id)
);


CREATE TABLE Fornecedor (
	id 					INT NOT NULL AUTO_INCREMENT,
    id_materia_prima	INT NOT NULL,
    id_produto			INT NOT NULL,
    nome				VARCHAR(32),
    
    PRIMARY KEY (id),
    FOREIGN KEY(id_materia_prima) REFERENCES MateriaPrima(id),
    FOREIGN KEY(id_produto) REFERENCES Produto(id)
);

CREATE TABLE Receita (
	id 					INT NOT NULL AUTO_INCREMENT,
	-- referencia pra materia prima
    id_materia_prima 	INT NOT NULL,
    qtd					INT NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_materia_prima) REFERENCES MateriaPrima(id)
);

CREATE TABLE Comentarios (
	id 			INT NOT NULL AUTO_INCREMENT,
	id_cliente 	INT NOT NULL,
    descricao	VARCHAR(256),
    -- incluir classificacao?
    
    PRIMARY KEY(id),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id)
);

CREATE TABLE Entrega (
	-- tabela de dominio
	id 			INT NOT NULL AUTO_INCREMENT,
	descricao 	VARCHAR(32),
    
    PRIMARY KEY(id)
);

CREATE TABLE MeioPgto (
	-- tabela de dominio
	id 			INT NOT NULL AUTO_INCREMENT,
    descricao 	VARCHAR(32),
    
    PRIMARY KEY(id)
);

CREATE TABLE DadosCartao (
	id	 			INT NOT NULL AUTO_INCREMENT,
    id_cliente		INT NOT NULL,
    num_cartao		VARCHAR(14),
    cvc				VARCHAR(4),
    validade		VARCHAR(5),
    nome_portador	VARCHAR(16),
    
    PRIMARY KEY(id),
    FOREIGN KEY(id_cliente) REFERENCES Cliente(id)
);

