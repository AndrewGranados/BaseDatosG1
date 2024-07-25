use NORTHWND;
go

select o.OrderID, o.OrderDate, c.CompanyName, c.City, od.Quantity, od.UnitPrice
from orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Customers as c
on c.CustomerID = o.CustomerID
where c.City in ('San Cristóbal', 'México D.F.')
go
---------------------------------------------------------
select c.CompanyName, count(o.OrderID) as 'NumeroOrdenes'
from orders as o
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Customers as c
on c.CustomerID = o.CustomerID
where c.City in ('San Cristóbal', 'México D.F.')
group by c.CompanyName
having count(*) > 18;
go
---------------------------------------------------------
--Obtener los nombres de los productos y sus categorias donde el precio promedio de los productos en la misma categoria sea mayor a 20 
select ca.CategoryName, p.ProductName, avg(p.UnitPrice) as 'PromedioPrecios'
from Products as p 
right join Categories as ca
on p.CategoryID = ca.CategoryID
where p.CategoryID is not null
group by ca.CategoryName, p.ProductName
having avg(p.UnitPrice) > 20
order by ca.CategoryName asc
go

--donde el maximo del precio unitario sea mayor a 40
select ca.CategoryName, p.ProductName, avg(p.UnitPrice) as 'PromedioPrecios'
from Products as p 
right join Categories as ca
on p.CategoryID = ca.CategoryID
where p.CategoryID is not null
group by ca.CategoryName, p.ProductName
having max(p.UnitPrice) > 263
order by ca.CategoryName asc
go