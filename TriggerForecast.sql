
use Forecast



CREATE TRIGGER trProtegerPopulacao
ON dbo.predicao_populacao
FOR DELETE
AS BEGIN

        ROLLBACK TRANSACTION;
        RAISERROR ('A exclusão da tabela é estritamente proibida!' ,16, 1)

END;

        
        
        CREATE TRIGGER trg_ProtegerPopulacao
ON world_population
FOR DELETE
AS
BEGIN
    -- Cancela a operação e envia uma mensagem de erro
    ROLLBACK TRANSACTION;
    RAISERROR ('A exclusão de dados nesta tabela é estritamente proibida!', 16, 1);
END;



CREATE TRIGGER trg_ProtegerPopulacao1
ON dbo.predicao_populacao
AFTER DELETE -- Define que vai rodar após uma tentativa de DELETE
AS
BEGIN
    -- Se a tabela temporária 'Deleted' tiver linhas, significa que tentaram apagar algo
    IF EXISTS (SELECT * FROM Deleted)
    BEGIN
        -- Cancela a operação e desfaz a exclusão
        ROLLBACK TRANSACTION;
        
        -- Retorna uma mensagem de erro para o usuário/aplicação
        RAISERROR ('Erro: A exclusão de dados nesta tabela foi bloqueada por motivos de segurança.', 16, 1);
    END
END;