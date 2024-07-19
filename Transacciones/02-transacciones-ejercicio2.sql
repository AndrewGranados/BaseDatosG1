--Ejercicio 2. insertar una venta
use NORTHWND;

select * from Orders;

create or alter proc spu_Agregar_venta
--Order
@CustomerID nchar(5),
@EmployeeID int,
@OrderDate datetime,
@RequiredDate datetime,
@ShippedDate datetime,
@ShipVia int,
@Freight money = null,
@ShipName nvarchar(40) = null,
@ShipAddress nvarchar(60) = null,
@ShipCity nvarchar(15) = null,
@ShipRegion nvarchar(15) = null,
@ShipPostalCode nvarchar(10) = null,
@ShipCountry nvarchar(15) = null,
--OrderDetail
--@OrderID int,
@ProductID int,
--@UnitPrice money,
@Quantity smallint,
@Discount real = 0
as 
begin 
	BEGIN TRANSACTION;
	BEGIN TRY
		INSERT INTO [dbo].[Orders]
           ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
     VALUES(
	@CustomerID,
	@EmployeeID,
	@OrderDate,
	@RequiredDate,
	@ShippedDate,
	@ShipVia,
	@Freight,
	@ShipName,
	@ShipAddress,
	@ShipCity,
	@ShipRegion,
	@ShipPostalCode,
	@ShipCountry);
		
	--obtener el id inseado en orders
	declare @orderid int;
	set @orderid = SCOPE_IDENTITY();

	--obtener el precio del producto
	declare @precioventa money
	select @precioventa = UnitPrice from Products 
	where ProductID = @ProductID

	--insertar en orders details
	INSERT INTO [dbo].[Order Details]
           ([OrderID]
           ,[ProductID]
           ,[UnitPrice]
           ,[Quantity]
           ,[Discount])
     VALUES(
	 @orderid,
	 @ProductID,
	 @precioventa,
   	 @Quantity,
	 @Discount)

	 --actualizar la tabla products en el campo UnitInStock
	 update Products
	 set UnitsInStock = UnitsInStock-@Quantity
	 where ProductID = @ProductID;

	 COMMIT TRANSACTION;

	END TRY
	BEGIN CATCH
	ROLLBACK TRANSACTION;

	declare @MensajeError nvarchar(4000);
	set @MensajeError = ERROR_MESSAGE();
	print @MensajeError;

	END CATCH

end; 
go