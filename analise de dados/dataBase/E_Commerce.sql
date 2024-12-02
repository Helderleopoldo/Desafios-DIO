-- CREATE DATABASE E_Commerce;
USE E_Commerce;

CREATE TABLE clientes(
	id INT AUTO_INCREMENT,
    f_nome VARCHAR(20) NOT NULL,
	l_nome VARCHAR(20) NOT NULL,
    senha VARCHAR(45) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT pk_id_cliente PRIMARY KEY (id)
)ENGINE=InnoDB;

CREATE TABLE clientes_fisicos(
	id_cliente INT NOT NULL,
	cpf VARCHAR(14),
    rg VARCHAR(20),
    CONSTRAINT pk_cliente_fisico PRIMARY KEY (id_cliente),
	CONSTRAINT fk_cliente_fisico FOREIGN KEY (id_cliente) REFERENCES clientes(id) ON DELETE CASCADE,
    CONSTRAINT unique_cpf_cliente UNIQUE(cpf),
    CONSTRAINT unique_rg_cliente UNIQUE(rg)
)ENGINE=InnoDB;

CREATE TABLE clientes_juridicos(
	id_cliente INT NOT NULL,
	cnpj VARCHAR(25),
    ie VARCHAR(20),
    CONSTRAINT pk_cliente_juridico PRIMARY KEY (id_cliente),
    CONSTRAINT fk_cliente_juridico FOREIGN KEY (id_cliente) REFERENCES clientes(id) ON DELETE CASCADE,
    CONSTRAINT unique_cnpj_cliente UNIQUE(cnpj),
    CONSTRAINT unique_ie_cliente UNIQUE(ie)
)ENGINE=InnoDB;

CREATE TABLE pedidos(
	id_pedido INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_pedido  ENUM('Processando', 'Pago', 'Enviado', 'Cancelado') DEFAULT 'Processando',
    total DECIMAL(10, 2) NOT NULL,
    CONSTRAINT pk_id_pedido PRIMARY KEY (id_pedido),
    CONSTRAINT fk_cliente_pedido FOREIGN KEY (id_cliente) REFERENCES clientes(id)    
)ENGINE=InnoDB;

CREATE TABLE entrega(
	id_entrega INT AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    status_entrega ENUM('Pendente', 'Em transporte', 'Entregue', 'Cancelado') DEFAULT 'Pendente',   
    cod_rastreio VARCHAR(20) UNIQUE,
    CONSTRAINT pk_id_entrega PRIMARY KEY (id_entrega),
    CONSTRAINT fk_entrega_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)    
)ENGINE=InnoDB;

CREATE TABLE pagamento(
	id_pagamento INT NOT NULL AUTO_INCREMENT,
	id_pedido INT NOT NULL,
    id_cliente INT NOT NULL, 
    tipo_pagamento ENUM('Cartão', 'Boleto') NOT NULL, 
    valor DECIMAL(10, 2) NOT NULL,      
    data_pagamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_id_pagamento PRIMARY KEY (id_pagamento),
    CONSTRAINT fk_pagamento_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id),
    CONSTRAINT fk_pagamento_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
)ENGINE=InnoDB;

CREATE TABLE cartao (
    id_cartao INT AUTO_INCREMENT PRIMARY KEY,
    id_pagamento INT NOT NULL,
    numero_cartao VARCHAR(20) NOT NULL,
    nome_titular VARCHAR(100) NOT NULL,
    data_validade DATE NOT NULL,
    cod_seguranca VARCHAR(4) NOT NULL,
    CONSTRAINT fk_cartao_pagamento FOREIGN KEY (id_pagamento) REFERENCES pagamento(id_pagamento) 
) ENGINE=InnoDB;

CREATE TABLE boleto (
    id_boleto INT AUTO_INCREMENT PRIMARY KEY,
    id_pagamento INT NOT NULL,
    cod_boleto VARCHAR(20) NOT NULL,
    data_vencimento DATE NOT NULL,
    CONSTRAINT fk_boleto_pagamento FOREIGN KEY (id_pagamento) REFERENCES pagamento(id_pagamento)
) ENGINE=InnoDB;

CREATE TABLE fornecedor (
    id_fornecedor INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(20) NOT NULL,
    endereco VARCHAR(255),
    CONSTRAINT pk_fornecedor PRIMARY KEY (id_fornecedor)  
) ENGINE=InnoDB;

CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    categoria VARCHAR(50),
    CONSTRAINT pk_produto PRIMARY KEY (id_produto) 
) ENGINE=InnoDB;

CREATE TABLE produto_fornecedor (
    id_produto INT NOT NULL,
    id_fornecedor INT NOT NULL,
    CONSTRAINT pk_produto_fornecedor PRIMARY KEY (id_produto, id_fornecedor),  
    CONSTRAINT fk_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    CONSTRAINT fk_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
) ENGINE=InnoDB;

CREATE TABLE estoque (
    id_estoque INT AUTO_INCREMENT,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    data_entrada TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_estoque PRIMARY KEY (id_estoque), 
    CONSTRAINT fk_estoque_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
) ENGINE=InnoDB;

CREATE TABLE produto_estoque (
    id_produto INT NOT NULL,
    id_estoque INT NOT NULL,
    quantidade INT NOT NULL,
    CONSTRAINT pk_produto_estoque PRIMARY KEY (id_produto, id_estoque),
    CONSTRAINT fk_produto_estoque_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    CONSTRAINT fk_produto_estoque_estoque FOREIGN KEY (id_estoque) REFERENCES estoque(id_estoque)
) ENGINE=InnoDB;

CREATE TABLE vendedor_externo (
    id_vendedor INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    telefone VARCHAR(20),
    CONSTRAINT pk_vendedor_externo PRIMARY KEY (id_vendedor)  
) ENGINE=InnoDB;

CREATE TABLE produto_vendedor (
    id_produto INT NOT NULL,
    id_vendedor INT NOT NULL,
    CONSTRAINT pk_produto_vendedor PRIMARY KEY (id_produto, id_vendedor),
    CONSTRAINT fk_produto_vendedor_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    CONSTRAINT fk_produto_vendedor_vendedor FOREIGN KEY (id_vendedor) REFERENCES vendedor_externo(id_vendedor)
) ENGINE=InnoDB;

CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL,
    status_pedido VARCHAR(20) DEFAULT 'Processando',
    CONSTRAINT pk_pedido PRIMARY KEY (id_pedido), 
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id)
) ENGINE=InnoDB;

CREATE TABLE pedido_produto (
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    CONSTRAINT pk_pedido_produto PRIMARY KEY (id_pedido, id_produto),  -- Chave primária composta
    CONSTRAINT fk_pedido_produto_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    CONSTRAINT fk_pedido_produto_produto FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
) ENGINE=InnoDB;

INSERT INTO clientes (f_nome, l_nome, senha) VALUES
('João', 'Silva', 'senha123'),
('Maria', 'Oliveira', 'senha456'),
('Carlos', 'Souza', 'senha789'),
('Fernanda', 'Costa', 'senha101'),
('Lucas', 'Pereira', 'senha202'),
('Ana', 'Lima', 'senha303'),
('Pedro', 'Santos', 'senha404'),
('Juliana', 'Alves', 'senha505'),
('Ricardo', 'Moura', 'senha606'),
('Patricia', 'Gomes', 'senha707'),
('Vinícius', 'Rocha', 'senha808'),
('Amanda', 'Martins', 'senha909'),
('Eduardo', 'Fernandes', 'senha1010'),
('Larissa', 'Carvalho', 'senha1111'),
('Felipe', 'Ribeiro', 'senha1212'),
('Mariana', 'Lopes', 'senha1313'),
('Roberto', 'Barros', 'senha1414'),
('Bruna', 'Araujo', 'senha1515'),
('Thiago', 'Nunes', 'senha1616'),
('Camila', 'Dias', 'senha1717');

INSERT INTO clientes_fisicos (id_cliente, cpf, rg) VALUES
(1, '123.456.789-00', 'MG1234567'),
(2, '987.654.321-00', 'SP9876543'),
(3, '111.222.333-44', 'RJ1122334'),
(4, '444.555.666-77', 'BA4455667'),
(5, '555.666.777-88', 'CE5566778'),
(6, '666.777.888-99', 'PR6677889'),
(7, '777.888.999-00', 'RS7788990'),
(8, '888.999.000-11', 'SC8899001'),
(9, '999.000.111-22', 'GO9900112'),
(10, '000.111.222-33', 'DF0011223');

INSERT INTO clientes_juridicos (id_cliente, cnpj, ie) VALUES
(11, '12.345.678/0001-90', '1234567890'),
(12, '23.456.789/0001-01', '2345678901'),
(13, '34.567.890/0001-12', '3456789012'),
(14, '45.678.901/0001-23', '4567890123'),
(15, '56.789.012/0001-34', '5678901234'),
(16, '67.890.123/0001-45', '6789012345'),
(17, '78.901.234/0001-56', '7890123456'),
(18, '89.012.345/0001-67', '8901234567'),
(19, '90.123.456/0001-78', '9012345678'),
(20, '01.234.567/0001-89', '0123456789');

INSERT INTO pedidos (id_cliente, status_pedido, total) VALUES
(1, 'Processando', 150.00),
(2, 'Pago', 200.00),
(3, 'Enviado', 350.00),
(4, 'Cancelado', 100.00),
(5, 'Pago', 120.00),
(6, 'Enviado', 230.00),
(7, 'Processando', 400.00),
(8, 'Pago', 500.00),
(9, 'Enviado', 750.00),
(10, 'Cancelado', 300.00),
(11, 'Processando', 600.00),
(12, 'Pago', 320.00),
(13, 'Enviado', 450.00),
(14, 'Cancelado', 190.00),
(15, 'Processando', 410.00),
(16, 'Pago', 300.00),
(17, 'Enviado', 550.00),
(18, 'Cancelado', 240.00),
(19, 'Processando', 180.00),
(20, 'Pago', 220.00);

INSERT INTO pagamento (id_pedido, id_cliente, tipo_pagamento, valor) VALUES
(1, 1, 'Cartão', 150.00),
(2, 2, 'Boleto', 200.00),
(3, 3, 'Cartão', 350.00),
(4, 4, 'Boleto', 100.00),
(5, 5, 'Cartão', 120.00),
(6, 6, 'Boleto', 230.00),
(7, 7, 'Cartão', 400.00),
(8, 8, 'Boleto', 500.00),
(9, 9, 'Cartão', 750.00),
(10, 10, 'Boleto', 300.00),
(11, 11, 'Cartão', 600.00),
(12, 12, 'Boleto', 320.00),
(13, 13, 'Cartão', 450.00),
(14, 14, 'Boleto', 190.00),
(15, 15, 'Cartão', 410.00),
(16, 16, 'Boleto', 300.00),
(17, 17, 'Cartão', 550.00),
(18, 18, 'Boleto', 240.00),
(19, 19, 'Cartão', 180.00),
(20, 20, 'Boleto', 220.00);

INSERT INTO cartao (id_pagamento, numero_cartao, nome_titular, data_validade, cod_seguranca) VALUES
(1, '1234 5678 9012 3456', 'João Silva', '2025-08-01', '123'),
(3, '2345 6789 0123 4567', 'Carlos Souza', '2026-06-01', '234'),
(6, '3456 7890 1234 5678', 'Ana Lima', '2025-12-01', '345'),
(7, '4567 8901 2345 6789', 'Pedro Santos', '2025-11-01', '456'),
(9, '5678 9012 3456 7890', 'Vinícius Rocha', '2026-05-01', '567'),
(11, '6789 0123 4567 8901', 'Eduardo Fernandes', '2025-10-01', '678'),
(13, '7890 1234 5678 9012', 'Mariana Lopes', '2026-09-01', '789'),
(15, '8901 2345 6789 0123', 'Felipe Ribeiro', '2025-07-01', '890'),
(17, '9012 3456 7890 1234', 'Roberto Barros', '2026-04-01', '901'),
(19, '0123 4567 8901 2345', 'Thiago Nunes', '2025-02-01', '012');

INSERT INTO boleto (id_pagamento, cod_boleto, data_vencimento) VALUES
(2, 'BOLETO123456', '2024-12-31'),
(4, 'BOLETO234567', '2024-11-30'),
(5, 'BOLETO345678', '2024-12-01'),
(6, 'BOLETO456789', '2024-12-10'),
(8, 'BOLETO567890', '2024-12-20'),
(10, 'BOLETO678901', '2024-12-25'),
(12, 'BOLETO789012', '2024-11-25'),
(14, 'BOLETO890123', '2024-12-15'),
(16, 'BOLETO901234', '2024-12-05'),
(18, 'BOLETO012345', '2024-11-28');

INSERT INTO fornecedor (nome, cnpj, endereco) VALUES
('Fornecedor A', '12.345.678/0001-99', 'Rua A, 123'),
('Fornecedor B', '98.765.432/0001-88', 'Rua B, 456'),
('Fornecedor C', '11.223.344/0001-77', 'Rua C, 789');

INSERT INTO vendedor_externo (nome, cpf, telefone) VALUES
('Vendedor X', '123.456.789-00', '99999-8888'),
('Vendedor Y', '234.567.890-11', '99999-7777'),
('Vendedor Z', '345.678.901-22', '99999-6666');

INSERT INTO produto (nome, descricao, preco, categoria) VALUES
('Produto 1', 'Descrição do Produto 1', 50.00, 'Categoria A'),
('Produto 2', 'Descrição do Produto 2', 150.00, 'Categoria B'),
('Produto 3', 'Descrição do Produto 3', 200.00, 'Categoria C');

INSERT INTO produto_fornecedor (id_produto, id_fornecedor) VALUES
(1, 1),  
(2, 2),  
(3, 3);  

UPDATE fornecedor
SET nome = 'Fornecedor A - Vendedor', endereco = 'Rua A, 123 - Vendedor'
WHERE id_fornecedor = 1;

UPDATE fornecedor
SET nome = 'Fornecedor B - Vendedor', endereco = 'Rua B, 456 - Vendedor'
WHERE id_fornecedor = 2;

SELECT * FROM produto;

SELECT * FROM fornecedor;

SELECT * FROM produto_fornecedor;

SELECT p.nome AS produto, f.nome AS fornecedor
FROM produto p
JOIN produto_fornecedor pf ON p.id_produto = pf.id_produto
JOIN fornecedor f ON pf.id_fornecedor = f.id_fornecedor;
 
SELECT p.nome AS produto, f.nome AS fornecedor
FROM produto p
JOIN produto_fornecedor pf ON p.id_produto = pf.id_produto
JOIN fornecedor f ON pf.id_fornecedor = f.id_fornecedor
WHERE f.nome LIKE '%Fornecedor A%';

SELECT f.nome AS fornecedor_vendedor
FROM fornecedor f
JOIN vendedor_externo v ON f.id_fornecedor = v.id_vendedor
WHERE f.nome LIKE '%Vendedor%'; 

SELECT v.nome AS vendedor, p.nome AS produto
FROM vendedor_externo v
JOIN fornecedor f ON v.id_vendedor = f.id_fornecedor
JOIN produto_fornecedor pf ON f.id_fornecedor = pf.id_fornecedor
JOIN produto p ON pf.id_produto = p.id_produto;

SELECT f.nome AS fornecedor, p.nome AS produto
FROM fornecedor f
JOIN produto_fornecedor pf ON f.id_fornecedor = pf.id_fornecedor
JOIN produto p ON pf.id_produto = p.id_produto;

START TRANSACTION;

INSERT INTO clientes (f_nome, l_nome, senha) 
VALUES ('João', 'Silva', 'senha123');

SET @id_cliente = LAST_INSERT_ID();

INSERT INTO pedidos (id_cliente, total) 
VALUES (@id_cliente, 150.00);

SET @id_pedido = LAST_INSERT_ID();

INSERT INTO pagamento (id_pedido, id_cliente, tipo_pagamento, valor)
VALUES (@id_pedido, @id_cliente, 'Cartão', 150.00);

COMMIT;

SELECT * FROM clientes;

SELECT id, f_nome, l_nome FROM clientes;

SELECT id, f_nome, l_nome FROM clientes
WHERE f_nome = 'João';

SELECT id_pedido, total, FORMAT(total * 0.1, 2) AS valor_imposto
FROM pedidos;

SELECT id_pedido, data_pedido, total
FROM pedidos
ORDER BY data_pedido DESC;

SELECT * FROM pedidos;

INSERT INTO pedidos (id_cliente, total) VALUES
(2, 250),
(2, 300),
(2, 350),
(2, 400),
(2, 450),
(2, 500);

SELECT id_cliente, COUNT(id_pedido) AS total_pedidos
FROM pedidos
GROUP BY id_cliente
HAVING COUNT(id_pedido) > 5;

SELECT c.id, c.f_nome, c.l_nome, p.id_pedido, p.total
FROM clientes c
INNER JOIN pedidos p ON c.id = p.id_cliente;

SELECT c.id, c.f_nome, c.l_nome, p.id_pedido
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.id_cliente;

SELECT p.nome AS produto, v.nome AS vendedor
FROM produto p
JOIN produto_vendedor pv ON p.id_produto = pv.id_produto
JOIN vendedor_externo v ON pv.id_vendedor = v.id_vendedor;

SELECT * FROM produto_vendedor;

INSERT INTO produto_vendedor (id_produto, id_vendedor)
VALUES 
(1, 1), 
(2, 2),  
(3, 3);  


