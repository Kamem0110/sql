CREATE TABLE TB_BI
(
CPF VARCHAR2 (14),
COLABORADOR VARCHAR2(50),
DATA_NASCIMENTO DATE,
IDADE INTEGER,
SEXO VARCHAR2(1),
TELEFONE_CELULAR VARCHAR2(13),
TELEFONE_RESIDENCIAL VARCHAR2(12),
EMAIL_PESSOAL VARCHAR2(50),
EMAIL_TRABALHO VARCHAR2(50),
DEPENDENTE1 VARCHAR2(50),
DEPENDENTE2 VARCHAR2(50),
ENDERECO VARCHAR2(150),
BAIRRO VARCHAR2(50),
CIDADE VARCHAR2(50),
ESTADO VARCHAR2(2),
CEP VARCHAR2(9)
);

INSERT INTO TB_BI (
CPF, COLABORADOR, DATA_NASCIMENTO,idade,sexo,telefone_celular,telefone_residencial,email_pessoal,
email_trabalho,dependente1,dependente2,endereco,bairro,cidade,estado,cep)
VALUES ('123.789.654-11','Fulano de Tal','01/05/95',28,'M','(61)99999-9999','(19)3030-4040',
'fulano@email.com','fulano.tal@brh.com','Filha Beltrana de Tal','Esposa Cicrana de Tal',
'Rua de Tal','Algum','Piracicaba','SP','12454-001');

SELECT * FROM TB_BI