--CONSULTAS AVANZADAS
select c.CategoryName as "NombreCategoria", p.ProductName as "NombreProducto", p.UnitPrice as "Precio", p.UnitsInStock as "Existencia"
from Categories as c
    inner join Products as p
    on c.CategoryID = p.CategoryID
where c.CategoryName in ('Beverages','Produce')

--seleccionar todas las ordenes que fueron emitidas por los empleados Nancy Davolio, Anne, Dodsworth, Andrew Fuller
select *
from Orders
where EmployeeID in (1,9,2);
select *
from Employees

--seleccionar todas las ordenes , dividiendo la fecha de orden en año, mes y dia
select orderDate as 'Fecha de orden', year(OrderDate) as 'Año', month(OrderDate) as 'Mes', day(OrderDate) as 'Dia'
from Orders;

--seleccionar todos los nombres de empleados
select CONCAT(FirstName, ' ', LastName) as 'Nombre Completo'
from Employees;

--seleccionar todos los productos donde la existencia sea mayor o igual a 40 y el precio sea menor a 19
select ProductName as 'NombreProducto', UnitsInStock as 'Existencia', UnitPrice as 'Precio'
from Products
where UnitsInStock>= 40 and UnitPrice < 19;

--seleccionar todas las ordenes realizadas de abril a agosto de 1996
select OrderID, CustomerID, EmployeeID, OrderDate
from Orders
where OrderDate between '1996-04-01' and '1996-06-31';

--seleccionar todas las ordenes entre 1996 y 1998
select *
from Orders
where year(OrderDate) between '1996' and '1998';

--seleciconar todas las ordenes de 1996 y 1999
select *
from Orders
where year(OrderDate) in ('1996', '1999');

--seleccionar todos los productos que comiencen con c
select *
from Products
where ProductName like 'c%';

--seleccionar todos los productos que terminen con s
select *
from Products
where ProductName like '%s';

--seleccionar todos los productos que el nombre del producto contenga la palabra no
select *
from Products
where ProductName like '%no%';

--seleccionar todos los producto que contengan todas las letras a o n
select *
from Products
where ProductName like '%[an]%';

--seleccionar todos los productos que comiencen entre la letra a y n
select *
from Products
where ProductName like '[a-n]%';

--seleccionar todas las ordenes que fueron emitidas por los empleados Nancy Davolio, Anne, Dodsworth, Andrew Fuller (inner join)
select o.OrderID as 'Numero Orden', o.OrderDate as 'Fecha Orden', CONCAT(FirstName, ' ', LastName) as 'Nombre'
from Employees as e inner join Orders as o
    on e.EmployeeID = o.EmployeeID
where e.FirstName in ('Nancy', 'Anne', 'Andrew')
    and e.LastName in ('Davolio', 'Dodsworth', 'Fuller');

--crear y usar base de datos
create database PruebaXYZ;
use PruebaXYZ;

--crear una tabla a partir de una consulta con 0 registros
select top 0
    *
into PruebaXYZ.dbo.Products2
from NORTHWND.dbo.Products;

--muestra la tabla products2 
select *
from Products2;

--agrega un constraint a la tabla products 2
alter table Products2
add constraint pk_Product2 primary key (ProductID);

alter table Products2
drop constraint pk_Product2;

--llenar una tabla a partir de una consulta
insert into PruebaXYZ.dbo.Products2
    (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
select ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
from NORTHWND.dbo.Products;

use NORTHWND;

--Ejercicio 1: Obtener el nombre del cliente y el nombre del empleado del representante de ventas de cada pedido.
--Nombre del cliente (customers)
--Nombre del empleado (Employees)
use NORTHWND;
select o.customerId, o.EmployeeID, o.orderId, o.orderdate
from Orders as o;

select c.CompanyName as 'Nombre del cliente', concat(e.FirstName,' ',e.LastName), o.OrderID, o.OrderDate, (od.Quantity * od.UnitPrice) as 'Importe'
from Customers as c
    inner join orders as o
    on o.CustomerID = c.CustomerID
    inner join Employees as e
    on o.EmployeeID = e.EmployeeID
    inner join [Order Details] as od
    on od.OrderID = o.OrderID
where year(OrderDate) in('1996', '1998');

--seleccionar cuantas ordenes se han realizado de 1996 y 1998
select count(*) as 'Total de ordenes'
from Customers as c
    inner join orders as o
    on o.CustomerID = c.CustomerID
    inner join Employees as e
    on o.EmployeeID = e.EmployeeID
    inner join [Order Details] as od
    on od.OrderID = o.OrderID
where year(OrderDate) in('1996', '1998');

--Ejercicio 2: Mostrar el nombre del producto, el nombre del proveedor y el precio unitario de cada producto.
select p.ProductName as 'NombreProducto', s.CompanyName as 'NombreCompañia', od.UnitPrice as 'PrecioUnitario'
from Products as p
    inner join Suppliers as s
    on p.SupplierID= s.SupplierID
    inner join [Order Details] as od
    on od.ProductID = p.ProductID;

--Ejercicio 3: Listar el nombre del cliente, el ID del pedido y la fecha del pedido para cada pedido.
select o.OrderID, c.CompanyName, o.OrderDate
from Customers as c
    inner join orders as o
    on c.CustomerID = o.CustomerID
order by o.OrderID asc

--Ejercicio 4: Obtener el nombre del empleado, el título del cargo y el departamento del empleado para cada empleado.
select CONCAT(e.FirstName,' ',e.LastName) as 'NombreCopmleto', e.TitleOfCourtesy, e.Address
from Employees as e;

--Ejercicio 5: Mostrar el nombre del proveedor, el nombre del contacto y el teléfono del contacto para cada proveedor.
select CompanyName, ContactName, Phone
from Suppliers

--Ejercicio 6: Listar el nombre del producto, la categoría del producto y el nombre del proveedor para cada producto.
select p.ProductName as 'NombreProducto', c.CategoryName as 'CategoriaProducto', s.CompanyName as 'NombreProveedor'
from Products as p
    inner join suppliers as s
    on p.SupplierID = s.SupplierID
    inner join categories as c
    on c.CategoryID = p.CategoryID;

--Ejercicio 7: Obtener el nombre del cliente, el ID del pedido, el nombre del producto y la cantidad del producto para cada detalle del pedido.
select c.CompanyName as 'NombreCliente', o.OrderID as 'IdPedido', p.ProductName as 'NombreProducto', od.Quantity as 'CantidadProducto'
from customers as c
    inner join orders as o
    on c.CustomerID = o.CustomerID
    inner join [Order Details] as od
    on o.OrderID = od.OrderID
    inner join Products as p
    on p.ProductID = od.ProductID


--Ejercicio 8: Obtener el nombre del empleado, el nombre del territorio y la región del territorio para cada empleado que tiene asignado un territorio.
select concat(e.FirstName, ' ', e.LastName) as 'NombreEmpleado', t.TerritoryDescription 'NombreTerritorio', r.RegionDescription as 'RegionTerritorio'
from Employees as e
    inner join EmployeeTerritories as et
    on e.EmployeeID = et.EmployeeID
    inner join Territories as t
    on t.TerritoryID = et.TerritoryID
    inner join region as r
    on r.RegionID = t.RegionID;

--Ejercicio 9: Mostrar el nombre del cliente, el nombre del transportista y el nombre del país del transportista para cada pedido enviado por un transportista.
select c.CompanyName as 'NombreCliente', sh.CompanyName as 'NombreTransportista', o.ShipCountry as 'PaísTransportista'
from Customers as c
    inner join Orders as o
    on c.CustomerID = o.CustomerID
    inner join Shippers as sh
    on sh.ShipperID = o.ShipVia;

--Ejercicio 10: Obtener el nombre del producto, el nombre de la categoría y la descripción de la categoría para cada producto que pertenece a una categoría.
select p.ProductName as 'NombreProducto', c.CategoryName as 'NombreCategoría', c.Description as 'DescripciónCategiría'
from Products as p
    inner join Categories as c
    on c.CategoryID = p.CategoryID;

--Ejercicio 11: Seleccionar el total de ordenes hechas por cada uno de los proveedores 
select s.CompanyName as 'Proveedor', count(od.orderId) as 'TotalOrdenes'
from Suppliers as s
    inner join products as p
    on s.SupplierID = p.SupplierID
    inner join [Order Details] as od
    on od.ProductID = p.ProductID
group by s.CompanyName;

--Ejercicio 12: Seleccionar el total de dinero que ha vendido por proveedor el ultimo trimestre de 1996
select s.CompanyName as 'Proveedor', sum(od.UnitPrice * od.Quantity) as 'Total de Ventas'
from Suppliers as s
    inner join products as p
    on s.SupplierID = p.SupplierID
    inner join [Order Details] as od
    on od.ProductID = p.ProductID
    inner join orders as o
    on o.OrderID = od.OrderID
where o.OrderDate between '1996-09-01' and '1996-12-31'
group by s.CompanyName

--Ejercicio 13: Seleccionar el total de dinero vendido por categoria
select c.categoryname, sum(od.quantity * od.UnitPrice) as 'Total de ventas'
from [Order Details] as od
    inner join Products as p
    on od.ProductID = p.ProductID
    inner join Categories as c
    on c.CategoryID = p.CategoryID
group by c.CategoryName
order by 2 desc;

select c.categoryname, sum(od.quantity * od.UnitPrice) as 'Total de ventas'
from [Order Details] as od
    inner join Products as p
    on od.ProductID = p.ProductID
    inner join Categories as c
    on c.CategoryID = p.CategoryID
group by c.CategoryName
order by 'Total de ventas' desc;

--Ejercicio 14: Seleccionar el total de dinero vendido por categoria y dentro por producto
select c.CategoryName as 'NombreCategoria', sum(od.Quantity * od.UnitPrice) as 'Total'
from [Order Details] as od
    inner join Products as p
    on od.ProductID = p.ProductID
    inner join Categories as c
    on c.CategoryID = p.CategoryID
GROUP by  c.CategoryName, p.ProductName
ASC;


select c.CategoryName as 'NombreCategoria', p.ProductName as 'NombreProducto', sum(od.unitPrice * od.Quantity) as 'Total'
from [Order Details] as od
    inner join products as p
    on od.ProductID = p.ProductID
    inner join Categories as c
    on p.CategoryID = c.CategoryID
group by c.CategoryName, p.ProductName
order by 'NombreCategoria', 'NombreProducto' asc;

use NORTHWND;
select c.CategoryName, p.ProductName, p.UnitsInStock, p.unitprice, p.discontinued
from (
    select Categoryname, categoryid
    from Categories
) as c
    inner join(
    select ProductName, UnitsInStock, CategoryID, UnitPrice, Discontinued
    from Products
)as p
    on c.CategoryID = p.CategoryID

--Left Joins

use PruebaJoinsG1;

select * from Producto;
select * from proveedor;

select p.provid,pr.nombre, pr.nombre from proveedor as p 
left join Producto as pr
on pr.proveedor = p.provid


--1. crear 2 tablas, empleados (idEmpleado, PrimerNombre, SegundoNombre, Direccion, Telefono, Salario) y DMI_empleados (idEmpleado, nombreCompleto, direccion, Telefono, Salario)
--