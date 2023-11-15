-- Exercício 1) Relatório pedidos clientes
-- Criar BD
CREATE DATABASE Parte2;

-- Usar BD
USE Parte2;

CREATE TABLE Parte2.Clientes(
       Id int auto_increment primary key,
       Nome varchar(255) not null,
       Email varchar(255) not null,
       Telefone varchar(255) not null
);

CREATE TABLE Parte2.Pedidos(
       Id int auto_increment primary key,
       IdCliente int,
       DataPedido date,
       ValorTotal float,
       foreign key (IdCliente) references Parte2.Clientes(Id)
);

-- Inserindo valores na Tabela Cliente
Insert into Parte2.Clientes(Nome,Email,Telefone)
Value("Bruno","brupereirasilva27@gmail.com","(77) 97777-7777");

-- Inserindo valores na tabela Pedidos
Insert into Parte2.Pedidos(IdCliente,DataPedido,ValorTotal)
Value(1,"2005-04-11",13);

-- View
CREATE VIEW Parte2.relatorio_cliente_pedido as 
SELECT C.Nome as "Nome",
count(P.Id) as "Quantidade de Pedidos",
P.ValorTotal as "Valor Total"
FROM Parte2.Clientes C
Inner Join Parte2.Pedidos P on C.Id = P.IdCliente;

DROP DATABASE Parte2;


-- Exercício 2) Estoque Critico
-- Criar BD
CREATE DATABASE Parte2;

-- Usar BD
USE Parte2;

CREATE TABLE Parte2.Produto(
       Id int auto_increment primary key,
       Nome varchar(255) not null,
       PrecoUnitario decimal (10.2) not null,
       Categoria varchar(255)
);

CREATE TABLE Parte2.Estoque(
       Id int auto_increment primary key,
       IdProduto int,
       Quantidade int,
       foreign key (IdProduto) references Parte2.Produto(Id)
);

-- Inserindo valores na Tabela Produto
Insert into Parte2.Produto(Nome,PrecoUnitario,Categoria)
Value("Arroz",30.2,"Alimentício");

Insert into Parte2.Produto(Nome,PrecoUnitario,Categoria)
Value("Feijão",12.2,"Alimentício");

-- Inserindo valores na tabela Estoque
Insert into Parte2.Estoque(IdProduto,Quantidade)
Value(1, 6);

Insert into Parte2.Estoque(IdProduto,Quantidade)
Value(2, 3);

-- View
CREATE VIEW Parte2.estoque_critico as 
SELECT P.Nome as "Nome",
E.Quantidade as "Quantidade"
FROM Parte2.produtos P
Inner Join Parte2.Estoque E
on P.Id = E.IdProduto
Where Quantidade < 10;

select * from Parte2.estoque_critico;

DROP DATABASE Parte2;


-- Exercício 3) Relatorio Venda Funcionario	
-- Criar BD
CREATE DATABASE Parte2;

-- Usar BD
USE Parte2;

CREATE TABLE Parte2.Funcionarios(
       Id int auto_increment primary key,
       Nome varchar(255) not null,
       Cargo varchar(255) not null,
       Salario decimal(10.2)
);

CREATE TABLE Parte2.Vendas(
       Id int auto_increment primary key,
       IdFuncionario int,
       DataVenda date,
       ValorVenda decimal(10.2),
       foreign key (IdFuncionario) references Parte2.Funcionario(Id)
);

-- Inserindo valores na Tabela Funcionario
Insert into Parte2.Funcionario(Nome,Cargo,Salario)
Value("Júlio","Manutenção",960.00);

Insert into Parte2.Funcionario(Nome,Cargo,Salario)
Value("Manuel","RH",1960.00);


-- Inserindo valores na tabela Vendas
Insert into Parte2.Vendas(IdFuncionario,DataVenda,ValorVenda)
Value(1, "2020-10-20", 190.00);

Insert into Parte2.Vendas(IdFuncionario,DataVenda,ValorVenda)
Value(2, "2020-09-24", 590.00);

-- View
CREATE VIEW Parte2.relatorio_venda_funcionario as 
SELECT F.Nome as "Nome",
count(V.Id) as "Número de Vendas",
Sum(V.ValorVenda) as "Valor das Vendas"
FROM Parte2.Funcionario F
Left Join Parte2.Vendas V
on F.Id = V.IdFuncionario
group by F.Nome ;

select * from Parte2.relatorio_venda_funcionario;

DROP DATABASE Parte2;


-- Exercício 4) Relatorio Produto Categoria
-- Criar BD
CREATE DATABASE Parte2;

-- Usar BD
USE Parte2;

CREATE TABLE Parte2.Categoria(
       Id int auto_increment primary key,
       Nome varchar(255) not null,
       Descricao varchar(255) not null
);

CREATE TABLE Parte2.Produto2(
       Id int auto_increment primary key,
       IdCategoria int,
       Nome varchar(255),
       PrecoUnitario decimal(10.2),
       foreign key (IdCategoria) references Parte2.Categoria(Id)
);

-- Inserindo valores na Tabela Categoria
Insert into Parte2.Categoria(Nome,Descricao)
Value("Sapato","Tamanho 42");

Insert into Parte2.Categoria(Nome,Descricao)
Value("Perfumes", "Perfume de 200ml");


-- Inserindo valores na tabela Produto
Insert into Parte2.Produto2(IdCategoria,Nome,PrecoUnitario)
Value(1, "Vestuário", 190.00);

Insert into Parte2.Produto2(IdCategoria,Nome,PrecoUnitario)
Value(2, "Beleza", 590.00);

-- View
CREATE VIEW Parte2.relatorio_produtos_categoria as 
SELECT C.Nome as "Nome",
count(P.Id) as "Quantidade de Produto"
FROM Parte2.Categoria C
Left Join Parte2.Produto2 P
on C.Id = P.IdCategoria
group by C.Nome ;

select * from Parte2.relatorio_produtos_categoria;

DROP DATABASE Parte2;


-- Exercício 5) Relatorio Pagamentos Cidade
-- Criar BD
CREATE DATABASE Parte2;

-- Usar BD
USE Parte2;

CREATE TABLE Parte2.Cliente2(
       Id int auto_increment primary key,
       Nome varchar(255) not null,
       Endereco varchar(255) not null,
       Cidade varchar(255)
);

CREATE TABLE Parte2.Pagamento(
       Id int auto_increment primary key,
       IdCliente2 int,
       DataPagamento date,
       ValorPagamento decimal(10.2),
       foreign key (IdCliente2) references Parte2.Cliente2(Id)
);

-- Inserindo valores na Tabela Categoria
Insert into Parte2.Cliente2(Nome,Endereco,Cidade)
Value("Julio","Itacaranha, 42", "Salvador");

Insert into Parte2.Cliente2(Nome,Endereco,Cidade)
Value("André", "Bariri, 45", "Salvador");

-- Inserindo valores na tabela Produto
Insert into Parte2.Pagamento(IdCliente2,DataPagamento,ValorPagamento)
Value(1, "2023-11-10", 190.00);

Insert into Parte2.Pagamento(IdCliente2,DataPagamento,ValorPagamento)
Value(2, "2023-11-11", 90.00);

-- View
CREATE VIEW Parte2.relatorio_pagamentos_cidade as 
SELECT C.Nome as "Nome dos Clientes",
C.Cidade as "Nome da Cidade",
sum(P.ValorPagamento) as "Valor do Pagamento"
From Parte2.Clientes2 C
Inner join Parte2.Pagamento P
On C.Id = P.IdCliente
Group by C.Nome;

select * from Parte2.relatorio_pagamentos_cidade;

DROP DATABASE Parte2;


