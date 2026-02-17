-- Script  (DQL)
-- Objetivo: Responder perguntas de negócio como faturamento, estoque e perfil de cliente.
-- Recuperações simples com SELECT Statement
-- Filtros com WHERE Statement
-- Crie expressões para gerar atributos derivados
-- Defina ordenações dos dados com ORDER BY
-- Condições de filtros aos grupos – HAVING Statement
-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados

Use ecommerce;

-- Listar os nomes de todos os clientes da loja com select simples

SELECT nome, email FROM cliente;

-- Pesquisar quais ferramentas custam mais de R$ 1000,00
SELECT * FROM produto 
WHERE categoria = 'Ferramentas' AND valor > 80.00;


-- expressões e produtos derivados
-- Qual o valor total de cada item no pedido?
-- resposta 1
SELECT idPedido, idProduto, (quantidade * valorUnitario) AS valorTotalItem
FROM produtoPedido;
-- resposta 2
SELECT 
    pp.idPedido, 
    p.descricao AS nomeProduto, 
    pp.quantidade, 
    pp.valorUnitario,
    (pp.quantidade * pp.valorUnitario) AS valorTotalItem
FROM produtoPedido pp
JOIN produto p ON pp.idProduto = p.idProduto;

-- Quais os produtos mais caros da loja do mais caro para o mais barato?

SELECT descricao, valor FROM produto 
ORDER BY valor DESC;

-- Quais  produtos possuem um valor médio maior que  R$ 80,00

SELECT categoria, ROUND(AVG(valor),2) AS mediaPreco
FROM produto
GROUP BY categoria
HAVING mediaPreco > 80.00;

SELECT 
    p.categoria, 
    SUM(ie.quantidade) AS totalProdutosEstoque
FROM `ecommerce`.`produto` p
JOIN `ecommerce`.`itemEstoque` ie ON p.idProduto = ie.idProduto
GROUP BY p.categoria;

-- Quais são os clientes que mais compram?
SELECT 
    c.nome, 
    COUNT(p.idPedido) AS quantidadePedidos,
    SUM(p.frete) AS totalGastoFrete
FROM `ecommerce`.`cliente` c
JOIN `ecommerce`.`pedido` p ON c.idCliente = p.idCliente
GROUP BY c.nome
ORDER BY quantidadePedidos DESC;

-- Qual a quantidade de pedidos   agrupados por estatus?

SELECT 
    statusPedido, 
    SUM(frete) AS totalFreteAcumulado,
    COUNT(*) AS totalPedidos
FROM `ecommerce`.`pedido`
GROUP BY statusPedido
HAVING totalPedidos > 0;

-- Join
-- Qual cliente fizeram pedidos e qual status de cada pedido?

SELECT c.nome, p.idPedido, p.statusPedido
FROM cliente AS c
INNER JOIN pedido AS p ON c.idCliente = p.idCliente;