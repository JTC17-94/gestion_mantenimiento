CREATE DATABASE gestion_ordenes_mantenimiento;
GO

USE gestion_ordenes_mantenimiento;
GO

-- Tabla Talleres
CREATE TABLE talleres(
	id INT PRIMARY KEY IDENTITY(1,1),
	codigo_taller VARCHAR(20) UNIQUE NULL,
	nombre_taller VARCHAR(255) NULL,
); 
GO

-- Tabla Proveedores
CREATE TABLE proveedores(
	id INT PRIMARY KEY IDENTITY(1,1),
	codigo_proveedor VARCHAR(20) UNIQUE NULL,
	nombre_proveedor VARCHAR(255) NULL,
	ruc_proveedor VARCHAR (30)  NULL,
); 
GO

-- Tabla Materiales
CREATE TABLE materiales(
	id INT PRIMARY KEY IDENTITY(1,1),
	codigo_material VARCHAR(255) UNIQUE NOT NULL,
	descripcion_material VARCHAR (255) NOT NULL,
	tipo_reposicion VARCHAR(255) NOT NULL,
	precio_unitario INT NULL,
	unidad_medida VARCHAR(10) NOT NULL,
); 
GO

ALTER TABLE materiales
ALTER COLUMN precio_unitario DECIMAL(10,2) NULL


-- Ordenes de Mantenimiento
CREATE TABLE ordenes_mantenimiento(
	id INT PRIMARY KEY IDENTITY(1,1),
	orden_trabajo VARCHAR(20) UNIQUE NOT NULL,
	tipo_orden VARCHAR (100) NOT NULL,
	equipo VARCHAR(255) NULL,
	descripcion_equipo VARCHAR (255) NULL,
	descripcion_trabajo VARCHAR (255) NOT NULL,
	revision VARCHAR (30) NULL,
	taller_id INT NOT NULL,
	qty_personas INT NULL,
	numero_horas INT NULL,
	CONSTRAINT FK_taller_orden_mantenimiento FOREIGN KEY (taller_id) REFERENCES talleres(id)
); 
GO
ALTER TABLE ordenes_mantenimiento
ADD carga_laboral_HH AS (numero_horas * qty_personas);

-- Pedidos
CREATE TABLE pedidos(
	id INT PRIMARY KEY IDENTITY(1,1),
	numero_pedido VARCHAR (20) NOT NULL,
	costo_total INT NULL,
	qty_pedido INT NULL,
	qty_pendiente_entrega INT NULL,
	fecha_generacion DATE NOT NULL,
	fecha_entrega DATE NOT NULL,
	proveedor_id INT,
	CONSTRAINT FK_proveedores_pedidos FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
);
GO

ALTER TABLE pedidos
ALTER COLUMN costo_total DECIMAL(10,2) NULL

-- Reservas
CREATE TABLE reservas(
	id INT PRIMARY KEY IDENTITY(1,1),
	numero_reserva VARCHAR(20) NOT NULL,
	orden_mantenimiento_id INT NOT NULL,
	material_id INT NOT NULL,
	qty_solicitada INT NOT NULL,
	qty_retirada INT NULL,
	fecha_requerimiento DATE NOT NULL,
	pedido_id INT,
	CONSTRAINT FK_ordenes_mantenimiento_reservas FOREIGN KEY (orden_mantenimiento_id) REFERENCES ordenes_mantenimiento(id),
	CONSTRAINT FK_materiales_reservas FOREIGN KEY (material_id) REFERENCES materiales(id),
	CONSTRAINT FK_pedidos_reservas FOREIGN KEY (pedido_id) REFERENCES pedidos(id)
); 
GO

--existencias
CREATE TABLE existencias(
	id INT PRIMARY KEY IDENTITY(1,1),
	material_id INT,
	codigo_almacen VARCHAR (10) NULL,
	qty_stock INT NULL,
	CONSTRAINT FK_materiales_existencias FOREIGN KEY (material_id) REFERENCES materiales(id)
); 
GO