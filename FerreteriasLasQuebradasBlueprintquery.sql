CREATE DATABASE FerreteriasLasQuebradas;
GO

USE FerreteriasLasQuebradas;
GO

CREATE TABLE dbo.Provincia (
    idProvincia int PRIMARY KEY,
    nombreProvincia nvarchar(45)
);

CREATE TABLE dbo.Canton (
    idCanton int PRIMARY KEY,
    nombreCanton nvarchar(45),
    idProvincia int REFERENCES dbo.Provincia
);

CREATE TABLE dbo.Distritos (
    idDistritos int PRIMARY KEY,
    nombreDistrito nvarchar(45),
    idCanton int REFERENCES dbo.Canton
);

CREATE TABLE dbo.Sucursales (
    idSucursal int PRIMARY KEY,
    nombreSucursal nvarchar(45),
    telefono int UNIQUE,
    horario nvarchar(45),
    gerente nvarchar(45),
    direccionExacta nvarchar(1000),
    idDistritos int REFERENCES dbo.Distritos
);

CREATE TABLE dbo.Empleados (
    idEmpleado int PRIMARY KEY,
    nombre nvarchar(45),
    primerApellido nvarchar(45),
    segundoApellido nvarchar(45),
    fechaContratacion date,
    correoElectronico nvarchar(45),
    estado nvarchar(45),
    puesto nvarchar(45),
    direccionExacta nvarchar(45),
    idSucursal int REFERENCES dbo.Sucursales,
    idDistritos int REFERENCES dbo.Distritos
);

CREATE TABLE dbo.Telefono_Empleado (
    telefono int PRIMARY KEY,
    idEmpleado int REFERENCES dbo.Empleados
);

CREATE TABLE dbo.Productos (
    idProducto int PRIMARY KEY,
    nombreProducto nvarchar(45),
    costo decimal(10,2),
    estado nvarchar(45),
    marca nvarchar(45)
);

CREATE TABLE dbo.Proveedores (
    idProveedor int PRIMARY KEY,
    nombreProveedor nvarchar(45),
    telefonoProveedor nvarchar(45)
);

CREATE TABLE dbo.Catalogo (
    idProveedor int REFERENCES dbo.Proveedores,
    idProducto int REFERENCES dbo.Productos,
    PRIMARY KEY (idProveedor, idProducto)
);

CREATE TABLE dbo.Stock (
    idStock int PRIMARY KEY,
    idProducto int REFERENCES dbo.Productos,
    idSucursal int REFERENCES dbo.Sucursales,
    pasillo nvarchar(45),
    cantidadStock int,
    cantidadLimitePasillo int
);

CREATE TABLE dbo.Cliente (
    idCliente int PRIMARY KEY,
    nombreCliente nvarchar(45),
    primerApellidoCliente nvarchar(45),
    segundoApellidoCliente nvarchar(45),
    correoCliente nvarchar(45),
    direccionExactaCliente nvarchar(45),
    idDistritos int REFERENCES dbo.Distritos
);

CREATE TABLE dbo.Facturas (
    idFactura int PRIMARY KEY,
    idCliente int REFERENCES dbo.Cliente,
    idEmpleado int REFERENCES dbo.Empleados,
    fechaVenta date,
    montoTotal decimal(10,2)
);

CREATE TABLE dbo.DetalleFactura (
    idDetalleFactura int PRIMARY KEY,
    idFactura int REFERENCES dbo.Facturas,
    idStock int REFERENCES dbo.Stock,
    cantidadVendida int
);

CREATE TABLE dbo.FacturaCompra (
    idFacturaCompra int PRIMARY KEY,
    idProveedor int REFERENCES dbo.Proveedores,
    idSucursal int REFERENCES dbo.Sucursales,
    fechaCompra date
);

CREATE TABLE dbo.DetalleFacturaCompra (
    idDetalleFacturaCompra int PRIMARY KEY,
    idFacturaCompra int REFERENCES dbo.FacturaCompra,
    idProducto int REFERENCES dbo.Productos,
    cantidadComprada int
);

CREATE TABLE dbo.AcomodoProductos (
    idAcomodo int PRIMARY KEY,
    idDetalleFacturaCompra int REFERENCES dbo.DetalleFacturaCompra,
    idStock int REFERENCES dbo.Stock,
    cantidadPasillo int
);


