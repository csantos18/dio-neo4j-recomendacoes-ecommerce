// 1. Recomendacao para um cliente com base em produtos comprados por clientes com comportamento parecido.
// Exemplo: produtos comprados por outros clientes que tambem compraram itens ja comprados por Ana.
MATCH (alvo:Cliente {clienteId: 'C001'})-[:REALIZOU]->(:Pedido)-[:CONTEM]->(produtoComprado:Produto)
MATCH (outro:Cliente)-[:REALIZOU]->(:Pedido)-[:CONTEM]->(produtoComprado)
WHERE outro <> alvo
MATCH (outro)-[:REALIZOU]->(:Pedido)-[:CONTEM]->(recomendado:Produto)
WHERE NOT EXISTS {
  MATCH (alvo)-[:REALIZOU]->(:Pedido)-[:CONTEM]->(recomendado)
}
RETURN recomendado.nome AS produtoRecomendado,
       count(DISTINCT outro) AS clientesEmComum
ORDER BY clientesEmComum DESC, produtoRecomendado;

// 2. Produtos frequentemente comprados juntos.
MATCH (pedido:Pedido)-[:CONTEM]->(p1:Produto)
MATCH (pedido)-[:CONTEM]->(p2:Produto)
WHERE p1.produtoId < p2.produtoId
WITH p1, p2, count(*) AS vezesJuntos
WHERE vezesJuntos > 0
RETURN p1.nome AS produtoA,
       p2.nome AS produtoB,
       vezesJuntos
ORDER BY vezesJuntos DESC, produtoA, produtoB;

// 3. Categorias com maior valor de vendas.
MATCH (:Pedido)-[item:CONTEM]->(p:Produto)-[:PERTENCE_A]->(cat:Categoria)
RETURN cat.nome AS categoria,
       round(sum(item.valorTotal), 2) AS receitaTotal,
       sum(item.quantidade) AS unidadesVendidas
ORDER BY receitaTotal DESC;

// 4. Clientes com perfil de compra parecido.
MATCH (c1:Cliente)-[:REALIZOU]->(:Pedido)-[:CONTEM]->(p:Produto)<-[:CONTEM]-(:Pedido)<-[:REALIZOU]-(c2:Cliente)
WHERE c1.clienteId < c2.clienteId
RETURN c1.nome AS clienteA,
       c2.nome AS clienteB,
       count(DISTINCT p) AS produtosEmComum,
       collect(DISTINCT p.nome) AS itensCompartilhados
ORDER BY produtosEmComum DESC;

// 5. Produtos com melhor avaliacao media.
MATCH (:Cliente)-[a:AVALIOU]->(p:Produto)
RETURN p.nome AS produto,
       round(avg(a.nota), 2) AS mediaAvaliacao,
       count(a) AS totalAvaliacoes
ORDER BY mediaAvaliacao DESC, totalAvaliacoes DESC;

// 6. Produtos substitutos ou complementares por similaridade.
MATCH (:Produto {produtoId: 'P001'})-[s:SIMILAR_A]-(similar:Produto)
RETURN similar.nome AS produtoSimilar,
       s.peso AS pesoSimilaridade,
       s.motivo AS motivo
ORDER BY pesoSimilaridade DESC;

// 7. Visualizacao de caminho cliente -> pedido -> produto -> categoria.
MATCH path=(c:Cliente {clienteId: 'C001'})-[:REALIZOU]->(:Pedido)-[:CONTEM]->(:Produto)-[:PERTENCE_A]->(:Categoria)
RETURN path;

// 8. Visualizacao geral do schema.
CALL db.schema.visualization();
