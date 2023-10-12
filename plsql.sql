SELECT* FROM BRH.PROJETO;

CREATE OR REPLACE PROCEDURE conexao.brh.insere_projeto
(
p_NOME CLIENTE.ID%type,
p_RESPONSAVEL CLIENTE.RAZAO_SOCIAL%type,
)
IS
    v_CATEGORIA CLIENTE.CATEGORIA%type;
BEGIN

    v_CATEGORIA := categoria_cliente(p_FATURAMENTO);

    INSERT INTO CLIENTE
    VALUES
    (p_ID, p_RAZAO, p_CNPJ, p_SEGMERCADO, SYSDATE, p_FATURAMENTO, v_CATEGORIA);
    COMMIT;
END;