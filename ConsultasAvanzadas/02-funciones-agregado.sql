--FUNCIONES DE AGREGADO Y AGRUPACIÓN

--utilizar base de datos
use NORTHWND;

--funciones de agregado

--seleccionar el numero total de ordenes de compra
--COUNT(*)
select count(*) as 'NumeroOrdenes' from orders 

select count(*) from Customers

select count(region) from customers

--seleccionar el maximo numero de productos pedidos
select max(Quantity) as 'Cantidad' from [order Details]

select min(Quantity) as 'Cantidad' from [order Details]

--seleccionar el total de la cantidad de predictos pedidos
select sum(UnitPrice) from [order Details]

--seleccionar el total de dinero que he vendido 
select sum(od.Quantity * od.UnitPrice) as 'Total' from [order Details] as od
inner join products as p
on od.ProductID = p.ProductID where p.ProductName = 'Aniseed Syrup';

--seleccionar el promedio de las ventas del producto 3
select avg(od.Quantity * od.UnitPrice) as 'PromedioVentas' from [order Details] as od
inner join products as p
on od.ProductID = p.ProductID where p.ProductName = 'Aniseed Syrup'; 

--seleccionar el numero de productos por categoria
select sum(categoryid), count(*) as 'NumeroProductos' from products

select CategoryID as 'TotalProductos' from products 
group by categoryid;

--seleccionar el numero de productos por nombre de categoria
select c.categoryname, count(p.productId) as 'TotalProducto' from categories as c
inner join products as p
on c.categoryid = p.categoryid
where c.categoryname in('Beverages', 'Confections')
group by categoryname;

--