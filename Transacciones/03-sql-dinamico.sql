use NORTHWND;
go

--crear un sp que reciba como parametro de entrada el nombre de una tabla y visualice todos sus registros

create or alter proc spu_mostrar_datos_tabla
@tabla varchar(100)
as
begin
	--SQL Dinámico
	declare @sql nvarchar(max);
	set @sql = 'select * from ' + @tabla;
	
	exec(@sql);
end;
go

exec spu_mostrar_datos_tabla 'products'

create or alter proc spu_mostrar_datos_tabla2
@tabla varchar(100)
as
begin
	--SQL Dinámico
	declare @sql nvarchar(max);
	set @sql = 'select * from ' + @tabla;
	
	exec sp_executesql @sql;
end;
go

exec spu_mostrar_datos_tabla2 'products'