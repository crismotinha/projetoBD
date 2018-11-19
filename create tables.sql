-- CREATE SCHEMA Pastelaria;

CREATE TABLE Cliente (
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(64) NOT NULL,
    cpf CHAR(11) NOT NULL,
    
    PRIMARY KEY (id)
);

CREATE TABLE TipoFuncionario (
	-- tabela de dominio
	id INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(64) NOT NULL,
    
    PRIMARY KEY (id)
);

CREATE TABLE Filial (
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(32) NOT NULL,
    num_funcionarios INT NOT NULL,
    
    PRIMARY KEY (id)
);


CREATE TABLE Funcionario (
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(64) NOT NULL,
    filial INT NOT NULL,
    tipo INT NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (filial) REFERENCES Filial(id),
    FOREIGN KEY (tipo) REFERENCES TipoFuncionario(id)
);


CREATE TABLE Produto (
	id INT NOT NULL AUTO_INCREMENT,
	descricao VARCHAR(64) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    tem_materia_prima BOOLEAN NOT NULL,
    
    PRIMARY KEY (id)
);

CREATE TABLE Item (
	id INT NOT NULL AUTO_INCREMENT,
    id_produto INT NOT NULL,
    qtd INT NOT NULL,
    sub_total DECIMAL(10,2) NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);

CREATE TABLE MateriaPrima (
	id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(32) NOT NULL,
    validade VARCHAR(32) NOT NULL,
    
    PRIMARY KEY(id)
);

CREATE TABLE FornecedorMateriaPrima (
	id INT NOT NULL AUTO_INCREMENT,
    id_materia_prima INT NOT NULL,
    nome VARCHAR(32) NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_materia_prima) REFERENCES MateriaPrima(id)
);

CREATE TABLE FornecedorProduto (
	id INT NOT NULL AUTO_INCREMENT,
    id_produto INT NOT NULL,
    nome VARCHAR(32) NOT NULL,
    
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
    id_entregador INT NOT NULL,
	endereco VARCHAR(64) NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_entregador) REFERENCES Funcionario(id)
);

CREATE TABLE MeioPgto (
	-- tabela de dominio
	id INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(32) NOT NULL,
    
    PRIMARY KEY(id)
);

CREATE TABLE DadosCartao (
	id INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    num_cartao VARCHAR(14) NOT NULL,
    cvc VARCHAR(4) NOT NULL,
    validade VARCHAR(5) NOT NULL,
    nome_portador VARCHAR(16) NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id)
);

CREATE TABLE ReposicaoMateriaPrima(
	id INT NOT NULL AUTO_INCREMENT,
    qtd_gramas_rep INT NOT NULL,
    id_materia_prima INT NOT NULL,
    data_rep DATE NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_materia_prima) REFERENCES MateriaPrima(id)
);

CREATE TABLE ReposicaoProduto(
    id INT NOT NULL AUTO_INCREMENT,
    qtd_rep INT NOT NULL,
    id_produto INT NOT NULL, 
    data_rep DATE NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);

CREATE TABLE PedidosMateriaPrima(
    id INT NOT NULL AUTO_INCREMENT,
    id_materia_prima INT NOT NULL,
    id_fornecedor INT NOT NULL,
    qtd_gramas_pedido INT NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_materia_prima) REFERENCES MateriaPrima(id),
    FOREIGN KEY (id_fornecedor) REFERENCES FornecedorMateriaPrima(id)
);

CREATE TABLE PedidosProduto(
    id INT NOT NULL AUTO_INCREMENT,
    id_produto INT NOT NULL,
    id_fornecedor INT NOT NULL,
    qtd_pedido INT NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id),
    FOREIGN KEY (id_fornecedor) REFERENCES FornecedorProduto(id)
);

CREATE TABLE EstoqueMateriaPrima (
	id INT NOT NULL AUTO_INCREMENT,
	id_materia_prima INT NOT NULL,
    qtd_gramas INT NOT NULL,
    estoque_min INT NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_materia_prima) REFERENCES MateriaPrima(id)
);

CREATE TABLE EstoqueProduto (
	id INT NOT NULL AUTO_INCREMENT,
	id_produto INT NOT NULL,
    qtd INT NOT NULL,
    estoque_min INT NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_produto) REFERENCES Produto(id)
);

CREATE TABLE Carrinho (
	id INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data DATE NOT NULL,
	
    PRIMARY KEY (id),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id)
);
    
CREATE TABLE ItemCarrinho (
    id INT NOT NULL AUTO_INCREMENT,
    id_item INT NOT NULL,
    id_carrinho INT NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_item) REFERENCES Item(id),
    FOREIGN KEY (id_carrinho) REFERENCES Carrinho(id)
);

CREATE TABLE Venda (
	id INT NOT NULL AUTO_INCREMENT,
    id_carrinho INT NOT NULL,
    id_pgto INT NOT NULL,
    id_entrega INT,
    id_func INT NOT NULL,
    id_cliente INT NOT NULL,
    data_venda DATE NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_carrinho) REFERENCES Carrinho(id),
    FOREIGN KEY (id_pgto) REFERENCES MeioPgto(id),
    FOREIGN KEY (id_entrega) REFERENCES Entrega(id),
    FOREIGN KEY (id_func) REFERENCES Funcionario(id),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id)
);

    
