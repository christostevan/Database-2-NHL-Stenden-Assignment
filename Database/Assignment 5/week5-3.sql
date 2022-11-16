-- Transaction 1, Adding a new cinema and set it with qualities and subtitles
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
CREATE PROCEDURE sp_add_new_cinema
@cinema VARCHAR(255)
AS
BEGIN TRAN transaction_1
    INSERT INTO [dbo].[Cinema] (cinema_name, description)
    VALUES (@cinema, 'lorem ipsum')

    INSERT INTO [dbo].[Cinema] (cinema_id, quality_id)
    VALUES ((SELECT cinema_id 
            FROM [dbo].[Cinema] 
            WHERE cinema_name = @cinema), 1)

IF(@@ERROR > 0)
BEGIN
    ROLLBACK TRANSACTION transaction_1
END
ELSE
BEGIN
    COMMIT TRANSACTION transaction_1
END

-- Transaction 2, Changing a Cinema Name and its Genre
BEGIN TRY
    BEGIN TRANSACTION
        DECLARE @gen_id INT;

        SELECT @gen_id = genre_id 
        FROM [dbo].[Genre]
        WHERE genre_name = 'Dune'

        UPDATE [dbo].[Cinema] SET cinema_name = 'Dune'
        WHERE cinema_id = 10

        UPDATE [dbo].[CinemaGenre] SET genre_id = @gen_id
        WHERE cinema_id = (SELECT cinema_id FROM [dbo].[Cinema] WHERE cinema_name = 'Dune')
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
END CATCH

