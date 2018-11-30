-- Aumentar numero de funcionario da filial depois de criar um funcionario novo
delimiter // 
CREATE TRIGGER after_funcionario_insert AFTER INSERT
 ON Funcionario
 FOR EACH ROW
 BEGIN
	UPDATE Filial f
    SET num_funcionarios = num_funcionarios + 1
    WHERE f.id = NEW.filial;
 END;
 
 delimiter ;
 
 -- Para testar:
-- select * from Filial;
-- INSERT INTO Funcionario (nome, filial, tipo) values
-- ("Luiza", 1, 1)
-- select * from Filial;

-- Aumentar estoque de materia prima depois da reposição
delimiter // 
CREATE TRIGGER after_ReposicaoMateriaPrima_insert AFTER INSERT
 ON ReposicaoMateriaPrima
 FOR EACH ROW
 BEGIN
	UPDATE EstoqueMateriaPrima e
    SET qtd_gramas = qtd_gramas + NEW.qtd_gramas_rep
    WHERE e.id_materia_prima = NEW.id_materia_prima;
 END;
 
 delimiter ;
 
 -- Para testar:
--  select * from EstoqueMateriaPrima where id=1;
--  INSERT INTO ReposicaoMateriaPrima (qtd_gramas_rep, id_materia_prima, data_rep) values
--  ("5000", 1, CURDATE());
--  select * from EstoqueMateriaPrima where id=1;

-- Aumentar estoque de produto depois da reposição
delimiter // 
CREATE TRIGGER after_ReposicaoProduto_insert AFTER INSERT
 ON ReposicaoProduto
 FOR EACH ROW
 BEGIN
	UPDATE EstoqueProduto e
    SET qtd = qtd + NEW.qtd_rep
    WHERE e.id_produto = NEW.id_produto;
 END;
 
 delimiter ;
 
 -- Para testar:
 -- select * from EstoqueProduto where id_produto=6;
--  INSERT INTO ReposicaoProduto (qtd_rep, id_produto, data_rep) values
--  ("50", 6, CURDATE());
--  select * from EstoqueProduto where id_produto=6;

-- Fazer pedido de materia prima caso chegue no estoque mínimo
delimiter // 
CREATE TRIGGER after_EstoqueMateriaPrima_update AFTER UPDATE
 ON EstoqueMateriaPrima
 FOR EACH ROW
 BEGIN
    IF NEW.qtd_gramas < NEW.estoque_min THEN
        IF ((SELECT data_ped 
            FROM PedidosMateriaPrima
            WHERE id_materia_prima = NEW.id_materia_prima) <> curdate()) OR
            ((SELECT data_ped 
            FROM PedidosMateriaPrima
            WHERE id_materia_prima = NEW.id_materia_prima) is null) THEN
            
            INSERT INTO PedidosMateriaPrima (id_materia_prima, qtd_gramas_pedido, data_ped, id_fornecedor) values
            (NEW.id_materia_prima, NEW.estoque_min + 5000, curdate(), 
                (SELECT id FROM FornecedorMateriaPrima WHERE id_materia_prima = NEW.id_materia_prima));
        END IF;
    END IF;
 END//
 
 delimiter ;
 
-- Para testar:
-- select * from EstoqueMateriaPrima
-- select * from PedidosMateriaPrima
-- 
-- update EstoqueMateriaPrima 
-- set qtd_gramas = 400
-- where id_materia_prima = 1;


-- Fazer pedido de produto caso chegue no estoque mínimo
delimiter // 
CREATE TRIGGER after_EstoqueProduto_update AFTER UPDATE
 ON EstoqueProduto
 FOR EACH ROW
 BEGIN
    IF NEW.qtd < NEW.estoque_min THEN
        IF ((SELECT data_ped 
            FROM PedidosProduto
            WHERE id_produto = NEW.id_produto) <> curdate()) OR
            ((SELECT data_ped 
            FROM PedidosProduto
            WHERE id_produto = NEW.id_produto) is null) THEN
            
            INSERT INTO PedidosProduto (id_produto, qtd_pedido, data_ped, id_fornecedor) values
            (NEW.id_produto, NEW.estoque_min + 50, curdate(), 
                (SELECT id FROM FornecedorProduto WHERE id_produto = NEW.id_produto));
        END IF;
    END IF;
 END//
 
 delimiter ;
 
-- Para testar:
-- select * from EstoqueProduto
-- select * from PedidosProduto
-- 
-- update EstoqueProduto 
-- set qtd = 3
-- where id_produto=1;
