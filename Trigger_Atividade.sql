-- Criar Banco de Dados
CREATE DATABASE Parte1;

-- Usar BD
USE Parte1;

-- Exercício 1)Gerencimaneto de Biblioteca

CREATE TABLE Parte1.Livros(
	   Id int auto_increment primary key,
	   Titulo varchar(255) not null,
	   Autor varchar(255) not null,
	   Quantidade_Estoque int not null
);

CREATE TABLE Parte1.Emprestimos(
       Id int auto_increment primary key,
       IdLivro int,
       Data_Emprestimo date,
       Data_Devolucao date,
       foreign key (IdLivro) references Parte1.Livros(Id)
);

--  Inserindo Valores na Tabela Livro
INSERT INTO Parte1.Livros(Titulo,Autor,Quantidade_Estoque) 
Values ("O Poder do Hábito", "Charles", 5);

-- Inserindo valores na Tabela Emprestimos
INSERT INTO Parte1.Emprestimos(IdLivro,Data_Emprestimo,Data_Devolucao)
Values (1, "2022-03-20", "2023-10-04");

-- Trigger

DELIMITER //
CREATE TRIGGER Parte1.atualizar_estoque_ao_emprestimo
AFTER INSERT ON Parte1.Emprestimos
FOR EACH ROW
BEGIN
  UPDATE parte1.Livros
  SET Quantidade_Estoque = Quantidade_Estoque - 1
  WHERE Id = NEW.IdLivro;
END;
// 
DELIMITER ;

-- Apagar BD
DROP DATABASE Parte1;


-- Exercício 2) Gerencimaneto de Finanças Pessoais

-- Criar Banco de Dados
CREATE DATABASE Parte1;

-- Usar BD
USE Parte1;

CREATE TABLE Parte1.Contas (
       Id int auto_increment primary key,
       Nome varchar(255) not null,
       Saldo decimal (10.2) not null
);

CREATE TABLE Parte1.Transacoes(
	   Id int auto_increment primary key,
       IdContas int,
       Tipo varchar(255),
       Valor decimal(10.2),
       Foreign key (IdContas) references Parte1.Contas(Id)
);

-- Inserindo Valores na Tabela Contas
INSERT INTO Parte1.Contas(Nome, Saldo)
Values ("Bruno", 900);

INSERT INTO Parte1.Andreza(Nome, Saldo)
Values ("Andreza", 2000);

-- Inserindo Valores na Tabela Transacoes
INSERT INTO Parte1.Transacoes(IdContas, Tipo, Valor)
Values (1, "TED", 500);

INSERT INTO Parte1.Transacoes(IdContas, Tipo, Valor)
Values (2, "PIX", 400);

-- Trigger
DELIMITER //
CREATE TRIGGER Parte1.financa_pessoal
AFTER INSERT ON Parte1.Transacoes
FOR EACH ROW
BEGIN
 IF New.Tipo = "TED" then
 UPDATE Parte1.Contas
 SET Saldo = Saldo + new.Valor
 WHERE Id = New.IdContas;
 ELSE
 UPDATE Parte1.Contas
 SET Saldo = Saldo - new.Valor
 WHERE Id = New.IdContas;
 END IF;
END;
//
DELIMITER ;

-- Apagar BD
DROP DATABASE Parte1;


-- Exercício 3) Sistema de RH
-- Criar Banco de Dados
CREATE DATABASE Parte1;

-- Usar BD
USE Parte1;

CREATE TABLE Parte1.Funcionarios(
       Id int primary key auto_increment,
       Nome varchar (255) not null,
       Data_Admissao date
);

-- Inserindo Valores na Tabela Funcionario
INSERT INTO Atividade.Funcionarios(Nome,Data_Admissao)
Values ("Bruno", "2021-06-10");

INSERT INTO Atividade.Funcionarios(Nome,Data_Admissao)
Values ("Adrian", "2023-10-11");

-- Trigger
DELIMITER //
CREATE TRIGGER Parte1.data_admissao
BEFORE INSERT ON Parte1.Funcionarios
FOR EACH ROW
BEGIN 
 IF new.Data_Admissao > "2023-11-15" THEN
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erro, a data de admissão deve ser mais que a data atual';
   END IF;
END;
//
DELIMITER ;

-- Apagar Banco de Dados
DROP DATABASE Parte1;


-- Exercício 4) Sistema de RH
-- Criar Banco de Dados
CREATE DATABASE Parte1;

-- Usar BD
USE Parte1;

CREATE TABLE Parte1.Produtos(
	   Id int primary key auto_increment,
       Nome varchar(255),
       Quantidade_Estoque int
);

CREATE TABLE Parte1.Vendas(
       Id int primary key auto_increment,
       Data_Venda date
);

CREATE TABLE Parte1.Itens_Venda(
       Id int primary key auto_increment,
       IdProduto int,
       IdVenda int,
       Quantidade int,
       foreign key (IdProduto) references Parte1.Produtos(Id),
       foreign key (IdVenda) references Parte1.Vendas(Id)
);

-- Insereindo Valores Tabela Produto
INSERT INTO Parte1.Produtos (Nome,Quantiade_Estoque)
Value ("Camiseta", 2);

-- Insereindo Valores Tabela Vendas
INSERT INTO Parte1.Vendas (Data_venda)
Value ("2023-10-30");

-- Insereindo Valores Tabela Itens_Venda
INSERT INTO Parte1.Itens_Venda(IdProduto,IdVenda,Quantidade)
Value (1,1,5);

-- Trigger
DELIMITER //
CREATE TRIGGER Parte1.analisar_estoque
BEFORE INSERT ON Parte1.Itens_Venda
FOR EACH ROW
BEGIN
 IF(
    SELECT Quantidade_Estoque
	FROM Produtos
    WHERE Id= new.IdProduto
 ) < new.Quantidade THEN
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT = 'Erro: A quantidade de produtos no estoque é insofuciente.';
   END IF;
END;
//
DELIMITER ;

-- Apagar Banco de Dados
DROP DATABASE Parte1;

-- Exercício 5) Matricula aluno
-- Criar Banco de Dados
CREATE DATABASE Parte1;

-- Usar BD
USE Parte1;

CREATE TABLE Parte1.Alunos(
	   Id int auto_increment primary key,
       Nome varchar (255),
       DataNasciomento date,
       Serie int
);

CREATE TABLE Parte1.Matriculas(
	   Id int auto_increment primary key,
       IdAluno varchar (255),
       DataMatricula date,
       StatusdaMatricula varchar(255),
       foreign key (IdAluno) references Parte1.Alunos(Id)
);

-- Inserindo Valores na Tabela Alunos
INSERT INTO Parte1.Alunos(Nome,DataNascimento,Serie)
Values ("Juliana", "2004-02-27",2);


-- Inserindo Valores na Tabela Matricula
INSERT INTO Parte1.Matriculas(IdAluno,DataMatricula,StatusdaMatricula)
Values (1, "2020-01-30","Matriculada");

-- Trigger

DELIMITER //

CREATE TRIGGER Parte1.verificar_idade_matricula
BEFORE INSERT ON Parte1.Matriculas
FOR each row
begin
-- 1°
 IF (SELECT Serie from Parte1.Aluno where Id = new.IdAluno) = 1 and (SELECT DataNascimento from Parte1.Aluno where Id = new.IdAluno) < "2017-01-01" OR (SELECT DataNascimento from Parte1.Aluno where Id = new.IdAluno)  > "2019-12-31"
THEN
 SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Requisito não aceito";
-- 2°
 ELSE IF(SELECT Serie from Parte1.Aluno where Id = new.IdAluno) = 2 and (SELECT DataNascimento from Parte1.Aluno where Id = new.IdAluno) < "2016-01-01" OR (SELECT DataNascimento from Parte1.Aluno where Id = new.IdAluno)  > "2018-12-31"
THEN
 SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Requisito não aceito";
-- 3°
 ELSE IF(SELECT Serie from Parte1.Aluno where Id = new.IdAluno) = 3 and (SELECT DataNascimento from Parte1.Aluno where Id = new.IdAluno) < "2015-01-01" OR (SELECT DataNascimento from Parte1.Aluno where Id = new.IdAluno)  > "2017-12-31"
THEN
 SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Requisito não aceito";
-- 4°
 ELSE IF(SELECT Serie from Parte1.Aluno where Id = new.IdAluno) = 4 and (SELECT DataNascimento from Parte1.Aluno where Id = new.IdAluno) < "2014-01-01" OR (SELECT DataNascimento from Parte1.Aluno where Id = new.IdAluno)  > "2016-12-31"
THEN
 SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Requisito não aceito";
-- 5°
 ELSE IF(SELECT Serie from Parte1.Aluno where Id = new.IdAluno) = 5 and (SELECT DataNascimento from Parte1.Aluno where Id = new.IdAluno) < "2013-01-01" OR (SELECT DataNascimento from Parte1.Aluno where Id = new.IdAluno)  > "2015-12-31"
THEN
 SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Requisito não aceito";
-- 6°
 ELSE IF(SELECT Serie from Parte1.Aluno where Id = new.IdAluno) = 6 and (SELECT DataNascimento from Parte1.Aluno where Id = new.ID_Aluno) < "2012-01-01" OR (SELECT DataNascimento from Parte1.Aluno where Id = new.IdAluno)  > "2014-12-31"
THEN
 SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Requisito não aceito";
-- 7°
 ELSE IF(SELECT Serie from Parte1.Aluno where Id = new.IdAluno) = 7 and (SELECT DataNascimento from Parte1.Aluno where Id = new.ID_Aluno) < "2011-01-01" OR (SELECT DataNascimento from Parte1.Aluno where Id = new.IdAluno)  > "2013-12-31"
THEN
 SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Requisito não aceito";
-- 8°
 ELSE IF(SELECT Serie from Parte1.Aluno where Id = new.IdAluno) = 8 and (SELECT DataNascimento from Parte1.Aluno where Id = new.ID_Aluno) < "2010-01-01" OR (SELECT DataNascimento from Parte1.Aluno where Id = new.IdAluno)  > "2012-12-31"
THEN
 SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Requisito não aceito";
-- 9°
 ELSE IF(SELECT Serie from Parte1.Aluno where Id = new.IdAluno) = 9 and (SELECT DataNascimento from Parte1.Aluno where Id = new.ID_Aluno) < "2009-01-01" OR (SELECT DataNascimento from Parte1.Aluno where Id = new.IdAluno)  > "2011-12-31"
THEN
 SIGNAL SQLSTATE "45000" SET MESSAGE_TEXT = "Requisito não aceito";

END IF;
END I
F;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END IF;
END;

//
DELIMITER ;




