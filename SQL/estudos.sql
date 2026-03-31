-- =========================================
-- 📚 ESTUDOS SQL - EVOLUÇÃO
-- Autor Cleyton Avelino
-- =========================================


-- =========================================
-- 🔰 NÍVEL 1 - CONSULTAS BÁSICAS
-- =========================================

-- Selecionar todos os clientes
SELECT  FROM cliente;

-- Selecionar nome e email
SELECT nome, email FROM cliente;

-- Filtrar preço maior que 50
SELECT preco FROM produto
WHERE preco  50;


-- =========================================
-- 🔰 NÍVEL 2 - FILTROS E ORDENAÇÃO
-- =========================================

-- Produtos entre valores
SELECT nome, preco FROM produto
WHERE preco BETWEEN 30 AND 200
ORDER BY preco ASC;

-- Top 3 produtos mais baratos
SELECT nome, preco FROM produto
ORDER BY preco ASC
LIMIT 3;

-- Ordenação por data
SELECT id_pedido, data_pedido FROM pedido
ORDER BY data_pedido DESC;


-- =========================================
-- 🔰 NÍVEL 3 - JOIN
-- =========================================

-- Pedidos com cliente
SELECT 
    c.nome,
    p.id_pedido
FROM pedido p
JOIN cliente c ON c.id_cliente = p.id_cliente;


-- =========================================
-- 🔰 NÍVEL 4 - FILTROS AVANÇADOS
-- =========================================

SELECT 
    c.nome,
    p.id_pedido
FROM pedido p
JOIN cliente c ON c.id_cliente = p.id_cliente
WHERE c.nome LIKE 'A%' OR c.nome LIKE 'M%';


-- =========================================
-- 🔰 NÍVEL 5 - AGRUPAMENTO
-- =========================================

-- Total de itens por pedido
SELECT
    p.id_pedido,
    SUM(i.quantidade) AS total_itens
FROM pedido p
JOIN item_pedido i ON p.id_pedido = i.id_pedido
GROUP BY p.id_pedido;


-- =========================================
-- 🔰 NÍVEL 6 - HAVING
-- =========================================

SELECT
    c.nome,
    COUNT(p.id_pedido) AS total_pedidos
FROM pedido p
JOIN cliente c ON c.id_cliente = p.id_cliente
GROUP BY c.nome
HAVING total_pedidos  2;


-- =========================================
-- 🔰 NÍVEL 7 - ANÁLISE DE VENDAS
-- =========================================

SELECT 
    c.nome,
    SUM(i.quantidade  pr.preco) AS total_gasto
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente
JOIN item_pedido i ON i.id_pedido = p.id_pedido
JOIN produto pr ON pr.id_produto = i.id_produto
GROUP BY c.nome;


-- =========================================
-- 🔰 NÍVEL 8 - SUBQUERY
-- =========================================

SELECT
    sub.nome,
    ROUND(AVG(sub.total_pedido), 2) AS ticket_medio
FROM (
    SELECT
        p.id_pedido,
        c.nome,
        SUM(i.quantidade  pr.preco) AS total_pedido
    FROM pedido p
    JOIN cliente c ON p.id_cliente = c.id_cliente
    JOIN item_pedido i ON i.id_pedido = p.id_pedido
    JOIN produto pr ON pr.id_produto = i.id_produto
    GROUP BY p.id_pedido, c.nome
) AS sub
GROUP BY sub.nome;