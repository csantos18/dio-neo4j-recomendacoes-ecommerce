# Evidencias Visuais

Esta pasta foi reservada para os prints do Neo4j Browser, Bloom ou Explore.

## Prints recomendados

1. `01-schema.png`
   - Rode: `CALL db.schema.visualization();`
   - Mostra labels e relacionamentos do projeto.

2. `02-cliente-pedidos-produtos.png`
   - Rode a consulta 7 do arquivo `cypher/02_business_queries.cypher`.
   - Mostra o caminho entre cliente, pedido, produto e categoria.

3. `03-recomendacoes-cliente.png`
   - Rode a consulta 1.
   - Mostra os produtos recomendados para o cliente `C001`.

4. `04-produtos-comprados-juntos.png`
   - Rode a consulta 2.
   - Mostra combinacoes de produtos presentes nos mesmos pedidos.

5. `05-ranking-avaliacoes.png`
   - Rode a consulta 5.
   - Mostra os produtos mais bem avaliados.

## Dica para o README principal

Depois de adicionar os prints, voce pode complementar o `README.md` com imagens assim:

```markdown
![Recomendacoes para cliente](docs/evidencias/03-recomendacoes-cliente.png)
```
