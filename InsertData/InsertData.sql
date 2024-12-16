--INSERCION DE DATOS PARA LAS TABLAS
USE gestion_ordenes_mantenimiento;
-- Talleres
SELECT*FROM talleres

INSERT INTO talleres(codigo_taller,nombre_taller)
VALUES
('MCRU','Chancado'),
('MOVE','Fajas'),
('MGRI','Molinos'),
('MPEB','Pebles'),
('MFLO','Flotación'),
('MFTM','Filtros'),
('MREC','Reclaim');

-- Proveedores
SELECT*FROM proveedores

DBCC CHECKIDENT('proveedores' , RESEED, 0)

DECLARE @counter INT
DECLARE @proveedor VARCHAR (100)
SET @proveedor = 'proveedor'
SET @counter = 1

WHILE @counter < 11
BEGIN
	INSERT INTO proveedores
	VALUES(
		@counter,
		CONCAT (@proveedor,CAST(@counter AS VARCHAR)),
		CONCAT ('2',CONVERT(bigint,ROUND(((99999999999 - 10000000000) * RAND() + 10000000000), 0))))
	SET @counter = @counter+ 1;
END

DELETE FROM proveedores

UPDATE proveedores
	SET nombre_proveedor = 'proveedor1'
	WHERE nombre_proveedor = 'SINAR'

--Tabla Materiales
-- Data importada de Materiales.txt
SELECT*FROM materiales

--Tabla OrdenesTrabajo
-- Data importada de OrdenesMantenimiento.txt
SELECT*FROM talleres
SELECT*FROM ordenes_mantenimiento

--Tabla Existencias
SELECT*FROM existencias

DECLARE @contador INT;
DECLARE @min_id INT;
DECLARE @max_id INT;

SET @min_id = (SELECT MIN(id) FROM materiales);
SET @max_id = (SELECT MAX(id) FROM materiales);
SET @contador = @min_id;


WHILE @contador <= @max_id
BEGIN
INSERT INTO existencias
SELECT
	id AS 'material_id',
	'1000' AS 'codigo_almacen',
	ROUND(RAND()*200,0) AS 'qty_stock'
FROM materiales
WHERE id = @contador
SET @contador = @contador+1
END

UPDATE existencias
SET codigo_almacen = '1001'
WHERE id <=4400

-- Tabla Pedidos
-- Insertado de Pedidos.txt
SELECT*FROM pedidos
SELECT*FROM proveedores
SELECT*FROM ordenes_mantenimiento
SELECT*FROM materiales

-- Tabla Reservas
USE gestion_ordenes_mantenimiento
SELECT*FROM reservas

DECLARE @counter INT
SET @counter = 0

WHILE @counter<=50
BEGIN
INSERT INTO reservas (numero_reserva,orden_mantenimiento_id,material_id,qty_solicitada,qty_retirada,fecha_requerimiento,pedido_id)
SELECT
	CONCAT ('2',CONVERT(bigint,ROUND(((999999 - 100000) * RAND() + 100000), 0))) as 'numero_reserva',
	om.id as 'orden_mantenimiento_id',
	mt.id as 'material_id',
	ROUND(RAND()*10+11,0) as 'qty_solicitada',
	ROUND(RAND()*10,0) as 'qty_retirada',
	DATEADD(DAY, ROUND(RAND() * 90, 0), GETDATE()) AS 'fecha_requerimiento',
	pd.id as 'pedido_id'
FROM ordenes_mantenimiento om
	CROSS JOIN materiales mt
	CROSS JOIN pedidos pd 
ORDER BY NEWID()
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY;
    SET @Counter = @Counter + 1
END


SELECT*FROM pedidos
SELECT*FROM proveedores
SELECT*FROM ordenes_mantenimiento
SELECT*FROM materiales
SELECT*FROM reservas
SELECT*FROM talleres
SELECT*FROM existencias
