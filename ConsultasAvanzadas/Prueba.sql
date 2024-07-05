create database PruebaCargaDinamica;
use PruebaCargaDinamica;

--drop database pruebacargadinamica
select top 0
    EmployeeID, FirstName, LastName, [Address], HomePhone, Country
into PruebaCargaDinamica.dbo.Empleado
from NORTHWND.dbo.Employees;

select *
from Empleado;

insert into PruebaCargaDinamica.dbo.Empleado
    (FirstName, LastName, [Address], HomePhone, Country)
select FirstName, LastName, [Address], HomePhone, Country
from NORTHWND.dbo.Employees;

select top 0
    EmployeeID, FirstName, LastNAme, [Address], HomePhone, Country
into PruebaCargaDinamica.dbo.DimEmpleado
from PruebaCargaDinamica.dbo.Empleado;

select * from DimEmpleado;
select * from Empleado;

--drop table DimEmpleado;
--drop table Empleado;

DELETE FROM Empleado WHERE EmployeeID = 10

insert into DimEmpleado
    (FirstName, LastNAme, [Address], HomePhone, Country)
select FirstName, LastName, [Address], HomePhone, Country
from PruebaCargaDinamica.dbo.Empleado;


Insert into PruebaCargaDinamica.dbo.Empleado
    (FirstName, LastNAme, [Address], HomePhone, Country)
values
    ('Aleks', 'Garcia', 'Tepatepec', '+52 7721131270', 'MEX');

select concat(FirstName, ' ', LastNAme) as 'NombreCompleto', [Address], HomePhone, Country
from DimEmpleado;
select *
from DimEmpleado;



