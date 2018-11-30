-- Procedures de venda:

DELIMITER //
CREATE PROCEDURE IniciaVenda (IN cliente_id INT, OUT carrinho_id INT)
BEGIN
    INSERT INTO Carrinho (id_cliente, data) values (cliente_id, CURDATE());
    SELECT c.id INTO carrinho_id FROM Carrinho c WHERE c.id_cliente = cliente_id ORDER BY id desc limit 1;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AdicionaNoCarrinho (IN id_produto INT, IN qtd_produto INT, IN id_carrinho INT)
BEGIN
    DECLARE preco_produto DECIMAL(10,2);
    SELECT preco INTO preco_produto FROM Produto p WHERE p.id = id_produto;
    INSERT INTO Item (id_produto, qtd, sub_total) VALUES (id_produto, qtd_produto, preco_produto * qtd); 
    INSERT INTO ItemCarrinho (id_item, id_carrinho) VALUES
        ((SELECT max(id) FROM Item i WHERE i.id_produto = id_produto AND i.qtd = qtd_produto), id_carrinho);
END //
DELIMITER ;

-- Criada pra melhorar a legibilidade do código, faz só o update da materia prima que é mais complexo

DELIMITER //
CREATE PROCEDURE UpdateEstoqueMateriaPrima (IN quantidade_produto INT, IN produto INT)
BEGIN
	
    DECLARE done INT DEFAULT 0;
    DECLARE cur_id_materia_prima INT;
    DECLARE cur_qtd_materia_prima INT;
    
    DECLARE cursor_id_produtos cursor for select * from ReceitaNoCarrinho;
    DECLARE continue handler for not found set done = 1;
    

	DROP TABLE IF EXISTS ReceitaNoCarrinho;
	CREATE TEMPORARY TABLE ReceitaNoCarrinho
	SELECT r.id_materia_prima, r.qtd * quantidade_produto 
	FROM Produto p
		INNER JOIN Receita r ON r.id_produto = p.id
	WHERE p.id = produto;
	
    OPEN cursor_id_produtos;
    REPEAT
    
        FETCH cursor_id_produtos into cur_id_materia_prima, cur_qtd_materia_prima;
        
        IF !done THEN
			UPDATE EstoqueMateriaPrima emp
			SET emp.qtd_gramas = qtd_gramas - cur_qtd_materia_prima
            WHERE emp.id_materia_prima = cur_id_materia_prima;	
		END IF;
    UNTIL done END REPEAT;

    CLOSE cursor_id_produtos;

END //
DELIMITER ;

-- Finaliza a venda
DELIMITER //
CREATE PROCEDURE FinalizaVenda (IN carrinho_id INT, IN id_tipo_pagamento INT, IN id_entrega INT, IN id_funcionario_caixa INT, OUT valor_final DECIMAL(10,2))
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE cur_id_produto INT;
    DECLARE cur_tem_materia_prima BOOL;
    DECLARE cur_qtd_produto INT;
    
    DECLARE cursor_id_produtos cursor for select id_produto, Qtd, tem_materia_prima from ItensNoCarrinho;
    DECLARE continue handler for not found set done = 1;
    
    DROP TABLE IF EXISTS ItensNoCarrinho;
    CREATE TEMPORARY TABLE ItensNoCarrinho
    SELECT i.id_produto, sum(i.qtd) as 'Qtd', sum(i.sub_total) as 'Soma', p.tem_materia_prima
    FROM ItemCarrinho ic
        INNER JOIN Item i ON ic.id_item = i.id
        INNER JOIN Produto p ON p.id = i.id_produto
    WHERE ic.id_carrinho = carrinho_id
    GROUP BY i.id_produto;
    
    SELECT sum(Soma) INTO valor_final FROM ItensNoCarrinho;
    
    INSERT INTO Venda (id_carrinho, id_pgto, id_entrega, id_func, data_venda, valor_total) VALUES
    (carrinho_id, id_tipo_pagamento, id_entrega, id_funcionario_caixa, curdate(), valor_final);


    OPEN cursor_id_produtos;
    REPEAT
    
        FETCH cursor_id_produtos into cur_id_produto, cur_qtd_produto, cur_tem_materia_prima;
        
        IF !done THEN
        
			CASE cur_tem_materia_prima WHEN false THEN
				UPDATE EstoqueProduto ep
				SET ep.qtd = ep.qtd - cur_qtd_produto
				WHERE ep.id_produto = cur_id_produto;
			
            WHEN true THEN
				CALL UpdateEstoqueMateriaPrima(cur_id_produto, cur_qtd_produto);
            
            END CASE;
        END IF;
    UNTIL done END REPEAT;

    CLOSE cursor_id_produtos;

END //
DELIMITER ;

-- Exemplo de Venda:

CALL IniciaVenda(1, @Carrinho);

SELECT @Carrinho;

CALL AdicionaNoCarrinho(2,2, @Carrinho);

CALL FinalizaVenda(@Carrinho, 1, null, 1, @ContaFinal);
SELECT @ContaFinal


-- Procedure de relatorio de vendas semanal

DELIMITER //
CREATE PROCEDURE RelatorioVendasSemanal()
BEGIN
  SELECT p.id AS ID_PRODUTO, p.descricao AS PRODUTO, sum(v.valor_total) AS VALOR_VENDAS
  FROM Produto p
    INNER JOIN Item i ON i.id_produto = p.id
    INNER JOIN ItemCarrinho ic ON i.id = ic.id_item
    INNER JOIN Carrinho c ON c.id = ic.id_carrinho
    INNER JOIN Venda v on v.id_carrinho = c.id
  WHERE v.data_venda >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK)
  GROUP BY p.id;
END //
DELIMITER ;

