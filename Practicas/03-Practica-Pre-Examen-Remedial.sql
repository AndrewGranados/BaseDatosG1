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