use NORTHWND

create or alter proc Nombre
--parametros

as begin
	begin transaction 
	begin try

	commit transaction
	end try
	begin catch

	end catch
end
go

--ejercicio1. realizar un sp que actualice los precios de un producto y despues que guarde esa modificacion en una tabla de historicos
--PreciosHistoricos
create table PreciosHistoricos(
	idprecios int identity(1,1) not null,
	precioAnterior money not null,
	precioNuevo money not null,
	fechaMod date default getdate(),
	constraint pk_precios primary key(idprecios)
)
--drop table PreciosHistoricos

create or alter proc CambiosPrecios
--parametros
@id int,
@precioNuevo money
as begin
	begin transaction;
	begin try

	declare @precioAntiguo money

	SELECT @precioAntiguo = UnitPrice
	FROM Products
	WHERE ProductID = @id;

	INSERT INTO PreciosHistoricos (precioAnterior, precioNuevo)
	VALUES (@precioAntiguo, @precioNuevo);
	
	UPDATE Products
	SET UnitPrice = @precioNuevo
	WHERE ProductID = @id;
	
	commit transaction;
	end try

	begin catch
	rollback transaction;

	declare @MensajeError varchar(100);
		set @MensajeError = ERROR_MESSAGE();
		print @MensajeError;

	end catch
end
go

exec CambiosPrecios 5, 20

select * from PreciosHistoricos;

select * from Products;

--ejercicio2. realizar un sp que elimine una orden de compra completa y debe actualizar los unitinstock en producto
--products
--orders
--ordersdetails

create or alter proc EliminarOrdenCompra
--parametros
@idOrder int

as begin
	begin transaction 
	begin try
		
		update p
		set UnitsInStock = p.UnitsInStock + od.Quantity
		from Products as p
		inner join [Order Details] as od
		on od.OrderID = p.ProductID
		where od.OrderID = @idOrder;

		DELETE FROM [Order Details] WHERE OrderID = @idOrder;
		DELETE FROM Orders WHERE OrderID = @idOrder;

	commit transaction;

	end try
	begin catch

	declare @MensajeError varchar(100);
	set @MensajeError = ERROR_MESSAGE();
	print @MensajeError;

	end catch
end
go

exec EliminarOrdenCompra @idOrder = 10251

select * from [Order Details]
where OrderID = 10251

select * from Orders
where OrderID = 10251

select * from Products
where ProductID in (22,57,65)
