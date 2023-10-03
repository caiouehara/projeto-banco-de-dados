CREATE OR REPLACE FUNCTION metaRecorrencia() 
RETURNS TRIGGER 
AS $$ 
    DECLARE
        cont_recorrencia INTEGER;
        desconto DECIMAL;
    BEGIN
        SELECT COUNT(*) INTO cont_recorrencia FROM Venda
            WHERE idCliente = NEW.idCliente;
    
        IF cont_recorrencia BETWEEN 10 AND 30 THEN 
            desconto := 0.01;
        ELSIF cont_recorrencia >= 30 THEN
            desconto := 0.30;
        END IF;
		NEW.total_compra := NEW.total_compra - (NEW.total_compra * desconto);
    RETURN NEW;
	END;
$$ LANGUAGE plpgsql;