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








