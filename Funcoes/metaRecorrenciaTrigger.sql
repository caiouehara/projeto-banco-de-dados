-- DROP TRIGGER metaRecorrenciaTrigger 
CREATE TRIGGER metaRecorrenciaTrigger
BEFORE INSERT ON Venda FOR EACH ROW 
EXECUTE FUNCTION metaRecorrencia();