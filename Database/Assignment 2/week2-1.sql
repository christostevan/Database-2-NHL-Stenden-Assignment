-- DCL (Data Control Language) => Making the database and tables
DROP DATABASE IF EXISTS Netflix
CREATE DATABASE Netflix
GO

USE Netflix
CREATE TABLE [Netflix].[dbo].[User] (
    user_id INT PRIMARY KEY IDENTITY(1, 1) NOT NULL,
    user_email VARCHAR(255),
    user_password VARCHAR(255),
    date_of_birth DATE,
    login_attempts TINYINT NULL,
    is_blocked BIT NOT NULL,
    activation_date DATE NULL,
    subscription_id INT NULL
)

CREATE TABLE [Netflix].[dbo].[Profile] (
    profile_id INT IDENTITY(1, 1) NOT NULL,
    profile_name VARCHAR(255),
    date_of_birth DATE,
    photo IMAGE NULL,
    user_id INT,
    language_id INT
)

CREATE TABLE [Netflix].[dbo].[Preference] (
    preference_id INT IDENTITY(1, 1) NOT NULL,
    interested_in_series BIT,
    minimum_age INT,
    profile_id INT
)

CREATE TABLE [Netflix].[dbo].[ViewingClassificationPreference] (
    viewing_classification_id INT,
    preference_id INT
)

CREATE TABLE [Netflix].[dbo].[ViewingClassification] (
    viewing_classifciation_id INT IDENTITY(1, 1) NOT NULL,
    viewing_classification_name VARCHAR(255) 
)

CREATE TABLE [Netflix].[dbo].[CinemaViewingClassification] (
    cinema_id INT,  
    viewing_classifciation_id INT
)

CREATE TABLE [Netflix].[dbo].[GenrePreference] (
    genre_id INT,
    preference_id INT
)

CREATE TABLE [Netflix].[dbo].[Genre] (
    genre_id INT IDENTITY(1, 1) NOT NULL,
    genre_name VARCHAR(200)
)

CREATE TABLE [Netflix].[dbo].[CinemaGenre] (
    genre_id INT,
    cinema_id INT
)

CREATE TABLE [Netflix].[dbo].[Watchlist] (
    profile_id INT,
    title_id INT
)

CREATE TABLE [Netflix].[dbo].[Wacthlater] (
    profile_id INT,
    cinema_id INT
)

CREATE TABLE [Netflix].[dbo].[ViewedList] (
    viewed_list_id INT IDENTITY(1, 1) NOT NULL,
    date_watched DATE,
    profile_id INT, 
    cinema_id INT,
    subtitle_id INT NULL
)

CREATE TABLE [Netflix].[dbo].[Language] (
    language_id INT IDENTITY(1, 1) NOT NULL,
    language_name VARCHAR(200)
)

CREATE TABLE [Netflix].[dbo].[Subtitle] (
    subtitle_id INT IDENTITY(1, 1) NOT NULL,
    subtitle_text VARCHAR(255),
    cinema_id INT,
    language_id INT
)

CREATE TABLE [Netflix].[dbo].[Cinema] (
    cinema_id INT IDENTITY(1, 1) NOT NULL,
    cinema_name VARCHAR(255),
    cinema_description VARCHAR(255),
    duration TIME(0) NULL,
    credits VARCHAR(255)
)

CREATE TABLE [Netflix].[dbo].[Season] (
    season_id INT IDENTITY(1, 1) NOT NULL,
    season_name VARCHAR(250),
    season_description VARCHAR(255),
    season_number INT,
    cinema_id INT
)

CREATE TABLE [Netflix].[dbo].[Episode] (
    episode_id INT IDENTITY(1, 1) NOT NULL,
    episode_number INT,
    episode_name VARCHAR(255),
    episode_descriotion VARCHAR(255),
    episode_duration TIME(0) NULL,
    season_id INT
)

CREATE TABLE [Netflix].[dbo].[CinemaQuality] (
    cinema_id INT,
    quality_id INT
)

CREATE TABLE [Netflix].[dbo].[Quality] (
    quality_id INT IDENTITY(1, 1) NOT NULL,
    quality_name VARCHAR(10)
)

CREATE TABLE [Netflix].[dbo].[SubscriptionQuality] (
    quality_id INT,
    subscription_id INT
)

CREATE TABLE [Netflix].[dbo].[Subscription] (
    subscription_id INT IDENTITY(1, 1) NOT NULL,
    subscription_name VARCHAR(20),
    price float(2)
)


