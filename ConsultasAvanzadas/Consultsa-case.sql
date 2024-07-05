
--case primera forma
select productname, unitprice, UnitsInStock, Discontinued,
case discontinued 
when 0 then 'No Disponible'
when 1 then 'Disponible'
else 'No existente'
end as 'Disponobilidad'
from products

--case segunda forma
select productname, unitprice, UnitsInStock, 
Discontinued,
disponibilidad = case discontinued 
when 0 then 'No Disponible'
when 1 then 'Disponible'
else 'No existente'
end
from products


select productname, UnitsInStock, unitprice,
case 
when UnitPrice >= 1 and UnitPrice <= 18 then 'Producto Barato'
when UnitPrice >=18 and UnitPrice <= 50 then 'Producto Accesible'
when UnitPrice between 51 and 100 then 'Producto Caro' 
else 'Carisimo'
end as 'Categoria de Precios'
from products where productid in (29,39)




use AdventureWorks2019;

select BusinessEntityID, SalariedFlag from HumanResources.Employee
order by 
case SalariedFlag 
when 1 then BusinessEntityID 
end desc,
case
when SalariedFlag = 0 then BusinessEntityID
end asc;

select BusinessEntityID, LastName, TerritoryName, CountryRegionName 
from sales.vSalesPerson
where TerritoryName is not null
order by 
	case CountryRegionName
	when 'United States' then TerritoryName
	else CountryRegionName
	end
;


--is null
select v.AccountNumber, v.Name, v.PurchasingWebServiceURL as 'PurchasinWebServiceURL' 
from [Purchasing].[Vendor] as v;

--is null -> no url
select v.AccountNumber, v.Name, isnull(v.PurchasingWebServiceURL, 'No URL') as 'PurchasinWebServiceURL' 
from [Purchasing].[Vendor] as v;

--is null -> case
select v.AccountNumber, v.Name, 
	case 
	when v.PurchasingWebServiceURL is null then 'No URL' 
	end
	as 'PurchasinWebServiceURL' 
from [Purchasing].[Vendor] as v
where AccountNumber = 'WIDEWOR0001';


--if -> estructura de control
--iff -> funcion 
--FUNCION IIF 
select iif(1=1, 'Verdadero', 'Falso') as 'Resultado'
create view vista_genero
as
select e.LoginID, e.JobTitle, iif(e.gender = 'F', 'Mujer', 'Hombre') as 'Sexo' 
from HumanResources.Employee as e;

select lower(JobTitle) as 'Titulo' from vista_genero where sexo = 'Mujer';
select upper(JobTitle) as 'Titulo' from vista_genero where sexo = 'Hombre';

--TABLAS TEMPORALES
--MERGE
select object_id(N'tempdb..#StudentsC1')
select object_id(N'tempdb..#StudentsC2')

IF OBJECT_ID (N'tempdb..#StudentsC1') is not NULL
begin
    drop table #StudentsC1;
end

CREATE TABLE #StudentsC1(
    StudentID INT,
    StudentName VARCHAR(50),
    StudentStatus BIT
);

INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)

IF OBJECT_ID(N'tempdb..#StudentsC2') is not NULL
begin
drop table #StudentsC2
END

CREATE TABLE #StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)

select * from #StudentsC1;
select * from #StudentsC2;

select * from #StudentsC1 as s1 
inner join #StudentsC2 as s2
on s1.StudentID = s2.StudentID;

select * from #StudentsC1 as s1 
right join #StudentsC2 as s2
on s1.StudentID = s2.StudentID;

--insertar datos de la tabla1 en tabla2
insert into #StudentsC2 (StudentID, StudentName, StudentStatus) 
select s1.StudentID, s1.StudentName, s1.StudentStatus from #StudentsC1 as s1 
left join #StudentsC2 as s2
on s1.StudentID = s2.StudentID
where s2.StudentID is null;

--actualizar los campos de la tabla2 
update s2
set s2.StudentName = s1.StudentName ,
    s2.StudentStatus = s1.StudentStatus
from #StudentsC1 as s1 
inner join #StudentsC2 as s2
on s1.StudentID = s2.StudentID;