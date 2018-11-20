-- Queries:

-- 1. Vendas por filial

-- 2. Filial que vendeu mais (ordenando por qtd de venda)

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
    SELECT avg(valor_total)
    FROM Vendas_Cartao vc
    WHERE vc.id_pgto = 2;

-- 6. Média de vendas por débito (em cima da view)
    SELECT avg(valor_total)
    FROM Vendas_Cartao vc
    WHERE vc.id_pgto = 3;

-- 7. Média de vendas por dinheiro
    SELECT avg(valor_total)
    FROM Vendas_Dinheiro;

-- 8. Qual cliente comprou mais


-- 9. Qual cliente comprou menos

-- 10. Produtos mais pedidos (sem receita) (refrigerante, cerveja)

-- 11. Produtos mais pedidos (com receita) (por exemplo pastel de carne)

-- 12. Matéria prima que gasta mais por semana

-- 13. Numero de entregas por funcionario entregador

-- 14. Produto mais vendido no dia

-- 15. Vendas mais caras do ultimo mes

-- 16. Peso total de cada produto com materia prima (soma das qtd que são em gramas)

-- 17. Numero de funcionarios por filial
SELECT num_funcionarios, nome
FROM Filial;

-- OU 
SELECT f.id AS ID_FILIAL, count(func.id) AS NUM_FUNC_FILIAL
FROM Funcionario func, Filial f
WHERE f.id = func.filial
GROUP BY func.filial

-- 18. Media de entregas por filial por mês

-- 19.

-- 20.