use NORTHWND;

--procedimiento para actualizar el precio de un producto y registrar el cambio
--proceso: paso n.1 -> crear un sp "ActualizarPrecioProducto"
--paso n.2 -> crear una tabla que se llame cambio de precios, los campos que va a tener es: 
--cambioid int identity(1,1) primary key
--productoid int 
--precioAnterior money
--precioNuevo money
--fechaCambio daytime  (getDate())
--paso n.3 -> debe aceptar 2 parametros, el producto a cambiar y el nuevo precio
--paso n.4 -> el procedimiento debe actualizar el precio del producto a la tabla products
--paso n.5 -> el procedimiento debe insertar un registro en la tabla cambio de precios con los detalles del cambio

create table CambioDePrecios(
	cambioid int identity(1,1) not null,
	productoid int not null,
	precioAnterior money not null,
	precioNuevo money not null,
	fechaCambio datetime not null
	constraint pk_CambioPrecio primary key (cambioid)
);

select * from Products

create or alter proc sp_ActualizarPrecioProducto
@id int,
@precioNuevo money
begin
as
	declare @precioAntiguo money;
	select @precioAntiguo =  UnitPrice from Products where ProductID = 1 --@id
	print @precioAntiguo

	UPDATE Products 
    SET UnitPrice = 20.0--@precioNuevo
    WHERE ProductID = 1 --@id;
end;
go
