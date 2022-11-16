-- Assign PK, FK, Constraints and Referential Integrity
ALTER TABLE [dbo].[Cinema]
ADD CONSTRAINT pk_Cinema_id PRIMARY KEY CLUSTERED(cinema_id)

ALTER TABLE [dbo].[Season]
ADD CONSTRAINT fk_season_id PRIMARY KEY (season_id),
CONSTRAINT fk_cinema_id FOREIGN KEY REFERENCES Cinema(cinema_id) ON UPDATE CASCADE ON DELETE CASCADE

ALTER TABLE [dbo].[Episode]
ADD PRIMARY KEY (episode_id),
CONSTRAINT fk_cinema_id FOREIGN KEY REFERENCES Season(season_id) ON UPDATE CASCADE ON DELETE CASCADE

ALTER TABLE [dbo].[CinemaQuality]
ADD FOREIGN KEY (cinema_id) REFERENCES Cinema(cinema_id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (quality_id) REFERENCES Quality(quality_id) ON UPDATE CASCADE ON DELETE CASCADE

ALTER TABLE [dbo].[Subscription]
ADD PRIMARY KEY(subscription_id);

ALTER TABLE [dbo].[CinemaViewingClassification]
ADD FOREIGN KEY (cinema_id) REFERENCES Cinema(cinema_id) ON UPDATE CASCADE ON DELETE CASCADE

ALTER TABLE 

ALTER TABLE [dbo].[SubscriptionQuality]
ADD FOREIGN KEY (quality_id) REFERENCES Quality(quality_id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (subscription_id) REFERENCES Subscription(subscription_id) ON UPDATE CASCADE ON DELETE CASCADE

ALTER TABLE [dbo].[Quality]
ADD PRIMARY KEY(quality_id)

ALTER TABLE [dbo].[GenrePreference]
ADD FOREIGN KEY (genre_id) REFERENCES Genre(genre_id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (preference_id) REFERENCES Preference(preference_id) ON UPDATE CASCADE ON DELETE CASCADE

ALTER TABLE [dbo].[Genre]
ADD PRIMARY KEY(genre_id),
UNIQUE(genre_name)
GO

ALTER TABLE [dbo].[ViewingClassificationPreference]
ADD CONSTRAINT fk_classification_id FOREIGN KEY REFERENCES ViewingClassification(viewing_classifciation_id) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_


ALTER TABLE [dbo].[ViewingClassification]
ADD PRIMARY KEY(viewing_classifciation_id)

    -- User table, if a user is created and is not assigned to any subscription then it would be assumed that the specific user doesn't have a subcription yet
ALTER TABLE [dbo].[User] ALTER COLUMN user_email VARCHAR(255) NOT NULL;
ALTER TABLE [dbo].[User] ALTER COLUMN user_password VARCHAR(255) NOT NULL;
ALTER TABLE [dbo].[User]
ADD  PRIMARY KEY (user_id),
CONSTRAINT fk_user_subscription_id FOREIGN KEY(subscription_id) REFERENCES Subscription(subscription_id),
CONSTRAINT df_user_subscription_id DEFAULT 0 FOR subscription_id,
CHECK(login_attempts <=4 AND login_attempts >= 0),

GO

ALTER TABLE [dbo].[Profile]
ADD CONSTRAINT pk_profile_profileid PRIMARY KEY (profile_id),
FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE ON UPDATE NO ACTION

    -- If a genre is deleted from the Genre table then a cinema doesn't belong to that genre anymore, 
    -- if a cinema is deleted from the Cinema table then it will be not stored in CinemaGenre table anymore
ALTER TABLE [dbo].[CinemaGenre]
ADD CONSTRAINT fk_CinemaGenre_genre_id FOREIGN KEY (genre_id) REFERENCES Genre(genre_id) ON DELETE CASCADE
ADD CONSTRAINT fk_CinemaGenre_cinema_id FOREIGN KEY (cinema_id) REFERENCES Cinema(cinema_id) ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Language]
ADD PRIMARY KEY (language_id)

ALTER TABLE [dbo].[Subtitle]
ADD PRIMARY KEY(subtitle_id)

ALTER TABLE [dbo].[WatchList]
ADD FOREIGN KEY (profile_id) REFERENCES Profile(profile_id) ON UPDATE CASCADE ON DELETE CASCADE
FOREIGN KEY (title_id) REFERENCES Cinema(cinema_id) ON UPDATE CASCADE ON DELETE CASCADE

ALTER TABLE [dbo].[WatchLater]
ADD FOREIGN KEY (profile_id) REFERENCES Profile(profile_id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (cinema_id) REFERENCES Cinema(cinema_id) ON UPDATE CASCADE ON DELETE CASCADE

ALTER TABLE [dbo].[ViewiedList]
ADD FOREIGN KEY (profile_id) REFERENCES Profile(profile_id) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (cinema_id) REFERENCES Cinema(cinema_id) ON UPDATE CASCADE ON DELETE CASCADE




--  Indexes
    -- This clustered index will sort all the cinema the Netflix has from primary id and its cinema name on asceding order
CREATE CLUSTERED INDEX IX__Cinema
ON [dbo].[Cinema] (cinema_name ASC)


-- View 1, for all of the Cinema that is a series, show how many season, episode, and total duration it has
CREATE VIEW view_series
AS
SELECT C.cinema_name AS series_name, COUNT(S.season_id) AS seasons, COUNT(E.episode_id) AS episodes, total_minutes = SUM(DATEDIFF(HOUR, '0:00:00', E.episode_duration))
FROM Cinema C
WHERE C.cinema_id = (
    SELECT cinema_id FROM [Season] S
    WHERE S.season_id = (
        SELECT season_id FROM [Episode] E
    )
)
GROUP BY series_name
        -- ORDER BY seasons ASC, episodes DESC

-- View 2, for all the users that have subscription, show how many profiles they have along with how many cinemas are in their watch-later list
CREATE VIEW vw_user_subscription
AS
SELECT U.user_id, COUNT(P.profile_id) AS 'Number of Profiles' , COUNT(W.title_id) AS 'Titles on Watchlist'
FROM [User] U
LEFT JOIN Profile P
ON U.user_id = P.user_id
LEFT JOIN Watchlist W
ON P.profile_id = W.profile_id
WHERE U.subscription_id IS NOT NULL
GROUP BY U.user_id


-- Stored Procedure 1, Select all the cinemas which are a tv series from how many episodes and seasons they currently have
CREATE PROCEDURE spGetTvSeriesBasedOnEpisodes&Seasons
@season INT,
@episode INT
AS
BEGIN
    SELECT cinema_name AS tv_series, COUNT(S.season_id) AS seasons, COUNT(E.episode_id) AS episodes
    FROM [Netflix].[dbo].[Cinema] C
    INNER JOIN [Netflix].[dbo].[Season] S
    ON C.cinema_id = S.
    INNER JOIN [Netflix].[dbo].[Episode] E
    ON 
    E.season_id = S.season_id
    WHERE (seasons = @season AND episodes = @episode)
    GROUP BY cinema_name
    ORDER BY cinema_name ASC
END

-- Stored Procedure 2, For each movie, count how many available subtitles and available qualities
CREATE PROC
AS
BEGIN
    SELECT C.cinema_id, COUNT(CQ.cinema_id) AS 'Available Qualities', COUNT(S.cinema_id) AS 'Available Subtitles'
    FROM Subtitle S
    RIGHT JOIN Cinema C
    ON S.cinema_id = C.cinema_id
    INNER JOIN CinemaQuality CQ
    ON C.cinema_id = CQ.cinema_id
    GROUP BY C.cinema_id
END
-- Trigger 1, Checking when User has more than 3 failed attempts then automatically blocks his account
CREATE TRIGGER tr_check_login_attempts
ON [dbo].[User]
FOR UPDATE
BEGIN
    DECLARE @Id INT,
    @login INT;
    SELECT @Id = user_id, @login = login_attempts FROM INSERTED;
    SELECT @login;
    IF @login = 4
    BEGIN
        UPDATE [Netflix].[dbo].[User]
        SET is_blocked = 1;
    END
END

-- Trigger 2, Checking when the movie is watched, it will removed from the Watch Later list and added in viewed list
CREATE TRIGGER 
ON [Netflix].[dbo].[ViewedList]
FOR UPDATE
AS
BEGIN
    DECLARE @Id INT;

    SELECT *
    INTO #TempTable
    FROM INSERTED

    WHILE (EXISTS (SELECT viewed_id FROM #TempTable))
    BEGIN
        SELECT TOP 1 @Id = cinema_id 
        FROM #TempTable;

        DELETE FROM [Netflix].[dbo].[WatchLater]
        WHERE cinema_id = @Id;  
    END
END

