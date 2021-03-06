-- Indice extra:
CREATE INDEX p_descricao_idx ON Produto(descricao);

-- Queries:

-- 1. Vendas por filial
    SELECT f.nome AS NOME_FILIAL, count(v.id) AS NUM_VENDAS
    FROM Filial f 
        INNER JOIN Funcionario fu ON fu.filial = f.id
        INNER JOIN Venda v ON v.id_func = fu.id
    GROUP BY f.id; 

-- 2. Filial que vendeu mais (ordenando por qtd de venda)
    SELECT f.nome AS NOME_FILIAL, count(v.id) AS NUM_VENDAS_MAX
    FROM Filial f 
        INNER JOIN Funcionario fu ON fu.filial = f.id
        INNER JOIN Venda v ON v.id_func = fu.id
    GROUP BY f.id
    ORDER BY NUM_VENDAS_MAX DESC LIMIT 1; 

-- 3. Funcionario que vendeu mais
    SELECT func.id AS ID_FUNC, count(v.id) AS NUM_VENDAS 
    FROM Funcionario func, Venda v
    WHERE v.id_func = func.id
    GROUP BY v.id_func
    ORDER BY count(v.id) DESC LIMIT 1 ; -- pensar aqui num jeito pq pode ter funcionarios com o mesmo numero de vendas

-- 4. Funcionario que vendeu menos
    SELECT func.id AS ID_FUNC, count(v.id) AS NUM_VENDAS 
    FROM Funcionario func, Venda v
    WHERE v.id_func = func.id
    GROUP BY v.id_func
    ORDER BY count(v.id) ASC LIMIT 1 ; 

-- 5. Média de vendas por crédito (em cima da view)
    SELECT avg(valor_total) AS MEDIA_CREDITO
    FROM Vendas_Cartao vc
    WHERE vc.id_pgto = 2;

-- 6. Média de vendas por débito (em cima da view)
    SELECT avg(valor_total) AS MEDIA_DEBITO
    FROM Vendas_Cartao vc
    WHERE vc.id_pgto = 3;

-- 7. Média de vendas por dinheiro (em cima da view)
    SELECT avg(valor_total) AS MEDIA_DINHEIRO
    FROM Vendas_Dinheiro;

-- 8. Qual cliente comprou mais
    SELECT c.nome AS NOME_CLIENTE, count(v.id) AS NUM_COMPRAS
    FROM Venda v 
        INNER JOIN Carrinho ca ON ca.id = v.id_carrinho
        INNER JOIN Cliente c ON c.id = ca.id_cliente
    GROUP BY c.id
    ORDER BY NUM_COMPRAS DESC LIMIT 1; 

-- 9. Qual cliente comprou menos
    SELECT c.nome AS NOME_CLIENTE, count(v.id) AS NUM_COMPRAS
    FROM Venda v 
        INNER JOIN Carrinho ca ON ca.id = v.id_carrinho
        INNER JOIN Cliente c ON c.id = ca.id_cliente
    GROUP BY c.id
    ORDER BY NUM_COMPRAS ASC LIMIT 1; 

-- 10. Produtos mais pedidos (sem receita) (refrigerante, cerveja)
    SELECT p.descricao AS NOME_PRODUTO, count(i.id) AS NUM_PEDIDOS
    FROM Produto p
        INNER JOIN Item i ON i.id_produto = p.id
    WHERE p.tem_materia_prima = false
    GROUP BY p.id
    ORDER BY NUM_PEDIDOS DESC LIMIT 5; -- pega os top 5
    

-- 11. Produtos mais pedidos (com receita) (por exemplo pastel de carne)
    SELECT p.descricao AS NOME_PRODUTO, count(i.id) AS NUM_PEDIDOS
    FROM Produto p
        INNER JOIN Item i ON i.id_produto = p.id
    WHERE p.tem_materia_prima = true
    GROUP BY p.id
    ORDER BY NUM_PEDIDOS DESC LIMIT 5; -- pega os top 5

-- 12. Numero de entregas por funcionario entregador
    SELECT func.nome AS NOME_FUNCIONARIO, count(e.id) AS NUM_ENTREGAS
    FROM Funcionario func
        INNER JOIN Entrega e ON e.id_func = func.id
    WHERE func.tipo = 2
    GROUP BY func.id;
 
-- 13. Produto mais vendido no dia
    SELECT p.descricao AS PRODUTO_MAIS_VENDIDO_HJ, count(i.id) AS NUM_PEDIDOS
    FROM Produto p
        INNER JOIN Item i ON i.id_produto = p.id
        INNER JOIN ItemCarrinho ic on ic.id_item = i.id
        INNER JOIN Carrinho ca ON ca.id = ic.id_carrinho
        INNER JOIN Venda v ON v.id_carrinho = ca.id
    WHERE v.data_venda = curdate()
    GROUP BY p.id
    ORDER BY NUM_PEDIDOS DESC LIMIT 1;

-- 14. Vendas mais caras do ultimo mes
    SELECT id, id_carrinho, valor_total
    FROM Venda v
    WHERE data_venda > DATE_SUB(NOW(), INTERVAL 1 MONTH)
    ORDER BY valor_total DESC LIMIT 5;

-- 15. Peso total de cada produto com receita (soma das qtd que são em gramas)
    SELECT p.descricao AS NOME_PRODUTO, sum(r.qtd) AS PESO_TOTAL 
    FROM Produto p
		INNER JOIN Receita r ON r.id_produto = p.id
	WHERE p.tem_materia_prima = true
    GROUP BY p.id;

-- 16. Sabor de pastel mais vendido
    SELECT p.descricao AS NOME_PRODUTO, count(i.id) AS NUM_PEDIDOS
    FROM Produto p
    USE INDEX (p_descricao_idx)
        INNER JOIN Item i ON i.id_produto = p.id
    WHERE p.tem_materia_prima = true
            AND p.descricao LIKE "Pastel%"
    GROUP BY p.id
    ORDER BY NUM_PEDIDOS DESC LIMIT 1;
    

-- 17. Sabor de pastel mais vendido por loja
    SELECT p.descricao AS NOME_PRODUTO, count(i.id) AS NUM_PEDIDOS, fi.nome AS NOME_FILIAL
    FROM Produto p
        INNER JOIN Item i ON i.id_produto = p.id
        INNER JOIN ItemCarrinho ic ON i.id = ic.id_item
        INNER JOIN Carrinho c ON c.id = ic.id_carrinho
        INNER JOIN Venda v ON v.id_carrinho = c.id
        INNER JOIN Funcionario f ON v.id_func = f.id
        INNER JOIN Filial fi ON f.filial = fi.id
    WHERE p.tem_materia_prima = true
            AND p.descricao LIKE "Pastel%"
    GROUP BY p.descricao, fi.nome
    ORDER BY NUM_PEDIDOS DESC;

-- 18. Fornecedor mais pedido de produto
    SELECT fp.nome AS NOME_FORNECEDOR, p.descricao AS PRODUTO, count(pp.id) AS QTD_PEDIDOS
    FROM PedidosProduto pp
        INNER JOIN FornecedorProduto fp ON fp.id = pp.id_fornecedor
        INNER JOIN Produto p ON pp.id_produto = p.id
    GROUP BY fp.id, p.descricao
    ORDER BY count(fp.id) DESC LIMIT 1;

    
-- 19. Fornecedor mais pedido de materia prima
    SELECT fmp.nome AS NOME_FORNECEDOR, mp.nome AS PRODUTO, count(pmp.id) AS QTD_PEDIDOS
    FROM PedidosMateriaPrima pmp
        INNER JOIN FornecedorMateriaPrima fmp ON fmp.id = pmp.id_fornecedor
        INNER JOIN MateriaPrima mp ON pmp.id_materia_prima = mp.id
    GROUP BY fmp.id, mp.nome
    ORDER BY count(fmp.id) DESC LIMIT 1;
    
-- 20. Fornecedor mais pedido de tudo 
    
    (SELECT fp.nome AS NOME_FORNECEDOR
    FROM PedidosProduto pp
        INNER JOIN FornecedorProduto fp ON fp.id = pp.id_fornecedor
        INNER JOIN Produto p ON pp.id_produto = p.id
    GROUP BY fp.id, p.descricao
    ORDER BY count(fp.id) DESC LIMIT 1)
    
    UNION
    
    (SELECT fmp.nome AS NOME_FORNECEDOR
    FROM PedidosMateriaPrima pmp
        INNER JOIN FornecedorMateriaPrima fmp ON fmp.id = pmp.id_fornecedor
        INNER JOIN MateriaPrima mp ON pmp.id_materia_prima = mp.id
    GROUP BY fmp.id, mp.nome
    ORDER BY count(fmp.id) DESC LIMIT 1);
