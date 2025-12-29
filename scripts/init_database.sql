/* 
===========================
Create Database and Schemas
===========================
Script Purpose:
	This Script creates a new database named "Datawarehouse" after checking if it already exists.
	If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas within the
	database: bronze,silver and gold.
*/

USE Master;
GO

--Drop and recreate the 'DataWarehouse' Database
If Exists (select 1 from sys.databases Where name= 'DataWarehouse')
Begin
	Alter DATABASE DataWarehouse set single_user with rollback immediate;
	drop database datawarehouse;
End;
Go

--Creating the 'DataWarehouse' database and schemas
Create Database DataWarehouse;
Go

USE DataWarehouse;
Go

Create Schema bronze;
Go

Create Schema silver;
Go

Create Schema gold;
Go
