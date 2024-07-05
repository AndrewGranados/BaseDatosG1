--LENGUAJE DE DEFINICION DE DATOS (SQL-LDD)
--Crear base digital
create database tiendadigital;
go
--Cambiar de base de datos
use tiendadigital;
go

--Crear tabla Proveedor
create table proveedor(
	provedorid int not null identity(1,1),
	numcontrol varchar(30) not null,
	nombreempresa varchar(50) not null,
	cp int not null,
	calle varchar(50) not null,
	colonia varchar(50) not null,
	numero int,
	estado varchar(20) not null,
	telefono varchar(20),
	paginaweb varchar(50), 
	constraint pk_provedor primary key(provedorid), 
	constraint unico_numcontrol	unique(numcontrol),
	constraint unico_nombreempresa unique(nombreempresa)
);

--Crear tabla categoria
create table categoria(
	categoriaid int not null,
	descripcion varchar(100) not null,
	constraint pk_categoria primary key(categoriaid),
	constraint unico_descripcion unique (descripcion),
);

--Crear tabla producto
create table producto(
	producto int not null identity(1,1),
	numerocontrol varchar(30) not null,
	descripcion varchar(100) not null,
	precio money not null,
	existencia int not null,
	[status] int null,
	categoriaid int not null,

	constraint pk_producto primary key(producto),
	constraint unico_numerocontrol unique(numerocontrol),
	constraint unico_descripcion_producto unique (descripcion),
	constraint chk_precio check(precio>0.0),
	constraint chk_existencia --check (existencia>=1 and existencia<=2000)
		check(existencia between 1 and 2000),
	constraint chk_status --check ([status]=0 or [status]=1),
		check([status] in(0,1)),
	constraint fk_producto_categoria foreign key (categoriaid) references categoria (categoriaid)
);

--Crear table cliente
create table cliente(
	clienteid int not null identity(1,1),
	numerocontrol varchar(20) not null,
	nombreempresa varchar(50) not null default 'Mostrador',
	rfc varchar(20) not null, 
	direccionfiscal varchar(100) not null,
	limitecredito money, 
	constraint pk_cliente primary key(clienteid),
	constraint unico_numerocontrol_cliente unique(numerocontrol),
	constraint unico_rfc unique (rfc),
	constraint chk_limite_credito check (limitecredito>=0 and limitecredito <=100000)
);

--Crear tabla empleado
create table empleado(
	empleadoid int not null identity(1,1),
	numeronomina int not null, 
	nombrecompleto varchar(50) not null,
	apellido1 varchar(20) not null,
	apellido2 varchar(20),
	rfc varchar(20) not null,
	curp varchar(20) not null,
	salario money not null,
	constraint pk_empleado primary key (empleadoid),
	constraint unico_numeronomina unique (numeronomina),
	constraint unico_rfc_empleado unique (rfc),
	constraint unico_curp unique (curp),
	constraint chk_salario check (salario>0.0)
);

--Crear tabla OrdenCompra
create table ordencompra(
	compraid int not null identity(1,1), 
	fechaorden date not null,
	fechaentrega date not null, 
	clienteid int not null,
	empleadoid int not null,
	constraint pk_ordencompra primary key(compraid),
	constraint fk_ordencompra_cliente foreign key (clienteid) references cliente(clienteid),
	constraint fk_ordencompra_empleado foreign key (empleadoid) references empleado (empleadoid)
);

--Crear tabla detalle orden
create table detalleorden(
	ordenid int not null,
	producto int not null,
	cantidad int not null,
	preciocompra money not null,
	constraint pk_detalleorden primary key (ordenid,producto),
	constraint fk_detalleorden_compra foreign key (ordenid) references ordencompra(compraid),
	constraint fk_detllecompra_compra foreign key (producto) references producto (producto)
)

create table contactoproveedor(
	contactoid int not null,
	provedorid int not null,
	nombrecompleto varchar(50) not null,
	apellido1 varchar(20) not null,
	apellido2 varchar(20),
	email varchar(30),
	constraint pk_contacto_proveedor primary key(contactoid,provedorid),
	constraint fk_contactoprov_prov foreign key (provedorid) references proveedor (provedorid),
)

create table telefonocontacto(
	telefonoid int not null,
	contactoid int not null,
	provedorid int not null,
	numerotelefono varchar(20) not null,
)
--modificar tabla
alter table telefonocontacto add constraint pk_telefonocontacto primary key (telefonoid)

alter table telefonocontacto add constraint fk_telefonocontacto_contacto foreign key (contactoid, provedorid) references contactoproveedor (contactoid,provedorid)

alter table producto add provedorid int not null

alter table producto add constraint fk_producto_proveedor foreign key (provedorid) references proveedor (provedorid)

--eliminar tabla--
--alter table telefonocontacto drop pk_telefonocontacto
drop table telefonocontacto

