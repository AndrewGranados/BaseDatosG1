use NORTHWND;

--Transaccion: Las transacciones en SqlServer son fundamentales para asegurar la 
--consistencia y la integridad de los datos en una base de datos 

--Una transacci�n es una unidad de trabajo que se ejecuta de manera completamente
--exitosa o no se ejecuta en absoluto

--sigue el principio ACID:
	--Atomicidad: Toda la transacci�n se completa o no se realiza nada
	--Consistencia: La transacci�n lleva la base de datos de un estado v�lido a otro
	--Aislamiento: Las transacciones concurrentes no interfieren entre si
	--Durabilildad: Una vez que una transacci�n se completa los cambios son permanentes

--Comandos a utilizar:
	--Begin transaction: inicia una nueva transacci�n
	--Commit transaction: confirma todos los cambios realizados durante la transacci�n
	--Rollback transaction: revierte todos los cambios realizados durante la transacci�n

select * from Categories;
go

--delete from Categories where CategoryID in (10,12);

begin transaction;

insert into Categories(CategoryName, Description)
values('Los remediales', 'Estar� muy bien');
go

rollback transaction;

commit transaction;


create database pruebaTransacciones;
go

use pruebaTransacciones;
go

create table Empleado(
	empleadoid int not null,
	nombre varchar(30) not null,
	salario money not null,
	constraint pk_empleado primary key (empleadoid),
	constraint chk_salario  check(salario > 0.0 and salario <= 50000)
);
go

create or alter proc spu_agregar_empleado
--parametros de entrada
@empleadoid int,
@nombre varchar(30),
@salario money
as
begin
	begin try
		begin transaction;

		--inserta en la tabla empledos
		insert into Empleado(empleadoid, nombre, salario) 
		values(@empleadoid, @nombre, @salario);

		--se confirma la transacci�n si todo sale bien
		commit transaction;

	end try

	begin catch
		--si falla revierte los cambios
		rollback transaction;
		
		--obtener el error
		declare @MensajeError nvarchar(4000)
		set @MensajeError = ERROR_MESSAGE();
		print @MensajeError;

	end catch;
end;
go

exec spu_agregar_empleado 1, 'Aleks Andrew', 21000
go

select * from Empleado;
go

exec spu_agregar_empleado 2, 'Diego waifu', 50000
go