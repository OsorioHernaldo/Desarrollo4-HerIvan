-- Creando Base de datos 'Sistema de Inventario de Zapateria'
CREATE DATABASE ZAPATERIA;

-- Eliminando la BD
/*DROP DATABASE ZAPATERIA;*/

-- Usando la base de datos
USE ZAPATERIA

-- Creando tabla MARCA
CREATE TABLE MARCA(
	ID_Marca INT primary key AUTO_INCREMENT not null,
	NombreMarca nvarchar(50) not null
)

-- Creando tabla MODELO
CREATE TABLE MODELO(
	ID_Modelo INT primary key AUTO_INCREMENT not null,
	Nombre_Modelo nvarchar(50) not null
)

-- Creando tabla TALLA  'Talla, guardará las diferentes medidas en los diferentes paises en venta'
CREATE TABLE TALLA(
	ID_Talla INT primary key AUTO_INCREMENT not null,
	Talla nvarchar(25) not null
)

-- Creando tabla PRODUCTO
CREATE TABLE DETALLE_PRODUCTO(
	ID_Producto VARCHAR(200) primary key DEFAULT(UUID()) not null,
	ID_Marca INT,
	ID_Modelo INT,
	ID_Talla INT,
	Existencia int not null,
	Precio decimal(9,2) not null,
	FOREIGN KEY (ID_Marca) REFERENCES MARCA(ID_Marca),
    FOREIGN KEY(ID_Modelo) references MODELO(ID_Modelo),
	FOREIGN KEY(ID_Talla) references TALLA(ID_Talla)
)

-- Creando tabla TELEFONO_PROVEEDOR
CREATE TABLE TELEFONO_PROVEEDOR(
	ID_Telefono INT primary key auto_increment not null,
	Telefono varchar(8)
)

-- Creando tabla PROVEEDORES
CREATE TABLE PROVEEDOR(
	ID_Proveedor INT primary key auto_increment not null,
	nombre_Proveedor nvarchar(25) not null,
	direccion nvarchar(50) not null,
	ID_Telefono int,
	FOREIGN KEY (ID_Telefono) references TELEFONO_PROVEEDOR(ID_Telefono)
)

CREATE TABLE DATOS_PERSONALES(
	Cedula VARCHAR(30) PRIMARY KEY NOT NULL,
	Nombre VARCHAR(40) NOT NULL,
	Correo VARCHAR(40) NOT NULL,
	Telefono INT NOT NULL
)

CREATE TABLE PUESTO(
	ID_Puesto INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	Nombre VARCHAR(40)
)

-- Creando Tabla Usuario
CREATE TABLE USUARIO(
	ID_Usuario VARCHAR(200) PRIMARY KEY DEFAULT(UUID()),
	Nombre_Usuario VARCHAR(40),
	Contraseña VARCHAR(40)
	-- Fecha_Creacion datetime default current_timestamp()
)

-- Creando Tabla TRABAJADOR
CREATE TABLE TRABAJADOR (
	ID_Empleado VARCHAR(200) PRIMARY KEY DEFAULT(UUID()), 
	ID_Puesto INT,
	Cedula VARCHAR(30),
	ID_Usuario VARCHAR(200),
	FOREIGN KEY (ID_Puesto) REFERENCES PUESTO(ID_Puesto),
	FOREIGN KEY (Cedula) REFERENCES DATOS_PERSONALES(Cedula),
	FOREIGN KEY (ID_Usuario) REFERENCES USUARIO(ID_Usuario)
)

-- Creando Tabla Venta
CREATE TABLE VENTA(
	ID_Venta VARCHAR(200) primary key DEFAULT(UUID()) not null,
	ID_Producto varchar(200),
	Fecha_venta datetime default now() not null,
	Cantidad int not null,
	Precio_venta decimal(9,2) NOT NULL,
	FOREIGN KEY (ID_Producto) REFERENCES DETALLE_PRODUCTO(ID_Producto)
)

INSERT INTO USUARIO (Nombre_Usuario,Contraseña) VALUES ("HAON","osorio98")

select * from USUARIO