CREATE OR REPLACE FUNCTION transacaoItem_Vendido()
RETURNS TRIGGER
AS $$
    DECLARE
        quantidadeEstoqueProduto produto.quantidade_estoque%TYPE;
        fluxoSaidaProduto item_vendido.quantidade%TYPE;

    BEGIN
        SELECT INTO quantidadeEstoqueProduto quantidade_estoque FROM produto
            WHERE NEW.idProduto = produto.idProduto;

        -- Atualização (UPDATE) quantidade de estoque após venda, caso houver disponibildade
        IF (NEW.quantidade > quantidadeEstoqueProduto)
        THEN
            RAISE NOTICE 'Transacão impossibilidade, pois não há estoque disponível';
            DELETE FROM item_vendido WHERE NEW.idProduto = idProduto AND NEW.cont = cont;
            RETURN OLD;
        ELSE
            UPDATE produto SET quantidade_estoque = quantidade_estoque - NEW.quantidade
                WHERE NEW.idProduto = produto.idProduto; 
        END IF;

        -- Cálculo do Fluxo de Saída baseado na Média Aritmética das 5 últimas transações
        SELECT INTO fluxoSaidaProduto AVG(quantidade) FROM (
            SELECT quantidade FROM item_vendido
            WHERE NEW.idProduto = item_vendido.idProduto
            ORDER BY cont DESC LIMIT 5
        ) AS last5_transacaoItemVendido;

        RAISE NOTICE 'Fluxo Saída Produto: %', fluxoSaidaProduto;

        IF (fluxoSaidaProduto > quantidadeEstoqueProduto - NEW.quantidade)
        THEN
            RAISE NOTICE 'Estoque com tendencia a acabar, compra necessária';
        END IF;
        RETURN OLD;
    END
$$ LANGUAGE 'plpgsql';