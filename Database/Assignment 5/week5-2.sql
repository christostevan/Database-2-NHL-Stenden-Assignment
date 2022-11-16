-- Recovery
USE [master]
ALTER DATABASE Netflix SET RECOVERY Full
GO

USE [master]
RESTORE DATABASE [Netflix] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\Backup\Netflix.bak' WITH  FILE = 1,  NOUNLOAD,  STATS = 5
GO



-- Transaction, Adding a new language to the database and set it with a cinema to make a new subtitle
CREATE PROCEDURE sp_add_language_insert_subtitle
@lang VARCHAR(255),
@name VARCHAR(255)
AS
BEGIN TRY
    BEGIN TRANSACTION
        BEGIN
            IF NOT EXISTS (SELECT L.language_name, C.cinema_name FROM [dbo].[Language] 
                            WHERE language_name = @lang)
            BEGIN
                INSERT INTO [dbo].[Language] (language_name)
                VALUES (@lang)

                INSERT INTO [dbo].[Subtitle] (language_id, cinema_id)
                SELECT language_id, language_name, cinema_id, cinema_name
                FROM [dbo].[Language] L
                INNER JOIN [dbo].[Subtitle] S
                ON L.language_id = S.language_id
                INNER JOIN [dbo].[Cinema] C
                ON S.cinema_id = C.cinema_id
                WHERE language_name = @lang
                AND cinema_name = @name
            END
        END
    COMMIT TRANSACTION
    PRINT 'Transcation successful'
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT 'Transaction failed'
END CATCH
