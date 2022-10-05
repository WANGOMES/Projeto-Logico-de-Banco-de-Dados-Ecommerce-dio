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
-- Modificando as tabelas
ALTER TABLE Produto MODIFY Preco DECIMAL(6,2);
ALTER TABLE Pedido MODIFY ValorFrete DECIMAL(4,2);
ALTER TABLE Entrega MODIFY Data_Entrega DATE;
ALTER TABLE Entrega MODIFY Data_Embarque DATE;
