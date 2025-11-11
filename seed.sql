CREATE DATABASE pizzaria;
\c pizzaria

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100), 
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    tipo VARCHAR(20) DEFAULT 'comum'
);

CREATE TABLE pizzas (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT DEFAULT 0
);

CREATE TABLE vendas (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id),
    pizza_id INT REFERENCES pizzas(id),
    quantidade INT NOT NULL,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO usuarios (nome, email, senha, tipo) VALUES
('Courtney', 'invisigal@pizzaria.com', 'invisigalpassword', 'admin'),
('Robert', 'mechaman@pizzaria.com', 'mechamanpassword', 'comum');

INSERT INTO pizzas (nome, preco, estoque) VALUES
('Brócolis com Requeijão', 25.00, 50),
('Lombo com Catupiry', 30.00, 40),
('Frango com Catupiry', 28.00, 60);

INSERT INTO vendas (usuario_id, pizza_id, quantidade) VALUES
(1, 2, 1),
(2, 1, 2),
(2, 3, 1);

UPDATE pizzas
SET estoque = estoque - (
    SELECT COALESCE(SUM(quantidade), 0) 
    FROM vendas 
    WHERE vendas.pizza_id = pizzas.id
);

SELECT * FROM usuarios;
SELECT * FROM pizzas;
SELECT * FROM vendas;