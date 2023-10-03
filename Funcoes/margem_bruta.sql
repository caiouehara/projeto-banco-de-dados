DROP FUNCTION margem_bruta;
CREATE OR REPLACE FUNCTION margem_bruta(p_data_inicio DATE, p_data_final DATE)
RETURNS TABLE (id_produto INT, margem_bruta NUMERIC)
AS $$
    DECLARE
        total_vendido NUMERIC;
        total_comprado NUMERIC;
        v_produto produto%ROWTYPE;
    BEGIN
        FOR v_produto IN (SELECT * FROM produto)
            LOOP
			
				-- Evita cálculos com NULL, uma vez que pode não existir transação para aquele produto
				IF NOT v_produto.idProduto IN (SELECT idProduto FROM item_vendido) THEN									
					CONTINUE;
				ELSIF NOT v_produto.idProduto IN (SELECT idProduto FROM item_comprado) THEN
					CONTINUE;
				END IF;
							
				-- Cálcula a soma dos itens vendidos a partir da nota_fiscal emitida em certa data
	            SELECT SUM(preço_unitário * quantidade) FROM item_vendido INTO total_vendido
			        WHERE 
						v_produto.idProduto = item_vendido.idProduto AND 
						nota_fiscal IN (
				        	SELECT nota_fiscal FROM Venda
						    	WHERE data BETWEEN p_data_inicio AND p_data_final
				    	);

				-- Cálcula a soma dos itens comprados a partir da nota_fiscal emitida em certa data
	            SELECT SUM(preço_unitário * quantidade) FROM item_comprado INTO total_comprado
			        WHERE 
						v_produto.idProduto = item_comprado.idProduto AND 
						nota_fiscal IN (
				        	SELECT nota_fiscal FROM Compra
						    	WHERE data BETWEEN p_data_inicio AND p_data_final
				    	);
                	
				-- Atribui a tabela o cálculo da margem bruta para cada produto 
                id_produto := v_produto.idProduto;
                margem_bruta := total_vendido - total_comprado;
				
				RETURN NEXT;
        END LOOP;
		RETURN;
    END;
$$ LANGUAGE plpgsql;