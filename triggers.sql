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