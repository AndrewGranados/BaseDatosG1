--crear la base de datos
create database EjercicioExamen;

--usar la base de datos
use EjercicioExamen;

--crear la tabla Proveedor
create table Proveedor(
    idProv int not null identity(1,1),
    nombre varchar(50) not null,
    limite_credito money not null,
    constraint pk_proveedor primary key (idProv),
    constraint unico_nombre unique (nombre)
);
--drop table Proveedor;
--drop table Categoria;
--drop table Producto;

--creat la tabla categoria
create table Categoria(
    idcategoria int not null,
    nombre varchar(50) not null,
    constraint pk_categoria primary key (idcategoria),
    constraint unico_nombre_categoria unique (nombre)
)

--creat la tabla Producto
CREATE TABLE Producto(
    idprod int not null,
    nombre varchar(50) not null,
    precio money not null,
    existencia int not null,
    proveedor int,
    idcategoria int
    constraint pk_producto primary key(idprod),
    constraint fk_producto_prov foreign key (proveedor) references proveedor(idprov),
    constraint fk_producto_categoria foreign key (idcategoria) references categoria(idcategoria)
)

select * from Producto

--Insertar datos en las tablas
insert into proveedor(nombre, limite_credito)
values('Coca-Cola', 98777),
('Pepsi', 87455),
('HayMePica', 545887),
('HayMeDuele', 24578),
('TengoMiedo', 54854);

insert into Categoria
values (1, 'Lacteos'),(2, 'LineaBlanca'), (3, 'Dulces'), (4, 'Vinos'), (5, 'Abarrotes');

select * from Categoria;

insert into Producto values (1, 'Mascara', 78.9, 20, 5, 5);

insert into Producto(proveedor, existencia, idcategoria, precio, idprod, nombre)
values (3, 34, 5, 56.7, 2, 'Manita Rascadora')

insert into Producto 
values (3, 'Tonayan', 1450, 56, 4, 4),
 (4, 'Caramelo', 200, 22, 1, 3),
 (5, 'Terry', 200, 24, 4, 4);

select * from Producto
select * from Categoria order by idcategoria asc
select * from Proveedor

--consultas con inner join
select c.idcategoria, p.idcategoria, c.nombre, p.nombre, p.precio from Categoria as c 
inner join Producto as p 
on c.idcategoria = p.idcategoria;

select * from Categoria as c 
inner join Producto as p 
on c.idcategoria = p.idcategoria
inner join Proveedor as pr
on pr.idProv = p.proveedor;


--inner join con tablas derivadas
--Categoria: idcatego, nombre
--Producto: precio, existencia, nombre
select c.idcategoria, c.nombre, p.nombre, p.existencia, p.precio, (p.precio*p.existencia) as importe
from
(select idcategoria, nombre from Categoria) as c
inner join
(select precio, existencia, idcategoria, nombre from Producto) as p
on c.idcategoria = p.idcategoria;



--left join
select c.nombre, p.nombre, p.precio, p.existencia from Categoria as c 
left join Producto as p 
on c.idcategoria = p.idcategoria
where p.idcategoria is null;

--left join con tablas derivadas
select c.nombre, p.nombre, p.precio, p.existencia
from 
(select nombre, idcategoria from Categoria) as c
left join
(select nombre, precio, existencia, idcategoria from Producto) as p
on p.idcategoria = c.idcategoria
where p.idcategoria is null;



--right join
select * from Categoria as c 
right join Producto as p 
on c.idcategoria = p.idcategoria;



--full join
select * from Categoria as c 
full join Producto as p 
on c.idcategoria = p.idcategoria;



--COnvinaciones entre inner join, left join, right join 
select * from Categoria as c 
full join Producto as p 
on c.idcategoria = p.idcategoria
inner join Proveedor as pr
on pr.idProv = p.proveedor;


--use NORTHWND
--Tablas derivadas de manera rápida
--select *
--from
--(select orderid, orderDate, ShipCountry, requireddate from orders) as o