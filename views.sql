-- view de vendas que foram realizadas no cartão (débito ou crédito)
CREATE VIEW Vendas_Cartao AS
SELECT v.id, v.id_carrinho AS CARRINHO, c.nome AS NOME_CLIENTE, mp.descricao AS CARTAO, v.id_entrega AS ID_ENTREGA, func.nome AS NOME_FUNCIONARIO, v.data_venda AS DATA_VENDA, v.valor_total AS VALOR_TOTAL
    FROM Venda v
        INNER JOIN Carrinho ca on ca.id = v.id_carrinho
        INNER JOIN Cliente c on ca.id_cliente = c.id
        INNER JOIN Funcionario func on func.id = v.id_func
        INNER JOIN MeioPgto mp on v.id_pgto = mp.id
    WHERE v.id_pgto = 2 OR v.id_pgto = 3;
    
-- view de vendas que foram realizadas no dinheiro
CREATE VIEW Vendas_Dinheiro AS
    SELECT v.id, v.id_carrinho AS CARRINHO, c.nome AS NOME_CLIENTE, v.id_entrega AS ID_ENTREGA, func.nome AS NOME_FUNCIONARIO, v.data_venda AS DATA_VENDA, v.valor_total AS VALOR_TOTAL
    FROM Venda v
        INNER JOIN Carrinho ca on ca.id = v.id_carrinho
        INNER JOIN Cliente c on ca.id_cliente = c.id
        INNER JOIN Funcionario func on func.id = v.id_func
    WHERE v.id_pgto = 1;

-- view de vendas que houve entrega
CREATE VIEW Vendas_Entrega AS
    SELECT v.id, v.id_carrinho AS CARRINHO, c.nome AS NOME_CLIENTE, func.nome AS NOME_FUNCIONARIO, v.data_venda AS DATA_VENDA, v.valor_total AS VALOR_TOTAL
    FROM Venda v
        INNER JOIN Carrinho ca on ca.id = v.id_carrinho
        INNER JOIN Cliente c on ca.id_cliente = c.id
        INNER JOIN Funcionario func on func.id = v.id_func
    WHERE v.id_entrega IS NOT NULL;

-- view de vendas que foram ao vivo
CREATE VIEW Vendas_Presencial AS
    SELECT v.id, v.id_carrinho AS CARRINHO, c.nome AS NOME_CLIENTE, func.nome AS NOME_FUNCIONARIO, v.data_venda AS DATA_VENDA, v.valor_total AS VALOR_TOTAL
    FROM Venda v
        INNER JOIN Carrinho ca on ca.id = v.id_carrinho
        INNER JOIN Cliente c on ca.id_cliente = c.id
        INNER JOIN Funcionario func on func.id = v.id_func
    WHERE v.id_entrega IS NULL;
