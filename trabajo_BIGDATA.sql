CREATE DATABASE CURSOS
GO

USE CURSOS
GO

CREATE TABLE Categorias 
(
    CategoriaID INT PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Slug AS LOWER(REPLACE(Nombre, ' ', '-')) 
)

CREATE TABLE Cursos 
(
    CursoID INT PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Slug AS LOWER(REPLACE(Nombre, ' ', '-')),  
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    Clasificacion AS 
        CASE 
            WHEN PrecioUnitario >= 500 THEN 'Premium'
            WHEN PrecioUnitario >= 200 THEN 'Intermedio'
            ELSE 'Básico'
			END,
    Estado BIT NOT NULL,  
    CategoriaID INT FOREIGN KEY REFERENCES Categorias(CategoriaID)
)

GO

