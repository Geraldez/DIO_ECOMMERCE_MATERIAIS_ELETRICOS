
-- desativa safe updates
SET SQL_SAFE_UPDATES = 0;

-- inserindo clientes
INSERT INTO `ecommerce`.`Cliente` (Nome, `Endereço`, `Endereço de Cobrança`, `Endereço de Entrega`) VALUES 
('Luffy do Chapéu de Palha', 'Vila Foosha, 01', 'Vila Foosha, 01', 'Navio Sunny'),
('Empresa ACME Corp', 'Rua Industrial, 500', 'Rua Industrial, 500', 'Galpão Logístico');

-- Inserindo os tipos de clientes 1(cpf)  para pessoa fisica 2 (cnpj)para pessoa juridica
INSERT INTO ecommerce.cliente_pf (idcliente, cpf) VALUES (1, '12345678901');
INSERT INTO `ecommerce`.`cliente_pj` (idcliente, cnpj) VALUES (2, '12345678000199');

-- inserindo atributos do  produto
INSERT INTO `ecommerce`.`produto` (idproduto, categoria, descricao, valor) VALUES 
(1, 'Eletrônicos', 'Smartphone XYZ', 1500.00),
(2, 'Acessórios', 'Capa Protetora', 50.00);

-- inserindo  o locai de armazenagem do estoque dos produto
INSERT INTO `ecommerce`.`estoque` (idestoque, local) VALUES (1, 'Depósito Central São Paulo');
-- inserindo a quantidade de produto em estoque
INSERT INTO `ecommerce`.`qt_em_estoque` (produto_idproduto, estoque_idestoque, Quantidade) VALUES 
(1, 1, 100),
(2, 1, 500);


-- Cria o pedido para o Cliente 1
INSERT INTO `ecommerce`.`pedido` (idpedido, status_do_pedido, descricao, frete, Cliente_idCliente) VALUES 
(101, 'Em processamento', 'Compra de celular', 15.00, 1);

-- Cria a forma de pagamento disponível
INSERT INTO `ecommerce`.`forma_de_pagamento` (idforma_de_pagamento, pix, pedido_idpedido, pedido_Cliente_idCliente) VALUES 
(1, 1, 101, 1);


-- Cria o pedido para o Cliente 1
INSERT INTO `ecommerce`.`pedido` (idpedido, status_do_pedido, descricao, frete, Cliente_idCliente) VALUES 
(101, 'Em processamento', 'Compra de celular', 15.00, 1);

-- cria a forma de pagamento disponível
INSERT INTO `ecommerce`.`forma_de_pagamento` (idforma_de_pagamento, pix, pedido_idpedido, pedido_Cliente_idCliente) VALUES 
(1, 1, 101, 1);

-- Registra o pagamento efetuado
INSERT INTO `ecommerce`.`pagamento_pedido` (id_forma_de_pagamento, id_pedido, valor) VALUES 
(1, 101, 1515.00);

-- ativa safe updates
SET SQL_SAFE_UPDATES = 1;