USE [gestion_ordenes_mantenimiento]
GO
/****** Object:  Table [dbo].[existencias]    Script Date: 19/12/2024 02:36:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[existencias](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[material_id] [int] NULL,
	[codigo_almacen] [varchar](10) NULL,
	[qty_stock] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[materiales]    Script Date: 19/12/2024 02:36:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[materiales](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[codigo_material] [varchar](255) NOT NULL,
	[descripcion_material] [varchar](255) NOT NULL,
	[tipo_reposicion] [varchar](255) NOT NULL,
	[precio_unitario] [decimal](10, 2) NULL,
	[unidad_medida] [varchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[codigo_material] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ordenes_mantenimiento]    Script Date: 19/12/2024 02:36:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ordenes_mantenimiento](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[orden_trabajo] [varchar](20) NOT NULL,
	[tipo_orden] [varchar](100) NOT NULL,
	[equipo] [varchar](255) NULL,
	[descripcion_equipo] [varchar](255) NULL,
	[descripcion_trabajo] [varchar](255) NOT NULL,
	[revision] [varchar](30) NULL,
	[taller_id] [int] NOT NULL,
	[qty_personas] [int] NULL,
	[numero_horas] [int] NULL,
	[carga_laboral_HH]  AS ([numero_horas]*[qty_personas]),
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[orden_trabajo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pedidos]    Script Date: 19/12/2024 02:36:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pedidos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[numero_pedido] [varchar](20) NOT NULL,
	[costo_total] [decimal](10, 2) NULL,
	[qty_pedido] [int] NULL,
	[qty_pendiente_entrega] [int] NULL,
	[fecha_generacion] [date] NOT NULL,
	[fecha_entrega] [date] NOT NULL,
	[proveedor_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[proveedores]    Script Date: 19/12/2024 02:36:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[proveedores](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[codigo_proveedor] [varchar](20) NULL,
	[nombre_proveedor] [varchar](255) NULL,
	[ruc_proveedor] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[codigo_proveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reservas]    Script Date: 19/12/2024 02:36:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reservas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[numero_reserva] [varchar](20) NOT NULL,
	[orden_mantenimiento_id] [int] NOT NULL,
	[material_id] [int] NOT NULL,
	[qty_solicitada] [int] NOT NULL,
	[qty_retirada] [int] NULL,
	[fecha_requerimiento] [date] NOT NULL,
	[pedido_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[talleres]    Script Date: 19/12/2024 02:36:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[talleres](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[codigo_taller] [varchar](20) NULL,
	[nombre_taller] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[codigo_taller] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[existencias]  WITH CHECK ADD  CONSTRAINT [FK_materiales_existencias] FOREIGN KEY([material_id])
REFERENCES [dbo].[materiales] ([id])
GO
ALTER TABLE [dbo].[existencias] CHECK CONSTRAINT [FK_materiales_existencias]
GO
ALTER TABLE [dbo].[ordenes_mantenimiento]  WITH CHECK ADD  CONSTRAINT [FK_taller_orden_mantenimiento] FOREIGN KEY([taller_id])
REFERENCES [dbo].[talleres] ([id])
GO
ALTER TABLE [dbo].[ordenes_mantenimiento] CHECK CONSTRAINT [FK_taller_orden_mantenimiento]
GO
ALTER TABLE [dbo].[pedidos]  WITH CHECK ADD  CONSTRAINT [FK_proveedores_pedidos] FOREIGN KEY([proveedor_id])
REFERENCES [dbo].[proveedores] ([id])
GO
ALTER TABLE [dbo].[pedidos] CHECK CONSTRAINT [FK_proveedores_pedidos]
GO
ALTER TABLE [dbo].[reservas]  WITH CHECK ADD  CONSTRAINT [FK_materiales_reservas] FOREIGN KEY([material_id])
REFERENCES [dbo].[materiales] ([id])
GO
ALTER TABLE [dbo].[reservas] CHECK CONSTRAINT [FK_materiales_reservas]
GO
ALTER TABLE [dbo].[reservas]  WITH CHECK ADD  CONSTRAINT [FK_ordenes_mantenimiento_reservas] FOREIGN KEY([orden_mantenimiento_id])
REFERENCES [dbo].[ordenes_mantenimiento] ([id])
GO
ALTER TABLE [dbo].[reservas] CHECK CONSTRAINT [FK_ordenes_mantenimiento_reservas]
GO
ALTER TABLE [dbo].[reservas]  WITH CHECK ADD  CONSTRAINT [FK_pedidos_reservas] FOREIGN KEY([pedido_id])
REFERENCES [dbo].[pedidos] ([id])
GO
ALTER TABLE [dbo].[reservas] CHECK CONSTRAINT [FK_pedidos_reservas]
GO
