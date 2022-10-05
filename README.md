# Projeto Logico de Banco de Dados Ecommerce DIO
Construindo Projeto Lógico de Banco de Dados para o cenário de e-commerce com base no diagrama modelo EER.

## 1. Criando queries SQL:

 _**1.1. Recuperações simples com SELECT Statement**_
 
 A querie abaixo utiliza o SELECT Statement e recupera as informações _idCliente_ e _NomeCliente_ da tabela _Cliente_.
 
      SELECT idCliente, NomeCliente FROM Cliente;
 
 _**1.2. Filtros com WHERE Statement**_
 
 Selecionando informações das tabelas _Produto_ e _Estoque_ com a WHERE Statement. Atributo derivado _Valor_Total_ é o produto de _Preço_ e _Quantidade_ nas tabelas _Produto_ e _No_Estoque_, respectivamente.
 
      SELECT p.ProdDescricao, p.Preco, e.LocalEstoque, ne.Quantidade, (p.Preco * ne.Quantidade) AS Valor_Total
      FROM Produto p, Estoque e, No_Estoque ne
      WHERE p.idProduto=ne.Produto_id AND ne.Estoque_id=e.idEstoque;
      
 ![imagem2](https://user-images.githubusercontent.com/40408615/194132738-5dfe7bc3-6d4e-4003-a794-3b6b14865648.png)

 _**1.3. Expressões com atributos derivados e Funções do MySQL DATEDIFF e DATE_FORMAT**_
 
 Consultando informações da _Entrega_ utilizando as Funções do MySQL DATEDIFF (retorna a diferença entre duas datas) e DATE_FORMAT (formata a data). Por meio do Atributo _Dias_Entrega_ podemos analisar a rapidez ou demora de uma entrega.
 
      SELECT e.idEntrega, DATE_FORMAT(e.Data_Embarque,'%d/%m/%Y') AS Data_Embarque, 
         DATE_FORMAT(e.Data_Entrega,'%d/%m/%Y') AS Data_Entrega,
         DATEDIFF(e.Data_Entrega, e.Data_Embarque) AS Dias_Entrega 
      FROM Entrega e;
 

 _**1.4. Ordenações dos dados com ORDER BY**_
 
 Ordenando os dados por _Data_Embarque_, _Data_Entrega_, _Dias_Entrega_, em ordem decrescente.
 
      SELECT e.idEntrega, DATE_FORMAT(e.Data_Embarque,'%d/%m/%Y') AS Data_Embarque, 
         DATE_FORMAT(e.Data_Entrega,'%d/%m/%Y') AS Data_Entrega, 
         DATEDIFF(e.Data_Entrega, e.Data_Embarque) AS Dias_Entrega 
      FROM Entrega e
      ORDER BY Data_Embarque, Data_Entrega, Dias_Entrega DESC;
      
![imagem1](https://user-images.githubusercontent.com/40408615/194132221-39ea133a-87a7-4525-96f2-f6a1062f2426.png)
 
 _**1.5. Agrupamentos com GROUP BY e Condições de filtros aos grupos – HAVING Statement**_
 
      SELECT pag.PagTipo AS Forma_Pagamento, COUNT(pag.idPagamento) AS Pedidos 
      FROM (Pedido p JOIN Pagamento pag ON pag.idPagamento=p.Pagamento_id) 
      GROUP BY Forma_Pagamento 
      HAVING COUNT(Forma_Pagamento)>=1;
 
 ![imagem7](https://user-images.githubusercontent.com/40408615/194135019-77c9327d-6a59-4dc4-8ef3-7647fc0b35cd.png)
 
 _**1.6. Junções entre tabelas para fornecer uma perspectiva mais complexa dos dados**_
 
 Join entre as tabelas _Entrega_, _Entrega_Pedidos_, _Pedido_, _Lista_Produtos_, _Produto_ e _Cliente_
 
      SELECT e.idEntrega, DATE_FORMAT(e.Data_Embarque,'%d/%m/%Y') AS Data_Embarque, 
         DATE_FORMAT(e.Data_Entrega,'%d/%m/%Y') AS Data_Entrega, 
         DATEDIFF(e.Data_Entrega, e.Data_Embarque) AS Dias_Entrega, 
         CONCAT(c.NomeCliente, " ", c.SobrenomeCliente) AS Cliente, prod.ProdDescricao, prod.Preco 
      FROM Entrega e 
      JOIN Entrega_Pedidos ep 
         ON ep.Entrega_id=e.idEntrega 
      JOIN Pedido p 
         ON p.idPedido=ep.Pedido_id 
      JOIN Lista_Produtos lp 
         ON lp.Pedido_id=p.idPedido 
      JOIN Produto prod 
         ON prod.idProduto=lp.Produto_id
      JOIN Cliente c 
         ON c.idCliente = p.Cliente_id
      ORDER BY Dias_Entrega, Data_Embarque, Data_Entrega, Preco;

![imagem3](https://user-images.githubusercontent.com/40408615/194133391-af6bda0d-0740-4076-bd42-9c58d2ed4acd.png)

## 2. Queries SQL mais elaboradas:

_**2.1. Quantos pedidos foram feitos por cada cliente?**_

      SELECT CONCAT(c.NomeCliente, " ", c.SobrenomeCliente) AS Cliente, 
         COUNT(p.Cliente_id) AS Pedidos 
      FROM Cliente c, Pedido p 
      WHERE c.idCliente=p.Cliente_id 
      GROUP BY Cliente
      ORDER BY Pedidos DESC;

![imagem4](https://user-images.githubusercontent.com/40408615/194133989-66afedf3-ffb4-4d03-a062-052a1415724c.png)

_**2.2. Algum vendedor também é fornecedor?**_

Esta query, para essa base de dados, retorna vazio, pois não há ocorrências para o INNER JOIN (interceção das tabelas _Vendedor_ e _Fornecedor_).

      SELECT * FROM Vendedor v JOIN Fornecedor f ON v.RazaoSocial=f.RazaoSocial;

_**2.3. Relação de produtos, fornecedores e estoques.**_

A query abaixo apresenta informações de produtos em estoque e seus fornecedores. É resultado do JOIN entre as entidades _Estoque_, _Produto_ e _Fornecedor_ e os relacionamentos _No_Estoque_ e _Fornece_Produtos_.

      SELECT p.idProduto, p.ProdDescricao, e.LocalEstoque, f.RazaoSocial AS Fornecedor, ne.Quantidade
      FROM Estoque e 
      JOIN No_Estoque ne 
         ON ne.Estoque_id=e.idEstoque 
      JOIN Produto p 
         ON p.idProduto=ne.Produto_id
      JOIN Fornece_Produtos fp 
         ON fp.Produto_id=p.idProduto 
      JOIN Fornecedor f 
         ON f.idFornecedor=fp.Fornecedor_id 
      ORDER BY p.ProdDescricao;

![imagem5](https://user-images.githubusercontent.com/40408615/194134326-dad318bf-a9b9-448e-ad28-6b16656d37a5.png)

_**2.4. Relação de nomes dos fornecedores e nomes dos produtos.**_

      SELECT f.idFornecedor,f.RazaoSocial AS Fornecedor, p.ProdDescricao AS Produto 
      FROM Fornece_Produtos fp 
      JOIN Produto p 
         ON fp.Produto_id=p.idProduto 
      JOIN Fornecedor f 
         ON f.idFornecedor=fp.Fornecedor_id 
      ORDER BY p.ProdDescricao;

![imagem6](https://user-images.githubusercontent.com/40408615/194134550-3328ce33-30a7-4c04-b8ab-6116a4faa125.png)

