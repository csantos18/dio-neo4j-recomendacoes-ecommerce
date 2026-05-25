// Constraints para evitar duplicidade e acelerar buscas por identificador.
CREATE CONSTRAINT cliente_id_unique IF NOT EXISTS
FOR (c:Cliente)
REQUIRE c.clienteId IS UNIQUE;

CREATE CONSTRAINT produto_id_unique IF NOT EXISTS
FOR (p:Produto)
REQUIRE p.produtoId IS UNIQUE;

CREATE CONSTRAINT categoria_id_unique IF NOT EXISTS
FOR (c:Categoria)
REQUIRE c.categoriaId IS UNIQUE;

CREATE CONSTRAINT pedido_id_unique IF NOT EXISTS
FOR (p:Pedido)
REQUIRE p.pedidoId IS UNIQUE;
