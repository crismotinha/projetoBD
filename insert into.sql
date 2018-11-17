INSERT INTO Cliente (nome, cpf) values
("Cris", "11111111111"),
("Let", "11111111112"),
("Emilly", "11111111113");

INSERT INTO TipoFuncionario (descricao) values
("Atendente"), ("Entregador");

INSERT INTO Filial (nome, num_funcionarios) values
("Gragoata", 3), ("Praia Vermelha", 2);

INSERT INTO Funcionario (nome, filial, tipo) values
("Joao", 1, 1),
("Jose", 1, 1),
("Carlos", 1, 2),
("Joana", 2, 1),
("Luiza", 2, 2);

INSERT INTO Produto (descricao, tem_materia_prima) values
("Pastel de carne", true),
("Pastel de calabresa", true),
("Pastel de banana com nutella", true),
("Pastel de queijo", true),
("Pastel de pizza", true),
("Coca cola", false),
("Fanta", false),
("Cerveja Antartica", false),
("Cerveja Brahma", false),
("Mate com limão", false),
("Mate sem limão", false);

INSERT INTO MateriaPrima (nome, validade) values
("Massa de pastel", "1 mes"),
("Carne moída", "1 mes"),
("Calabresa moída","1 mes"),
("Presunto","1 mes"),
("Banana amassada","1 mes"),
("Nutella","1 mes"),
("Tomate picado","1 mes"),
("Queijo mussarela ralado","1 mes");

INSERT INTO FornecedorMateriaPrima(id_materia_prima, nome) values
(1, "Joao das Neves"),
(2, "Mercado Prix"),
(3, "Mercado Prix"),
(4, "Mercado Prix"),
(5, "Mercado Prix"),
(6, "Mercado Mundial"),
(7, "Mercado Mundial"),
(8, "Mercado Mundial");

INSERT INTO FornecedorProduto(id_produto, nome) values
(1, "Mercado de Bebidas"),
(2, "Mercado de Bebidas"),
(3, "Mercado de Bebidas"),
(4, "Depósito de Bebidas do João"),
(5, "Depósito de Bebidas do João"),
(6, "Depósito de Bebidas do João");

INSERT INTO Receita (id_materia_prima, qtd, id_produto) values
(1, 100, 1),
(2, 200, 1),
(1, 100, 2),
(3, 200, 2),
(1, 100, 3),
(5, 150, 3),
(6, 50, 3),
(1, 100, 4),
(8, 200, 4),
(1, 100, 5),
(4, 75, 5),
(7, 75, 5),
(8, 100, 5);

INSERT INTO MeioPgto(descricao) values
("Dinheiro"),("Credito"), ("Debito");

INSERT INTO DadosCartao(id_cliente, num_cartao, cvc, validade, nome_portador) values
(1, "1234 XXXX XXXX", "1234", "11/20", "CRISLAINE"),
(2, "1324 XXXX XXXX", "1234", "10/19", "LETYCILEIDE"),
(3, "1764 XXXX XXXX", "1234", "09/22", "EMILLYANYLLY");

INSERT INTO EstoqueMateriaPrima(id_materia_prima, qtd_gramas, estoque_min) values
(1, 10000, 5000),
(2, 10000, 5000),
(3, 10000, 5000),
(4, 10000, 5000),
(5, 10000, 5000),
(6, 10000, 5000),
(7, 10000, 5000),
(8, 10000, 5000);

INSERT INTO EstoqueProduto(id_produto, qtd, estoque_min) values
(6, 20, 5),
(7, 20, 5),
(8, 20, 5),
(9, 20, 5),
(10, 20, 5),
(11, 20, 5);