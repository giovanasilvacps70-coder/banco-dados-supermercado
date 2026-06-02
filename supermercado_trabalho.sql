DROP DATABASE IF EXISTS supermercado;
CREATE DATABASE supermercado;
USE supermercado;
-- =========================
-- CLIENTE
-- =========================
CREATE TABLE tb_cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    data_nascimento DATE,
    endereco VARCHAR(150),
    cep VARCHAR(10)
);

-- =========================
-- COLABORADOR
-- =========================
CREATE TABLE tb_colaborador (
    id_colaborador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    cargo VARCHAR(50),
    data_admissao DATE
);

-- =========================
-- PRODUTO
-- =========================
CREATE TABLE tb_produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(50),
    estoque INT NOT NULL
);

-- =========================
-- VENDA
-- =========================
CREATE TABLE tb_venda (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATETIME NOT NULL,
    valor_total DECIMAL(10,2),
    id_cliente INT NOT NULL,
    id_colaborador INT NOT NULL,

    FOREIGN KEY (id_cliente) 
        REFERENCES tb_cliente(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (id_colaborador) 
        REFERENCES tb_colaborador(id_colaborador)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =========================
-- ITEM_VENDA (ASSOCIATIVA)
-- =========================
CREATE TABLE tb_item_venda (
    id_venda INT,
    id_produto INT,
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (id_venda, id_produto),

    FOREIGN KEY (id_venda) 
        REFERENCES tb_venda(id_venda)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (id_produto) 
        REFERENCES tb_produto(id_produto)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =========================
-- INSERT CLIENTES
-- =========================
INSERT INTO tb_cliente (nome, cpf, telefone, email, data_nascimento, endereco, cep) VALUES
('Lucas Martins', '111.111.111-01', '11970000001', 'lucas@email.com', '1992-03-15', 'Rua A, 100', '01000-000'),
('Fernanda Alves', '111.111.111-02', '11970000002', 'fernanda@email.com', '1988-11-22', 'Rua B, 200', '02000-000'),
('Rafael Gomes', '111.111.111-03', '11970000003', 'rafael@email.com', '2000-07-10', 'Rua C, 300', '03000-000'),
('Camila Rocha', '111.111.111-04', '11970000004', 'camila@email.com', '1995-01-05', 'Rua D, 400', '04000-000'),
('Bruno Lima', '111.111.111-05', '11970000005', 'bruno@email.com', '1985-09-18', 'Rua E, 500', '05000-000');

-- =========================
-- INSERT COLABORADORES
-- =========================
INSERT INTO tb_colaborador (nome, cpf, cargo, data_admissao) VALUES
('Ana Costa', '222.222.222-01', 'Caixa', '2022-01-10'),
('Carlos Lima', '222.222.222-02', 'Caixa', '2023-03-15'),
('Bruna Rocha', '222.222.222-03', 'Repositor', '2021-06-01'),
('Diego Pereira', '222.222.222-04', 'Gerente', '2020-02-10');

-- =========================
-- INSERT PRODUTOS
-- =========================
INSERT INTO tb_produto (nome, preco, categoria, estoque) VALUES
('Arroz 5kg', 25.90, 'Alimentos', 100),
('Feijão 1kg', 8.50, 'Alimentos', 150),
('Leite 1L', 4.80, 'Alimentos', 200),
('Macarrão 500g', 4.50, 'Alimentos', 180),
('Óleo de Soja 900ml', 6.99, 'Alimentos', 120),
('Café 500g', 12.90, 'Alimentos', 90),
('Açúcar 1kg', 3.90, 'Alimentos', 140),
('Detergente', 2.50, 'Limpeza', 300),
('Sabão em pó 1kg', 9.80, 'Limpeza', 80),
('Shampoo 350ml', 11.50, 'Higiene', 60);

-- =========================
-- INSERT VENDAS
-- =========================
INSERT INTO tb_venda (data_venda, valor_total, id_cliente, id_colaborador) VALUES
('2026-04-29 14:30:00', 59.80, 1, 1),
('2026-04-30 10:15:00', 35.00, 2, 2),
('2026-04-30 18:45:00', 42.30, 3, 1),
('2026-05-01 09:20:00', 27.90, 4, 2),
('2026-05-01 20:10:00', 65.00, 5, 1);

-- =========================
-- INSERT ITENS
-- =========================
INSERT INTO tb_item_venda VALUES
(1, 1, 1, 25.90),
(1, 2, 2, 8.50),
(1, 3, 3, 4.80),

(2, 4, 2, 4.50),
(2, 5, 1, 6.99),
(2, 6, 1, 12.90),

(3, 7, 2, 3.90),
(3, 8, 3, 2.50),
(3, 9, 1, 9.80),

(4, 1, 1, 25.90),
(4, 8, 1, 2.50),

(5, 3, 5, 4.80),
(5, 6, 2, 12.90),
(5, 10, 1, 11.50);

-- =========================
-- CONSULTA FINAL
-- =========================
SELECT 
    v.id_venda,
    v.data_venda,
    c.nome AS cliente,
    p.nome AS produto,
    iv.quantidade,
    iv.valor_unitario,
    (iv.quantidade * iv.valor_unitario) AS subtotal
FROM tb_venda v
JOIN tb_cliente c ON v.id_cliente = c.id_cliente
JOIN tb_item_venda iv ON v.id_venda = iv.id_venda
JOIN tb_produto p ON iv.id_produto = p.id_produto;