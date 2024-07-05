use NORTHWND;
--Vistas(objetos de las bdd - SQL-LDD)

create view vista_ventas
as
select c.customerId as 'ClaveCliente', c.companyname as 'Cliente', concat(e.firstname,' ',e.lastname) as 'Nombre',
o.orderdate as 'FechaOrden', datepart(year, o.orderdate) as 'AñoCompra', datename(mm, o.orderdate) as 'MesCompra',
datepart(quarter, o.orderdate) as 'Trimestre', upper(p.productname) as 'NombreProducto', od.quantity as 'CantidadVendida',
od.UnitPrice as 'PrecioVenta', p.supplierid as 'Proveedorid'
from orders as o
inner join customers as c 
on o.customerId = c.customerid
inner join Employees as e 
on e.employeeID = o.employeeID
inner join [order Details] as od 
on od.orderid = o.orderid
inner join products as p 
on p.productid = od.productid;

--drop view vista_ventas;

select * from vista_ventas;

select ClaveCliente, Nombre, NombreProducto, FechaOrden, (CantidadVendida * PrecioVenta) as 'Importe'
from vista_ventas
where NombreProducto = 'CHAI' and (CantidadVendida * PrecioVenta) > 600
and datepart(year, fechaOrden) = 1996;

--inner join de la vista con suppliers
select * from vista_ventas as vv
inner join suppliers as s 
on s.supplierid = vv.proveedorid;


--case primera forma
select productname, unitprice, UnitsInStock, Discontinued,
case discontinued 
when 0 then 'No Disponible'
when 1 then 'Disponible'
else 'No existente'
end as 'Disponobilidad'
from products

--case segunda forma
select productname, unitprice, UnitsInStock, 
Discontinued,
disponibilidad = case discontinued 
when 0 then 'No Disponible'
when 1 then 'Disponible'
else 'No existente'
end
from products