/**
PROCEDIMIENTOS ALMACENADOS (STORED PROCEDURE)
*/
/**
Acciones CRUD para un registro en una tabla de la BD
  Create  -> INSERT
  Read    -> SELECT
  Update  -> UPDATE
  Delete  -> DELETE
*/

USE master
go

CREATE DATABASE bdadb7365
GO

Use bdadb7365
GO

CREATE TABLE University(
    UniversityID INT IDENTITY PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(100) NOT NULL,
	City NVARCHAR (50) NOT NULL,
)

CREATE TABLE Student(
    StudentID INTEGER IDENTITY PRIMARY KEY NOT NULL,
	Code VARCHAR (10) NOT NULL,
	IdCard VARCHAR (15) NOT NULL, -- DNI/ CE
	LastName NVARCHAR (50) NOT NULL,
	FirstName NVARCHAR (50) NOT NULL,
	Gender CHAR (1) NOT NULL,-- S/C/V/D/F
	MaritalStatus CHAR (1) NOT NULL,
	BirthDate DATE NOT NULL,
	EnrollmentDate DATE NOT NULL,
	UniversityID INT FOREIGN KEY REFERENCES University(UniversityId)
)

INSERT INTO University (Name , City) VALUES ('UPN','Cajamarca,Perú'),
                                            ('UNI','LIMA,Perú'),
											('UNMSM','LIMA,Perú')
SELECT *
FROM University
GO

CREATE PROCEDURE sp_ListarUniversidades
AS

SELECT UniversityID ,[Name], City FROM University
GO

EXECUTE sp_ListarUniversidades
EXEC sp_ListarUniversidades
GO

sp_ListarUniversidades
GO

CREATE PROCEDURE sp_ListarUniversidadesPorNombre
@nombre VARCHAR (50)
AS

SELECT UniversityID, [Name], City
FROM University

WHERE [Name] LIKE CONCAT ('%',@nombre,'%')
GO

EXEC sp_ListarUniversidadesPorNombre 'UN'
GO

)




