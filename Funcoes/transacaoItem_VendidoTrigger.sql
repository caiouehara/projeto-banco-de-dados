DROP TRIGGER transacaoItem_VendidoTrigger ON item_vendido;
CREATE TRIGGER transacaoItem_VendidoTrigger
AFTER INSERT ON item_vendido FOR EACH ROW
EXECUTE FUNCTION transacaoItem_Vendido();