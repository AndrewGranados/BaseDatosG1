use NORTHWND;
go
--crear un sp que solicite un id de una categoria y devulva el promedio de los precios de sus productos

create or alter proc sp_SolicitarPromedioProductos
@catego int --parametro de entrada
as
begin
	select avg(UnitPrice) as 'PromedioPreciosProductos'
	from Products where CategoryID = @catego;
end
go

exec sp_SolicitarPromedioProductos 2
exec sp_SolicitarPromedioProductos @catego = 5
exec sp_SolicitarPromedioProductos @catego = 3

--crear un storage procedures que reciba 2 fechas y devuelva una lista de empleados (nombres full, hiredate) que fueron contratados en ese rano de fechas
create or alter proc listadoEmpleados
@fecha1 date,
@fecha2 date
as
begin
	select concat(e.FirstName, ' ', e.LastName) as 'NombreCompleto', e.HireDate as 'FechaContratacion' from Employees as e
	where HireDate between @fecha1 and @fecha2
end

exec listadoEmpleados '1992-05-01', '1992-12-01'

