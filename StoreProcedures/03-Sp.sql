use NORTHWND;
select * from Customers


create database ETLEmpresa;
use ETLEmpresa;

create table Cliente(
	clienteid int not null identity(1,1),
	clientebk nchar(5) not null,
	empresa nvarchar(40) not null,
	ciudad nvarchar(15) not null,
	region nvarchar(15) not null,
	pais nvarchar(15) not null
	constraint pk_clienteid primary key (clienteid)
);

create proc sp_etl_carga_cliente
as begin

	insert into ETLEmpresa.dbo.Cliente
	select CustomerID, upper(CompanyName) as 'Empresa',upper(city) as 'Ciudad', upper(isnull(nc.Region, 'SIN REGION')) as 'Region', upper(Country) as 'Pais'
	from NORTHWND.dbo.Customers as nc
	left join ETLEmpresa.dbo.Cliente as etle
	on nc.CustomerID = etle.clientebk
	where etle.clientebk is null

	update cl
	set cl.empresa = upper(c.CompanyName),
		cl.ciudad = upper(c.City),
		cl.pais = upper(c.Country),
		cl.region = upper(isnull(c.Region, 'SIN REGION'))
	from NORTHWND.dbo.Customers as c
	inner join ETLEmpresa.dbo.Cliente as cl
	on c.CustomerID = cl.clientebk;

	select * from NORTHWND.dbo.Customers
	where CustomerID = 'CLIB1';

	select * from ETLEmpresa.dbo.Cliente
	where clientebk = 'CLIB1';

	update NORTHWND.dbo.Customers 
	set CompanyName = 'Pepsi' where CustomerID = 'CLIB1'

end

truncate table etlempresa.dbo.cliente

create table Producto(
	productoid int not null identity(1,1),
	productobk int not null,
	nombreproducto nvarchar(40) not null,
	categoria nvarchar(15) not null,
	precio money not null,
	existencia int not null,
	descontinuado bit not null,
	constraint pk_producto primary key (productoid)
);

create proc sp_etl_carga_Producto
as begin

	insert into ETLEmpresa.dbo.Producto
	select p.ProductID, upper(p.ProductName) as 'NombreProducto', upper(c.CategoryName) as 'NombreCategoria', p.UnitPrice, p.UnitsInStock, p.Discontinued
	from NORTHWND.dbo.Products as p
	inner join NORTHWND.dbo.Categories as c
	on c.CategoryID = p.CategoryID
	left join ETLEmpresa.dbo.Producto as etle
	on p.CategoryID = etle.productobk
	where etle.productobk is null

	update p
	set p.nombreproducto = upper(pr.ProductName),
		p.categoria = upper(c.CategoryName),
		p.precio = upper(pr.UnitPrice),
		p.existencia = upper(pr.UnitsInStock),
		p.descontinuado = upper(pr.Discontinued)
	from NORTHWND.dbo.Products as pr
	inner join NORTHWND.dbo.Categories as c
	on c.CategoryID = pr.CategoryID
	inner join ETLEmpresa.dbo.Producto as p
	on p.productobk = pr.ProductID;

	--select * from NORTHWND.dbo.Products
	--where ProductID = 2;

	--select * from ETLEmpresa.dbo.Producto
	--where productobk = 2;

	--update NORTHWND.dbo.Products 
	--set UnitsInStock = 20 where ProductID = 2

end

truncate table etlempresa.dbo.Producto


create table Empleado(
	empleadoid int not null identity(1,1),
	empleadobk int not null,
	nombrecompleto nvarchar(30) not null,
	ciudad nvarchar(15) not null,
	region nvarchar(15) not null,
	pais nvarchar(15) not null,
	constraint pk_empleado primary key(empleadoid)
);

select * from Empleado

create proc sp_etl_carga_Empleado
as begin

	insert into ETLEmpresa.dbo.Empleado
	select e.EmployeeID, upper(concat(e.FirstName, ' ', e.LastName)) as 'NombreCompleto', upper(e.City) as 'Ciudad', upper(isnull(e.Region, 'SIN REGION')) as 'Region', upper(e.Country) as 'Pais'
	from NORTHWND.dbo.Employees as e
	left join ETLEmpresa.dbo.Empleado as em
	on e.EmployeeID = em.empleadobk
	where em.empleadobk is null;

	update em
	set em.nombrecompleto = upper(concat(e.FirstName, ' ', e.LastName)),
		em.ciudad = upper(e.City),
		em.region = upper(isnull(e.Region, 'SIN REGION')),
		em.pais = upper(e.Country)
	from NORTHWND.dbo.Employees as e
	inner join ETLEmpresa.dbo.Empleado as em
	on e.EmployeeID = em.empleadobk

	--select * from NORTHWND.dbo.Employees
	--where EmployeeID = 5;

	--select * from ETLEmpresa.dbo.Empleado
	--where empleadoid = 5;

	--update NORTHWND.dbo.Employees 
	--set FirstName = 'Andrew' where EmployeeID = 5

end

truncate table etlempresa.dbo.Empleado
go


create table Proveedor(
	proveedorid int not null identity(1,1),
	proveedorbk int not null,
	empresa nvarchar(50) not null,
	ciudad nvarchar(15) not null,
	region nvarchar(15) not null,
	pais nvarchar(15) not null,
	homepage ntext not null,
	constraint pk_proveedor primary key (proveedorid)
);

select * from NORTHWND.dbo.Suppliers

create proc sp_etl_carga_Proveedor
as begin

	insert into ETLEmpresa.dbo.Proveedor
	select s.SupplierID, upper(s.CompanyName) as 'NombreCompañia', upper(s.City) as 'Ciudad', upper(isnull(s.Region, 'SIN REGION')) as 'Region', upper(s.Country) as 'Pais', isnull(s.HomePage, 'SIN URL') as 'Url'
	from NORTHWND.dbo.Suppliers as s
	left join ETLEmpresa.dbo.Proveedor as p
	on s.SupplierID = p.proveedorid
	where p.proveedorbk is null;

	update p 
	set p.empresa = upper(s.CompanyName),
		p.ciudad = upper(s.City),
		p.region = upper(isnull(s.region, 'SIN REGION')),
		p.pais = upper(s.Country),
		p.homepage = isnull(s.HomePage, 'SIN URL')
	from NORTHWND.dbo.Suppliers as s
	inner join ETLEmpresa.dbo.Proveedor as p
	on s.SupplierID = p.proveedorid

	--select * from NORTHWND.dbo.Suppliers
	--where SupplierID = 2;

	--select * from ETLEmpresa.dbo.Proveedor
	--where proveedorid = 2;
	
	--update NORTHWND.dbo.Suppliers 
	--set city = 'Tepeji' where SupplierID = 2

end

truncate table etlempresa.dbo.Proveedor


create table Ventas(
	clienteid int not null,
	--clientebk nchar(5) not null,
	productoid int not null,
	empleadoid int not null,
	proveedorid int not null,
	cantidad smallint not null,
	precio money not null,
	constraint fk_cliente foreign key(clienteid) references Cliente(clienteid),
	constraint fk_producto foreign key(productoid) references Producto(productoid),
	constraint fk_empleado foreign key(empleadoid) references Empleado(empleadoid),
	constraint fk_proveedor foreign key(proveedorid) references Proveedor(proveedorid)
);

drop table Ventas

create proc sp_etl_carga_Ventas
as begin

	insert into ETLEmpresa.dbo.Ventas
	select c.clienteid, p.productoid, e.empleadoid, pr.proveedorid, od.Quantity, od.UnitPrice
	from NORTHWND.dbo.[Order Details] as od
	inner join NORTHWND.dbo.Products as pro
	on od.ProductID = pro.ProductID
	inner join NORTHWND.dbo.Suppliers as su
	on su.SupplierID = pro.SupplierID
	inner join NORTHWND.dbo.Orders as o
	on o.OrderID = od.OrderID
	inner join NORTHWND.dbo.Employees as em
	on em.EmployeeID = o.EmployeeID
	inner join NORTHWND.dbo.Customers as cu
	on cu.CustomerID = o.CustomerID
	inner join ETLEmpresa.dbo.Producto as p
	on p.productoid = pro.ProductID
	inner join ETLEmpresa.dbo.Empleado as e
	on e.empleadoid = em.EmployeeID
	inner join ETLEmpresa.dbo.Proveedor as pr
	on pr.proveedorid = su.SupplierID
	inner join ETLEmpresa.dbo.Cliente as c
	on c.clientebk = cu.CustomerID
	left join ETLEmpresa.dbo.Ventas as v
	on od.OrderID = v.productoid
	where v.clienteid is null;
	select * from Ventas;
	select * from NORTHWND.dbo.Customers;

	update p 
	set p.empresa = upper(s.CompanyName),
		p.ciudad = upper(s.City),
		p.region = upper(isnull(s.region, 'SIN REGION')),
		p.pais = upper(s.Country),
		p.homepage = isnull(s.HomePage, 'SIN URL')
	from NORTHWND.dbo.Suppliers as s
	inner join ETLEmpresa.dbo.Proveedor as p
	on s.SupplierID = p.proveedorid

	--select * from NORTHWND.dbo.Suppliers
	--where SupplierID = 2;

	--select * from ETLEmpresa.dbo.Proveedor
	--where proveedorid = 2;
	
	--update NORTHWND.dbo.Suppliers 
	--set city = 'Tepeji' where SupplierID = 2

end

truncate table etlempresa.dbo.Proveedor

select * from Cliente
