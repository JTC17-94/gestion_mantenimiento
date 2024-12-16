USE [master]
GO
/****** Object:  Database [gestion_ordenes_mantenimiento]    Script Date: 16/12/2024 16:02:20 ******/
CREATE DATABASE [gestion_ordenes_mantenimiento]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'gestion_ordenes_mantenimiento', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\gestion_ordenes_mantenimiento.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'gestion_ordenes_mantenimiento_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\gestion_ordenes_mantenimiento_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [gestion_ordenes_mantenimiento].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET ARITHABORT OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET  ENABLE_BROKER 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET RECOVERY FULL 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET  MULTI_USER 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET DB_CHAINING OFF 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'gestion_ordenes_mantenimiento', N'ON'
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET QUERY_STORE = ON
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [gestion_ordenes_mantenimiento]
GO
/****** Object:  Table [dbo].[existencias]    Script Date: 16/12/2024 16:02:20 ******/
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
/****** Object:  Table [dbo].[materiales]    Script Date: 16/12/2024 16:02:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[materiales](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[codigo_material] [varchar](50) NULL,
	[descripcion_material] [varchar](50) NULL,
	[tipo_reposicion] [varchar](50) NULL,
	[precio_unitario] [varchar](50) NULL,
	[unidad_medida] [varchar](50) NULL,
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
/****** Object:  Table [dbo].[ordenes_mantenimiento]    Script Date: 16/12/2024 16:02:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ordenes_mantenimiento](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[orden_trabajo] [varchar](20) NOT NULL,
	[tipo_orden] [varchar](100) NOT NULL,
	[equipo] [varchar](255) NULL,
	[descripcion_trabajo] [varchar](30) NOT NULL,
	[revision] [varchar](30) NULL,
	[taller_id] [int] NULL,
	[descripcion_equipo] [varchar](255) NULL,
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
/****** Object:  Table [dbo].[pedidos]    Script Date: 16/12/2024 16:02:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pedidos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[numero_pedido] [varchar](20) NOT NULL,
	[costo_total] [int] NULL,
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
/****** Object:  Table [dbo].[proveedores]    Script Date: 16/12/2024 16:02:20 ******/
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
/****** Object:  Table [dbo].[reservas]    Script Date: 16/12/2024 16:02:20 ******/
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
/****** Object:  Table [dbo].[talleres]    Script Date: 16/12/2024 16:02:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[talleres](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[codigo_taller] [varchar](20) NOT NULL,
	[nombre_taller] [varchar](255) NOT NULL,
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
USE [master]
GO
ALTER DATABASE [gestion_ordenes_mantenimiento] SET  READ_WRITE 
GO
