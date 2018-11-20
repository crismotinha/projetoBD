-- procs venda
-- iniciaVenda(cliente)
--  cria uma nova entrada em Carrinho (cliente)
-- adicionaCarrinho(id carrinho, id produto, qtd)
--  cria um novo item(id produto, qtd) calculando o total
--  adiciona o item a itensCarrinho(id carrinho, id item)
-- fechaVenda(id carrinho)
--  soma todos os itens de itensCarrinho(id carrinho)
--  cria uma nova venda(id carrinho, preço total, cliente, etc)

DELIMITER //
CREATE PROCEDURE IniciaVenda (IN cliente_id INT, OUT carrinho_id INT)
BEGIN
    INSERT INTO Carrinho (id_cliente, data) values (cliente_id, CURDATE());
    SELECT c.id INTO carrinho_id FROM Carrinho c WHERE c.id_cliente = cliente_id ORDER BY id desc limit 1;
END //
DELIMITER ;
drop procedure IniciaVenda

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

drop procedure AdicionaNoCarrinho;

CALL IniciaVenda(1, @Carrinho);
SELECT @Carrinho;
CALL AdicionaNoCarrinho(11,1, @Carrinho)

select * from EstoqueProduto
select * from 

CALL FinalizaVenda(13, 1, null, 1, @ContaFinal);
SELECT @ContaFinal

drop procedure FinalizaVenda

DELIMITER //
CREATE PROCEDURE FinalizaVenda (IN carrinho_id INT, IN id_tipo_pagamento INT, IN id_entrega INT, IN id_funcionario_caixa INT, OUT valor_final DECIMAL(10,2))
BEGIN
	DECLARE done INT DEFAULT 0;
    DECLARE cur_id_produto INT;
    DECLARE cur_tem_materia_prima BOOL;
    DECLARE cur_qtd_produto INT;
    
    DECLARE cliente INT;
    
    DECLARE cursor_id_produtos cursor for select id_produto, Qtd, tem_materia_prima from ItensNoCarrinho;
    DECLARE continue handler for not found set done = 1;
	
    SELECT c.id_cliente into cliente FROM Carrinho c WHERE c.id = carrinho_id;
    
    DROP TABLE IF EXISTS ItensNoCarrinho;
    CREATE TEMPORARY TABLE ItensNoCarrinho
    SELECT i.id_produto, sum(i.qtd) as 'Qtd', sum(i.sub_total) as 'Soma', p.tem_materia_prima
    FROM ItemCarrinho ic
		INNER JOIN Item i ON ic.id_item = i.id
        INNER JOIN Produto p ON p.id = i.id_produto
	WHERE ic.id_carrinho = carrinho_id
    GROUP BY i.id_produto;
    
    SELECT sum('Soma') INTO valor_final FROM ItensNoCarrinho;
    
	INSERT INTO Venda (id_carrinho, id_pgto, id_entrega, id_func, id_cliente, data_venda, valor_total) VALUES
    (carrinho_id, id_tipo_pagamento, id_entrega, id_funcionario_caixa, cliente, curdate(), valor_final);

	

	OPEN cursor_id_produtos;
    REPEAT
		FETCH cursor_id_produtos into cur_id_produto, cur_qtd_produto, cur_tem_materia_prima;
        
        CASE cur_tem_materia_prima WHEN false THEN
			UPDATE EstoqueProduto ep
            SET ep.qtd = ep.qtd - cur_qtd_produto
            WHERE ep.id_produto = cur_id_produto;
		END CASE;
        
	UNTIL done
	END REPEAT;

	CLOSE cursor_id_produtos;

END //
DELIMITER ;
