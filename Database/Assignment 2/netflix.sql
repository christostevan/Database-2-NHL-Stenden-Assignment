-- DCL (Data Control Language) => Making the database and tables
DROP DATABASE IF EXISTS Netflix;
CREATE DATABASE Netflix CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE Netflix;
CREATE TABLE `Netflix`.`User` (
    user_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    user_email VARCHAR(255),
    user_password VARCHAR(255),
    date_of_birth DATE,
    login_attempts TINYINT CHECK(login_attempts <=4),
    is_blocked BOOL NOT NULL,
    activation_date DATETIME,
    subscription_id INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`Profile`(
   	profile_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    profile_name VARCHAR(255),
    date_of_birth DATE,
    photo LONGBLOB,
    user_id INT,
    language_id INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`Preference` (
    preference_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    interested_in_series BOOLEAN,
    minimum_age INT,
    profile_id INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`ViewingClassificationPreference` (
    viewing_classification_id  INT,
    preference_id INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`ViewingClassification` (
    viewing_classifciation_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    viewing_classification_name VARCHAR(255) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`CinemaViewingClassification` (
    cinema_id INT,  
    viewing_classifciation_id INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`GenrePreference` (
    genre_id INT,
    preference_id INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`Genre` (
    genre_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    genre_name VARCHAR(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`CinemaGenre` (
    genre_id INT,
    cinema_id INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`Watchlist` (
    profile_id INT,
    title_id INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`Wacthlater` (
    profile_id INT,
    cinema_id INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`ViewedList` (
    viewed_list_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    date_watched DATE,
    profile_id INT, 
    cinema_id INT,
    subtitle_id INT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`Language` (
    language_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    language_name VARCHAR(200)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`Subtitle` (
    subtitle_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    subtitle_text VARCHAR(255),
    cinema_id INT,
    language_id INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`Cinema` (
    cinema_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    cinema_name VARCHAR(255),
    cinema_description VARCHAR(255),
    duration TIME(0) NULL,
    credits VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`Season` (
    season_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    season_name VARCHAR(250),
    season_description VARCHAR(255),
    season_number INT,
    cinema_id INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`Episode` (
    episode_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    episode_number INT,
    episode_name VARCHAR(255),
    episode_descriotion VARCHAR(255),
    episode_duration TIME(0) NULL,
    season_id INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`CinemaQuality` (
    cinema_id INT,
    quality_id INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`Quality` (
    quality_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    quality_name VARCHAR(10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`SubscriptionQuality` (
    quality_id INT,
    subscription_id INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `Netflix`.`Subscription` (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    subscription_name VARCHAR(20),
    price float(2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

