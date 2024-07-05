create database PruebaJoinsG1;

use PruebaJoinsG1;

create table proveedor
(
    provid int not null IDENTITY(1,1),
    nombre varchar(50) not null,
    limite_credito money not null,
    constraint pk_proveedor PRIMARY key (provid),
    constraint unico_nombrepro unique(nombre)
);

create table Producto
(
    productid int not null identity(1,1),
    nombre varchar(50) not null,
    precio money not null,
    existencia int not null,
    proveedor int,
    constraint pk_producto primary key(productid),
    constraint unico_nombre_proveedor unique (nombre),
    constraint fk_proveedor_producto foreign key(proveedor) references proveedor(provid)
);

--Agregar registro a la tabla proveedor y producto
insert into proveedor
    (nombre, limite_credito)
values
    ('Proveedor1', 5700),
    ('Proveedor2', 8900),
    ('Proveedor3', 1300),
    ('Proveedor4', 3400),
    ('Proveedor5', 6000);

select * from proveedor;

insert into producto
    (nombre, precio,existencia, proveedor)
VALUES
    ('Producto1', 50, 39, 1),
    ('Producto2', 20, 31, 1),
    ('Producto3', 56, 87.3, 1),
    ('Producto4', 80.2, 64, 1),
    ('Producto5', 70.2, 44, 2);

select * from proveedor as p 
inner join producto as pr
on pr.proveedor = p.provid

