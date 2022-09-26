create database ecommerce;

use ecommerce;

create table Cliente(
	idCliente int not null auto_increment primary key,
    NomeCliente varchar(30) not null,
    SobrenomeCliente varchar(30) not null,
    End_Tipo_Logradouro varchar(3),
    End_Nome_Logradouro varchar(30),
    End_Numero int,
    End_Bairro varchar(30),
    End_Complemento varchar(10),
    End_Cidade varchar(30),
    End_UF char(2),
    Idenficicacao_tipo enum("CPF", "CNPJ") not null,
    Numero_identificacao varchar(14) not null,
    constraint uniq_ident_cliente unique (Numero_identificacao)
);

create table Produto(
	idProduto int not null auto_increment primary key,
    ProdDescricao varchar(45),
    ProdCategoria ENUM("Eletrodomésticos", "Ferramentas", "Brinquedos", "Bebidas"),
    Preco decimal(2) not null
);

create table Pedido(
	idPedido int not null auto_increment primary key,
    PDescricao varchar(45),
    PStatus ENUM("Processando", "Entregue", "A Caminho", "Cancelado"),
    Frete boolean,
    ValorFrete decimal(2),
    Cliente_id int,
    Pagamento_Cliente_id int,
    Pagamento_id int,
    constraint fk_id_Cliente_Pedido foreign key(Cliente_id) references Cliente(idCliente),
    constraint fk_PagCliente_id_Pedido foreign key(Pagamento_Cliente_id) references Pagamento(Cliente_id) 
    on update cascade,
    constraint fk_Pagamento_id foreign key (Pagamento_id) references Pagamento(idPagamento)
);

create table Pagamento(
	idPagamento int not null auto_increment primary key,
    PagTipo ENUM("Débito", "Crédito", "Boleto", "Pix"),
    Cliente_id int,
    constraint fk_idCliente foreign key(Cliente_id) references Cliente(idCliente)
);

-- Relacionamento entre Produto e Pedido
create table Lista_Produtos(
	Produto_id int,
    Pedido_id int,
    Pedido_Cliente_id int,
    constraint fk_id_Cliente_Pedido_Lis_Prod foreign key(Pedido_Cliente_id) references Pedido(Cliente_id),
    constraint fk_id_pedido_Lis_Prod foreign key (Pedido_id) references Pedido(idPedido),
    constraint fk_id_produto_Lis_Prod foreign key (Produto_id) references Produto(idProduto)
);

create table Entrega(
	idEntrega int not null auto_increment primary key,
    Transport_Nome varchar(45) not null,
    CNPJ_Transport varchar(14) not null, 
    Data_Embarque datetime,
    Data_Entrega datetime,
    Codigo_Rastreio int not null
);

-- Relacionamento entre Entrega e Pedido
create table Entrega_Pedidos(
	Pedido_Pagamento_id int,
    Pedido_id int,
    Pedido_Cliente_id int,
    Pedido_Pagamento_Cliente_id int,
    Entrega_id int,
    constraint fk_id_Cliente_Ent_Ped foreign key(Pedido_Cliente_id) references Pedido(Cliente_id),
    constraint fk_id_pedido_Ent_Ped foreign key (Pedido_id) references Pedido(idPedido),
    constraint fk_id_pag_pedido_Ent_Ped foreign key (Pedido_Pagamento_id) references Pedido(Pagamento_id),
    constraint fk_id_pag_pedido_Cliente_Ent_Ped foreign key (Pedido_Pagamento_Cliente_id) references Pedido(Pagamento_Cliente_id),
    constraint fk_id_pag_pedido_Entrega_Ent_Ped foreign key (Entrega_id) references Entrega(idEntrega)
);
    
-- Fornecedor
create table Fornecedor(
	idFornecedor int not null auto_increment primary key,
    RazaoSocial varchar(30) not null,
    End_Tipo_Logradouro varchar(3),
    End_Nome_Logradouro varchar(30),
    End_Numero int,
    End_Bairro varchar(30),
    End_Complemento varchar(10),
    End_Cidade varchar(30),
    End_UF char(2),
    CNPJ varchar(14) not null,
    constraint uniq_ident_cliente unique (CNPJ)
);

-- Vendedor
create table Vendedor(
	idVendedor int not null auto_increment primary key,
    RazaoSocial varchar(30) not null,
    End_Tipo_Logradouro varchar(3),
    End_Nome_Logradouro varchar(30),
    End_Numero int,
    End_Bairro varchar(30),
    End_Complemento varchar(10),
    End_Cidade varchar(30),
    End_UF char(2),
    CNPJ varchar(14) not null,
    constraint uniq_ident_cliente unique (CNPJ)
);
-- Estoque
create table Estoque(
	idEstoque int not null auto_increment primary key,
    LocalEstoque varchar(45) not null
);

-- Relacionamento entre Estoque e Produto
create table No_Estoque(
	Produto_id int,
    Estoque_id int,
    Quantidade int default 0,
    constraint fk_id_Produto foreign key(Produto_id) references Produto(idProduto),
    constraint fk_id_Estoque foreign key (Estoque_id) references Estoque(idEstoque)
);

-- Relacionamento entre Fornecedor e Produto
create table Fornece_Produtos(
	Fornecedor_id int,
    Produto_id int,
    constraint fk_id_Fornecedor_For_Prod foreign key(Fornecedor_id) references Fornecedor(idFornecedor),
    constraint fk_id_Produto_For_Prod foreign key (Produto_id) references Produto(idProduto)
);

-- Relacionamento entre Vendedor e Produto
create table Vende_Produtos(
	Vendedor_id int,
    Produto_id int,
    constraint fk_id_Vendedor_Ven_Prod foreign key(Vendedor_id) references Vendedor(idVendedor),
    constraint fk_id_Produto_Ven_Prod foreign key (Produto_id) references Produto(idProduto)
);

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
			

ALTER TABLE Produto MODIFY Preco DECIMAL(6,2);
ALTER TABLE Pedido MODIFY ValorFrete DECIMAL(4,2);

insert into Estoque values (1, "CD Nova Contagem-MG"), (2, "CD Praça João Boulevard-MG"),(3, "CD Campo Largo-PA");

insert into No_Estoque values (1, 3, 1200), (2, 2, 15000), (2, 3, 5000), (3, 1, 120000),(4, 3, 4000), (5, 3, 800);

insert into Pagamento values (1, "Crédito", 3), (2, "Crédito", 5), (3, "Crédito", 7),(4, "Débito", 3),(5, "Pix", 3), (6, "Crédito", 5);

insert into Entrega values (1, "Variante Transportes", "31778984000125", null, null, 174588),
							(2, "Trans Transportes", "31778977000125", null, null, 174558),
							(3, "TransPass", "31778900000125", null, null, 451358),
							(4, "Log Transportes", "34478984000125", null, null, 999868),
							(5, "Mundial Transportes", "55678984000125", null, null, 001358),
							(6, "Panorama Logistica", "31778984000225", null, null, 3358);

insert into Entrega_Pedidos values (2, );



