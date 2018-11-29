# Trabalho Final de Banco de Dados, UFF - 2018.2 (Cris Motinha e Let Vidal)

## Descrição

É um sistema de pastelaria, que permite vender produtos que sejam comprados prontos (como bebidas em lata) e produtos que sejam fabricados (com diversas matérias primas).

## Features

- Cadastrar filiais: você pode cadastrar filiais que estarão diretamente ligadas as suas vendas
- Cadastrar funcionários: você pode cadastrar n tipos de funcionários e também ligá-los as suas filiais
- Carrinho: você pode adicionar itens individualmente no momento da compra e finalizá-la uma vez, com o cálculo do valor total de uma forma rápida
- Desconto automático de estoque ao finalizar compra: somente ao finalizar compra, cada produto (seja ele pronto ou com várias matérias primas) serão automaticamente descontados dos estoques
- Cadastro de receita: para produtos que são fabricados no local, cadastre suas receitas para ter o desconto automático do estoque no momento da venda
- Pedido de novos insumos e produtos: defina um estoque mínimo para te ajudar, e também conte com o nosso controle de recebimento
- Métricas de vendas: veja qual o produto mais vendido em todas as suas lojas ou em cada uma delas, qual funcionário vendeu mais e menos, qual filial vendeu mais e vendas por filial, média de vendas separadas por forma de pagamento, número de entregas por entregador e muito mais!

## Objetos

São 22 entidades: 
- Cliente; quem compra o produto
- TipoFuncionario: cargo do funcionário (caixa, entregador)
- Filial: identificação da filial
- Funcionario: quem vende/entrega o produto
- Produto: objeto vendido (pode ter ou não matérias primas)
- MateriaPrima: objeto que compõe um produto
- FornecedorMateriaPrima: quem fornece cada matéria prima
- FornecedorProduto: quem fornece cada produto
- Receita: quantidade de cada matéria prima para fazer um produto
- Entrega: identificação da entrega (endereço)
- MeioPgto: tipo de meio de pagamento (crédito, débito, dinheiro)
- DadosCartao: dados do cartão do cliente para pagamentos online
- ReposicaoMateriaPrima: controle de reposição de matéria prima
- ReposicaoProduto: controle de reposição de produtos
- PedidosMateriaPrima: pedidos de matéria prima para um fornecedor
- PedidosProduto: pedidos de produto para um fornecedor
- EstoqueMateriaPrima: quantidades de matéria prima em estoque
- EstoqueProduto: quantidades de produto em estoque
- Item: produto e quantidade para uma venda
- Carrinho: parte que compõe a compra, e identifica o cliente da compra
- ItemCarrinho: ligação entre cada item e seu carrinho
- Venda: entidade que une tudo relacionado a venda: funcionário, carrinho, valor total, meio de pagamento, entrega

## Realizando uma venda

Para realizar uma venda, basta usar as procedures! Inicie a venda, adicione itens no carrinho e finalize!
Exemplo:
```
CALL IniciaVenda(1, @Carrinho); -- Inicia a venda para o cliente id 1

CALL AdicionaNoCarrinho(2,2, @Carrinho); -- Adiciona 2 unidades do item 2 no carrinho

CALL FinalizaVenda(@Carrinho, 1, null, 1, @ContaFinal); -- Finaliza a venda do carrinho atual, com o funcionário de id 1, sem entrega e com o  meio de pagamento 1

SELECT @ContaFinal -- Mostra o valor final da compra
```

