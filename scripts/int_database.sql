/*
Create Database and Schemas
====================================
Script Purpose:
  This Script creates a new database named 'DWProject' after checking if it already exists.
  If the database exists, it is droped and recreated. Additonally, the script sets up three schemas within
  the database: 'bronze', 'Silver' and 'gold'

WARNING:
  Running this scripts eill drop the entire 'DWProject' databse if it exists.
  All data in the database will be permanently deleted. Proceed with caution and ensure you have proper backups before this script.
 */


USE master;
GO

--Drop and Recreate the 'DWProject' Database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DWProject')
BEGIN
  ALTER DATABASE DWProject SET SINGLE_USER With ROLLBACK IMMEDIATE;
END;
GO

---Create the 'DWProject' database
CREATE DATABASE DWProject;

USE DWProject;
GO

--Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
