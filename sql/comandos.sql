UPDATE brh.atribuicao
SET projeto  = 5 where projeto = 1;
UPDATE brh.atribuicao
SET projeto  = 6 where projeto = 2;
UPDATE brh.atribuicao
SET projeto  = 7 where projeto = 3;
UPDATE brh.atribuicao
SET projeto  = 8 where projeto = 4;



-- SEMANA 2 // MATERIALIZAR MODELO F�SICO
CREATE TABLE TB_BRH
(
ATRIBUIDOR VARCHAR2 (50),
COLABORADOR VARCHAR2(50),
DEPARTAMENTO VARCHAR2 (50),
DEPENDENTE VARCHAR2(50),
PAPEL VARCHAR2(50),
PROJETO VARCHAR2(50),

);

-- SEMANA 2 // EFETUAR CARGA DE DADOS (EXCLUIR O BRH)

DROP TABLE TB_BRH;

-- SEMANA 2 // INSERIR NOVO COLABORADOR

SELECT * FROM BRH.ATRIBUICAO; --1 OK
SELECT * FROM BRH.PAPEL; --2 OK
SELECT * FROM BRH.DEPARTAMENTO; --3 OK
SELECT * FROM BRH.COLABORADOR; --4 OK
SELECT * FROM BRH.TELEFONE_COLABORADOR; --5 OK
SELECT * FROM BRH.PROJETO; --6 OK
SELECT * FROM BRH.DEPENDENTE; --7 OK

INSERT INTO BRH.ATRIBUICAO (
COLABORADOR, PROJETO, PAPEL)
VALUES ('A121',1,2);

INSERT INTO brh.papel
(id, nome)
VALUES
(8, 'BI');

UPDATE BRH.PAPEL SET NOME = 'Especialista de Neg�cios' WHERE ID = 8;

-- DEPARTAMENTO OK
INSERT INTO brh.departamento
(sigla, nome, chefe, departamento_superior)
VALUES
('BI', 'Especialista de Neg�cios', 'A121', 'DEREH');

-- ENDERECO
INSERT INTO brh.endereco 
(cep, uf, cidade, bairro)
VALUES
('01111-100', 'SP', 'PIRACICABA', 'Nova Piraciaba');

-- COLABORADOR NA EMPRESA
INSERT INTO brh.colaborador
(matricula, nome, cpf, salario, departamento, cep, logradouro, complemento_endereco)
VALUES
('A121', 'Fulano de Tal', '176.074.270-86', '4866', 'BI', '01111-100', 'Nova `Piracicaba', 'Casa 1');

-- CELULAR MOVEL (M) -- OK
INSERT INTO brh.telefone_colaborador
(colaborador, numero, tipo)
VALUES
('A121', '(61) 99999-9999', 'M');

-- TELEFONE RESIDENCIAL (R) --OK
INSERT INTO brh.telefone_colaborador
(colaborador, numero, tipo)
VALUES 
('A121', '(61) 3030-4040', 'R');

-- TELEFONE COMERCIAL (C) --OK
INSERT INTO brh.telefone_colaborador 
(colaborador, numero, tipo)
VALUES
('A121', '(11) 2105-0199', 'C');

-- EMAIL PESSOAL (P) -- OK
INSERT INTO brh.email_colaborador
(colaborador, email, tipo)
VALUES
('A121', 'fulano@email.com', 'P');

-- EMAIL TRABALHO (T) --OK
INSERT INTO brh.email_colaborador 
(colaborador, email, tipo)
VALUES
('A121', 'fulano@brh.com', 'T');

-- PROJETO -- OK
INSERT INTO brh.projeto
(nome, responsavel, inicio, fim)
VALUES
('BI', 'A121', to_date('12/04/2020', 'DD/MM/YYYY'), to_date('21/12/2024', 'DD/MM/YYYY'));

-- DEPENDENTES DO COLABORADOR
INSERT INTO brh.dependente 
(cpf, colaborador, nome, parentesco, data_nascimento) 
VALUES
('043.161.552-67', 'A121', 'Beltrana de Tal', 'Filho(a)', to_date('21/11/2015', 'DD/MM/YYYY'));
INSERT INTO brh.dependente
(cpf, colaborador, nome, parentesco, data_nascimento)
VALUES
('073.340.136-38', 'A121', 'Cicrana de Tal', 'Cônjuge', to_date('02/06/1968', 'DD/MM/YYYY'));

--SEMANA 2 // RELAT�RIO DE DEPARTAMENTO
SELECT SIGLA, NOME FROM BRH.DEPARTAMENTO ORDER BY NOME;

-- SEMANA 2 // RELAT�RIO DE CONTATOS
SELECT NOME, EMAIL, NUMERO
FROM BRH.COLABORADOR
INNER JOIN BRH.TELEFONE_COLABORADOR ON COLABORADOR.MATRICULA = TELEFONE_COLABORADOR.COLABORADOR
INNER JOIN BRH.EMAIL_COLABORADOR ON COLABORADOR.MATRICULA = EMAIL_COLABORADOR.COLABORADOR
WHERE TELEFONE_COLABORADOR.TIPO = 'C' AND EMAIL_COLABORADOR.TIPO = 'T';

-- SEMANA 2 // EXCLUIR DEPARTAMENTO SECAP
DELETE FROM brh.DEPARTAMENTO WHERE SIGLA = 'SECAP';

-- SEMANA 3 // Filtrar dependentes

CREATE VIEW VW_DEPENDENTES AS
SELECT C.NOME AS COLABORADOR, D.NOME AS DEPENDENTE, D.DATA_NASCIMENTO
FROM BRH.DEPENDENTE D INNER JOIN BRH.COLABORADOR C
ON C.MATRICULA = D.COLABORADOR;

SELECT * FROM VW_DEPENDENTES

SELECT COLABORADOR, DEPENDENTE, DATA_NASCIMENTO FROM VW_DEPENDENTES
WHERE (extract(month from data_nascimento)>=4 and extract(month from data_nascimento)<=6)
OR UPPER(DEPENDENTE) LIKE '%h%';

SELECT COLABORADOR, DEPENDENTE, DATA_NASCIMENTO FROM VW_DEPENDENTES
WHERE 
(extract(month from data_nascimento))>=4
and extract(month from data_nascimento)<=6;


-- SEMANA 3 // LISTAR COLABORADOR COM MAIOR SALARIO

SELECT NOME, SALARIO FROM BRH.COLABORADOR
WHERE SALARIO >= 40944
order by salario desc;

-- SEMANA 3 // Relat�rio de senioridade

SELECT MATRICULA, NOME, SALARIO,
CASE
WHEN SALARIO <= 3000 THEN 'JUNIOR'
WHEN SALARIO > 3000 AND SALARIO <= 6000 THEN 'PLENO'
WHEN SALARIO > 6000 AND SALARIO <= 20000 THEN 'SENIOR'
ELSE 'CORPO DIRETOR'
END AS CORPO_DIRETOR
FROM BRH.COLABORADOR
ORDER BY COLABORADOR.SALARIO DESC;

-- SEMANA 3 // Listar colaboradores com mais dependentes
--Criar consulta que liste nome do colaborador e a quantidade de dependentes que ele possui;

SELECT * FROM BRH.COLABORADOR;

SELECT * FROM BRH.DEPENDENTE;

SELECT  C.NOME, COUNT(D.CPF)
FROM BRH.COLABORADOR C
INNER JOIN BRH.DEPENDENTE D
ON C.MATRICULA = D.COLABORADOR
GROUP BY C.NOME
HAVING COUNT(D.CPF) >= 2
ORDER BY COUNT(D.CPF) DESC, C.NOME

-- SEMANA 3 // Listar colaboradores com mais dependentes
--No relat�rio deve ter somente colaboradores com 2 ou mais dependentes.
--Ordenar consulta pela quantidade de dependentes em ordem decrescente, e colaborador crescente.

SELECT * FROM BRH.COLABORADOR;

SELECT * FROM BRH.DEPENDENTE;

SELECT  C.NOME, COUNT(D.CPF)
FROM BRH.COLABORADOR C
INNER JOIN BRH.DEPENDENTE D
ON C.MATRICULA = D.COLABORADOR
GROUP BY C.NOME
HAVING COUNT(D.CPF) >= 2
ORDER BY COUNT(D.CPF) DESC, C.NOME

-- SEMANA 3 // Listar colaboradores em projetos
--Ordene a consulta pelo nome do departamento e nome do projeto.
SELECT * FROM BRH.DEPARTAMENTO;

SELECT * FROM BRH.PROJETO;

SELECT COUNT(NOME) FROM BRH.DEPARTAMENTO; 

SELECT 
brh.D.NOME AS DEPARTAMENTO,
brh.P.NOME AS PROJETO,
COUNT(brh.c.nome) AS QUANTIDADE_COLABORADORES
FROM 
BRH.DEPARTAMENTO D
INNER JOIN
BRH.colaborador C ON brh.D.SIGLA = brh.C.DEPARTAMENTO
INNER JOIN
BRH.ATRIBUICAO A ON brh.C.MATRICULA = brh.A.COLABORADOR
INNER JOIN
BRH.PROJETO P ON brh.A.PROJETO = brh.P.ID
GROUP BY D.NOME, P.NOME
ORDER BY D.NOME


-- SEMANA 3 // Listar faixa et�ria dos dependentes

SELECT
CPF, NOME, DATA_NASCIMENTO, PARENTESCO,
COLABORADOR,
TRUNC(MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO)/12) AS IDADE_ATUAL,
CASE
WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, DATA_NASCIMENTO)/12) < 18 THEN 'MENOR DE IDADE'
ELSE 'MAIOR DE IDADE'
END AS IDADES
FROM BRH.DEPENDENTE
ORDER BY COLABORADOR, NOME;

-- SEMANA 3 // Paginar listagem de colaboradores

SELECT ROWNUM AS NUM_LINHA, NOME
FROM BRH.COLABORADOR
ORDER BY NOME
FETCH FIRST 10 ROWS ONLY; --

SELECT ROWNUM AS NUM_LINHA, NOME
FROM BRH.COLABORADOR
ORDER BY NOME
OFFSET 10 ROWS --
FETCH NEXT 10 ROWS ONLY;

SELECT ROWNUM AS NUM_LINHA, NOME
FROM BRH.COLABORADOR
ORDER BY NOME
OFFSET 20 ROWS
FETCH NEXT 10 ROWS ONLY;

commit;

