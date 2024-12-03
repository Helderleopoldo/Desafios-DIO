-- comando para criação do bancos de dados 
CREATE DATABASE oficina_mecanica;

-- comando para usar banco de dados criado
USE oficina_mecanica;

-- criação das tabelas basicas 

-- Tabela para registro de clientes com informações principais e contatos
CREATE TABLE Cliente(
 	id_cliente SMALLINT UNSIGNED AUTO_INCREMENT,
 	nome_cliente VARCHAR(50) NOT NULL,
 	cpf_cliente CHAR(11) UNIQUE NOT NULL,
	data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	CONSTRAINT pk_id_cliente PRIMARY KEY (id_cliente)
) ENGINE=InnoDB;

 -- Tabela para registros na equipe
CREATE TABLE Equipe(
 	id_equipe INT UNSIGNED AUTO_INCREMENT,
    nome VARCHAR(100),
 	descricao VARCHAR(255),
    CONSTRAINT pk_id_equipe PRIMARY KEY (id_equipe)
)ENGINE=InnoDB;

 -- Tabela para registro de mecanicos com informações principais
CREATE TABLE Mecanico(
 	id_mecanico SMALLINT UNSIGNED AUTO_INCREMENT,
    nome_mecanico VARCHAR(50) NOT NULL,
    especialidade VARCHAR(50),
    data_admissao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_equipe INT UNSIGNED,
    CONSTRAINT pk_id_mecanico PRIMARY KEY (id_mecanico),
    CONSTRAINT fk_id_equipe_mecanico FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe) ON DELETE SET NULL
)ENGINE=InnoDB;

CREATE TABLE Eletronico(
 	id_eletronico SMALLINT UNSIGNED AUTO_INCREMENT,
    nome_eletronico VARCHAR(50) NOT NULL,
    especialidade VARCHAR(50),
    data_admissao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_equipe INT UNSIGNED,
    CONSTRAINT pk_id_eletronico PRIMARY KEY (id_eletronico),
    CONSTRAINT fk_id_equipe_eletronico FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe) ON DELETE SET NULL
)ENGINE=InnoDB;

CREATE TABLE Balconista(
 	id_balconista SMALLINT UNSIGNED AUTO_INCREMENT,
    nome_balconista VARCHAR(50) NOT NULL,
    especialidade VARCHAR(50),
    data_admissao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_equipe INT UNSIGNED,
    CONSTRAINT pk_id_balconista PRIMARY KEY (id_balconista),
    CONSTRAINT fk_id_equipe_balconista FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe) ON DELETE SET NULL
)ENGINE=InnoDB;

 -- Tabela para registro dos contatos, e abaixo de telefone e email
CREATE TABLE Contato(
	id_contato SMALLINT UNSIGNED AUTO_INCREMENT,
    tipo VARCHAR(20) NOT NULL,
 	id_cliente SMALLINT UNSIGNED NOT NULL,   
    CONSTRAINT pk_id_contato PRIMARY KEY (id_contato),
    CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB;

 CREATE TABLE Telefone (
     id_telefone SMALLINT UNSIGNED AUTO_INCREMENT,
     numero VARCHAR(15) NOT NULL,    
     contato_id SMALLINT UNSIGNED NOT NULL,
     CONSTRAINT pk_id_telefone PRIMARY KEY (id_telefone),
     CONSTRAINT fk_id_contato_telefone FOREIGN KEY (contato_id) REFERENCES Contato(id_contato) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE Email (
    id_email SMALLINT AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL,   
    contato_id SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT pk_id_email PRIMARY KEY (id_email),
    CONSTRAINT fk_id_contato_email FOREIGN KEY (contato_id) REFERENCES Contato(id_contato) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB;

 -- Tabela para registro de veiculo
CREATE TABLE Veiculo(	
 	placa VARCHAR(10) UNIQUE,
 	modelo VARCHAR(50),
 	marca VARCHAR(50),
 	ano INT,
 	cliente_id SMALLINT UNSIGNED NOT NULL,
    CONSTRAINT pk_placa PRIMARY KEY (placa),
 	CONSTRAINT fk_id_placa_cliente FOREIGN KEY (cliente_id) REFERENCES Cliente(id_cliente)
)ENGINE=InnoDB;

-- Tabela para registro de serviços realizados
CREATE TABLE Servico (
    id_servico SMALLINT UNSIGNED AUTO_INCREMENT,
    tipo_servico ENUM('Revisao', 'Conserto') NOT NULL,  
    data_servico TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descricao TEXT,
    id_cliente SMALLINT UNSIGNED NOT NULL,
    id_veiculo VARCHAR(10)  NOT NULL,
    id_mecanico SMALLINT UNSIGNED NOT NULL,
    id_equipe INT UNSIGNED NOT NULL,
    CONSTRAINT pk_id_servico PRIMARY KEY (id_servico), 
    CONSTRAINT fk_servico_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE CASCADE,
    CONSTRAINT fk_id_veiculo FOREIGN KEY (id_veiculo) REFERENCES Veiculo(placa) ON DELETE CASCADE,
    CONSTRAINT fk_id_mecanico FOREIGN KEY (id_mecanico) REFERENCES Mecanico(id_mecanico) ON DELETE CASCADE,
    CONSTRAINT fk_id_servico_equipe FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabela para registro de peças utilizadas
CREATE TABLE Peca (
    id_peca SMALLINT UNSIGNED AUTO_INCREMENT,
    nome_peca VARCHAR(100) NOT NULL,
    descricao TEXT,
    quantidade INT UNSIGNED NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    id_servico SMALLINT UNSIGNED NOT NULL,
    id_veiculo VARCHAR(10) NOT NULL,
    CONSTRAINT pk_id_peca PRIMARY KEY (id_peca), 
    CONSTRAINT fk_id_peca_servico FOREIGN KEY (id_servico) REFERENCES Servico(id_servico) ON DELETE CASCADE,
    CONSTRAINT fk_id_peca_veiculo FOREIGN KEY (id_veiculo) REFERENCES Veiculo(placa) ON DELETE CASCADE
) ENGINE=InnoDB;

SHOW TABLES;

SELECT now() as TIMESTAMP;

DESC Veiculo;
INSERT INTO Veiculo(placa, modelo, marca, ano, cliente_id) VALUES ('MBA 2598','Corsa', 'Chevrolet', 2006, 1),
('MBA 4598','Celta', 'Chevrolet', 2006, 2),('MFU 1234','Captiva', 'Chevrolet', 2008, 3),
('MCA 2554','Meriva', 'Chevrolet', 2006, 4),('MBA 3562','Corsa', 'Chevrolet', 2016, 1);

INSERT INTO Veiculo(placa, modelo, marca, ano, cliente_id) VALUES ('MCH 3658','Strada', 'Fiat', 2006, 6);
SELECT * FROM Veiculo;

DESC Contato;
INSERT INTO Contato (tipo, id_cliente) VALUES ('Email',3);
SELECT * FROM Contato;

DESC Cliente;
INSERT INTO Cliente(nome_cliente,cpf_cliente) VALUES('Helder Rosa Leopoldo', 04573422935);
INSERT INTO Cliente(nome_cliente,cpf_cliente) VALUES('Camila Orácio Leopoldo',1234567891),
('Gabriel Orácio Leopoldo',6544567891),('Paulo Orácio Leopoldo',1234565481),('Jose Orácio Leopoldo',8464567891);

SELECT * FROM Telefone;
DESC Telefone;
INSERT INTO Telefone(numero, contato_id) VALUES('(48)99176-9512',4);

SELECT * FROM Email;
DESC Email;
INSERT INTO Email(email, contato_id) VALUES('carlaleopoldo@gmail.com',2),('camilaleopoldo@gmail.com',3),
('joseleopoldo@gmail.com',4),('gabrielleopoldo@gmail.com',2);

SELECT * FROM Equipe;
DESC Equipe;
INSERT INTO Equipe(nome, descricao) VALUES('Mecânicos','Realizam serviços mecânicos, troca de peças e ajustes.'),
('Eletrônicos','Realizam serviços elétricos, troca de peças e calibração.'),
('Balconistas','Realizam atendimentos de clientes, venda de peças e cobranças.');

SELECT * FROM Balconista;
DESC Balconista;
INSERT INTO Balconista(nome_balconista, especialidade, id_equipe) VALUES('Carla','Atender clientes.',3);

DESC Peca;
SELECT * FROM Peca;
INSERT INTO Peca(nome_peca, descricao, quantidade, preco) VALUES('Correia','Dentada 8M-150',30, 150.00);

SELECT * FROM Cliente;

SELECT TABLE_NAME, CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
WHERE CONSTRAINT_NAME = 'fk_id_equipe';

ALTER TABLE Mecanico DROP FOREIGN KEY fk_id_equipe;
ALTER TABLE Mecanico ADD CONSTRAINT fk_id_equipe_mecanico FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe) ON DELETE SET NULL;

DESC Contato;

SELECT DISTINCT tipo FROM Contato;

SELECT nome_cliente, cpf_cliente 
FROM Cliente;

-- Consulta de clientes cadastrados com emails e telefones e seus veiculos
SELECT c.nome_cliente AS Nome, c.cpf_cliente AS CPF, e.email AS Email, t.numero AS Telefone, 
v.placa AS Placa, v.modelo AS Modelo, v.marca AS Marca, v.ano AS Ano
FROM Cliente c
-- Relaciona Cliente com Contato para e-mails
JOIN Contato ce ON c.id_cliente = ce.id_cliente AND ce.tipo = 'email'
JOIN Email e ON ce.id_contato = e.contato_id
-- Relaciona Cliente com Contato para telefones
JOIN Contato ct ON c.id_cliente = ct.id_cliente AND ct.tipo = 'telefone'
JOIN Telefone t ON ct.id_contato = t.contato_id
-- Relaciona Cliente com Veiculos
JOIN Veiculo v ON c.id_cliente = v.cliente_id
WHERE c.id_cliente = 1;

-- Consulta de clientes e veiculos cadastrados na oficina
SELECT c.nome_cliente AS Nome, c.cpf_cliente AS CPF, 
v.placa AS Placa, v.modelo AS Modelo, v.marca AS Marca, v.ano AS Ano
FROM Cliente c
-- Relaciona Cliente com Veiculos
JOIN Veiculo v ON c.id_cliente = v.cliente_id;
















