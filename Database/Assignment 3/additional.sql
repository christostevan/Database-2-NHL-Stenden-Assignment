-- Select cinema that is a tv series
USE Netflix 
SELECT cinema_name, cinema_description 
FROM cinema
WHERE cinema_id = (SELECT cinema_id FROM Season)
GO

-- Determine age from date of birth
SELECT YEAR(GETDATE()) - YEAR(dateOfBirth) AS Age 
FROM Profile

SELECT DATEDIFF(YY, dateOfBirth, GETDATE()) AS Age
FROM Profile

SELECT DATEDIFF(MONTH, dateOfBirth, GETDATE()) / 12 -
CASE 
    WHEN month(dateOfBirth) = MONTH(GETDATE()) AND DAY(dateOfBirth) > DAY(GETDATE()) 
    THEN 1 ELSE 0
END
AS Age 
FROM Profile

-- Check if a subtitle is part of a series


-- Sum 2 times
    DECLARE @StartTime      datetime = '08:00'
    DECLARE @EndTime        datetime = '10:47'
    DECLARE @durMinutes     int
    DECLARE @duration       nvarchar(5)

    SET @durMinutes = DATEDIFF(MINUTE, @StartTime, @EndTime)

    SET @duration = 
    (SELECT RIGHT('00' + CAST((@durMinutes / 60) AS VARCHAR(2)),2) + ':' + 
            RIGHT('00' + CAST((@durMinutes % 60) AS VARCHAR(2)), 2))
    SELECT @duration
    
    -- 
    DECLARE @Tab TABLE
    (
        data CHAR(5)
    )

    INSERT @Tab
    SELECT '25:30' UNION ALL
    SELECT '31:45' UNION ALL
    SELECT '16:00'

    SELECT STUFF(CONVERT(CHAR(8), DATEADD(SECOND, theHours + theMinutes, 
        '19000101'), 8), 1, 2, CAST((theHours + theMinutes) / 3600 AS VARCHAR(12)))
    FROM (
        SELECT ABS(SUM(CASE CHARINDEX(':', data) WHEN 0 THEN 0 ELSE 3600 * 
            LEFT(data, CHARINDEX(':', data) - 1) END)) AS theHours,
        ABS(SUM(CASE CHARINDEX(':', data) WHEN 0 THEN 0 ELSE 60 * 
            SUBSTRING(data, CHARINDEX(':', data) + 1, 2) END)) AS theMinutes
        FROM @Tab
    ) AS d
-- 


