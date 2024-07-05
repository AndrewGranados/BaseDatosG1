--Declaracion de y uso de variables en transact-sql

--Declaración de una variable
declare @numeroCal int
declare @calif decimal(10,2)

--Asignación de variables
set @numeroCal = 10
if @numeroCal <= 0
begin
    set @numeroCal = 1
end

declare @i = 1
while (@i <= @numeroCal)
    begin
    set @calif = @calif + 10
    set @i = @i + 1
end
    set @calif = @calif / @numeroCal
print('El resultado es: '+ @calif)


--Parametros salida
create or alter procedure calcular_area

--parametros de entrada
@radio float,

--parametro de salida
@area float output

as 
begin
	set @area = PI() * @radio*@radio;
end
go

declare @resp float
exec calcular_area @radio = 23.3, @area = @resp output
print 'El area es: ' + cast(@resp as varchar)


select CONCAT(FirstName, ' ', LastName) as 'Full name' from Employees where EmployeeID = 10;
go

create or alter procedure sp_ObtenerDatosEmpleado 
@numeroEmpleado int, 
@fullname nvarchar(35) output
as 
begin
select @fullname=CONCAT(FirstName, ' ', LastName) from Employees where EmployeeID = @numeroEmpleado
	if @fullname is null
	begin
		print 'No existe ningun registro';
	end
end;
go

declare @nombre varchar(35)
exec sp_ObtenerDatosEmpleado @numeroEmpleado = 9, @fullname = @nombre output
print 'El nombre completo es: '+@nombre