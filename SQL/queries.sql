-- =========================================
-- 📊 PROJETO: ANÁLISE DE VENDAS
-- Autor: Cleyton Avelino
-- =========================================


-- =========================================
-- 🔎 1. CONSULTA POR QUANTIDADE COM FILTROS
-- Objetivo: Filtrar pedidos por intervalo e quantidade de itens
-- =========================================

SELECT
    c.nome AS cliente,
    p.id_pedido,
    i.quantidade
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente
JOIN item_pedido i ON i.id_pedido = p.id_pedido
WHERE p.id_pedido BETWEEN 1 AND 10
  AND i.quantidade BETWEEN 2 AND 5
ORDER BY i.quantidade DESC;


-- =========================================
-- 📊 2. TICKET MÉDIO POR CLIENTE (COM FILTRO)
-- Objetivo: Calcular ticket médio e filtrar clientes acima de R$200
-- =========================================

SELECT
    c.nome AS cliente,
    SUM(i.quantidade * pr.preco) AS total_gasto,
    COUNT(DISTINCT p.id_pedido) AS total_pedidos,
    ROUND(
        SUM(i.quantidade * pr.preco) / COUNT(DISTINCT p.id_pedido),
        2
    ) AS ticket_medio
FROM pedido p
JOIN cliente c ON p.id_cliente = c.id_cliente
JOIN item_pedido i ON i.id_pedido = p.id_pedido
JOIN produto pr ON pr.id_produto = i.id_produto
GROUP BY c.nome
HAVING ticket_medio > 200
ORDER BY ticket_medio DESC;


-- =========================================
-- 📈 3. RESUMO DE VENDAS POR CLIENTE
-- Objetivo: Calcular total de pedidos, total gasto e ticket médio
-- =========================================

SELECT
    sub.nome AS cliente,
    COUNT(sub.id_pedido) AS total_pedidos,
    SUM(sub.total_pedido) AS total_gasto,
    ROUND(AVG(sub.total_pedido), 2) AS ticket_medio
FROM (
    SELECT
        p.id_pedido,
        c.nome,
        SUM(i.quantidade * pr.preco) AS total_pedido
    FROM pedido p
    JOIN cliente c ON p.id_cliente = c.id_cliente
    JOIN item_pedido i ON i.id_pedido = p.id_pedido
    JOIN produto pr ON pr.id_produto = i.id_produto
    GROUP BY p.id_pedido, c.nome
) AS sub
GROUP BY sub.nome
ORDER BY total_gasto DESC;

-- =========================================
-- 📊 4. CLIENTES COM MAIS DE 2 PEDIDOS
-- Objetivo: Identificar clientes recorrentes
-- =========================================

SELECT
    c.nome AS cliente,
    COUNT(p.id_pedido) AS total_pedidos
FROM pedido p
JOIN cliente c ON c.id_cliente = p.id_cliente
GROUP BY c.nome
HAVING total_pedidos > 2
ORDER BY total_pedidos DESC;

-- =========================================
-- 📊 5. Faturamento total
-- Objetivo: Identificar o faturamento total dos produtos
-- =========================================


SELECT
    SUM(i.quantidade * pr.preco) AS faturamento_total
FROM item_pedido i
JOIN produto pr ON pr.id_produto = i.id_produto;