CREATE DATABASE  IV
GO
USE IV
GO 

CREATE TABLE CARGO(
ID_CARGO INT IDENTITY PRIMARY KEY NOT NULL,
DESCRIPCION VARCHAR (50) NOT NULL, 
)
GO 

CREATE TABLE EMPLEADO
(
ID_EMPLEADO INT IDENTITY PRIMARY KEY NOT NULL,
NOMBRE VARCHAR (50) NOT NULL,
APELLIDOS VARCHAR (50) NOT NULL,
FECHA_DE_NACIMIENTO DATE NOT NULL,
TELEFONO VARCHAR (50) NOT NULL,
EMAIL VARCHAR (50) NOT NULL,
SALARIO DECIMAL (10,2) NOT NULL,
ID_CARGO INT NOT NULL,
FOREIGN KEY (ID_CARGO) REFERENCES  CARGO ( ID_CARGO)
)
GO 

CREATE TABLE CLIENTE 
(
ID_CLIENTE INT IDENTITY PRIMARY KEY NOT NULL,
NOMBRE VARCHAR (50) NOT NULL,
APELLIDOS VARCHAR (50) NOT NULL,
DNI NUMERIC NOT NULL,
FECHA_REGISTRO DATE NOT NULL,
TELEFONO NUMERIC NOT NULL,
EMAIL VARCHAR (50) NOT NULL,
HISTORIAL_COMPRA VARCHAR (50) NOT NULL
)
GO

CREATE TABLE CATEGORIA
(
ID_CATEGORIA INT IDENTITY PRIMARY KEY NOT NULL,
NOMBRE_CATEGORIA VARCHAR(50) NOT NULL,
DESCRIPCION VARCHAR (50) NOT NULL
)
GO

CREATE TABLE PRODUCTO 
(
ID_PRODUCTO INT IDENTITY PRIMARY KEY NOT NULL,
NOMBRE_PRODUCTO VARCHAR(50) NOT NULL,
MARCA VARCHAR(50) NOT NULL,
DESCRIPCION VARCHAR(50) NOT NULL,
ESTADO VARCHAR (50) NOT NULL,
PRECIO_UNITARIO FLOAT NOT NULL,
ID_CATEGORIA INT NOT NULL,
FOREIGN KEY (ID_CATEGORIA) REFERENCES CATEGORIA ( ID_CATEGORIA)
)
GO

CREATE TABLE PRODUCTO_DEFECTUOSO
(
ID_PRODUCTO_DEFECTUOSO INT IDENTITY PRIMARY KEY NOT NULL,
FECHA_DETENCION VARCHAR (50) NOT NULL,
DESCRIPCION VARCHAR (50) NOT NULL,
ID_PRODUCTO INT NOT NULL,
FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO (ID_PRODUCTO),
)
GO

CREATE TABLE PROVEEDOR
(
ID_PROVEEDOR INT IDENTITY PRIMARY KEY NOT NULL,
NOMBRE_PROVEEDOR VARCHAR (50) NOT NULL,
CONTACTO VARCHAR (50) NOT NULL,
EMAIL VARCHAR (50) NOT NULL,
TELEFONO NUMERIC NOT NULL,
DIRECCION VARCHAR (50) NOT NULL,
JIRON VARCHAR (50) NOT NULL,
NUMERO INT NOT NULL
)
GO

CREATE TABLE ORDEN_COMPRA
(
ID_ORDEN_COMPRA INT IDENTITY PRIMARY KEY NOT NULL,
FECHA_PRODUCCION DATE NOT NULL ,
FECHA_CADUCIDAD DATE NOT NULL ,
ID_PROVEEDOR INT NOT NULL,
ID_EMPLEADO INT NOT NULL,
FOREIGN KEY (ID_PROVEEDOR) REFERENCES PROVEEDOR(ID_PROVEEDOR),
FOREIGN KEY (ID_EMPLEADO) REFERENCES EMPLEADO (ID_EMPLEADO),
)
GO

CREATE TABLE LOTE
(
ID_LOTE INT IDENTITY PRIMARY KEY NOT NULL,
FECHA_PRODUCTO DATE NOT NULL,
TOTAL_ORDEN INT NOT NULL,
ID_PRODUCTO INT NOT NULL,
FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO (ID_PRODUCTO)
)
GO

CREATE TABLE PROMOCION
(
ID_PROMOCION INT IDENTITY PRIMARY KEY NOT NULL,
CONDICION VARCHAR (50) NOT NULL,
TIPO VARCHAR (50) NOT NULL,
FECHA_INICIO DATE NOT NULL,
FECHA_FIN DATE NOT NULL,
ID_PRODUCTO INT NOT NULL,
FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO (ID_PRODUCTO)
)
GO

CREATE TABLE DESCUENTO
(
ID_DESCUENTO INT IDENTITY PRIMARY KEY NOT NULL,
NOMBRE VARCHAR (50) NOT NULL,
TIPO VARCHAR (50) NOT NULL,
PORCENTAJE VARCHAR (50) NOT NULL,
FECHA_INICIO DATE NOT NULL,
FECHA_FIN DATE NOT NULL, 
ID_PRODUCTO INT NOT NULL, 
FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO (ID_PRODUCTO) 
)
GO

CREATE TABLE VENTA
(
ID_VENTA INT IDENTITY PRIMARY KEY NOT NULL,
FECHA_VENTA DATE NOT NULL,
METODO_PAGO VARCHAR (50) NOT NULL,
TOTAL FLOAT NOT NULL,
DESCUENTO DECIMAL (19,4) NOT NULL,
ID_EMPLEADO INT NOT NULL,
ID_CLIENTE INT NOT NULL,
FOREIGN KEY (ID_EMPLEADO) REFERENCES EMPLEADO (ID_EMPLEADO),
FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID_CLIENTE),
)
GO

CREATE TABLE DETALLE_VENTA
( 
ID_VENTA INT NOT NULL,
ID_PRODUCTO INT NOT NULL,
CANTIDAD INT NOT NULL,
PRECIO_UNITARIO DECIMAL (19,4) NOT NULL,
SUB_TOTAL AS (CANTIDAD*PRECIO_UNITARIO),
FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO (ID_PRODUCTO),
FOREIGN KEY (ID_VENTA) REFERENCES VENTA (ID_VENTA),
)
GO 

CREATE TABLE DEVOLUCION
(
IDDEVOLUCION INT IDENTITY PRIMARY KEY NOT NULL,
MOTIVO VARCHAR (50) NOT NULL,
FECHA DATE NOT NULL ,
ID_PRODUCTO INT NOT NULL,
ID_CLIENTE INT NOT NULL,
ID_EMPLEADO INT NOT NULL,
ID_VENTA INT NOT NULL,
FOREIGN KEY (ID_PRODUCTO) REFERENCES PRODUCTO (ID_PRODUCTO) ,
FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID_CLIENTE) ,
FOREIGN KEY (ID_EMPLEADO) REFERENCES EMPLEADO (ID_EMPLEADO) ,
FOREIGN KEY (ID_VENTA) REFERENCES VENTA (ID_VENTA) 
)
GO

CREATE TABLE INVENTARIO
(
ID_INVENTARIO INT IDENTITY PRIMARY KEY NOT NULL,
ENTRADAS VARCHAR (50)NOT NULL,
SALIDAS VARCHAR (50)NOT NULL,
FECHA_ACTUALIZACIÓN DATE NOT NULL,
ID_PRODUCTO INT NOT NULL,
FOREIGN KEY (ID_PRODUCTO) REFERENCES  PRODUCTO (ID_PRODUCTO)
)
GO

CREATE TABLE UBICACION 
(
ID_UBICACION INT IDENTITY PRIMARY KEY NOT NULL,
SECCION  VARCHAR (50)NOT NULL,
ESTANTE VARCHAR (50)NOT NULL,
NIVEL INT NOT NULL,
ID_INVENTARIO  INT NOT NULL,
FOREIGN KEY (ID_INVENTARIO) REFERENCES INVENTARIO (ID_INVENTARIO)
)
GO


CREATE TABLE CONDUCTOR 
(
ID_CONDUCTOR INT IDENTITY PRIMARY KEY NOT NULL,
NOMBRE VARCHAR (50) NOT NULL,
TELEFONO VARCHAR (50) NOT NULL,
LICENCIA VARCHAR (50) NOT NULL,
EMAIL VARCHAR (50) NOT NULL
)
GO

CREATE TABLE TRANSPORTE
(
ID_TRANSPORTE INT IDENTITY PRIMARY KEY NOT NULL,
TIPO VARCHAR (50)NOT NULL,
PLACA VARCHAR (50)NOT NULL,
CAPACIDAD VARCHAR (50) NOT NULL,
ID_CONDUCTOR INT NOT NULL,
FOREIGN KEY (ID_CONDUCTOR) REFERENCES CONDUCTOR (ID_CONDUCTOR)
)
GO

CREATE TABLE PEDIDO
(
ID_PEDIDO INT IDENTITY PRIMARY KEY NOT NULL,
DIRECCION VARCHAR (50) NOT NULL,
FECHA_PEDIDO DATE NOT NULL,
FECHA_ENTREGA DATE NOT NULL,
ID_TRANSPORTE INT NOT NULL,
ID_VENTA INT NOT NULL,
FOREIGN KEY (ID_TRANSPORTE) REFERENCES  TRANSPORTE (ID_TRANSPORTE),
FOREIGN KEY (ID_VENTA) REFERENCES  VENTA (ID_VENTA) 
)
GO

CREATE TABLE BOLETA_PEDIDO
(
ID_BOLETA_PEDIDO INT IDENTITY PRIMARY KEY NOT NULL,
METODO_PAGO VARCHAR (50) NOT NULL,
MONTO DECIMAL (19,4) NOT NULL
)
GO
  

-- Insertar registros en la tabla CARGO
INSERT INTO CARGO (DESCRIPCION) VALUES 
('Gerente General'),
('Administrador'),
('Contador'),
('Jefe de Ventas'),
('Asistente de Ventas'),
('Cajero'),
('Analista de Sistemas'),
('Soporte Técnico'),
('Recursos Humanos'),
('Auxiliar de Logística');
go

-- Insertar registros en la tabla EMPLEADO (ID_CARGO supone que existen)
INSERT INTO EMPLEADO (  NOMBRE, APELLIDOS, FECHA_DE_NACIMIENTO, TELEFONO, EMAIL, SALARIO, ID_CARGO) VALUES
(  'Juan', 'Perez', '1990-05-10', '123456789', 'juan.perez@example.com', 2500.00, 1),
(  'Ana', 'Garcia', '1985-08-15', '987654321', 'ana.garcia@example.com', 1800.00, 2),
(  'Carlos', 'Ramirez', '1992-12-20', '456789123', 'carlos.ramirez@example.com', 1600.00, 3),
(  'Sofia', 'Lopez', '1994-03-25', '321654987', 'sofia.lopez@example.com', 1400.00, 4),
(  'Luis', 'Martinez', '1988-11-05', '654987123', 'luis.martinez@example.com', 1500.00, 5),
(  'Pedro', 'Gonzalez', '1987-04-12', '789123456', 'pedro.gonzalez@example.com', 1700.00, 6),
(  'Laura', 'Mendoza', '1993-09-17', '852963741', 'laura.mendoza@example.com', 1600.00, 7),
(  'Mario', 'Lopez', '1991-06-13', '159753486', 'mario.lopez@example.com', 1500.00, 8),
(  'Lucia', 'Torres', '1990-02-14', '753951456', 'lucia.torres@example.com', 1400.00, 9),
(  'Carlos', 'Silva', '1986-07-22', '456321789', 'carlos.silva@example.com', 1200.00, 10);
go

UPDATE EMPLEADO
SET EMAIL = 'juan.perez@gmail.com'
WHERE NOMBRE = 'Juan'
GO

-- Insertar registros en la tabla CLIENTE
INSERT INTO CLIENTE (NOMBRE, APELLIDOS, DNI, FECHA_REGISTRO, TELEFONO, EMAIL, HISTORIAL_COMPRA) VALUES
('Pedro', 'Sanchez', 12345678, '2023-01-15', 123456789, 'pedro.sanchez@example.com', 'Producto A, Producto B'),
('Maria', 'Diaz', 87654321, '2023-02-20', 987654321, 'maria.diaz@example.com', 'Producto C, Producto D'),
('Jorge', 'Martinez', 23456789, '2023-03-12', 456789123, 'jorge.martinez@example.com', 'Producto E, Producto F'),
('Ana', 'Perez', 34567890, '2023-04-25', 321654987, 'ana.perez@example.com', 'Producto G'),
('Lucia', 'Gomez', 45678901, '2023-05-30', 654987123, 'lucia.gomez@example.com', 'Producto H, Producto I'),
('Rafael', 'Mendoza', 56789012, '2023-06-18', 789123456, 'rafael.mendoza@example.com', 'Producto J'),
('Carmen', 'Torres', 67890123, '2023-07-20', 852963741, 'carmen.torres@example.com', 'Producto K, Producto L'),
('Diego', 'Fernandez', 78901234, '2023-08-10', 159753486, 'diego.fernandez@example.com', 'Producto M'),
('Claudia', 'Castro', 89012345, '2023-09-25', 753951456, 'claudia.castro@example.com', 'Producto N'),
('Luis', 'Lopez', 90123456, '2023-10-05', 456321789, 'luis.lopez@example.com', 'Producto O, Producto P');
go

-- Insertar registros en la tabla CATEGORIA
INSERT INTO CATEGORIA (NOMBRE_CATEGORIA, DESCRIPCION) VALUES
('Electrónica', 'Dispositivos electrónicos'),
('Muebles', 'Muebles para el hogar'),
('Ropa', 'Ropa y accesorios'),
('Juguetes', 'Juguetes para niños'),
('Deportes', 'Artículos deportivos'),
('Libros', 'Libros y revistas'),
('Hogar', 'Artículos para el hogar'),
('Computación', 'Componentes y accesorios informáticos'),
('Jardinería', 'Herramientas de jardinería'),
('Mascotas', 'Accesorios para mascotas');
go

-- Insertar registros en la tabla PRODUCTO (suponiendo ID_CATEGORIA existente)
INSERT INTO PRODUCTO (NOMBRE_PRODUCTO, MARCA, DESCRIPCION, ESTADO, PRECIO_UNITARIO, ID_CATEGORIA) VALUES
('Televisor LED', 'Samsung', 'Televisor LED 40"', 'Disponible', 1200.00, 1),
('Sofá', 'IKEA', 'Sofá de 3 plazas', 'Disponible', 300.00, 2),
('Camisa', 'Zara', 'Camisa casual', 'Disponible', 40.00, 3),
('Robot', 'Hasbro', 'Robot interactivo', 'Disponible', 50.00, 4),
('Pelota', 'Adidas', 'Pelota de fútbol', 'Disponible', 20.00, 5),
('Libro', 'Planeta', 'Libro de aventura', 'Disponible', 15.00, 6),
('Lámpara', 'Philips', 'Lámpara de escritorio', 'Disponible', 25.00, 7),
('Teclado', 'Logitech', 'Teclado inalámbrico', 'Disponible', 30.00, 8),
('Rastrillo', 'Truper', 'Rastrillo de jardín', 'Disponible', 10.00, 9),
('Collar para perros', 'Petco', 'Collar de cuero', 'Disponible', 12.00, 10);
go

-- Insertar registros en la tabla PROVEEDOR
INSERT INTO PROVEEDOR (NOMBRE_PROVEEDOR, CONTACTO, EMAIL, TELEFONO, DIRECCION, JIRON, NUMERO) VALUES
('Distribuidora Global', 'Maria Ramirez', 'contacto@global.com', 123456789, 'Av. Principal', 'Jiron Uno', 101),
('Tech Supplies', 'Carlos Mejia', 'carlos@techsupplies.com', 234567890, 'Calle Secundaria', 'Jiron Dos', 202),
('Moda Total', 'Laura Diaz', 'laura@modatotal.com', 345678901, 'Calle Moda', 'Jiron Tres', 303),
('ElectroHouse', 'Pedro Alva', 'pedro@electrohouse.com', 456789012, 'Av. Tecnologica', 'Jiron Cuatro', 404),
('PetWorld', 'Ana Torres', 'ana@petworld.com', 567890123, 'Calle Mascotas', 'Jiron Cinco', 505),
('Libros & Co', 'Jorge Hernandez', 'jorge@librosyco.com', 678901234, 'Av. Cultura', 'Jiron Seis', 606),
('Muebles Estilo', 'Sofia Castro', 'sofia@mueblesestilo.com', 789012345, 'Calle Diseño', 'Jiron Siete', 707),
('Jardin Verde', 'Luis Perez', 'luis@jardinverde.com', 890123456, 'Av. Flores', 'Jiron Ocho', 808),
('SportsMania', 'Rafael Rios', 'rafael@sportsmania.com', 901234567, 'Calle Deportes', 'Jiron Nueve', 909),
('Casa Blanca', 'Marta Lozano', 'marta@casablanca.com', 1023456789, 'Av. Hogar', 'Jiron Diez', 1001);
go

-- Insertar registros en la tabla ORDEN_COMPRA (suponiendo ID_PROVEEDOR e ID_EMPLEADO existentes)
INSERT INTO ORDEN_COMPRA (FECHA_PRODUCCION, FECHA_CADUCIDAD, ID_PROVEEDOR, ID_EMPLEADO) VALUES
('2023-01-01', '2024-01-01', 1, 1),
('2023-02-10', '2024-02-10', 2, 2),
('2023-03-15', '2024-03-15', 3, 3),
('2023-04-20', '2024-04-20', 4, 4),
('2023-05-25', '2024-05-25', 5, 5),
('2023-06-30', '2024-06-30', 6, 6),
('2023-07-05', '2024-07-05', 7, 7),
('2023-08-10', '2024-08-10', 8, 8),
('2023-09-15', '2024-09-15', 9, 9),
('2023-10-20', '2024-10-20', 10, 10);
go

-- Insertar registros en la tabla LOTE (suponiendo ID_PRODUCTO existente)
INSERT INTO LOTE (FECHA_PRODUCTO, TOTAL_ORDEN, ID_PRODUCTO) VALUES
('2023-01-15', 100, 1),
('2023-02-18', 150, 2),
('2023-03-20', 200, 3),
('2023-04-25', 250, 4),
('2023-05-30', 300, 5),
('2023-06-05', 350, 6),
('2023-07-10', 400, 7),
('2023-08-15', 450, 8),
('2023-09-20', 500, 9),
('2023-10-25', 550, 10);
go

-- Insertar registros en la tabla PROMOCION (suponiendo ID_PRODUCTO existente)
INSERT INTO PROMOCION (CONDICION, TIPO, FECHA_INICIO, FECHA_FIN, ID_PRODUCTO) VALUES
('Compra mínima de $50', 'Descuento', '2023-01-01', '2023-01-31', 1),
('2x1 en artículos seleccionados', 'Oferta', '2023-02-01', '2023-02-28', 2),
('Envío gratis en compras mayores a $100', 'Envío', '2023-03-01', '2023-03-31', 3),
('Descuento de $10 en primera compra', 'Descuento', '2023-04-01', '2023-04-30', 4),
('Descuento de 20%', 'Descuento', '2023-05-01', '2023-05-31', 5),
('Regalo sorpresa por cada compra', 'Regalo', '2023-06-01', '2023-06-30', 6),
('3 cuotas sin interés', 'Financiación', '2023-07-01', '2023-07-31', 7),
('Cupones de descuento', 'Cupón', '2023-08-01', '2023-08-31', 8),
('Compra y gana', 'Sorteo', '2023-09-01', '2023-09-30', 9),
('Regalo adicional en compras mayores a $200', 'Regalo', '2023-10-01', '2023-10-31', 10);
go

-- Insertar registros en la tabla DESCUENTO (suponiendo ID_PRODUCTO existente)
INSERT INTO DESCUENTO (NOMBRE, TIPO, PORCENTAJE, FECHA_INICIO, FECHA_FIN, ID_PRODUCTO) VALUES
('Descuento Verano', 'Estacional', '10%', '2023-01-01', '2023-02-28', 1),
('Descuento Invierno', 'Estacional', '15%', '2023-03-01', '2023-04-30', 2),
('Descuento Aniversario', 'Evento', '20%', '2023-05-01', '2023-06-30', 3),
('Descuento para Miembros', 'Miembro', '25%', '2023-07-01', '2023-08-31', 4),
('Descuento Navidad', 'Temporada', '30%', '2023-09-01', '2023-10-31', 5),
('Descuento CyberMonday', 'Evento', '35%', '2023-11-01', '2023-11-30', 6),
('Descuento por Compra Mayorista', 'Mayorista', '40%', '2023-12-01', '2023-12-31', 7),
('Descuento de Fin de Temporada', 'Temporada', '15%', '2024-01-01', '2024-02-28', 8),
('Descuento de Primavera', 'Estacional', '10%', '2024-03-01', '2024-04-30', 9),
('Descuento de Otoño', 'Estacional', '20%', '2024-05-01', '2024-06-30', 10);
go

-- Insertar registros en la tabla VENTA (suponiendo ID_EMPLEADO e ID_CLIENTE existentes)
INSERT INTO VENTA (FECHA_VENTA, METODO_PAGO, TOTAL, DESCUENTO, ID_EMPLEADO, ID_CLIENTE) VALUES
('2023-01-10', 'Tarjeta', 200.00, 10.00, 1, 1),
('2023-02-14', 'Efectivo', 150.00, 5.00, 2, 2),
('2023-03-20', 'Transferencia', 300.00, 20.00, 3, 3),
('2023-04-25', 'Tarjeta', 400.00, 15.00, 4, 4),
('2023-05-30', 'Efectivo', 120.00, 0.00, 5, 5),
('2023-06-05', 'Tarjeta', 210.00, 10.50, 6, 6),
('2023-07-12', 'Transferencia', 250.00, 5.00, 7, 7),
('2023-08-18', 'Efectivo', 175.00, 8.75, 8, 8),
('2023-09-22', 'Tarjeta', 225.00, 11.25, 9, 9),
('2023-10-29', 'Efectivo', 275.00, 13.75, 10, 10);
go

-- Insertar registros en la tabla DETALLE_VENTA (suponiendo ID_PRODUCTO e ID_VENTA existentes)
INSERT INTO DETALLE_VENTA (ID_VENTA, ID_PRODUCTO, CANTIDAD, PRECIO_UNITARIO) VALUES
(1, 1, 2, 100.00),
(2, 2, 1, 150.00),
(3, 3, 3, 100.00),
(4, 4, 4, 100.00),
(5, 5, 1, 120.00),
(6, 6, 2, 105.00),
(7, 7, 3, 125.00),
(8, 8, 1, 175.00),
(9, 9, 5, 45.00),
(10, 10, 4, 275.00);
go

-- Insertar registros en la tabla DEVOLUCION (suponiendo ID_PRODUCTO, ID_CLIENTE, ID_EMPLEADO e ID_VENTA existentes)
INSERT INTO DEVOLUCION (MOTIVO, FECHA, ID_PRODUCTO, ID_CLIENTE, ID_EMPLEADO, ID_VENTA) VALUES
('Defecto de fábrica', '2023-01-15', 1, 1, 1, 1),
('Producto dañado', '2023-02-20', 2, 2, 2, 2),
('No cumple expectativas', '2023-03-22', 3, 3, 3, 3),
('Error en pedido', '2023-04-18', 4, 4, 4, 4),
('No funciona correctamente', '2023-05-14', 5, 5, 5, 5),
('Daños por transporte', '2023-06-10', 6, 6, 6, 6),
('Cambio de talla', '2023-07-12', 7, 7, 7, 7),
('Error de modelo', '2023-08-15', 8, 8, 8, 8),
('Entrega incorrecta', '2023-09-20', 9, 9, 9, 9),
('Falla técnica', '2023-10-25', 10, 10, 10, 10);
go
 

-- Insertar registros en la tabla INVENTARIO (suponiendo ID_PRODUCTO existente)
INSERT INTO INVENTARIO (ENTRADAS, SALIDAS, FECHA_ACTUALIZACIÓN, ID_PRODUCTO) VALUES
('Entrada inicial', '0', '2023-01-05', 1),
('Entrada mensual', '50', '2023-02-10', 2),
('Ajuste por venta', '10', '2023-03-15', 3),
('Reposición', '20', '2023-04-20', 4),
('Inventario físico', '5', '2023-05-25', 5),
('Venta especial', '15', '2023-06-30', 6),
('Devoluciones', '2', '2023-07-05', 7),
('Ajuste negativo', '8', '2023-08-10', 8),
('Entrada estacional', '30', '2023-09-15', 9),
('Corrección de stock', '12', '2023-10-20', 10);
go

-- Insertar registros en la tabla UBICACION (suponiendo ID_INVENTARIO existente)
INSERT INTO UBICACION (SECCION, ESTANTE, NIVEL, ID_INVENTARIO) VALUES
('A', 'Estante 1', 1, 1),
('A', 'Estante 2', 2, 2),
('B', 'Estante 1', 3, 3),
('B', 'Estante 2', 1, 4),
('C', 'Estante 1', 2, 5),
('C', 'Estante 2', 3, 6),
('D', 'Estante 1', 1, 7),
('D', 'Estante 2', 2, 8),
('E', 'Estante 1', 3, 9),
('E', 'Estante 2', 1, 10);
go

-- Insertar registros en la tabla CONDUCTOR
INSERT INTO CONDUCTOR (NOMBRE, TELEFONO, LICENCIA, EMAIL) VALUES
('Carlos Paredes', '987654321', 'B001', 'carlos.paredes@email.com'),
('Luis Suárez', '987654322', 'B002', 'luis.suarez@email.com'),
('Maria López', '987654323', 'B003', 'maria.lopez@email.com'),
('Jose García', '987654324', 'B004', 'jose.garcia@email.com'),
('Ana Pérez', '987654325', 'B005', 'ana.perez@email.com'),
('David Rivera', '987654326', 'B006', 'david.rivera@email.com'),
('Lucía Gómez', '987654327', 'B007', 'lucia.gomez@email.com'),
('Roberto Torres', '987654328', 'B008', 'roberto.torres@email.com'),
('Carla Mejía', '987654329', 'B009', 'carla.mejia@email.com'),
('Sergio Díaz', '987654330', 'B010', 'sergio.diaz@email.com');
go

-- Insertar registros en la tabla TRANSPORTE (suponiendo ID_CONDUCTOR existente)
INSERT INTO TRANSPORTE (TIPO, PLACA, CAPACIDAD, ID_CONDUCTOR) VALUES
('Camión', 'ABC-123', '2000kg', 1),
('Furgoneta', 'DEF-456', '1500kg', 2),
('Camión', 'GHI-789', '3000kg', 3),
('Auto', 'JKL-012', '500kg', 4),
('Camioneta', 'MNO-345', '1000kg', 5),
('Moto', 'PQR-678', '150kg', 6),
('Camioneta', 'STU-901', '800kg', 7),
('Camión', 'VWX-234', '2500kg', 8),
('Furgoneta', 'YZA-567', '1800kg', 9),
('Camioneta', 'BCD-890', '1200kg', 10);
go

-- Insertar registros en la tabla PEDIDO (suponiendo ID_TRANSPORTE e ID_VENTA existentes)
INSERT INTO PEDIDO (DIRECCION, FECHA_PEDIDO, FECHA_ENTREGA, ID_TRANSPORTE, ID_VENTA) VALUES
('Av. Principal 100', '2023-01-01', '2023-01-05', 1, 1),
('Calle Secundaria 200', '2023-02-01', '2023-02-05', 2, 2),
('Av. Industrial 300', '2023-03-01', '2023-03-05', 3, 3),
('Calle Comercio 400', '2023-04-01', '2023-04-05', 4, 4),
('Av. Tecnológica 500', '2023-05-01', '2023-05-05', 5, 5),
('Calle Central 600', '2023-06-01', '2023-06-05', 6, 6),
('Av. Empresarial 700', '2023-07-01', '2023-07-05', 7, 7),
('Calle Nueva 800', '2023-08-01', '2023-08-05', 8, 8),
('Av. Expansión 900', '2023-09-01', '2023-09-05', 9, 9),
('Calle Horizonte 1000', '2023-10-01', '2023-10-05', 10, 10);
GO

-- Insertar registros en la tabla BOLETA_PEDIDO
INSERT INTO BOLETA_PEDIDO (METODO_PAGO, MONTO) VALUES
('Tarjeta', 250.00),
('Efectivo', 150.00),
('Transferencia', 300.00),
('Tarjeta', 400.00),
('Efectivo', 120.00),
('Tarjeta', 210.00),
('Transferencia', 250.00),
('Efectivo', 175.00),
('Tarjeta', 225.00),
('Efectivo', 275.00);
GO
SELECT *
FROM EMPLEADO
GO

