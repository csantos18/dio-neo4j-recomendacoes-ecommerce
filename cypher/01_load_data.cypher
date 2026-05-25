// Limpeza opcional para ambientes de estudo.
// MATCH (n) DETACH DELETE n;

// Carga de clientes.
LOAD CSV WITH HEADERS FROM 'file:///clientes.csv' AS row
MERGE (c:Cliente {clienteId: row.clienteId})
SET c.nome = row.nome,
    c.cidade = row.cidade,
    c.estado = row.estado,
    c.segmento = row.segmento;

// Carga de categorias.
LOAD CSV WITH HEADERS FROM 'file:///categorias.csv' AS row
MERGE (cat:Categoria {categoriaId: row.categoriaId})
SET cat.nome = row.nome,
    cat.departamento = row.departamento;

// Carga de produtos e relacionamento com categoria.
LOAD CSV WITH HEADERS FROM 'file:///produtos.csv' AS row
MATCH (cat:Categoria {categoriaId: row.categoriaId})
MERGE (p:Produto {produtoId: row.produtoId})
SET p.nome = row.nome,
    p.marca = row.marca,
    p.preco = toFloat(row.preco)
MERGE (p)-[:PERTENCE_A]->(cat);

// Carga de pedidos e relacionamento com cliente.
LOAD CSV WITH HEADERS FROM 'file:///pedidos.csv' AS row
MATCH (c:Cliente {clienteId: row.clienteId})
MERGE (o:Pedido {pedidoId: row.pedidoId})
SET o.data = date(row.data),
    o.canal = row.canal,
    o.status = row.status
MERGE (c)-[:REALIZOU]->(o);

// Carga de itens comprados.
LOAD CSV WITH HEADERS FROM 'file:///itens_pedido.csv' AS row
MATCH (o:Pedido {pedidoId: row.pedidoId})
MATCH (p:Produto {produtoId: row.produtoId})
MERGE (o)-[r:CONTEM]->(p)
SET r.quantidade = toInteger(row.quantidade),
    r.precoUnitario = toFloat(row.precoUnitario),
    r.valorTotal = toInteger(row.quantidade) * toFloat(row.precoUnitario);

// Carga de avaliacoes feitas por clientes.
LOAD CSV WITH HEADERS FROM 'file:///avaliacoes.csv' AS row
MATCH (c:Cliente {clienteId: row.clienteId})
MATCH (p:Produto {produtoId: row.produtoId})
MERGE (c)-[r:AVALIOU]->(p)
SET r.nota = toInteger(row.nota),
    r.comentario = row.comentario,
    r.data = date(row.data);

// Carga de similaridades entre produtos.
LOAD CSV WITH HEADERS FROM 'file:///similaridades.csv' AS row
MATCH (origem:Produto {produtoId: row.produtoOrigemId})
MATCH (destino:Produto {produtoId: row.produtoDestinoId})
MERGE (origem)-[r:SIMILAR_A]->(destino)
SET r.peso = toFloat(row.peso),
    r.motivo = row.motivo;
