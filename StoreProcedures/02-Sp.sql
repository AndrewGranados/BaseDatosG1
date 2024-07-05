use NORTHWND;
--crear un store procedures
create procedure sp_prueba_g1
as 
begin 
    print 'Hola mundo'; 
end 

--ejecutar un store procedures
exec sp_prueba_g1

--declaracion de variables
Declare @n int
declare @i int

--asignación de valor
set @n = 5;
set @i = 1;

print('El valor de n es: ' + cast(@n as varchar))
print('El valor de i es: ' + cast(@i as varchar))

--crear otra base de datos
create database prueba_sp;
use prueba_sp;

create procedure sp_1
as 
begin
	Declare @n int
	declare @i int

	set @n = 5;
	set @i = 1;

	print('El valor de n es: ' + cast(@n as varchar))
	print('El valor de i es: ' + cast(@i as varchar))
end

execute sp_1;

--ejecutar 10 veces sp_1, solamente si el sentinela es 1


create procedure sp_2
as 
begin
	declare @n int = 10, @i int = 1;

	while @i <= @n begin
		print(@i);
		set @i += 1; --set @i = @i + 1
	end
end

execute sp_2

--store procedure con parametros de entrada
create proc sp_3
	@n int --parametro de entrada
as 
begin
declare @i int = 1

if @n > 0 
	begin
		while @i <= @n 
		begin
			print(@i);
			set @i += 1; --set @i = @i + 1
		end
	end
	else
	begin
		print 'El valor de n debe ser mayor a 0';
	end
end

exec sp_3 4
exec sp_3 @n = 20

--sp de un acumulador
create or alter proc sp_4 --para crear cuando no existe y modificar cuando ya existe
	@n int --parametro de entrada
as 
begin
declare @i int = 1, @acum int = 0;

if @n > 0 
	begin
		while @i <= @n 
		begin
			set @acum = @acum + @i 
			set @i += 1; --set @i = @i + 1
		end
			print('la suma de los numeros es: ' + cast(@acum as varchar));
	end
	else
	begin
		print 'El valor de n debe ser mayor a 0';
	end
end

execute sp_4 10

drop procedure sp_4 

--seleccionar de la base de datos NORTHWND todas las ordenes de compra para un año determinado
use NORTHWND

--select * from Orders where year(OrderDate) = 1996;

create or alter proc sp_5 
	@n int 
as 
begin
	select * from Orders where datepart(year, OrderDate) = @n;
end

execute sp_5 1998;


select p.ProductName ,year(o.OrderDate), sum(od.Quantity * od.UnitPrice) as 'TotalVentas'  from [Order Details] as od
inner join
orders as o
on o.OrderID = od.OrderID
inner join Products as p
on p.ProductID = od.ProductID
group by year(o.OrderDate)

