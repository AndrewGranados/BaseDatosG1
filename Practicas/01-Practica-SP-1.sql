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