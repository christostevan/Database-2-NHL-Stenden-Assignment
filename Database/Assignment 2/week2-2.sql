
-- DDL (Data Definition Language) Create user and give permissions
-- User 1, System admin
CREATE LOGIN [admin] WITH PASSWORD=N'admin123', DEFAULT_DATABASE=[Netflix], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER [admin]
GO
CREATE USER [sa] FOR LOGIN [admin]
GO

-- User 2, Math Smith, Chief Data Analyst, can perform DML queries
CREATE LOGIN [login_1] WITH PASSWORD=N'user2', DEFAULT_DATABASE=[Netflix], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
CREATE USER [Math_Smith] FOR LOGIN [login_1]
GO

CREATE ROLE Chief_Data_Analyst
AUTHORIZATION [Math_Smith]
GO

GRANT INSERT, UPDATE, DELETE TO Math_Smith
GO

-- User 3, Mick Worry, Data Analyst, can perform Select, DML queries

CREATE ROLE [Data_Analyst] AUTHORIZATION [Mick_Worry]
GO

GRANT INSERT, UPDATE, DELETE, SELECT TO [Mick_Worry]
GO
-- User 4, Adam Verogue, Data Analyst, can perform Select, DML queries

ALTER ROLE [Data_Analyst] ADD MEMBER [Adam_Verogue]
GO

GRANT INSERT, UPDATE, DELETE, SELECT TO [Adam_Verogue]
GO

-- User 5, Tim Snapps, can perform Select DML queries with the exception of personal and financial data
CREATE USER [Tim_Snapps]
GO

CREATE ROLE [Junio_Data_Analyst] AUTHORIZATION [Tim_Snapps]
GO



-- User 6, Netflix account, cannot perform CRUD operations directly on the database
CREATE USER [Netflix_application] WITHOUT LOGIN
GO
GRANT SELECT TO [Netflix_application] 



  