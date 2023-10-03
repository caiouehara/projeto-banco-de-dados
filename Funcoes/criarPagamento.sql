DROP FUNCTION criarPagamento();
CREATE OR REPLACE FUNCTION criarPagamento() 
RETURNS TABLE (nome VARCHAR(45), idFuncionario INT, pagamento_liq DECIMAL)
AS $$ 
    DECLARE
        cs_funcionaro CURSOR FOR SELECT * FROM funcionário;
        v_salario DECIMAL;
        reg RECORD;
    BEGIN
        OPEN cs_funcionaro;
        FETCH cs_funcionaro INTO reg;
        WHILE FOUND LOOP 
            v_salario := (reg.salário::DECIMAL);
            	
            -- Disconto do IR no salário bruto
            IF v_salario < 2111.01 THEN
				v_salario := v_salario;
            ELSIF v_salario BETWEEN 2111.01 AND 2826.65 THEN
                v_salario := v_salario * (1 - 0.075);
            ELSIF v_salario BETWEEN 2826.66 AND 3751.05 THEN 
                v_salario := v_salario * (1 - 0.15);   
            ELSIF v_salario BETWEEN 3751.06 AND 4664.68 THEN
                v_salario := v_salario * (1 - 0.225);
            ELSE
                v_salario := v_salario * (1 - 0.275);
            END IF;

            -- Insere na tabela de retorno
            nome := reg.nome;
            idFuncionario := reg.idFuncionário;
            pagamento_liq := v_salario;


            -- Insert na tabela pagamento (nome, idFuncionario)
            INSERT INTO pagamento VALUES 
                (nextval('cód_pagamento_seq'), pagamento_liq, current_date, current_date, idFuncionario);

            FETCH cs_funcionaro INTO reg;
			RETURN NEXT;
        END LOOP;
	END;
$$ LANGUAGE plpgsql;