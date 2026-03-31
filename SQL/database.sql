-- =========================================
-- 📊 PROJETO: ANÁLISE DE VENDAS
-- Autor: Cleyton Avelino
-- =========================================

CREATE DATABASE sistemaloja;
USE sistemaloja;

-- =========================================
-- 🧱 TABELA: CLIENTE
-- =========================================

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL
);

INSERT INTO cliente (nome, email, telefone) VALUES
('Joao Pedro', 'joaopedro@gmail.com', '21 99987-9890'),
('Camila Pitanga', 'camila@gmail.com', '21 97789-9876'),
('Julio Cesar', 'julio@gmail.com', '21 98749-2232'),
('Miguel Jesus', 'miguel@gmail.com', '21 98786-2145'),
('Cleyton Avelino', 'cleyton@gmail.com', '21 99769-2314');

-- =========================================
-- 🧾 TABELA: PEDIDO
-- =========================================

CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

INSERT INTO pedido (id_cliente) VALUES
(1),(1),(2),(3),(2),(4),(5),(4),(5),(2),(2),(5),(5),(5);

-- =========================================
-- 📦 TABELA: PRODUTO
-- =========================================

CREATE TABLE produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL
);

INSERT INTO produto (nome, preco, estoque) VALUES
('Bicicleta', 50.99, 5),
('Escova', 1.99, 30),
('Cama', 289.90, 13),
('Oculos', 12.99, 40),
('Bolsa', 39.90, 25);

-- =========================================
-- 🛒 TABELA: ITEM_PEDIDO
-- =========================================

CREATE TABLE item_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

INSERT INTO item_pedido (id_pedido, id_produto, quantidade) VALUES
(1,3,2),(2,2,3),(3,5,2),(4,4,2),(5,1,1),
(6,3,3),(7,4,2),(8,2,2),(9,5,5),(10,1,4),
(11,3,4),(12,4,10),(13,5,8),(14,2,7);

-- =========================================
-- 💳 TABELA: PAGAMENTO
-- =========================================

CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT UNIQUE NOT NULL,
    tipo_pagamento VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

INSERT INTO pagamento (id_pedido, tipo_pagamento, status) VALUES
(1,'cartao de credito','pago'),
(2,'dinheiro','pago'),
(3,'cartao de debito','pago'),
(4,'cartao de debito','cancelado'),
(5,'cartao de credito','pago'),
(6,'dinheiro','pago'),
(7,'cartao de debito','pago'),
(8,'dinheiro','pago'),
(9,'dinheiro','pago'),
(10,'cartao de credito','pago'),
(11,'cartao de credito','pago'),
(12,'cartao de credito','pago'),
(13,'cartao de credito','pago'),
(14,'cartao de credito','pago');

-- =========================================
-- 🔒 CONSTRAINT
-- =========================================

ALTER TABLE pagamento
ADD CONSTRAINT chk_status
CHECK (status IN ('pendente', 'pago', 'cancelado'));