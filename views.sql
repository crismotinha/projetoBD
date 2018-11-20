-- view de vendas que foram realizadas no cartão (débito ou crédito)
CREATE VIEW Vendas_Cartao AS
    SELECT v.id, v.id_entrega, v.id_func, v.id_cliente, v.data_venda, v.valor_total
    FROM Venda v
    WHERE v.id_pgto = 2 OR v.id_pgto = 3;
    
-- view de vendas que foram realizadas no dinheiro
CREATE VIEW Vendas_Dinheiro AS
    SELECT v.id, v.id_carrinho, v.id_entrega, v.id_func, v.id_cliente, v.data_venda, v.valor_total
    FROM Venda v
    WHERE v.id_pgto = 1;

-- view de vendas que houve entrega
CREATE VIEW Vendas_Entrega AS
    SELECT v.id, v.id_carrinho, v.id_pgto, v.id_func, v.id_cliente, v.data_venda, v.valor_total
    FROM Venda v
    WHERE v.id_entrega IS NOT NULL;

-- view de vendas que foram ao vivo
CREATE VIEW Vendas_Presencial AS
    SELECT v.id, v.id_carrinho, v.id_pgto, v.id_func, v.id_cliente, v.data_venda, v.valor_total
    FROM Venda v
    WHERE v.id_entrega IS NULL;
