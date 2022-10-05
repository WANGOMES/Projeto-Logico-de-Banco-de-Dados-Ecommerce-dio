-- QUERIES

use ecommerce;
show tables;

desc Entrega_Pedidos;
select * from Cliente;


insert into Cliente values(1, "Wellington", "Pacheco", "Rua", "Primeira", 124, "Guaranis", "A", "Jequitinhonha", "MG", "CPF", "23456789114"),
							(2, "Wellington", "Gomes", "Rua", "Primeira", 124, "Novo Ribeirão das Neves", "A", "Ribeirão das Neves", "MG", "CPF", "23456789101"),
						  (3, "Washington", "Modesto", "Rua", "Nova", 124, "Novo Ribeirão das Neves", "A", "Vespasiano", "MG", "CPF", "14567891012"),
                          (4, "Carlos", "Prates", "Rua", "Nova", 124, "Novo Ribeirão das Neves", "A", "Belo Horizonte", "MG", "CPF", "23456789107"),
                          (5, "Juliana", "Mascarenhas", "Rua", "Nova", 124, "Novo Ribeirão das Neves", "A", "Corinto", "MG", "CPF", "12345678915"),
                          (6, "Edvaldo", "Leal", "Rua", "Nova", 124, "Novo Ribeirão das Neves", "A", "Contagem", "MG", "CPF", "12345578910"),
                          (7, "Amarildo", "Nunes", "Rua", "Nova", 124, "Novo Ribeirão das Neves", "A", "Guaratingueta", "SP", "CPF", "13345678910");
                          
insert into Fornecedor values (1, "Magalhães Indústria Com Ltda", "Rua", "Primeira", 14224, "Colina", "A", "Pindamonhangaba", "RJ", "13578496000178"),
							  (2, "São Patrick Moda Praia Eireli", "Ave", "Monte Leal", 1055, "Bairro Nova", "Galpão 7", "Santo Antonio do Monte", "MG", "12998496000144");
                              
insert into Vendedor values (1, "Comercio Novo Ltda", "Rua", "Da Base", 14224, "Colina", "A", "Rio de Janeiro", "RJ", "13578496000178"),
							  (2, "Inventa Moda Eireli", "Ala", "Orquídeas", 1055, "Bairro Floral", "B", "Contagem", "MG", "12998496000144");
insert into Vendedor values (3, "Santo Inacio Com.", "Rua", "das Indústrias", 15, "Morada Velha", "C", "Diamente", "MG", "12998333000144");
                              
insert into Produto values (1, "Colchão de Molas", "Eletrodomésticos", "1255.99"),
							(2, "NoteBook Dell 4MD45O5S", null , "4899.50"),
							(3, "Chiclete Que Bola", null, "0.99"),
							(4, "Caninha 51", "Bebidas", "29.99"),
							(5, "Furadeira Bosh 4000W", "Ferramentas", "985.98");
                            
insert into Vende_Produtos values (1, 1),(1, 2),(1, 3),(1, 4),(1,5),(2, 1),(2, 2),(2,3),(2,4),(2,5);

insert into Vende_Produtos values(3, 4),(3,5);
			



insert into Estoque values (1, "CD Nova Contagem-MG"), (2, "CD Praça João Boulevard-MG"),(3, "CD Campo Largo-PA");

insert into No_Estoque values (1, 3, 1200), (2, 2, 15000), (2, 3, 5000), (3, 1, 120000),(4, 3, 4000), (5, 3, 800);

insert into Pagamento values (1, "Crédito", 3), (2, "Crédito", 5), (3, "Crédito", 7),(4, "Débito", 3),(5, "Pix", 3), (6, "Crédito", 5);

insert into Entrega values (1, "Variante Transportes", "31778984000125", "2022-01-25", "2022-02-04", 174588),
			(2, "Trans Transportes", "31778977000125", null, null, 174558),
			(3, "TransPass", "31778900000125", "2021-12-24", "2021-12-30", 451358),
			(4, "Log Transportes", "34478984000125", "2022-01-25", "2022-02-10", 999868),
			(5, "Mundial Transportes", "55678984000125", "2021-12-24", "2022-01-10", 001358),
			(6, "Panorama Logistica", "31778984000225", "2022-01-25", "2022-02-04", 3358);

insert into Pedido values (1, "Pedido NoteBook Dell 4MD45O5S", "Processando", 1, 25.90, 3, 3, 1),
							(2, "Pedido Chiclete Que Bola", "Processando", 1, 25.90, 5, 5, 2),
							(3, "Pedido Colchão de Molas", "A Caminho", 1, 25.90, 7, 7, 3),
							(4, "Pedido NoteBook Dell 4MD45O5S", "Entregue", 1, 25.90, 3, 3, 4),
							(5, "Pedido Caninha 51", "A Caminho", 1, 25.90, 5, 5, 6),
							(6, "Pedido Furadeira Bosh 4000W", "A Caminho", 1, 25.90, 3, 3, 5),
							(7, "Pedido NoteBook Dell 4MD45O5S", "Cancelado", 1, 25.90, 3, 3, 5);

UPDATE Pedido set Frete=0 where idPedido=1 or idPedido=4 or idPedido=7;
UPDATE Pedido set ValorFrete=0.0 where Frete=0;
UPDATE Pedido set ValorFrete=32.95 where idPedido=5;
UPDATE Pedido set ValorFrete=12.85 where idPedido=6;

insert into Lista_Produtos values (2, 1, 3), (2, 4, 3), (5, 6, 3), (2, 7, 3), (3, 2, 5), (4, 5, 5), (1, 3, 7);
insert into Entrega_Pedidos values (1, 1, 3, 3, 1),  (2, 2, 5, 5, 2), (3, 3, 7, 7, 3), (4, 4, 3, 3, 4), (6, 5, 5, 5, 5), (5, 6, 3, 3, 6);
insert into Fornece_Produtos values (1, 1), (1, 2), (1, 3), (2, 4), (1, 5);

-- Utilizando Funçoes do MySQL atributo derivado Dias_Entrega
SELECT e.idEntrega, DATE_FORMAT(e.Data_Embarque,'%d/%m/%Y') AS Data_Embarque, 
	DATE_FORMAT(e.Data_Entrega,'%d/%m/%Y') AS Data_Entrega, 
    DATEDIFF(e.Data_Entrega, e.Data_Embarque) AS Dias_Entrega 
    FROM Entrega e;

-- ORDER BY
SELECT e.idEntrega, DATE_FORMAT(e.Data_Embarque,'%d/%m/%Y') AS Data_Embarque, 
	DATE_FORMAT(e.Data_Entrega,'%d/%m/%Y') AS Data_Entrega, 
    DATEDIFF(e.Data_Entrega, e.Data_Embarque) AS Dias_Entrega 
    FROM Entrega e
    ORDER BY Data_Embarque, Data_Entrega, Dias_Entrega DESC;


-- JOIN encadeados.
SELECT e.idEntrega, DATE_FORMAT(e.Data_Embarque,'%d/%m/%Y') AS Data_Embarque, 
	DATE_FORMAT(e.Data_Entrega,'%d/%m/%Y') AS Data_Entrega, 
    DATEDIFF(e.Data_Entrega, e.Data_Embarque) AS Dias_Entrega, 
    CONCAT(c.NomeCliente, " ", c.SobrenomeCliente) AS Cliente, prod.ProdDescricao, prod.Preco 
	FROM Entrega e JOIN Entrega_Pedidos ep 
		ON ep.Entrega_id=e.idEntrega 
    JOIN Pedido p 
		ON p.idPedido=ep.Pedido_id 
    JOIN Lista_Produtos lp 
		ON lp.Pedido_id=p.idPedido 
    JOIN Produto prod 
		ON prod.idProduto=lp.Produto_id
	JOIN Cliente c 
		ON c.idCliente = p.Cliente_id;

-- ORDER BY
SELECT e.idEntrega, DATE_FORMAT(e.Data_Embarque,'%d/%m/%Y') AS Data_Embarque, 
	DATE_FORMAT(e.Data_Entrega,'%d/%m/%Y') AS Data_Entrega, 
    DATEDIFF(e.Data_Entrega, e.Data_Embarque) AS Dias_Entrega, 
    CONCAT(c.NomeCliente, " ", c.SobrenomeCliente) AS Cliente, prod.ProdDescricao, prod.Preco 
	FROM Entrega e JOIN Entrega_Pedidos ep 
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

-- WHERE
SELECT p.ProdDescricao, p.Preco, e.LocalEstoque, ne.Quantidade, (p.Preco * ne.Quantidade) AS Valor_Total 
	FROM Produto p, Estoque e, No_Estoque ne 
	WHERE p.idProduto=ne.Produto_id AND ne.Estoque_id=e.idEstoque;

-- GROUP BY -- PEDIDOS POR CLIENTE
SELECT CONCAT(c.NomeCliente, " ", c.SobrenomeCliente) AS Cliente, COUNT(p.Cliente_id) AS Pedidos 
FROM Cliente c, Pedido p 
WHERE c.idCliente=p.Cliente_id 
GROUP BY Cliente 
ORDER BY Pedidos DESC;

SELECT * FROM Vendedor v JOIN Fornecedor f ON v.RazaoSocial=f.RazaoSocial;

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

SELECT f.idFornecedor,f.RazaoSocial AS Fornecedor, p.ProdDescricao AS Produto 
FROM Fornece_Produtos fp 
JOIN Produto p 
	ON fp.Produto_id=p.idProduto 
JOIN Fornecedor f 
	ON f.idFornecedor=fp.Fornecedor_id 
ORDER BY p.ProdDescricao;

-- GROUP BY HAVING
SELECT pag.PagTipo AS Forma_Pagamento, COUNT(pag.idPagamento) AS Pedidos 
FROM (Pedido p JOIN Pagamento pag ON pag.idPagamento=p.Pagamento_id) 
GROUP BY Forma_Pagamento 
HAVING COUNT(Forma_Pagamento)>=1;