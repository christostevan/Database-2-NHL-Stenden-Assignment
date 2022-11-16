-- 1.) How many Netflix users there are
SELECT COUNT(user_id) AS 'Total number of users'
FROM [User];

-- 2.) How many Netflix profiles there are
SELECT COUNT(profile_id) AS total_profile
FROM [Profile]

--  3.) How many Netflix subscriptions there are
SELECT COUNT(subscription_id) AS Netflix_subscrpitions
FROM Subscription 

-- 4.) How many films there are
SELECT COUNT(cinema_id) AS films 
FROM [dbo].[Cinema] C
JOIN [dbo][Season] S ON C.cinema_id = S.cinema_id

--  5.) What the average users age is
SELECT AVG()

-- 6.) What the combined age of all users is
SELECT SUM()
FROM [dbo].[Profile]

-- 7.) How many different subtitles there are in the database
SELECT COUNT(subtitle_id) AS avaliable_subtitles
FROM [Netflix].[dbo].[Subtitle]

-- 8.) How many people have been invited to join by other users


-- 9.) How many items there are that users still want to watch
SELECT profile_id AS user, COUNT(cinema_id) AS cinemas_yet_watched
FROM [Watchlist] W
GROUP BY cinema_id
ORDER BY cinemas_yet_watched ASC

-- 10.) Which preferences I can set up as user


-- 11.) How many people have a subscription
SELECT COUNT(user_id) AS 
FROM

-- 12.) How many people are currently watching for free
SELECT COUNT(user_id) AS free_users
FROM [dbo].[Users]
WHERE (
    SELECT DATEPART(DAY, GETDATE()) - DATEPART(DAY, [Users].activation_date)
) < 7

-- 13.) How many minutes users have watched in total
SELECT profile_name AS user, 
DATEDIFF(MINUTE, 0, COUNT()) AS minutes_spent
FROM [Profile] P 
INNER JOIN Viewedlist V
ON P.profile_id = V.profile_id


-- 14.) How often Dutch subtitling has been used
SELECT COUNT(viewedlist_id) AS dutch_subtitle_used
FROM [ViewedList] V
INNER JOIN Cinema C ON C.cinema_id = V.cinema_id
WHERE 

-- 15.) How often no subtitling has been used
SELECT COUNT(viewedlist_id) AS no_subtitle
FROM [dbo].[ViewedList]
WHERE subtitle_id = NULL

-- 16.) Which users have more than 4 profiles
SELECT email AS user_name 
FROM Users
WHERE EXISTS (
    SELECT COUNT(*)
    FROM [dbo].[Profile]
    WHERE [Users].user_id = [Profile].user_id
    GROUP BY user_id
    HAVING COUNT(*) > 1
)

--  17.) Which users have watched the film 'Stenden'
SELECT profile_name AS stenden_lovers
FROM [dbo].[Profile] P
INNER JOIN [dbo].[Viewedlist] V 
ON P.profile_id = V.profile_id
WHERE V.cinema_id = (
    SELECT cinema_id FROM Cinema WHERE cinema_name = 'Stenden'
)

--  18.) How many users prefer horror
SELECT COUNT(profile_id) AS horror_enjoyer 
FROM [dbo].[Profile] P
INNER JOIN [Preference] Pr
ON P.profile_id = Pr.profile_id
WHERE Pr.preference_id = (
    SELECT preference_id 
    FROM GenrePreference Gp
    INNER JOIN Genre G 
    ON Gp.genre_id = G.genre_id
    WHERE UPPER(G.name) LIKE '%HORROR%'  
)


-- 19.) Which users have no preference
SELECT profile_name AS no_preference_user
FROM [Profile] P
LEFT OUTER JOIN [Preference] Pr
ON P.profile_id <> Pr.profile_id

-- SELECT DISTINCT U.user_id AS 'Total number of users without preferences'
-- FROM [User] U
-- LEFT JOIN Profile P
-- ON U.user_id = P.user_id
-- INNER JOIN Preference PR
-- ON P.profile_id = PR.profile_id
-- WHERE P.user_id IS NULL;


-- 20.) Which users are not yet activated
SELECT email AS non_activated_users
FROM [dbo].[User]
WHERE activation_date IS NULL

-- 21.) How many euros are earned per month
SELECT SUM(price) AS stonks_per_month -
CASE
    U.invited_user_id <> NULL
    THEN 2 ELSE 0
END
FROM Subscription S
INNER JOIN User U 
ON S.subscription_id = U.subscription_id

-- 22.) How many extra euros can be earned per month when all users who do not subscribe would take out a subscription


-- 23.) Which users have watched a film with English subtitles


-- 24.) Which users who do not have a UHD subscription have watched a UHD film
SELECT profile_name AS users
FROM [Profile] P
INNER JOIN [Viewedlist] V
ON P.profile_id = V.profile_id
INNER JOIN [User] U
ON P.user_id = U.user_id
WHERE U.subscription_id = (
    SELECT subscription_id
)

-- 25.) What the percentage is per subtitle that has been used to watch films


-- 26.) What the most used subtitle is for each user, excluding the native lamguage


-- 27.) If the most watched genre of a specific user is also a genre that is from their prefferred genre list


-- 28.) Which of the following genres are viewed most on Valentines day? Return a list order by amount of views descending, Romantic Comedy, Action, 
-- Horror, Sci-fi and Anime
SELECT V.COUNT(viewedlist_id) AS views, G.genre_name AS prefered_genre 
FROM [Genre] G
INNER JOIN CinemaGenre CG
ON G.genre_id = CG.genre_id
INNER JOIN [Title] T
ON CG.title_id = T.title_id
INNER JOIN [Viewedlist] V
ON 
WHERE DATE_FORMAT(V.date_watched, '%m%d') = '0214'
ORDER BY views DESC AND