CREATE TABLE Cliente (
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(64),
    cpf CHAR(11),
    
    PRIMARY KEY (id)
);

CREATE TABLE TipoFuncionario (
	-- tabela de dominio
	id INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(64),
    
    PRIMARY KEY (id)
);

CREATE TABLE Filial (
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(32),
    num_funcionarios INT,
    
    PRIMARY KEY (id)
);


CREATE TABLE Funcionario (
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(64),
    filial INT NOT NULL,
    tipo INT NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (filial) REFERENCES Filial(id),
    FOREIGN KEY (tipo) REFERENCES TipoFuncionario(id)
);


CREATE TABLE Produto (
	id INT NOT NULL AUTO_INCREMENT,
	descricao VARCHAR(64),
    tem_materia_prima BOOLEAN,
    
    PRIMARY KEY (id)
);

CREATE TABLE Item (
	-- item da venda
	id INT NOT NULL AUTO_INCREMENT,
    id_produto INT NOT NULL,
    qtd INT,
    preco DECIMAL(10,2),
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);

CREATE TABLE MateriaPrima (
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(32),
    validade VARCHAR(32),
    
    PRIMARY KEY(id)
);

CREATE TABLE FornecedorMateriaPrima (
	id INT NOT NULL AUTO_INCREMENT,
    id_materia_prima INT NOT NULL,
    nome VARCHAR(32),
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_materia_prima) REFERENCES MateriaPrima(id)
);

CREATE TABLE FornecedorProduto (
	id INT NOT NULL AUTO_INCREMENT,
    id_produto INT NOT NULL,
    nome VARCHAR(32),
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);

CREATE TABLE Receita (
	id INT NOT NULL AUTO_INCREMENT,
	-- referencia pra materia prima
    id_materia_prima INT NOT NULL,
    qtd INT NOT NULL,
    id_produto INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_materia_prima) REFERENCES MateriaPrima(id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);

CREATE TABLE Entrega (
	id INT NOT NULL AUTO_INCREMENT,
    id_func INT NOT NULL,
	descricao VARCHAR(32),
    
    PRIMARY KEY(id),
    FOREIGN KEY (id_func) REFERENCES Funcionario(id)
);

CREATE TABLE MeioPgto (
	-- tabela de dominio
	id INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(32),
    
    PRIMARY KEY(id)
);

CREATE TABLE DadosCartao (
	id INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    num_cartao VARCHAR(14),
    cvc VARCHAR(4),
    validade VARCHAR(5),
    nome_portador VARCHAR(16),
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id)
);

CREATE TABLE Venda (
	id INT NOT NULL AUTO_INCREMENT,
    id_item INT NOT NULL,
    id_pgto INT NOT NULL,
    id_entrega INT,
    id_func INT NOT NULL,
    id_cliente INT NOT NULL,
    data_venda DATE NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_item) REFERENCES Item(id),
    FOREIGN KEY (id_pgto) REFERENCES MeioPgto(id),
    FOREIGN KEY (id_entrega) REFERENCES Entrega(id),
    FOREIGN KEY (id_func) REFERENCES Funcionario(id),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id)
);

CREATE TABLE ReposicaoMateriaPrima(
	id INT NOT NULL AUTO_INCREMENT,
    qtd_gramas_rep INT,
    id_materia_prima INT NOT NULL,
    data_rep DATE NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_materia_prima) REFERENCES MateriaPrima(id)
);

CREATE TABLE ReposicaoProduto(
    id INT NOT NULL AUTO_INCREMENT,
    qtd_rep INT,
    id_produto INT NOT NULL, 
    data_rep DATE NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);

CREATE TABLE PedidosMateriaPrima(
    id INT NOT NULL AUTO_INCREMENT,
    id_materia_prima INT NOT NULL,
    qtd_gramas_pedido INT,

    PRIMARY KEY (id),
    FOREIGN KEY (id_materia_prima) REFERENCES MateriaPrima(id)
);

CREATE TABLE PedidosProduto(
    id INT NOT NULL AUTO_INCREMENT,
    id_produto INT NOT NULL,
    qtd_pedido INT,

    PRIMARY KEY (id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);

CREATE TABLE EstoqueMateriaPrima (
    id INT NOT NULL AUTO_INCREMENT,
    id_materia_prima INT NOT NULL,
    qtd_gramas INT,
    estoque_min INT,
    
    PRIMARY KEY(id),
    FOREIGN KEY (id_materia_prima) REFERENCES MateriaPrima(id)
);

CREATE TABLE EstoqueProduto (
    id INT NOT NULL AUTO_INCREMENT,
    id_produto INT NOT NULL,
    qtd INT,
    estoque_min INT,
    
    PRIMARY KEY(id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);

-- avaliar se as tabelas de reposição e/ou produto não podem ter um BOOL indicando "produto ou materia"

-- TODO
    -- estoque mínimo em algum lugar
    -- exportar projeto lógico (pelo workbench msm)
    -- criar modelo de entidade relacional
    -- Área de anexos (?)
