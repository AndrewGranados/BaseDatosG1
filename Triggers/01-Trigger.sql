/*
create trigger Nombre-trigger
on tabla
after [insert], [delete], [update]
as
begin
	...
end
*/

create database PruebaTriggersG1;

use PruebaTriggersG1;

create table Empleado(
	idempleado int not null primary key,
	nombreempleado varchar(30) not null,
	apellido1 varchar(15) not null,
	apellido2 varchar(15),
	salario money not null
);
go

/*create or alter trigger tg_1
on empleado
after insert 
as
begin
	print 'Se ejecutó el trigger tg_1 en el evento insert'
end;
go*/

--select * from empleado;

insert into Empleado
values (2, 'Rocio', 'Cruz', 'Cervantes', 8000);

drop trigger tg_1

create or alter trigger tg_2
on empleado
after insert
as
begin
	select * from inserted;
	select * from deleted;
end;
go

create or alter trigger tg_3
on empleado
after delete
as
begin
	select * from inserted;
	select * from deleted;
end;
go

delete empleado where idempleado = 2;

create or alter trigger tg_4
on empleado
after update
as
begin
	select * from inserted;
	select * from deleted;
end;
go

update empleado 
set nombreempleado = 'Jose'
where idempleado =1

select * from empleado;

create or alter trigger tg_5
on empleado
after insert, delete
as
begin
	if exists(select 1 from inserted)
	begin
		print 'Se realizó un insert'
	end
	else if exists(select 1 from deleted) and not exists(select 1 from inserted)
	begin
		print 'Se realizó un delete'
	end
end;
go

insert into empleado
values (2, 'Leslie', 'Delia', 'Nery', 10000)

delete from empleado 
where idempleado = 2
