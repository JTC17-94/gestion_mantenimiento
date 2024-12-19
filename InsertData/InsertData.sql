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

--DBCC CHECKIDENT('proveedores' , RESEED, 0)

DECLARE @counter INT
DECLARE @proveedor VARCHAR (255)
SET @proveedor = 'proveedor'
SET @counter = 1

WHILE @counter <= 10
BEGIN
	INSERT INTO proveedores
	VALUES(
		@counter,
		CONCAT (@proveedor,CAST(@counter AS VARCHAR)),
		CONCAT ('2',CONVERT(bigint,ROUND(((99999999999 - 10000000000) * RAND() + 10000000000), 0))))
	SET @counter = @counter+ 1;
END


UPDATE proveedores
	SET nombre_proveedor = CASE
		WHEN ID=1 THEN 'CCI'
		WHEN ID=2 THEN 'BRAY'
		WHEN ID=3 THEN 'ADOLPHUS'
		WHEN ID=4 THEN 'SKF'
		WHEN ID=5 THEN 'BC BEARING'
		WHEN ID=6 THEN 'CASSADO'
		WHEN ID=7 THEN 'METSO'
		WHEN ID=8 THEN 'FLS'
		WHEN ID=9 THEN 'VULCO'
		WHEN ID=10 THEN 'ITT'
		ELSE nombre_proveedor
	END



--Tabla Materiales
-- Data importada de Materiales.txt
SELECT*FROM materiales

--Tabla OrdenesTrabajo
-- Data importada de OrdenesMantenimiento.txt
SELECT*FROM talleres
SELECT*FROM ordenes_mantenimiento
-- Agregamos cantidad de personas y numero de horas
DECLARE @contador INT;
DECLARE @min_id INT;
DECLARE @max_id INT;

SET @min_id = (SELECT MIN(id) FROM materiales);
SET @max_id = (SELECT MAX(id) FROM materiales);
SET @contador = @min_id;

WHILE @contador <= @max_id
BEGIN

	UPDATE ordenes_mantenimiento
	SET qty_personas = ROUND(RAND()*4+1,0),
		numero_horas = ROUND(RAND()*9+1,0)
	WHERE id = @contador;

	SET @contador = @contador+1;
END;


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
	ROUND(RAND()*50,0) AS 'qty_stock'
FROM materiales
WHERE id = @contador
SET @contador = @contador+1
END

UPDATE existencias
SET codigo_almacen = CASE
	WHEN id <1100 THEN '1001'
	WHEN id <1400 THEN '1002'
	ELSE codigo_almacen
END


-- Tabla Pedidos
-- Insertado de Pedidos.txt
SELECT*FROM pedidos
SELECT*FROM proveedores
SELECT*FROM ordenes_mantenimiento
SELECT*FROM materiales

DECLARE @contador INT;
DECLARE @min_id INT;
DECLARE @max_id INT;
DECLARE @qty_pedido INT;

SET @min_id = (SELECT MIN(id) FROM pedidos);
SET @max_id = (SELECT MAX(id) FROM pedidos);
SET @contador = @min_id;

WHILE @contador <= @max_id
BEGIN
	SELECT @qty_pedido = qty_pedido
	FROM pedidos
	WHERE id = @contador

UPDATE pedidos
	SET qty_pendiente_entrega = FLOOR(RAND() * @qty_pedido) 
	WHERE id = @contador
	
	SET @contador = @contador+1
END;

-- Tabla Reservas
USE gestion_ordenes_mantenimiento
SELECT*FROM reservas
--DELETE FROM reservas
DECLARE @counter INT
SET @counter = 1

WHILE @counter<=100
BEGIN
INSERT INTO reservas (numero_reserva,orden_mantenimiento_id,material_id,qty_solicitada,qty_retirada,fecha_requerimiento,pedido_id)
SELECT
	CONCAT ('2',CONVERT(bigint,ROUND(((999999 - 100000) * RAND() + 100000), 0))) as 'numero_reserva',
	om.id as 'orden_mantenimiento_id',
	mt.id as 'material_id',
	ROUND(RAND()*9+1,0) as 'qty_solicitada',
	ROUND(RAND()*9+1,0) as 'qty_retirada',
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
-- Actualizamos qty retirada

DECLARE @contador INT;
DECLARE @min_id INT;
DECLARE @max_id INT;
DECLARE @qty_solicitada INT;

SET @min_id = (SELECT MIN(id) FROM pedidos);
SET @max_id = (SELECT MAX(id) FROM pedidos);
SET @contador = @min_id;

WHILE @contador <= @max_id
BEGIN
	SELECT @qty_solicitada = qty_solicitada
	FROM reservas
	WHERE id = @contador

UPDATE reservas
	SET qty_retirada = ROUND(RAND() * @qty_solicitada,0) 
	WHERE id = @contador
	
	SET @contador = @contador+1
END;




SELECT*FROM pedidos
SELECT*FROM proveedores
SELECT*FROM ordenes_mantenimiento
SELECT*FROM materiales
SELECT*FROM reservas

SELECT*FROM talleres
SELECT*FROM existencias
