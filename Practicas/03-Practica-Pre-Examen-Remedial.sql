USE BDEJEMPLO2;
go

create or alter proc SPU_realizar_pedido
@numeroPedido int,
@fecha date,
@cliente int,
@repre int,
@fab char(3),
@prod char(5),
@cantidad int,
@mensaje nvarchar(50) output
as
begin
	declare @stock int;
	declare @precio money;

	select @stock = stock, @precio = precio
	from Productos
	where Id_fab = @fab and Id_producto = @precio;

	if @stock >= @cantidad
	begin
		insert into Pedidos
		values(@numeroPedido, @fecha, @cliente, @repre, @fab, @prod, @cantidad, @cantidad*@precio)

		update Productos
		set Stock = Stock - @cantidad
		where Id_fab = @fab and Id_producto = @prod;

		set @mensaje = 'Se insertó correctamente';
	end
	else
	begin
		set @mensaje = 'No existe suficiente stock'
	end
end
go

exec SPU_realizar_pedido 
go


---------------CONSULTAS DEL EXAMEN REMEDIAL---------------
--CONSULTA N.1
select pe.Num_Pedido, pe.Fecha_Pedido, c.Empresa, c.Limite_Credito
from pedidos as pe
inner join Clientes as c
on pe.Cliente = c.Num_Cli
where c.Limite_Credito in (50000, 100000, 150000)
go

--CONSULTA N.2
select r.Nombre, r.Ventas, o.Ciudad, r.Ventas
from Representantes as r
inner join Oficinas as o
on o.Oficina = r.Oficina_Rep
where r.Ventas between 5000 and 200000
go

--CONSULTA N.3
select p.Id_producto, p.Stock
from productos as p
go

--CONSULTA N.4
select r.Nombre, r.Ventas, o.Region
from Representantes as r
inner join Oficinas as o
on o.Oficina = r.Oficina_Rep
where r.Ventas > 10000 and o.Region = 'Este'
go

--SP N.5
create or alter proc spu_1
as
begin
	select  c.Empresa, p.Importe, p.Cantidad
	from Clientes as c
	left join Pedidos as p
	on c.Num_Cli = p.Cliente
	where p.cantidad > 2
	order by c.Empresa asc
end

exec spu_1