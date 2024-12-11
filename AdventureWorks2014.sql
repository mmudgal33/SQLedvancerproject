USE AdventureWorks2014;
SELECT @@VERSION;
select DB_NAME();
SELECT ORIGINAL_LOGIN(), CURRENT_USER, SYSTEM_USER;

SELECT NationalIDNumber,
LoginID,
JobTitle
FROM HumanResources.Employee;

SELECT *
FROM HumanResources.Employee;

SELECT Title, FirstName, LastName
FROM Person.Person
WHERE Title = 'Ms.';

SELECT Title, FirstName, LastName
FROM Person.Person
WHERE Title = 'Ms.' AND LastName = 'Antrim';

SELECT Title, FirstName, LastName
FROM Person.Person
WHERE Title = 'Ms.' AND
(LastName = 'Antrim' OR LastName = 'Galvin')

SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'HumanResources';

SELECT *
FROM sys.tables

SELECT name
FROM sys.tables
WHERE SCHEMA_NAME(schema_id)='HumanResources';

/*SELECT 'DROP ' + table_schema + '.' + table_name + ';'
FROM information_schema.tables
WHERE table_schema = 'HumanResources'
AND table_type = 'BASE TABLE';*/

SELECT BusinessEntityID AS "Employee ID",
VacationHours AS "Vacation",
SickLeaveHours AS "Sick Time"
FROM HumanResources.Employee;

SELECT E.BusinessEntityID AS "Employee ID",
E.VacationHours AS "Vacation",
E.SickLeaveHours AS "Sick Time"
FROM HumanResources.Employee AS E
WHERE E.VacationHours > 40;

SELECT BusinessEntityID AS "EmployeeID",
VacationHours + SickLeaveHours AS "AvailableTimeOff"
FROM HumanResources.Employee;

SELECT Title, FirstName, LastName
FROM Person.Person
WHERE NOT Title = 'Ms.';

SELECT Title, FirstName, LastName
FROM Person.Person
WHERE NOT (Title = 'Ms.' OR Title = 'Mr.')

SELECT Title, FirstName, LastName
FROM Person.Person
WHERE Title = 'Ms.' AND
(FirstName = 'Catherine' OR
LastName = 'Adams');

SELECT TOP(1) 1
FROM HumanResources.Employee
WHERE SickLeaveHours > 80;

SELECT 1
WHERE EXISTS (
SELECT *
FROM HumanResources.Employee
WHERE SickLeaveHours > 40
);

SELECT SalesOrderID, ShipDate
FROM Sales.SalesOrderHeader
WHERE ShipDate BETWEEN '2011-07-23 00:00:00.0' AND '2011-07-24 23:59:59.0';

SELECT SalesOrderID, ShipDate
FROM Sales.SalesOrderHeader
WHERE ShipDate >= '2011-07-23' AND ShipDate < '2011-07-25';

SELECT ProductID, Name, Weight
FROM Production.Product
WHERE Weight IS NULL;

SELECT ProductID, Name, Weight
FROM Production.Product
WHERE Weight IS NOT NULL;

SELECT ProductID, Name, Weight
FROM Production.Product
WHERE Weight <> NULL; 
/*NULL values cannot be identified using operators such as = and <> that are designed to compare two values
and return a TRUE or FALSE result.*/

SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IN ('Silver', 'Black', 'Red');

SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color = 'Silver' OR Color = 'Black' OR Color = 'Red'

SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE 'B%';

/*% The percent sign. Represents a string of zero or more characters
_ The underscore. Represents a single character
[...] A list of characters enclosed within square brackets. Represents a single character from
among any in the list.
[^...] A list of characters enclosed within square brackets and preceded by a caret. Represents a
single character from among any not in the list.*/

SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE '%/%%' ESCAPE '/'

SELECT p.Name, h.EndDate, h.ListPrice
FROM Production.Product p
INNER JOIN Production.ProductListPriceHistory h ON
p.ProductID = h.ProductID
ORDER BY p.Name, h.EndDate;

SELECT p.Name, h.EndDate, h.ListPrice
FROM Production.Product p
INNER JOIN Production.ProductListPriceHistory h ON
p.ProductID = h.ProductID
ORDER BY p.Name ASC, h.EndDate DESC

SELECT p.Name, h.EndDate, h.ListPrice
FROM Production.Product p
INNER JOIN Production.ProductListPriceHistory h ON
p.ProductID = h.ProductID
ORDER BY p.Name ASC, h.EndDate DESC

SELECT p.Name, h.EndDate, h.ListPrice
FROM Production.Product p
INNER JOIN Production.ProductListPriceHistory h ON
p.ProductID = h.ProductID
ORDER BY p.Name, h.EndDate, p.Color

SELECT p.Name, h.EndDate, h.ListPrice
FROM Production.Product p
INNER JOIN Production.ProductListPriceHistory h ON
p.ProductID = h.ProductID
ORDER BY p.Name COLLATE Latin1_General_BIN ASC,
h.EndDate DESC;

SELECT Name, Description
FROM fn_helpcollations();

SELECT DISTINCT SUBSTRING(Name, 1, CHARINDEX('_', Name)-1)
FROM fn_helpcollations();

SELECT Name, Description
FROM fn_helpcollations()
WHERE Name LIKE 'Ukrainian%';

SELECT ProductID, Name, Weight
FROM Production.Product
ORDER BY ISNULL(Weight, 1) DESC, Weight;

/*A null weight yields a result of 1. Otherwise, the expression is itself null. Those are the only two possible
results: 1 or null. It‘s a simple matter to then append ASC or DESC to specify whether the rows returning 1 sort
last or first.*/

SELECT ProductID, Name, Weight
FROM Production.Product
ORDER BY IIF(Weight IS NULL, 1, 0), Weight;

/*The result from IIF in this example is 1 for null and zero otherwise. The normal sort order is ascending.
Rows causing the expression to evaluate to zero have non-null weights and are sorted first. The null weights
trigger IIF to return a 1, and they sort last.*/

SELECT p.ProductID, p.Name, p.Color
FROM Production.Product AS p
WHERE p.Color IS NOT NULL
ORDER BY CASE p.Color
WHEN 'Red' THEN NULL ELSE p.COLOR END;

/*The solution takes advantage of the fact that SQL Server sorts nulls first. The CASE expression returns NULL
for red-colored items, thus forcing those first. Other colors are returned unchanged. The result is all the red
items appear first in the list, and then red is followed by other colors in their natural sort order.*/

SELECT ProductID, Name
FROM Production.Product
ORDER BY Name
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

SELECT *
FROM Purchasing.PurchaseOrderHeader
TABLESAMPLE (5 PERCENT);

SELECT *
FROM Purchasing.PurchaseOrderHeader
TABLESAMPLE (200 ROWS);

DECLARE @AddressLine1 NVARCHAR(60);
DECLARE @AddressLine2 NVARCHAR(60);
SELECT @AddressLine1 = AddressLine1, @AddressLine2 = AddressLine2
FROM Person.Address
WHERE AddressID = 66;
SELECT @AddressLine1 AS Address1, @AddressLine2 AS Address2;

/*ake sure to write queries that can return at most one row. One way to be sure is to specify
either a primary key or a unique key in the WHERE clause.*/

DECLARE @AddressLine1 NVARCHAR(60) = 'Alger County Sheriff'
DECLARE @AddressLine2 NVARCHAR(60) = '101 E. Varnum'
SELECT @AddressLine1 = AddressLine1, @AddressLine2 = AddressLine2
FROM Person.Address
WHERE AddressID = 49862;
SELECT @AddressLine1, @AddressLine2;

DECLARE @AddressLine1 NVARCHAR(60) = 'Alger County Sheriff'
DECLARE @AddressLine2 NVARCHAR(60) = '101 E. Varnum'
SELECT @AddressLine1 = AddressLine1, @AddressLine2 = AddressLine2
FROM Person.Address
WHERE AddressID = 49862;
IF @@ROWCOUNT = 1
SELECT @AddressLine1, @AddressLine2
ELSE
SELECT 'Either no rows or too many rows found.';

DECLARE @AddressLine1 NVARCHAR(60);
DECLARE @AddressLine2 NVARCHAR(60);
DECLARE @OneLine NVARCHAR(120);
SELECT @AddressLine1 = AddressLine1, @AddressLine2 = AddressLine2
FROM Person.Address
WHERE AddressID = 66;
SET @OneLine = @AddressLine1 + '; ' + @AddressLine2;
SELECT @OneLine;

DECLARE @piChar NVARCHAR(4) = '3.14';
DECLARE @piNum DECIMAL (3,2);
SET @piNum = CAST(@piChar AS DECIMAL(3,2));

DECLARE @QuerySelector int = 1;
IF @QuerySelector = 1
BEGIN
SELECT TOP 3 ProductID, Name, Color
FROM Production.Product
WHERE Color = 'Silver'
ORDER BY Name;
END
ELSE
BEGIN
SELECT TOP 3 ProductID, Name, Color
FROM Production.Product
WHERE Color = 'Black'
ORDER BY Name;
END;

/*Because the solution example is written with only one statement in each block, you can omit the
BEGIN...END syntax:*/

IF EXISTS (
SELECT * FROM Production.Product
WHERE Color = 'Silver')
BEGIN
SELECT TOP 3 ProductID, Name, Color
FROM Production.Product
WHERE Color = 'Silver'
ORDER BY Name;
END
ELSE
BEGIN
SELECT TOP 3 ProductID, Name, Color
FROM Production.Product
WHERE Color = 'Black'
ORDER BY Name;
END;

DECLARE @Name nvarchar(50) = 'Engineering';
DECLARE @GroupName nvarchar(50) = 'Research and Development';
DECLARE @Exists bit = 0;
IF EXISTS (
SELECT Name
FROM HumanResources.Department
WHERE Name = @Name)
BEGIN
SET @Exists = 1;
GOTO SkipInsert;
END;
INSERT INTO HumanResources.Department
(Name, GroupName)
VALUES(@Name , @GroupName);
SkipInsert: IF @Exists = 1
BEGIN
PRINT @Name + ' already exists in HumanResources.Department';
END
ELSE
BEGIN
PRINT 'Row added';
END;

USE AdventureWorks2014;
GO
BEGIN TRY
ALTER TABLE Production.Product
DROP CONSTRAINT FK_Trap_Color;
END TRY
BEGIN CATCH
PRINT 'Ignore this failure.';
END CATCH;
GO
BEGIN TRY
DROP TABLE Production.TrapColor;
END TRY
BEGIN CATCH
PRINT 'Ignore this failure.';
END CATCH;
GO
CREATE TABLE Production.TrapColor (
Color NVARCHAR(15),
CONSTRAINT PK_TrapColor_Color
PRIMARY KEY (Color)
);
GO
BEGIN TRY
INSERT INTO Production.TrapColor (Color)
SELECT DISTINCT Color
FROM Production.Product;
END TRY
BEGIN CATCH
PRINT 'Fail!';
DROP TABLE Production.TrapColor;
THROW;
END CATCH;
GO
ALTER TABLE Production.Product ADD
CONSTRAINT FK_Trap_Color
FOREIGN KEY (Color)
REFERENCES Production.TrapColor;

/*begin end try catch*/

IF NOT EXISTS
(SELECT ProductID
FROM Production.Product
WHERE Color = 'Pink')
BEGIN
RETURN;
END;

CREATE PROCEDURE ReportPink AS
IF NOT EXISTS
(SELECT ProductID
FROM Production.Product
WHERE Color = 'Pink')
BEGIN
--Return the value 100 to indicate no pink products
RETURN 100;
END;

DECLARE @ResultStatus int;
EXEC @ResultStatus = ReportPink;
PRINT @ResultStatus;

SELECT DepartmentID AS DeptID, Name, GroupName
FROM HumanResources.Department;

SELECT DepartmentID AS DeptID, Name, GroupName,
CASE GroupName
WHEN 'Research and Development' THEN 'Room A'
WHEN 'Sales and Marketing' THEN 'Room B'
WHEN 'Manufacturing' THEN 'Room C'
ELSE 'Room D'
END AS ConfRoom
FROM HumanResources.Department;

SELECT DepartmentID, Name,
CASE
WHEN Name = 'Research and Development' THEN 'Room A'
WHEN (Name = 'Sales and Marketing' OR DepartmentID = 10) THEN 'Room B'
WHEN Name LIKE 'T%'THEN 'Room C'
ELSE 'Room D' END AS ConferenceRoom
FROM HumanResources.Department;

WHILE (1=1)
BEGIN
PRINT 'Endless While, because 1 always equals 1.';
IF 1=1
BEGIN
PRINT 'But we won''t let the endless loop happen!';
BREAK; --Because this BREAK statement terminates the loop.
END;
END;


DECLARE @n int = 1;
WHILE @n = 1
BEGIN
SET @n = @n + 1;
IF @n > 1
CONTINUE;
PRINT 'You will never see this message.';
END;

/*NULL + 10 = NULL
NULL AND TRUE = NULL
NULL OR FALSE = NULL
ISNULL ISNULL validates whether an expression is NULL and, if so, replaces the NULL value with an
alternate value.
COALESCE The COALESCE function returns the first non-NULL value from a provided list of expressions.
NULLIF NULLIF returns a NULL value when the two provided expressions have the same value.
Otherwise, the first expression is returned.*/

SELECT h.SalesOrderID,
h.CreditCardApprovalCode,
CreditApprovalCode_Display = ISNULL(h.CreditCardApprovalCode,
'**NO APPROVAL**')
FROM Sales.SalesOrderHeader h
WHERE h.SalesOrderID BETWEEN 43735 AND 43740;

SELECT ISNULL(CAST(NULL AS CHAR(10)), '20 characters*******') ;
SELECT ISNULL(1, 'String Value') ;

SELECT c.CustomerID,
SalesPersonPhone = spp.PhoneNumber,
CustomerPhone = pp.PhoneNumber,
PhoneNumber = COALESCE(pp.PhoneNumber, spp.PhoneNumber, '**NO PHONE**')
FROM Sales.Customer c
LEFT OUTER JOIN Sales.Store s
ON c.StoreID = s.BusinessEntityID
LEFT OUTER JOIN Person.PersonPhone spp
ON s.SalesPersonID = spp.BusinessEntityID
LEFT OUTER JOIN Person.PersonPhone pp
ON c.CustomerID = pp.BusinessEntityID
ORDER BY CustomerID ;

SELECT COALESCE(1, 5) ;
SELECT COALESCE('five', 5) ;

DECLARE @i INT = NULL ;
SELECT ISNULL(@i, 'five') ;

DECLARE @sql NVARCHAR(MAX) = '
SELECT TOP 10
FirstName,
LastName,
MiddleName_ISNULL = ISNULL(MiddleName, ''''),
MiddleName_COALESCE = COALESCE(MiddleName, '''')
FROM Person.Person ;
' ;
EXEC sp_executesql @sql ;
SELECT column_ordinal,
name,
is_nullable
FROM master.sys.dm_exec_describe_first_result_set(@sql, NULL, 0) a ;

/*The nullability of ISNULL will always be false if at least one of the inputs is not nullable. COALESCE’s
nullability will be false only if all inputs are not nullable.*/

/*The first hurdle to overcome when working with NULLs is to remove this WHERE clause from your mind:
WHERE SomeColumn = NULL. The second hurdle is to remove this clause: WHERE SomeCol <> NULL. NULL is an
“unknown” value. SQL Server cannot evaluate any operator where an input to the operator is unknown.*/

/*To search for NULL values, use IS NULL and IS NOT NULL. Specifically, IS NULL returns TRUE if the
operand is NULL, and IS NOT NULL returns TRUE if the operand is defined as (NOT NULL). Take the following
statement:*/

DECLARE @value INT = NULL;
SELECT CASE WHEN @value = NULL THEN 1
WHEN @value <> NULL THEN 2
WHEN @value IS NULL THEN 3
ELSE 4
END ;

SELECT TOP 5
LastName, FirstName, MiddleName
FROM Person.Person
WHERE MiddleName IS NULL ;

SET SHOWPLAN_TEXT ON ;
GO
SELECT JobCandidateID,
BusinessEntityID
FROM HumanResources.JobCandidate
WHERE ISNULL(BusinessEntityID, 1) <> 1 ;
GO
SET SHOWPLAN_TEXT OFF ;

SET SHOWPLAN_TEXT ON ;
GO
SELECT JobCandidateID,
BusinessEntityID
FROM HumanResources.JobCandidate
WHERE ISNULL(BusinessEntityID, 1) = BusinessEntityID ;
GO
SET SHOWPLAN_TEXT OFF ;

SET SHOWPLAN_TEXT ON ;
GO
SELECT JobCandidateID,
BusinessEntityID
FROM HumanResources.JobCandidate
WHERE BusinessEntityID IS NOT NULL ;
GO
SET SHOWPLAN_TEXT OFF ;

/*• What is the variance for all operations?
• What is the variance for all operations where the variance is not 0?*/

SELECT r.ProductID,
r.OperationSequence,
StartDateVariance = AVG(DATEDIFF(day, ScheduledStartDate,
ActualStartDate)),
StartDateVariance_Adjusted = AVG(NULLIF(DATEDIFF(day,
ScheduledStartDate,
ActualStartDate), 0))
FROM Production.WorkOrderRouting r
WHERE r.ProductID BETWEEN 514 AND 516
GROUP BY r.ProductID,
r.OperationSequence
ORDER BY r.ProductID,
r.OperationSequence ;

USE tempdb;
CREATE TABLE dbo.Product
(
ProductId INT NOT NULL
CONSTRAINT PK_Product PRIMARY KEY CLUSTERED,
ProductName NVARCHAR(50) NOT NULL,
CodeName NVARCHAR(50)
) ;
GO

CREATE UNIQUE INDEX UX_Product_CodeName ON dbo.Product (CodeName) ;
GO

INSERT INTO dbo.Product (ProductId, ProductName, CodeName) VALUES (1, 'Product 1', 'Shiloh');
INSERT INTO dbo.Product (ProductId, ProductName, CodeName) VALUES (2, 'Product 2', 'Sphynx');
INSERT INTO dbo.Product (ProductId, ProductName, CodeName) VALUES (3, 'Product 3', NULL);
INSERT INTO dbo.Product (ProductId, ProductName, CodeName) VALUES (4, 'Product 4', NULL);
GO

SELECT *
FROM dbo.Product;

CREATE TABLE dbo.Category
(
CategoryId INT NOT NULL
CONSTRAINT PK_Category PRIMARY KEY CLUSTERED,
CategoryName NVARCHAR(50) NOT NULL
) ;
GO

INSERT INTO dbo.Category (CategoryId, CategoryName)
VALUES (1, 'Category 1'),
(2, 'Category 2'),
(3, 'Category 3') ;
GO

SELECT *
FROM dbo.Category;

CREATE TABLE dbo.Item
(
ItemId INT NOT NULL
CONSTRAINT PK_Item PRIMARY KEY CLUSTERED,
ItemName NVARCHAR(50) NOT NULL,
CategoryId INTEGER NULL
CONSTRAINT FK_Item_Category REFERENCES Category(CategoryId)
) ;
GO

INSERT INTO dbo.Item (ItemId, ItemName, CategoryId) VALUES (1, 'Item 1', 1);
INSERT INTO dbo.Item (ItemId, ItemName, CategoryId) VALUES (2, 'Item 2', 4);
INSERT INTO dbo.Item (ItemId, ItemName, CategoryId) VALUES (3, 'Item 3', NULL);

SELECT *
FROM dbo.Item;

CREATE TABLE dbo.Test1
(
TestValue NVARCHAR(10) NULL
);
CREATE TABLE dbo.Test2
(
TestValue NVARCHAR(10) NULL
) ;
GO

INSERT INTO dbo.Test1
VALUES ('apples'),
('oranges'),
(NULL),
(NULL) ;
INSERT INTO dbo.Test2
VALUES (NULL),
('oranges'),
('grapes'),
(NULL) ;
GO

SELECT t1.TestValue,
t2.TestValue
FROM dbo.Test1 t1
INNER JOIN dbo.Test2 t2
ON t1.TestValue = t2.TestValue ;

select * from Test1
select * from Test2

/*Predicates in the join condition evaluate NULLs the same way as predicates do in the WHERE clause. When
SQL Server evaluates the condition t1.TestValue = t2.TestValue, the equals operator returns FALSE if one
or both of the operands is NULL; therefore, the only rows that will be returned from an INNER JOIN are rows
where neither side of the join is NULL and those non-NULL values are equal.*/


SELECT PersonPhone.BusinessEntityID,
FirstName,
LastName,
PhoneNumber
FROM Person.Person
INNER JOIN Person.PersonPhone
ON Person.BusinessEntityID = PersonPhone.BusinessEntityID
ORDER BY LastName,
FirstName,
Person.BusinessEntityID;

SELECT p.Name,
s.DiscountPct
FROM Sales.SpecialOffer s
INNER JOIN Sales.SpecialOfferProduct o
ON s.SpecialOfferID = o.SpecialOfferID
INNER JOIN Production.Product p
ON o.ProductID = p.ProductID
WHERE p.Name = 'All-Purpose Bike Stand';

/*String two inner joins together. The following example joins three tables in order to return discount
information on a specific product:*/

/*Write an outer join rather than the inner join that you have seen in the recipes so far. You can designate
an outer join as being either left or right. Following is a left outer join that produces a list of all states and
provinces, including tax rates when they are available.*/

SELECT s.CountryRegionCode,
s.StateProvinceCode,
t.TaxType,
t.TaxRate
FROM Person.StateProvince s
LEFT OUTER JOIN Sales.SalesTaxRate t
ON s.StateProvinceID = t.StateProvinceID;

select s.CountryRegionCode,
s.StateProvinceCode from Person.StateProvince s

select t.TaxType,
t.TaxRate from Sales.SalesTaxRate t

SELECT soh.SalesOrderID,
sr.SalesReasonID,
sr.Name
FROM Sales.SalesOrderHeader soh
FULL OUTER JOIN Sales.SalesOrderHeaderSalesReason sohsr
ON soh.SalesOrderID = sohsr.SalesOrderID
FULL OUTER JOIN Sales.SalesReason sr
ON sr.SalesReasonID = sohsr.SalesReasonID;

SELECT s.CountryRegionCode,
s.StateProvinceCode,
t.TaxType,
t.TaxRate
FROM Person.StateProvince s
CROSS JOIN Sales.SalesTaxRate t;

SELECT DISTINCT
s.PurchaseOrderNumber
FROM Sales.SalesOrderHeader s
INNER JOIN (SELECT SalesOrderID
FROM Sales.SalesOrderDetail
WHERE UnitPrice BETWEEN 1000 AND 2000
) d
ON s.SalesOrderID = d.SalesOrderID;

SELECT
DATENAME(MONTH,
DATEADD(MONTH,
DATEDIFF(MONTH,'19000101',OrderDate),
'19000101')
) AS Mth,
SUM(TotalDue) AS Total
FROM Sales.SalesOrderHeader
WHERE OrderDate>='20120101'
AND OrderDate<'20140101'
GROUP BY DATEADD(MONTH,
DATEDIFF(MONTH,'19000101',OrderDate),
'19000101')
ORDER BY DATEADD(MONTH,
DATEDIFF(MONTH,'19000101',OrderDate),
'19000101');

SELECT DATENAME(MONTH,FirstDayOfMth) AS Mth,
SUM(TotalDue) AS Total
FROM Sales.SalesOrderHeader
CROSS APPLY (
SELECT DATEADD(MONTH,
DATEDIFF(MONTH,'19000101',OrderDate),
'19000101') AS FirstDayOfMth
) F_Mth
where OrderDate>='20120101'
and OrderDate<'20140101'
group by FirstDayOfMth
order by FirstDayOfMth

SELECT s.PurchaseOrderNumber
FROM Sales.SalesOrderHeader s
WHERE EXISTS ( SELECT SalesOrderID
FROM Sales.SalesOrderDetail sod
WHERE sod.UnitPrice BETWEEN 1000 AND 2000
AND sod.SalesOrderID = s.SalesOrderID );

SELECT BusinessEntityID,
SalesQuota AS CurrentSalesQuota
FROM Sales.SalesPerson
WHERE SalesQuota = (SELECT MAX(SalesQuota)
FROM Sales.SalesPerson
);

SELECT BusinessEntityID,
GETDATE() QuotaDate,
SalesQuota
FROM Sales.SalesPerson
WHERE SalesQuota > 0
UNION ALL
SELECT BusinessEntityID,
QuotaDate,
SalesQuota
FROM Sales.SalesPersonQuotaHistory
WHERE SalesQuota > 0
ORDER BY BusinessEntityID DESC,
QuotaDate DESC;

/*The ORDER BY clause sorts the result set by BusinessEntitylD and QuotaDate, both in descending
order. The ORDER BY clause, when needed, must appear at the bottom of the entire statement. In the solution
query, the clause is:*/

SELECT P1.LastName
FROM HumanResources.Employee E
INNER JOIN Person.Person P1
ON E.BusinessEntityID = P1.BusinessEntityID
UNION
SELECT P2.LastName
FROM Sales.SalesPerson SP
INNER JOIN Person.Person P2
ON SP.BusinessEntityID = P2.BusinessEntityID;

SELECT P.ProductID
FROM Production.Product P
EXCEPT
SELECT BOM.ComponentID
FROM Production.BillOfMaterials BOM;

SELECT PR1.ProductID
FROM Production.ProductReview PR1
WHERE PR1.Rating >= 4
INTERSECT
SELECT PR1.ProductID
FROM Production.ProductReview PR1
WHERE PR1.Rating <= 2;

SELECT PR3.ProductID,
PR3.Name
FROM Production.Product PR3
INNER JOIN (SELECT PR1.ProductID
FROM Production.ProductReview PR1
WHERE PR1.Rating >= 4
INTERSECT
SELECT PR1.ProductID
FROM Production.ProductReview PR1
WHERE PR1.Rating <= 2
) SQ
ON PR3.ProductID = SQ.ProductID;

SELECT ProductID,
Name
FROM Production.Product
WHERE ProductID IN (SELECT PR1.ProductID
FROM Production.ProductReview PR1
WHERE PR1.Rating >= 4
INTERSECT
SELECT PR1.ProductID
FROM Production.ProductReview PR1
WHERE PR1.Rating <= 2);

SELECT ProductID,
Name
FROM Production.Product
WHERE ProductID IN (937);

SELECT ProductID
FROM Production.Product
EXCEPT
SELECT ProductID
FROM Sales.SpecialOfferProduct;

SELECT P.ProductID,
P.Name
FROM Production.Product P
WHERE NOT EXISTS ( SELECT *
FROM Sales.SpecialOfferProduct SOP
WHERE SOP.ProductID = P.ProductID );

SELECT *
INTO Person.PasswordCopy
FROM Person.Password;

/*You have two copies of a table. You want to test for equality. Do both copies have the same row and
column values?*/
SELECT *,
COUNT(*) DupeCount,
'Password' TableName
FROM Person.Password P
GROUP BY BusinessEntityID,
PasswordHash,
PasswordSalt,
rowguid,
ModifiedDate
HAVING NOT EXISTS ( SELECT *,
COUNT(*)
FROM Person.PasswordCopy PC
GROUP BY BusinessEntityID,
PasswordHash,
PasswordSalt,
rowguid,
ModifiedDate
HAVING PC.BusinessEntityID = P.BusinessEntityID
AND PC.PasswordHash = P.PasswordHash
AND PC.PasswordSalt = P.PasswordSalt
AND PC.rowguid = P.rowguid
AND PC.ModifiedDate = P.ModifiedDate
AND COUNT(*) = COUNT(ALL P.BusinessEntityID) )
UNION
SELECT *,
COUNT(*) DupeCount,
'PasswordCopy' TableName
FROM Person.PasswordCopy PC
GROUP BY BusinessEntityID,
PasswordHash,
PasswordSalt,
rowguid,
ModifiedDate
HAVING NOT EXISTS ( SELECT *,
COUNT(*)
FROM Person.Password P
GROUP BY BusinessEntityID,
PasswordHash,
PasswordSalt,
rowguid,
ModifiedDate
HAVING PC.BusinessEntityID = P.BusinessEntityID
AND PC.PasswordHash = P.PasswordHash
AND PC.PasswordSalt = P.PasswordSalt
AND PC.rowguid = P.rowguid
AND PC.ModifiedDate = P.ModifiedDate
AND COUNT(*) = COUNT(ALL PC.BusinessEntityID) );

SELECT *,
COUNT(*) DupeCount,
'PasswordCopy' TableName
FROM Person.PasswordCopy PC
GROUP BY BusinessEntityID,
PasswordHash,
PasswordSalt,
rowguid,
ModifiedDate;

/*Next comes a subquery in the HAVING clause to restrict the results to only those rows not also appearing
in the Password table:*/
HAVING NOT EXISTS ( SELECT *,
COUNT(*)
FROM Person.PasswordCopy PC
GROUP BY BusinessEntityID,
PasswordHash,
PasswordSalt,
rowguid,
ModifiedDate
HAVING PC.BusinessEntityID = P.BusinessEntityID
AND PC.PasswordHash = P.PasswordHash
AND PC.PasswordSalt = P.PasswordSalt
AND PC.rowguid = P.rowguid
AND PC.ModifiedDate = P.ModifiedDate
AND COUNT(*) = COUNT(ALL P.BusinessEntityID) )


/*AVG The AVG aggregate function calculates the average of non-NULL values in a group.
CHECKSUM_AGG The CHECKSUM_AGG function returns a checksum value based on a group of rows,
allowing you to potentially track changes to a table. For example, adding a new
row or changing the value of a column that is being aggregated will usually result
in a new checksum integer value. The reason I say “usually” is because there is a
possibility that the checksum value does not change even if values are modified.
COUNT The COUNT aggregate function returns an integer data type showing the count of rows
in a group, including rows with NULL values.
COUNT_BIG The COUNT_BIG aggregate function returns a bigint data type showing the count of
rows in a group, including rows with NULL values.
GROUPING
MAX The MAX aggregate function returns the highest value in a set of non-NULL values.
MIN The MIN aggregate function returns the lowest value in a group of non-NULL values.
STDEV The STDEV function returns the standard deviation of all values provided in the
expression based on a sample of the data population.
STDEVP The STDEVP function also returns the standard deviation for all values in the provided
expression, but does so based upon the entire data population.
SUM The SUM aggregate function returns the summation of all non-NULL values in an
expression.
VAR The VAR function returns the statistical variance of values in an expression based
upon a sample of the provided population.
VARP The VARP function returns the statistical variance of values in an expression, but does
so based upon the entire data population.*/

SELECT MIN(Rating) Rating_Min,
MAX(Rating) Rating_Max,
SUM(Rating) Rating_Sum,
AVG(Rating) Rating_Avg
FROM Production.ProductReview;

SELECT AVG(Grade) AS AvgGrade,
AVG(DISTINCT Grade) AS AvgDistinctGrade
FROM (VALUES (1, 100),
(1, 100),
(1, 100),
(1, 100),
(1, 100),
(1, 30)
) dt (StudentId, Grade);

SELECT TOP (10)
SalesOrderID,
SUM(LineTotal) AS OrderTotal,
MIN(LineTotal) AS MinLine,
MAX(LineTotal) AS MaxLine,
AVG(LineTotal) AS AvgLine,
COUNT(LineTotal) AS CountLine
FROM [Sales].[SalesOrderDetail]
GROUP BY SalesOrderID
ORDER BY SalesOrderID;

/*ORDER BY always comes last*
This error is raised because any column being returned by the query that is not used in an aggregate
function in the SELECT list must be listed in the GROUP BY clause for the query.*/

SELECT TOP (5)
Shelf,
COUNT(ProductID) AS ProductCount,
COUNT_BIG(ProductID) AS ProductCountBig
FROM Production.ProductInventory
GROUP BY Shelf
ORDER BY Shelf;

COUNT | COUNT_BIG ( { [ [ ALL | DISTINCT ] expression ] | * } )
/*beyond integer range used*/

DECLARE @test TABLE (col1 TEXT);
SELECT COUNT(*) FROM @test;
/*When utilizing the COUNT or COUNT_BIG functions, the expression parameter can be of any data type
except for the text, image, or ntext data types. For instance, for the following table variable:*/

IF OBJECT_ID('tempdb.dbo.[#Recipe5.4]') IS NOT NULL DROP TABLE [#Recipe5.4];
CREATE TABLE [#Recipe5.4]
(
StudentID INTEGER,
Grade INTEGER
);

INSERT INTO [#Recipe5.4] (StudentID, Grade)
VALUES (1, 100),
(1, 95)

SELECT * FROM [#Recipe5.4];

SELECT StudentID, CHECKSUM_AGG(Grade) AS GradeChecksumAgg
FROM [#Recipe5.4]
GROUP BY StudentID;

UPDATE [#Recipe5.4]
SET Grade = 99
WHERE Grade = 95;

SELECT StudentID, CHECKSUM_AGG(Grade) AS GradeChecksumAgg
FROM [#Recipe5.4]
GROUP BY StudentID;

/*The CHECKSUM_AGG function returns the checksum of the values in the group, in this case the values from
the Grade column. In the second query, the last grade is changed, and when the first query is rerun, the
aggregated checksum returns a different value.*/

SELECT s.Name,
COUNT(w.WorkOrderID) AS Cnt
FROM Production.ScrapReason s
INNER JOIN Production.WorkOrder w
ON s.ScrapReasonID = w.ScrapReasonID
GROUP BY s.Name
HAVING COUNT(*) > 50;

/*The HAVING clause of the SELECT statement allows you to specify a search condition on a query that uses
GROUP BY and/or an aggregated value. The syntax is as follows:*/

SELECT select_list
FROM table_list
[ WHERE search_conditions ]
[ GROUP BY group_by_list ]
[ HAVING search_conditions ]

/*The HAVING clause is used to qualify the results after the GROUP BY has been applied. The WHERE clause,
in contrast, is used to qualify the rows that are returned from the tables specified in the FROM clause before
the data is aggregated or grouped. HAVING qualifies the aggregated data after the data has been grouped.
In this recipe, the SELECT clause requests a count of WorkOrderIDs by failure name:*/

SELECT [RateChangeDate],
COUNT([Rate]) AS [Count],
COUNT(DISTINCT Rate) AS [DistinctCount]
FROM [HumanResources].[EmployeePayHistory]
WHERE RateChangeDate >= '2008-12-01'
AND RateChangeDate < '2008-12-10'
GROUP BY RateChangeDate;

/*You need to know the quantity of unique values per date.*/

SELECT RateChangeDate, Rate
FROM HumanResources.EmployeePayHistory
WHERE RateChangeDate = '2008-12-02';

SELECT i.Shelf,
p.Name,
SUM(i.Quantity) AS Total
FROM Production.ProductInventory i
INNER JOIN Production.Product p
ON i.ProductID = p.ProductID
WHERE i.Shelf IN ('A','B')
AND p.Name LIKE 'Metal%'
GROUP BY ROLLUP(i.Shelf, p.Name);

/*The order in which you place the columns in the GROUP BY ROLLUP clause affects how data is aggregated.
ROLLUP in this query aggregates the total quantity for each change in Shelf. Notice the row with shelf A and
the NULL name; this holds the total quantity for shelf A. Also notice that the final row is the grand total of
all product quantities. Whereas CUBE creates a result set that aggregates all combinations for the selected
columns, ROLLUP generates the aggregates for a hierarchy of values.*/

SELECT i.Shelf,
i.LocationID,
p.Name,
SUM(i.Quantity) AS Total
FROM Production.ProductInventory i
INNER JOIN Production.Product p
ON i.ProductID = p.ProductID
WHERE i.Shelf IN ('A','B')
AND p.Name LIKE 'Metal%'
GROUP BY i.Shelf, i.LocationID, ROLLUP(i.Shelf, p.Name)
ORDER BY i.Shelf, i.LocationID;

SELECT Shelf,
LocationID,
SUM(Quantity) AS Total
FROM Production.ProductInventory
WHERE Shelf IN ('A','B')
AND LocationID IN (10, 20)
GROUP BY CUBE(Shelf, LocationID);

/*You need to include the CUBE argument after the GROUP BY clause. This example uses the CUBE argument to
produce subtotal lines at both the Shelf and LocationID levels, as well as a grand total line:*/

SELECT Shelf,
LocationID,
SUM(i.Quantity) AS Total
FROM Production.ProductInventory i
WHERE Shelf in ('A','B')
AND LocationID in (10,20)
GROUP BY shelf, CUBE(Shelf, LocationID);

SELECT i.Shelf,
i.LocationID,
p.Name,
SUM(i.Quantity) AS Total
FROM Production.ProductInventory i
INNER JOIN Production.Product p
ON i.ProductID = p.ProductID
WHERE Shelf IN ('A', 'C')
AND Name IN ('Chain', 'Decal', 'Head Tube')
GROUP BY GROUPING SETS((i.Shelf), (i.Shelf, p.Name), (i.LocationID, p.Name));

SELECT NULL AS Shelf,
i.LocationID,
p.Name,
SUM(i.Quantity) AS Total
FROM Production.ProductInventory i
INNER JOIN Production.Product p
ON i.ProductID = p.ProductID
WHERE Shelf IN ('A', 'C')
AND Name IN ('Chain', 'Decal', 'Head Tube')
GROUP BY i.LocationID,
p.Name
UNION ALL
SELECT i.Shelf,
NULL,
NULL,
SUM(i.Quantity) AS Total
FROM Production.ProductInventory i
INNER JOIN Production.Product p
ON i.ProductID = p.ProductID
WHERE Shelf IN ('A', 'C')
AND Name IN ('Chain', 'Decal', 'Head Tube')
GROUP BY i.Shelf
UNION ALL
SELECT i.Shelf,
NULL,
p.Name,
SUM(i.Quantity) AS Total
FROM Production.ProductInventory i
INNER JOIN Production.Product p
ON i.ProductID = p.ProductID
WHERE Shelf IN ('A', 'C')
AND Name IN ('Chain', 'Decal', 'Head Tube')
GROUP BY i.Shelf,
p.Name;

/*The new GROUPING SETS operator allows you to define varying aggregate groups in a single query while
avoiding having multiple queries attached together using the UNION ALL operator. The core of this recipe’s
example is the following line of code:
GROUP BY GROUPING SETS ((i.Shelf), (i.Shelf, p.Name), (i.LocationID, p.Name))*/

SELECT CASE WHEN GROUPING(ReorderPoint) = 1 THEN '--GROUP--'
ELSE CONVERT(VARCHAR(15), ReorderPoint)
END AS ReorderPointCalc,
ReorderPoint,
CASE WHEN GROUPING(Size) = 1 THEN '--GROUP--'
ELSE CONVERT(VARCHAR(15), Size)
END AS SizeCalc,
Size,
CASE WHEN GROUPING(ReorderPoint) = 0 AND GROUPING(Size) = 1 THEN 'Size Total'
WHEN GROUPING(ReorderPoint) = 1 AND GROUPING(Size) = 0 THEN 'ReorderPoint
Total'
WHEN GROUPING(ReorderPoint) = 1 AND GROUPING(Size) = 1 THEN 'Grand Total'
ELSE 'Regular Row'
END AS RowType,
SUM(StandardCost) AS Total
FROM Production.Product
WHERE ReorderPoint = 3
GROUP BY CUBE(ReorderPoint, Size);

SELECT Shelf,
LocationID,
Bin,
CASE GROUPING_ID(Shelf, LocationID, Bin)
WHEN 1 THEN 'Shelf/Location Total'
WHEN 2 THEN 'Shelf/Bin Total'
WHEN 3 THEN 'Shelf Total'
WHEN 4 THEN 'Location/Bin Total'
WHEN 5 THEN 'Location Total'
WHEN 6 THEN 'Bin Total'
WHEN 7 THEN 'Grand Total'
ELSE 'Regular Row'
END AS GroupingType,
SUM(Quantity) AS Total
FROM Production.ProductInventory
WHERE LocationID IN (3)
AND Bin IN (1, 2)
GROUP BY CUBE(Shelf, LocationID, Bin)
ORDER BY Shelf,
LocationID,
Bin;

/*Identifying which rows belong to which type of aggregate becomes progressively more difficult for
each new column you add to the GROUP BY clause and for each unique data value that can be grouped and
aggregated. For example, this query shows the quantity of products in location 3 within bins 1 and 2:*/

SELECT Shelf,
LocationID,
Bin,
Quantity
FROM Production.ProductInventory
WHERE LocationID IN (3)
AND Bin IN (1, 2);

SELECT Shelf,
LocationID,
Bin,
SUM(Quantity) AS Total
FROM Production.ProductInventory
WHERE LocationID IN (3)
AND Bin IN (1, 2)
GROUP BY CUBE(Shelf, LocationID, Bin)
ORDER BY Shelf,
LocationID,
Bin;

/*Now, what if we needed to report aggregations based on the various combinations of Shelf, Location,
and Bin? We could use CUBE to give summaries of all these potential combinations:*/

SELECT Shelf,
LocationID,
Bin,
CASE GROUPING_ID(Shelf, LocationID, Bin)
WHEN 1 THEN 'Shelf/Location Total'
WHEN 2 THEN 'Shelf/Bin Total'
WHEN 3 THEN 'Shelf Total'
WHEN 4 THEN 'Location/Bin Total'
WHEN 5 THEN 'Location Total'
WHEN 6 THEN 'Bin Total'
WHEN 7 THEN 'Grand Total'
ELSE 'Regular Row'
END AS GroupingType,
GROUPING_ID(Shelf, LocationID, Bin) AS [G_ID],
GROUPING(Shelf) AS [G_Shelf],
GROUPING(LocationID) AS [G_Loc],
GROUPING(Bin) AS [G_Bin],
(GROUPING(Shelf)*4) + (GROUPING(LocationID)*2) + GROUPING(Bin) AS [G_Total],
SUM(Quantity) AS Total
FROM Production.ProductInventory
WHERE LocationID IN (3)
AND Bin IN (1, 2)
GROUP BY CUBE(Shelf, LocationID, Bin)
ORDER BY Shelf,
LocationID,
Bin;

SELECT i.Shelf,
i.LocationID,
i.Bin,
CASE GROUPING_ID(i.Shelf, i.LocationID, i.Bin)
WHEN 1 THEN 'Shelf/Location Total'
WHEN 2 THEN 'Shelf/Bin Total'
WHEN 3 THEN 'Shelf Total'
WHEN 4 THEN 'Location/Bin Total'
WHEN 5 THEN 'Location Total'
WHEN 6 THEN 'Bin Total'
WHEN 7 THEN 'Grand Total'
ELSE 'Regular Row'
END AS GroupingType,
CASE WHEN GROUPING(Shelf) = 0 AND GROUPING(LocationID) = 0 AND GROUPING(Bin) = 1
THEN 'Shelf/Location Total'
WHEN GROUPING(Shelf) = 0 AND GROUPING(LocationID) = 1 AND GROUPING(Bin) = 0
THEN 'Shelf/Bin Total'
WHEN GROUPING(Shelf) = 0 AND GROUPING(LocationID) = 1 AND GROUPING(Bin) = 1
THEN 'Shelf Total'
WHEN GROUPING(Shelf) = 1 AND GROUPING(LocationID) = 0 AND GROUPING(Bin) = 0
THEN 'Location/Bin Total'
WHEN GROUPING(Shelf) = 1 AND GROUPING(LocationID) = 0 AND GROUPING(Bin) = 1
THEN 'Location Total'
WHEN GROUPING(Shelf) = 1 AND GROUPING(LocationID) = 1 AND GROUPING(Bin) = 0
THEN 'Bin Total'
WHEN GROUPING(Shelf) = 1 AND GROUPING(LocationID) = 1 AND GROUPING(Bin) = 1
THEN 'Grand Total'
ELSE 'Regular Row'
END,
SUM(i.Quantity) AS Total
FROM Production.ProductInventory i
WHERE i.LocationID IN (3)
AND i.Bin IN (1, 2)
GROUP BY CUBE(i.Shelf, i.LocationID, i.Bin)
ORDER BY i.Shelf,
i.LocationID,
i.Bin;


/*Advanced Select Techniques*/

SELECT DISTINCT TOP (10) HireDate
FROM HumanResources.Employee
ORDER BY HireDate;

SELECT TOP (10) HireDate
FROM HumanResources.Employee
GROUP BY HireDate
ORDER BY HireDate;

SELECT TOP (5) HireDate
FROM HumanResources.Employee
GROUP BY HireDate
ORDER BY HireDate DESC;

SELECT TOP (5) PERCENT HireDate
FROM HumanResources.Employee
GROUP BY HireDate
ORDER BY HireDate DESC;

DECLARE @FirstHireDate DATE,
@LastHireDate DATE;
SELECT @FirstHireDate = MIN(HireDate),
@LastHireDate = MAX(HireDate)
FROM HumanResources.Employee;
SELECT @FirstHireDate AS FirstHireDate,
@LastHireDate AS LastHireDate;

DECLARE @LastHireDate DATE;
SELECT @LastHireDate = HireDate
FROM HumanResources.Employee
ORDER BY HireDate DESC;
SELECT TOP (1) HireDate
FROM HumanResources.Employee
ORDER BY HireDate DESC;
SELECT @LastHireDate AS LastHireDate;

IF OBJECT_ID('dbo.Sales') IS NOT NULL DROP TABLE dbo.Sales;
SELECT *
INTO dbo.Sales
FROM Sales.SalesOrderDetail
WHERE ModifiedDate = '2011-06-01T00:00:00.000';
SELECT COUNT(*) AS QtyOfRows
FROM dbo.Sales;

/*There are some limitations to the use of this syntax, as follows:
• You cannot create a new table on a different instance or server.
• You cannot create a table variable or a partitioned table.
• Only data and columns are copied; indexes, constraints, and triggers are not copied.
• Use of the ORDER BY clause does not guarantee that the rows will be inserted in
that order.
• If a computed column is selected, the column in the new table will not be a
computed column. The data in this column will be the result of the computed
column.
• New columns that originate from a sparse column will not have the sparse
property set.
• The Identity property of a column is applied to the new column, unless one of the
following conditions is true:
• Multiple select statements are joined by using UNION.
• The identity column is part of an expression.
• The identity column is listed more than once in the select list.
• The SELECT statement contains a join.
• The identity column is from a remote data source.*/

SELECT s.PurchaseOrderNumber
FROM Sales.SalesOrderHeader s
WHERE EXISTS ( SELECT SalesOrderID
FROM Sales.SalesOrderDetail
WHERE UnitPrice BETWEEN 1900 AND 2000
AND SalesOrderID = s.SalesOrderID )
ORDER BY s.PurchaseOrderNumber;

SELECT DISTINCT sh.PurchaseOrderNumber
FROM Sales.SalesOrderHeader AS sh
JOIN Sales.SalesOrderDetail AS sd
ON sh.SalesOrderID = sd.SalesOrderID
WHERE sd.UnitPrice BETWEEN 1900 AND 2000;

SELECT DISTINCT
s.PurchaseOrderNumber
FROM Sales.SalesOrderHeader s
JOIN (SELECT SalesOrderID
FROM Sales.SalesOrderDetail
WHERE UnitPrice BETWEEN 1900 AND 2000
) dt
ON s.SalesOrderID = dt.SalesOrderID
ORDER BY s.PurchaseOrderNumber;

/*Passing Rows Through a Function*/

IF OBJECT_ID('dbo.fn_WorkOrderRouting') IS NOT NULL DROP FUNCTION dbo.fn_WorkOrderRouting;
GO
CREATE FUNCTION dbo.fn_WorkOrderRouting (@WorkOrderID INT)
RETURNS TABLE
AS
RETURN
SELECT WorkOrderID,
ProductID,
OperationSequence,
LocationID
FROM Production.WorkOrderRouting
WHERE WorkOrderID = @WorkOrderID;
GO

SELECT TOP (5)
w.WorkOrderID,
w.OrderQty,
r.ProductID,
r.OperationSequence
FROM Production.WorkOrder w
CROSS APPLY dbo.fn_WorkOrderRouting(w.WorkOrderID) AS r
ORDER BY w.WorkOrderID,
w.OrderQty,
r.ProductID;

INSERT INTO Production.WorkOrder
(ProductID,
OrderQty,
ScrappedQty,
StartDate,
EndDate,
DueDate,
ScrapReasonID,
ModifiedDate)
VALUES (1,
1,
1,
GETDATE(),
GETDATE(),
GETDATE(),
1,
GETDATE());

SELECT w.WorkOrderID,
w.OrderQty,
r.ProductID,
r.OperationSequence
FROM Production.WorkOrder AS w
CROSS APPLY dbo.fn_WorkOrderRouting(w.WorkOrderID) AS r
WHERE w.WorkOrderID IN (SELECT MAX(WorkOrderID)
FROM Production.WorkOrder);

/*Since there isn’t a row in the Production.WorkOrderRouting table, a row isn’t returned by the function.
Since a CROSS APPLY is being utilized, the absence of a row from the function removes the row from the left
operand, resulting in no rows being returned by the query.
Now, change the CROSS APPLY to an OUTER APPLY.*/

SELECT w.WorkOrderID,
w.OrderQty,
r.ProductID,
r.OperationSequence
FROM Production.WorkOrder AS w
OUTER APPLY dbo.fn_WorkOrderRouting(w.WorkOrderID) AS r
WHERE w.WorkOrderID IN (SELECT MAX(WorkOrderID)
FROM Production.WorkOrder);

/*CROSS AND OUTER APPLY*/

SELECT TOP (5)
w.WorkOrderID,
w.OrderQty,
r.ProductID,
r.OperationSequence
FROM Production.WorkOrder w
CROSS APPLY (SELECT WorkOrderID,
ProductID,
OperationSequence,
LocationID
FROM Production.WorkOrderRouting
WHERE WorkOrderID = w.WorkOrderId
) AS r
ORDER BY w.WorkOrderID,
w.OrderQty,
r.ProductID;

/*PIVOT TABLE*/
SELECT s.Name AS ShiftName,
h.BusinessEntityID,
d.Name AS DepartmentName
FROM HumanResources.EmployeeDepartmentHistory h
INNER JOIN HumanResources.Department d
ON h.DepartmentID = d.DepartmentID
INNER JOIN HumanResources.Shift s
ON h.ShiftID = s.ShiftID
WHERE EndDate IS NULL
AND d.Name IN ('Production', 'Engineering', 'Marketing')
ORDER BY ShiftName;

SELECT ShiftName,
Production,
Engineering,
Marketing
FROM (SELECT s.Name AS ShiftName,
h.BusinessEntityID,
d.Name AS DepartmentName
FROM HumanResources.EmployeeDepartmentHistory h
INNER JOIN HumanResources.Department d
ON h.DepartmentID = d.DepartmentID
INNER JOIN HumanResources.Shift s
ON h.ShiftID = s.ShiftID
WHERE EndDate IS NULL
AND d.Name IN ('Production', 'Engineering', 'Marketing')
) AS a
PIVOT
(
COUNT(BusinessEntityID)
FOR DepartmentName IN ([Production], [Engineering], [Marketing])
) AS b
ORDER BY ShiftName;

SELECT s.Name AS ShiftName,
SUM(CASE WHEN d.Name = 'Production' THEN 1 ELSE 0 END) AS Production,
SUM(CASE WHEN d.Name = 'Engineering' THEN 1 ELSE 0 END) AS Engineering,
SUM(CASE WHEN d.Name = 'Marketing' THEN 1 ELSE 0 END) AS Marketing
FROM HumanResources.EmployeeDepartmentHistory h
INNER JOIN HumanResources.Department d
ON h.DepartmentID = d.DepartmentID
INNER JOIN HumanResources.Shift s
ON h.ShiftID = s.ShiftID
WHERE h.EndDate IS NULL
AND d.Name IN ('Production', 'Engineering', 'Marketing')
GROUP BY s.Name;

/*SAME RESULT AS PIVOT ABOVE*/

IF OBJECT_ID('tempdb.dbo.#Contact') IS NOT NULL DROP TABLE #Contact;
CREATE TABLE #Contact
(
EmployeeID INT NOT NULL,
PhoneNumber1 BIGINT,
PhoneNumber2 BIGINT,
PhoneNumber3 BIGINT
)
GO

SELECT * FROM tempdb.dbo.#Contact;

INSERT #Contact
(EmployeeID, PhoneNumber1, PhoneNumber2, PhoneNumber3)
VALUES (1, 2718353881, 3385531980, 5324571342),
(2, 6007163571, 6875099415, 7756620787),
(3, 9439250939, NULL, NULL);

/*UNPIVOT BY TWO WAYS*/

SELECT EmployeeID,
PhoneType,
PhoneValue
FROM #Contact c
UNPIVOT
(
PhoneValue
FOR PhoneType IN ([PhoneNumber1], [PhoneNumber2], [PhoneNumber3])
) AS p;

SELECT EmployeeID,
'PhoneNumber1' AS PhoneType,
c.PhoneNumber1 AS PhoneValue
FROM #Contact c
WHERE c.PhoneNumber1 IS NOT NULL
UNION ALL
SELECT EmployeeID,
'PhoneNumber2' AS PhoneType,
c.PhoneNumber2 AS PhoneValue
FROM #Contact c
WHERE c.PhoneNumber2 IS NOT NULL
UNION ALL
SELECT EmployeeID,
'PhoneNumber3' AS PhoneType,
c.PhoneNumber3 AS PhoneValue
FROM #Contact c
WHERE c.PhoneNumber3 IS NOT NULL
ORDER BY EmployeeID, PhoneType;

WITH cte AS
(
SELECT SalesOrderID
FROM Sales.SalesOrderDetail
WHERE UnitPrice BETWEEN 1900 AND 2000
)
SELECT s.PurchaseOrderNumber
FROM Sales.SalesOrderHeader s
WHERE EXISTS (SELECT SalesOrderID
FROM cte
WHERE SalesOrderID = s.SalesOrderID );


IF OBJECT_ID('tempdb.dbo.#Company') IS NOT NULL DROP TABLE #Company;
CREATE TABLE #Company
(
CompanyID INT NOT NULL
PRIMARY KEY,
ParentCompanyID INT NULL,
CompanyName VARCHAR(25) NOT NULL
);

INSERT #Company
(CompanyID, ParentCompanyID, CompanyName)
VALUES (1, NULL, 'Mega-Corp'),
(2, 1, 'Mediamus-Corp'),
(3, 1, 'KindaBigus-Corp'),
(4, 3, 'GettinSmaller-Corp'),
(5, 4, 'Smallest-Corp'),
(6, 5, 'Puny-Corp'),
(7, 5, 'Small2-Corp');

SELECT * FROM tempdb.dbo.#Company;


WITH CompanyTree(ParentCompanyID, CompanyID, CompanyName, CompanyLevel) AS
(
-- Anchor Member
SELECT ParentCompanyID,
CompanyID,
CompanyName,
0 AS CompanyLevel
FROM #Company
WHERE ParentCompanyID IS NULL
UNION ALL
-- Recursive Member
SELECT c.ParentCompanyID,
c.CompanyID,
c.CompanyName,
p.CompanyLevel + 1
FROM #Company c
INNER JOIN CompanyTree p
ON c.ParentCompanyID = p.CompanyID
)
SELECT ParentCompanyID,
CompanyID,
CompanyName,
CompanyLevel
FROM CompanyTree;


SELECT *
FROM (VALUES ('George', 'Washington'),
('Thomas', 'Jefferson'),
('John', 'Adams'),
('James', 'Madison'),
('James', 'Monroe'),
('John Quincy', 'Adams'),
('Andrew', 'Jackson'),
('Martin', 'Van Buren'),
('William', 'Harrison'),
('John', 'Tyler')
) dtPresidents(FirstName, LastName);

/*CHAPTER Windowing Functions*/
/*ROW_NUMBER ROW_NUMBER returns an incrementing integer for each row within a partition
of a set. ROW_NUMBER will return a unique number within each partition,
starting with 1.
RANK Similar to ROW_NUMBER, RANK increments its value for each row within a
partition of the set. The key difference is that if rows with tied values exist
within the partition, they will receive the same rank value, and the next
value will receive the rank value as if there had been no ties, producing a gap
between assigned numbers.
DENSE_RANK The difference between DENSE_RANK and RANK is that DENSE_RANK doesn’t
have gaps in the rank values when there are tied values; the next value has
the next rank assignment.
NTILE NTILE divides the result set into a specified number of groups, based on the
ordering and optional partition clause.

CUME_DIST CUME_DIST calculates the cumulative distribution of a value in a group of
values. The cumulative distribution is the relative position of a specified value
in a group of values.
FIRST_VALUE Returns the first value from an ordered set of values.
LAG Retrieves data from a previous row in the same result set as specified by a row
offset from the current row.
LAST_VALUE Returns the last value from an ordered set of values.
LEAD Retrieves data from a subsequent row in the same result set as specified by a
row offset from the current row.
PERCENTILE_CONT Calculates a percentile based on a continuous distribution of the column value.
The value returned may or may not be equal to any of the specific values in the
column.
PERCENTILE_DISC Computes a specific percentile for sorted values in the result set. The value
returned will be the value with the smallest CUME_DIST value (for the same sort
specification) that is greater than or equal to the specified percentile. The value
returned will be equal to one of the values in the specific column.
PERCENT_RANK Computes the relative rank of a row within a set.*/

CREATE TABLE #Transactions
(
AccountId INTEGER,
TranDate DATE,
TranAmt NUMERIC(8, 2)
);


INSERT INTO #Transactions
SELECT *
FROM ( VALUES ( 1, '2011-01-01', 500),
( 1, '2011-01-15', 50),
( 1, '2011-01-22', 250),
( 1, '2011-01-24', 75),
( 1, '2011-01-26', 125),
( 1, '2011-01-26', 175),
( 2, '2011-01-01', 500),
( 2, '2011-01-15', 50),
( 2, '2011-01-22', 25),
( 3, '2011-01-22', 5000),
( 3, '2011-01-27', 550),
( 3, '2011-01-27', 95 ),
( 3, '2011-01-30', 2500)
) dt (AccountId, TranDate, TranAmt);

SELECT * FROM #Transactions

SELECT AccountId,
TranDate,
TranAmt,
-- running total of all transactions
RunTotalAmt = SUM(TranAmt) OVER (PARTITION BY AccountId ORDER BY TranDate)
FROM #Transactions AS t
ORDER BY AccountId,
TranDate;

SELECT AccountId,
TranDate,
TranAmt,
-- running total of all transactions
RunTotalAmt = SUM(TranAmt) OVER (PARTITION BY AccountId ORDER BY TranDate),
-- "Proper" running total by row position
RunTotalAmt2 = SUM(TranAmt) OVER (PARTITION BY AccountId
ORDER BY TranDate
ROWS UNBOUNDED PRECEDING)
FROM #Transactions AS t
ORDER BY AccountId,
TranDate;

SELECT AccountId,
TranDate,
TranAmt,
-- running average of all transactions
RunAvg = AVG(TranAmt) OVER (PARTITION BY AccountId ORDER BY TranDate),
-- running total # of transactions
RunTranQty = COUNT(*) OVER (PARTITION BY AccountId ORDER BY TranDate),
-- smallest of the transactions so far
RunSmallAmt = MIN(TranAmt) OVER (PARTITION BY AccountId ORDER BY TranDate),
-- largest of the transactions so far
RunLargeAmt = MAX(TranAmt) OVER (PARTITION BY AccountId ORDER BY TranDate),
-- running total of all transactions
RunTotalAmt = SUM(TranAmt) OVER (PARTITION BY AccountId ORDER BY TranDate)
FROM #Transactions AS t
WHERE AccountID = 1
ORDER BY AccountId, TranDate;

SELECT AccountId,
TranDate,
TranAmt,
-- average of the current and previous 2 transactions
SlideAvg = AVG(TranAmt)
OVER (PARTITION BY AccountId
ORDER BY TranDate
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
-- total # of the current and previous 2 transactions
SlideQty = COUNT(*)
OVER (PARTITION BY AccountId
ORDER BY TranDate
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
-- smallest of the current and previous 2 transactions
SlideMin = MIN(TranAmt)
OVER (PARTITION BY AccountId
ORDER BY TranDate
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
-- largest of the current and previous 2 transactions
SlideMax = MAX(TranAmt)
OVER (PARTITION BY AccountId
ORDER BY TranDate
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),
-- total of the current and previous 2 transactions
SlideTotal = SUM(TranAmt)
OVER (PARTITION BY AccountId
ORDER BY TranDate
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM #Transactions AS t
ORDER BY AccountId, TranDate;

SELECT AccountId,
TranDate,
TranAmt,
AccountTotal = SUM(TranAmt) OVER (PARTITION BY AccountId),
AmountPct = TranAmt / SUM(TranAmt) OVER (PARTITION BY t.AccountId)
FROM #Transactions AS t

SELECT AccountId,
TranDate,
TranAmt,
Total = SUM(TranAmt) OVER (),
AmountPct = TranAmt / SUM(TranAmt) OVER ()
FROM #Transactions AS t
ORDER BY AccountId, TranDate;

/*DIFF BETWEEN ORDER AND PARTITION BY, WHEN TAKEN EITHER ONE OR BOTH*/

SELECT AccountId,
TranDate,
TranAmt,
AcctRowID = ROW_NUMBER() OVER (PARTITION BY AccountId ORDER BY AccountId, TranDate),
AcctRowQty = COUNT(*) OVER (PARTITION BY AccountId),
RowID = ROW_NUMBER() OVER (ORDER BY AccountId, TranDate),
RowQty = COUNT(*) OVER ()
FROM #Transactions AS t
ORDER BY AccountId, TranDate;;

/*IF TWO SALORY ROWS ARE EQUAL THEN THEY ADDED TOGETHER AND SHOWN TOGETHER IN SUM BY RANGE, SUM BY ROWS: ADD EVERY ROW */

CREATE TABLE #Test
(
RowID INT IDENTITY,
FName VARCHAR(20),
Salary SMALLINT
);

INSERT INTO #Test (FName, Salary)
VALUES ('George', 800),
('Sam', 950),
('Diane', 1100),
('Nicholas', 1250),
('Samuel', 1250), --<< duplicate value of above row
('Patricia', 1300),
('Brian', 1500),
('Thomas', 1600),
('Fran', 2450),
('Debbie', 2850),
('Mark', 2975),
('James', 3000),
('Cynthia', 3000), --<< duplicate value of above row
('Christopher', 5000);

SELECT RowID,
FName,
Salary,
SumByRows = SUM(Salary) OVER (ORDER BY Salary ROWS UNBOUNDED PRECEDING),
SumByRange = SUM(Salary) OVER (ORDER BY Salary RANGE UNBOUNDED PRECEDING)
FROM #Test
ORDER BY RowID;

SELECT TOP 10
AccountNumber,
OrderDate,
TotalDue,
ROW_NUMBER() OVER (PARTITION BY AccountNumber ORDER BY OrderDate) AS RowNumber
FROM AdventureWorks2014.Sales.SalesOrderHeader
ORDER BY AccountNumber;

SELECT BusinessEntityID,
SalesQuota,
RANK() OVER (ORDER BY SalesQuota DESC) AS RankWithGaps,
DENSE_RANK() OVER (ORDER BY SalesQuota DESC) AS RankWithoutGaps,
ROW_NUMBER() OVER (ORDER BY SalesQuota DESC) AS RowNumber
FROM Sales.SalesPersonQuotaHistory
WHERE QuotaDate = '2014-03-01'
AND SalesQuota < 500000;

/*BusinessEntityID SalesQuota RankWithGaps RankWithoutGaps RowNumber
---------------- ---------- ------------ --------------- ---------
284 497000.00 1 1 1
286 421000.00 2 2 2
283 403000.00 3 3 3
278 390000.00 4 4 4
280 390000.00 4 4 5
274 187000.00 6 5 6
285 26000.00 7 6 7
287 1000.00 8 7 8*/

/*RANK-EQUAL SALES EQUAL RANK, DIRECT 6 COMES RankWithGaps
DENSE-RANK SALES EQUAL RANK, DIRECT 6 COMES RankWithoutGaps
ROW-NUMBER is row number*/

SELECT BusinessEntityID,
QuotaDate,
SalesQuota,
NTILE(4) OVER (ORDER BY SalesQuota DESC) AS [NTILE]
FROM Sales.SalesPersonQuotaHistory
WHERE SalesQuota BETWEEN 266000.00 AND 319000.00;

/*The NTILE function divides the result set into the specified number of groups based upon the partitioning
and ordering specified in the OVER clause.
WE PROVIDE 4 BUT NO RULE FOR DIVISION, ITS INTERNAL*/

CREATE TABLE #RFID_Location (
TagId INTEGER,
Location VARCHAR(25),
SensorReadTime DATETIME);
INSERT INTO #RFID_Location
(TagId, Location, SensorReadTime)
VALUES (1, 'Room1', '2012-01-10T08:00:01'),
(1, 'Room1', '2012-01-10T08:18:32'),
(1, 'Room2', '2012-01-10T08:25:42'),
(1, 'Room3', '2012-01-10T09:52:48'),
(1, 'Room2', '2012-01-10T10:05:22'),
(1, 'Room3', '2012-01-10T11:22:15'),
(1, 'Room4', '2012-01-10T14:18:58'),
(2, 'Room1', '2012-01-10T08:32:18'),
(2, 'Room1', '2012-01-10T08:51:53'),
(2, 'Room2', '2012-01-10T09:22:09'),
(2, 'Room1', '2012-01-10T09:42:17'),
(2, 'Room1', '2012-01-10T09:59:16'),
(2, 'Room2', '2012-01-10T10:35:18'),
(2, 'Room3', '2012-01-10T11:18:42'),
(2, 'Room4', '2012-01-10T15:22:18');

SELECT * FROM #RFID_Location

/*Grouping Logically Consecutive Rows Together*/

WITH cte AS
(
SELECT TagId, Location, SensorReadTime,
ROW_NUMBER() OVER (PARTITION BY TagId ORDER BY SensorReadTime) -
ROW_NUMBER() OVER (PARTITION BY TagId, Location ORDER BY SensorReadTime) AS Grp
FROM #RFID_Location
)
SELECT TagId, Location, SensorReadTime, Grp,
DENSE_RANK() OVER (PARTITION BY TagId, Location ORDER BY Grp) AS TripNbr
FROM cte
ORDER BY TagId, SensorReadTime;



WITH cte AS
(
SELECT TagId, Location, SensorReadTime,
-- For each tag, number each sensor reading by its timestamp
ROW_NUMBER()OVER (PARTITION BY TagId ORDER BY SensorReadTime) AS RN1,
-- For each tag and location, number each sensor reading by its timestamp.
ROW_NUMBER() OVER (PARTITION BY TagId, Location ORDER BY SensorReadTime) AS RN2
FROM #RFID_Location
)
SELECT TagId, Location, SensorReadTime,
-- Display each of the row numbers,
-- Subtract RN2 from RN1
RN1, RN2, RN1-RN2 AS Grp
FROM cte
ORDER BY TagId, SensorReadTime;


WITH cte AS
(
SELECT TagId, Location, SensorReadTime,
ROW_NUMBER() OVER (PARTITION BY TagId ORDER BY SensorReadTime) -
ROW_NUMBER() OVER (PARTITION BY TagId, Location ORDER BY SensorReadTime) AS Grp
FROM #RFID_Location
)
SELECT TagId, Location, SensorReadTime, Grp,
DENSE_RANK() OVER (PARTITION BY TagId, Location ORDER BY Grp) AS TripNbr,
RANK() OVER (PARTITION BY TagId, Location ORDER BY Grp) AS TripNbrRank
FROM cte
ORDER BY TagId, SensorReadTime;



/*You need to write a sales summary report that shows the total due from orders by year and quarter. You want
to include a difference between the current quarter and prior quarter, as well as a difference between the
current quarter of this year and the same quarter of the previous year.*/

WITH cte AS
(
-- Break the OrderDate down into the Year and Quarter
SELECT DATEPART(QUARTER, OrderDate) AS Qtr,
DATEPART(YEAR, OrderDate) AS Yr,
TotalDue
FROM Sales.SalesOrderHeader
), cteAgg AS
(
-- Aggregate the TotalDue, Grouping on Year and Quarter
SELECT Yr,
Qtr,
SUM(TotalDue) AS TotalDue
FROM cte
GROUP BY Yr, Qtr
)
SELECT Yr,
Qtr,
TotalDue,
-- Get the total due from the prior quarter
TotalDue - LAG(TotalDue, 1, NULL) OVER (ORDER BY Yr, Qtr) AS DeltaPriorQtr,
-- Get the total due from 4 quarters ago.
-- This will be for the prior Year, same Quarter.
TotalDue - LAG(TotalDue, 4, NULL) OVER (ORDER BY Yr, Qtr) AS DeltaPriorYrQtr
FROM cteAgg
ORDER BY Yr, Qtr;


LAG(TotalDue, 1, NULL) OVER (ORDER BY Yr, Qtr)
LAG | LEAD (scalar_expression [,offset] [,default])
OVER ( [ partition_by_clause ] order_by_clause )


CREATE TABLE #Gaps (col1 INTEGER PRIMARY KEY CLUSTERED);
INSERT INTO #Gaps (col1)
VALUES (1), (2), (3),
(50), (51), (52), (53), (54), (55),
(100), (101), (102),
(500),
(950), (951), (952),
(954);
-- Compare the value of the current row to the next row.
-- If > 1, then there is a gap.

SELECT * FROM #Gaps

WITH cte AS
(
SELECT col1 AS CurrentRow,
LEAD(col1, 1, NULL) OVER (ORDER BY col1) AS NextRow
FROM #Gaps
)
SELECT cte.CurrentRow + 1 AS [Start of Gap],
cte.NextRow - 1 AS [End of Gap]
FROM cte
WHERE cte.NextRow - cte.CurrentRow > 1;


--7-12. Accessing the First or Last Value from a Partition
--You need to write a report that shows, for each customer, the date that they placed their least and most
--expensive orders.
--Utilize the FIRST_VALUE and LAST_VALUE functions:

SELECT DISTINCT TOP (5)
CustomerID,
-- Get the date for the customer's least expensive order
FIRST_VALUE(OrderDate)
OVER (PARTITION BY CustomerID
ORDER BY TotalDue
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS OrderDateLow,
-- Get the date for the customer's most expensive order
LAST_VALUE(OrderDate)
OVER (PARTITION BY CustomerID
ORDER BY TotalDue
ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS OrderDateHigh
FROM Sales.SalesOrderHeader
ORDER BY CustomerID;

SELECT * FROM Sales.SalesOrderHeader

/*Rows between unbounded preceding and unbounded following
UNBOUNDED PRECEDING is the default. CURRENT ROW indicates the window begins or ends at the current row.
UNBOUNDED FOLLOWING indicates that the window ends at the last row of the partition;
offset FOLLOWING indicates that the window ends a number of rows equivalent to the value of offset after the current row.*/

/*The FIRST_VALUE and LAST_VALUE functions are used to return a scalar expression (typically a column) from
the first and last rows in the partition; in this example they are returning the OrderDate column. The window
is set to a partition of the CustomerID, ordered by the TotalDue, and the ROWS clause is used to specify all of
the rows for the partition. The syntax for the FIRST_VALUE and LAST_VALUE functions is as follows:*/

FIRST_VALUE | LAST_VALUE ( scalar_expression )
OVER ( [ partition_by_clause ] order_by_clause [ rows_range_clause ] )

--7-13. Calculating the Relative Position or Rank of a Value
--within a Set of Values
CUME_DIST() | PERCENT_RANK( )
OVER ( [ partition_by_clause ] order_by_clause )

SELECT CustomerID,
TotalDue,
CUME_DIST()
OVER (PARTITION BY CustomerID
ORDER BY TotalDue) AS CumeDistOrderTotalDue,
PERCENT_RANK()
OVER (PARTITION BY CustomerID
ORDER BY TotalDue) AS PercentRankOrderTotalDue
FROM Sales.SalesOrderHeader
WHERE CustomerID IN (11439, 30116)
ORDER BY CustomerID, TotalDue;

DECLARE @Employees TABLE
(
EmplId INT PRIMARY KEY CLUSTERED,
DeptId INT,
Salary NUMERIC(8, 2)
);

INSERT INTO @Employees
VALUES (1, 1, 10000),
(2, 1, 11000),
(3, 1, 12000),
(4, 2, 25000),
(5, 2, 35000),
(6, 2, 75000),
(7, 2, 100000);

SELECT EmplId,
DeptId,
Salary,
PERCENTILE_CONT(0.5)
WITHIN GROUP (ORDER BY Salary ASC)
OVER (PARTITION BY DeptId) AS MedianCont,
PERCENTILE_DISC(0.5)
WITHIN GROUP (ORDER BY Salary ASC)
OVER (PARTITION BY DeptId) AS MedianDisc,
PERCENTILE_CONT(0.75)
WITHIN GROUP (ORDER BY Salary ASC)
OVER (PARTITION BY DeptId) AS Percent75Cont,
PERCENTILE_DISC(0.75)
WITHIN GROUP (ORDER BY Salary ASC)
OVER (PARTITION BY DeptId) AS Percent75Disc,
CUME_DIST()
OVER (PARTITION BY DeptId
ORDER BY Salary) AS CumeDist
FROM @Employees
ORDER BY DeptId, EmplId;

select * from @Employees;

IF EXISTS (SELECT *
FROM sys.sequences AS seq
JOIN sys.schemas AS sch
ON seq.schema_id = sch.schema_id
WHERE sch.name = 'dbo'
AND seq.name = 'CH7Sequence')
DROP SEQUENCE dbo.CH7Sequence;
CREATE SEQUENCE dbo.CH7Sequence AS INTEGER START WITH 1;
DECLARE @ClassRank TABLE
(
StudentID TINYINT,
Grade TINYINT,
SeqNbr INTEGER
);
INSERT INTO @ClassRank (StudentId, Grade, SeqNbr)
SELECT StudentId,
Grade,
NEXT VALUE FOR dbo.CH7Sequence OVER (ORDER BY Grade ASC)
FROM (VALUES (1, 100),
(2, 95),
(3, 85),
(4, 100),
(5, 99),
(6, 98),
(7, 95),
(8, 90),
(9, 89),
(10, 89),
(11, 85),
(12, 82)) dt(StudentId, Grade);
SELECT StudentId, Grade, SeqNbr
FROM @ClassRank;


--Inserting, Updating, Deleting

INSERT INTO Production.Location
(Name, CostRate, Availability)
VALUES ('Wheel Storage', 11.25, 80.00) ;

SELECT Name,
CostRate,
Availability
FROM Production.Location
WHERE Name = 'Wheel Storage' ;

--You need to insert one row into a table, and you want to use a table’s default values for some columns.
/*Column Name Data Type Nullability Default Value Identity Column?
LocationID smallint NOT NULL Yes
Name dbo.Name (user-defineddata type)NOT NULL No
CostRate smallmoney NOT NULL 0.00 No
Availability decimal(8,2) NOT NULL 0.00 No
ModifiedDate datetime NOT NULL GETDATE() (function to returnthe current date and time)No*/

INSERT Production.Location
(Name,
CostRate,
Availability,
ModifiedDate)
VALUES ('Wheel Storage 2',
11.25,
80.00,
'4/1/2012') ;

INSERT Production.Location
(Name,
CostRate,
Availability,
ModifiedDate)
VALUES ('Wheel Storage 3',
11.25,
80.00,
DEFAULT) ;

INSERT INTO Person.Address
(AddressLine1,
AddressLine2,
City,
StateProvinceID,
PostalCode)
VALUES ('15 Wake Robin Rd',
DEFAULT,
'Sudbury',
30,
'01776') ;

SET IDENTITY_INSERT HumanResources.Department ON|OFF;

INSERT HumanResourcesDepartment
(DepartmentID,
Name,
GroupName)
VALUES (17,
'Database Services',
'Information Technology') ;


/*The NEWID system function generates a new GUID that can be inserted into a column defined with
UNIQUEIDENTIFIER:*/

INSERT Purchasing.ShipMethod
(Name,
ShipBase,
ShipRate,
rowguid)
VALUES ('MIDDLETON CARGO TS1',
8.99,
1.22,
NEWID()) ;
SELECT rowguid,
Name
FROM Purchasing.ShipMethod
WHERE Name = 'MIDDLETON CARGO TS1';


CREATE TABLE dbo.Shift_Archive
(
ShiftID TINYINT NOT NULL,
Name Name NOT NULL,
StartTime DATETIME NOT NULL,
EndTime DATETIME NOT NULL,
ModifiedDate DATETIME NOT NULL
CONSTRAINT DF_ShiftModDate DEFAULT (GETDATE()),
CONSTRAINT PK_Shift_ShiftID PRIMARY KEY CLUSTERED (ShiftID ASC)
);
GO

--Inserting Results from a Query
--Insert from other table to newly created table

INSERT INTO dbo.Shift_Archive
(ShiftID,
Name,
StartTime,
EndTime,
ModifiedDate)
SELECT ShiftID,
Name,
StartTime,
EndTime,
ModifiedDate
FROM HumanResources.Shift
ORDER BY ShiftID ;

SELECT ShiftID,
Name
FROM dbo.Shift_Archive ;

--8-6. Inserting Results from a Stored Procedure

CREATE PROCEDURE dbo.usp_SEL_Production_TransactionHistory
@ModifiedStartDT DATETIME,
@ModifiedEndDT DATETIME
AS
SELECT TransactionID,
ProductID,
ReferenceOrderID,
ReferenceOrderLineID,
TransactionDate,
TransactionType,
Quantity,
ActualCost,
ModifiedDate
FROM Production.TransactionHistory
WHERE ModifiedDate BETWEEN @ModifiedStartDT
AND @ModifiedEndDT
AND TransactionID NOT IN (
SELECT TransactionID
FROM Production.TransactionHistoryArchive) ;
GO


INSERT Production.TransactionHistoryArchive
(TransactionID,
ProductID,
ReferenceOrderID,
ReferenceOrderLineID,
TransactionDate,
TransactionType,
Quantity,
ActualCost,
ModifiedDate)
EXEC dbo.usp_SEL_Production_TransactionHistory '2011-04-16', '2012-07-31' ;

SELECT * FROM Production.TransactionHistoryArchive

/*EXEC dbo.usp_SEL_Production_TransactionHistory '2013-09-01', '2013-09-02';
This returns 648 rows based on the date range passed to the procedure. Next, use this stored procedure
to insert the 648 rows into the Production.TransactionHistoryArchive table:*/

--8-7. Inserting Multiple Rows at Once from Supplied Values

CREATE TABLE HumanResources.Degree
(
DegreeID INT NOT NULL
IDENTITY(1, 1)
PRIMARY KEY,
DegreeName VARCHAR(30) NOT NULL,
DegreeCode VARCHAR(5) NOT NULL,
ModifiedDate DATETIME NOT NULL
) ;
GO

INSERT INTO HumanResources.Degree
(DegreeName, DegreeCode, ModifiedDate)
VALUES ('Bachelor of Arts', 'B.A.', GETDATE()),
('Bachelor of Science', 'B.S.', GETDATE()),
('Master of Arts', 'M.A.', GETDATE()),
('Master of Science', 'M.S.', GETDATE()),
('Associate" s Degree', 'A.A.', GETDATE()) ;
GO

SELECT * FROM HumanResources.Degree

--8-8. Inserting Rows and Returning the Inserted Rows
INSERT Purchasing.ShipMethod
(Name, ShipBase, ShipRate)
OUTPUT INSERTED.ShipMethodID, INSERTED.Name,
INSERTED.rowguid, INSERTED.ModifiedDate
VALUES ('MIDDLETON CARGO TS11', 10, 10),
('MIDDLETON CARGO TS12', 10, 10),
('MIDDLETON CARGO TS13', 10, 10) ;

DECLARE @insertedShipMethodIDs TABLE
(
ShipMethodID INTEGER
);
INSERT Purchasing.ShipMethod (Name, ShipBase, ShipRate)
OUTPUT inserted.ShipMethodID INTO @insertedShipMethodIDs
VALUES ('MIDDLETON CARGO TS17', 10, 10),
('MIDDLETON CARGO TS18', 10, 10),
('MIDDLETON CARGO TS19', 10, 10);

--8-9. Updating a Single Row or Set of Rows

SELECT DiscountPct
FROM Sales.SpecialOffer
WHERE SpecialOfferID = 10 ;

UPDATE Sales.SpecialOffer
SET DiscountPct = 0.15
WHERE SpecialOfferID = 10 ;

SELECT * FROM Sales.SpecialOffer

--You need to update rows in a table, but either your filter condition requires a second table or you need to use
--data from a second table as the source of your update.

UPDATE c
SET Quantity = 2,
ModifiedDate = GETDATE()
FROM Sales.ShoppingCartItem c
INNER JOIN Production.Product p
ON c.ProductID = p.ProductID
WHERE p.Name = 'Full-Finger Gloves, M '
AND c.Quantity > 2 ;

SELECT * FROM Sales.ShoppingCartItem c
INNER JOIN Production.Product p
ON c.ProductID = p.ProductID
WHERE p.Name = 'Full-Finger Gloves, M '
AND c.Quantity > 1 ;

--8-11. Updating Data and Returning the Affected Rows

UPDATE Sales.SpecialOffer
SET DiscountPct *= 1.05
OUTPUT inserted.SpecialOfferID,
deleted.DiscountPct AS old_DiscountPct,
inserted.DiscountPct AS new_DiscountPct
WHERE Category = 'Customer' ;

/*8-12. Updating Large-Value Columns
• varchar(max), which holds non-Unicode variable-length data
• nvarchar(max), which holds Unicode variable-length data
• varbinary(max), which holds variable-length binary data*/

--8-13. Deleting Rows
SELECT *
INTO Production.Example_ProductProductPhoto
FROM Production.ProductProductPhoto ;

DELETE Production.Example_ProductProductPhoto ;

-- Repopulate the Example_ProductProductPhoto table
INSERT Production.Example_ProductProductPhoto
SELECT *
FROM Production.ProductProductPhoto ;
DELETE Production.Example_ProductProductPhoto
WHERE ProductID NOT IN (SELECT ProductID
FROM Production.Product) ;

DELETE
FROM ppp
FROM Production.Example_ProductProductPhoto ppp
LEFT OUTER JOIN Production.Product p
ON ppp.ProductID = p.ProductID
WHERE p.ProductID IS NULL ;

--8-14. Deleting Rows and Returning the Deleted Rows
SELECT *
INTO HumanResources.Example_JobCandidate
FROM HumanResources.JobCandidate ;

DELETE
FROM HumanResources.Example_JobCandidate
OUTPUT deleted.JobCandidateID
WHERE JobCandidateID < 5 ;

DELETE
FROM HumanResources.Example_JobCandidate
OUTPUT deleted.JobCandidateID INTO @deletedCandidates
WHERE JobCandidateID < 5

--8-15. Deleting All Rows Quickly (Truncating)
SELECT *
INTO Production.Example_TransactionHistory
FROM Production.TransactionHistory ;

TRUNCATE TABLE Production.Example_TransactionHistory ;

SELECT COUNT(*)
FROM Production.Example_TransactionHistory ;

--8-16. Merging Data (Inserting, Updating, and/or DeletingValues)

CREATE TABLE Sales.LastCustomerOrder
(
CustomerID INT,
SalesOrderID INT,
CONSTRAINT pk_LastCustomerOrder PRIMARY KEY CLUSTERED (CustomerId)
) ;

DECLARE @CustomerID INT = 100,
@SalesOrderID INT = 101 ;
MERGE INTO Sales.LastCustomerOrder AS tgt
USING
(SELECT @CustomerID AS CustomerID,
@SalesOrderID AS SalesOrderID
) AS src
ON tgt.CustomerID = src.CustomerID
WHEN MATCHED
THEN UPDATE
SET SalesOrderID = src.SalesOrderID
WHEN NOT MATCHED
THEN INSERT (
CustomerID,
SalesOrderID
)
VALUES (src.CustomerID,
src.SalesOrderID) ;

SELECT *
FROM Sales.LastCustomerOrder ;


CREATE TABLE Sales.LargestCustomerOrder
(
CustomerID INT,
SalesOrderID INT,
TotalDue MONEY,
CONSTRAINT pk_LargestCustomerOrder PRIMARY KEY CLUSTERED (CustomerId)
);

DECLARE @CustomerID INT = 100,
@SalesOrderID INT = 101 ,
@TotalDue MONEY = 1000.00;
MERGE INTO Sales.LargestCustomerOrder AS tgt
USING
(SELECT @CustomerID AS CustomerID,
@SalesOrderID AS SalesOrderID,
@TotalDue AS TotalDue
) AS src
ON tgt.CustomerID = src.CustomerID
WHEN MATCHED AND tgt.TotalDue < src.TotalDue
THEN UPDATE
SET SalesOrderID = src.SalesOrderID
, TotalDue = src.TotalDue
WHEN NOT MATCHED
THEN INSERT (
CustomerID,
SalesOrderID,
TotalDue
)
VALUES (src.CustomerID,
src.SalesOrderID,
src.TotalDue);

SELECT *
FROM Sales.LargestCustomerOrder;


DECLARE @CustomerID INT = 100,
@SalesOrderID INT = 201 ,
@TotalDue MONEY = 1200.00;
MERGE INTO Sales.LargestCustomerOrder AS tgt
USING
(SELECT @CustomerID AS CustomerID,
@SalesOrderID AS SalesOrderID,
@TotalDue AS TotalDue
) AS src
ON tgt.CustomerID = src.CustomerID
WHEN MATCHED AND tgt.TotalDue < src.TotalDue
THEN UPDATE
SET SalesOrderID = src.SalesOrderID
, TotalDue = src.TotalDue
WHEN NOT MATCHED
THEN INSERT (
CustomerID,
SalesOrderID,
TotalDue
)
VALUES (src.CustomerID,
src.SalesOrderID,
src.TotalDue)
OUTPUT
$ACTION,
DELETED.*,
INSERTED.*;


-- Create a table variable to hold the output data
-- This could be a temporary or a permanent table.
DECLARE @dml_output TABLE (
MergeAction VARCHAR(6),
DeletedCustomerID INTEGER,
DeletedSalesOrderID INTEGER,
DeletedTotalDue MONEY,
InsertedCustomerID INTEGER,
InsertedSalesOrderID INTEGER,
InsertedTotalDue MONEY
);
-- Insert into the holding table
INSERT INTO @dml_output
(MergeAction,
DeletedCustomerID,
DeletedSalesOrderID,
DeletedTotalDue,
InsertedCustomerID,
InsertedSalesOrderID,
InsertedTotalDue
)
-- SELECT from a table source
SELECT *
-- The FROM clause needs to be a derived table
-- The output columns are its output. FROM (
MERGE INTO Sales.LargestCustomerOrder AS tgt
USING
(SELECT 100 AS CustomerID,
205 AS SalesOrderID,
2500.00 AS TotalDue
) AS src
ON tgt.CustomerID = src.CustomerID
WHEN MATCHED AND tgt.TotalDue < src.TotalDue
THEN UPDATE
SET SalesOrderID = src.SalesOrderID
, TotalDue = src.TotalDue
WHEN NOT MATCHED
THEN INSERT (
CustomerID,
SalesOrderID,
TotalDue
)
VALUES (src.CustomerID,
src.SalesOrderID,
src.TotalDue)
OUTPUT
$ACTION,
DELETED.*,
INSERTED.*
-- Define the derived table's output column
) dt(MergeAction,
DeletedCustomerID,
DeletedSalesOrderID,
DeletedTotalDue,
InsertedCustomerID,
InsertedSalesOrderID,
InsertedTotalDue);

SELECT *
FROM @dml_output;


--Working with Strings

/*Function Name(s) Description
CONCAT The CONCAT function concatenates a variable list of string values into one
larger string.
ASCII and CHAR The ASCII function takes the leftmost character of a character expression and
returns the ASCII code. The CHAR function converts an integer value for an
ASCII code to a character value instead.
CHARINDEX and PATINDEX The CHARINDEX function is used to return the starting position of a string
within another string. The PATINDEX function is similar to CHARINDEX, except
that PATINDEX allows the use of wildcards when specifying the string for
which to search.
DIFFERENCE and SOUNDEX DIFFERENCE and SOUNDEX both work with character strings to evaluate those
that sound similar. SOUNDEX assigns a string a four-digit code, and DIFFERENCE
evaluates the level of similarity between the SOUNDEX outputs for two separate
strings.
FORMAT The FORMAT function returns locale-aware formatting of date/time and
number values as strings.
LEFT and RIGHT The LEFT function returns a part of a character string, beginning at the
specified number of characters from the left. The RIGHT function is like the
LEFT function, only it returns a part of a character string beginning at the
specified number of characters from the right.
LEN and DATALENGTH The LEN function returns the number of characters in a string expression,
excluding any blanks after the last character (trailing blanks). DATALENGTH,
however, returns the number of bytes used for an expression. LEN works
for any data type that can be implicitly converted to a string; DATALENGTH
works on any data type.
LOWER and UPPER The LOWER function returns a character expression in lowercase, and the
UPPER function returns a character expression in uppercase.
LTRIM and RTRIM The LTRIM function removes leading blanks, and the RTRIM function removes
trailing blanks.
NCHAR and UNICODE The UNICODE function returns the Unicode integer value for the first character
of the character or input expression. The NCHAR function takes an integer
value that designates a Unicode character and converts it to its character
equivalent.
QUOTENAME The QUOTENAME function returns a UNICODE string with added delimiters so as
to make a valid identifier for SQL Server.
REPLACE The REPLACE function replaces all instances of a provided string within a
specified string with a new string.
REPLICATE The REPLICATE function repeats a given character expression a designated
number of times.
REVERSE The REVERSE function takes a character expression and outputs the
expression with each character position displayed in reverse order.
SPACE The SPACE function returns a string of repeated blank spaces, based on the
integer you designate for the input parameter.
STR The STR function converts numerical data to a string.
STUFF The STUFF function deletes a specified length of characters and inserts a
designated string at the specified starting point.
SUBSTRING The SUBSTRING function returns a defined chunk of a specified expression.*/

SELECT TOP (5)
FullName = CONCAT(LastName, ', ', FirstName, ' ', MiddleName)
FROM Person.Person p;

SELECT TOP (5)
FullName = CONCAT(LastName, ', ', FirstName, ' ', MiddleName),
FullName2 = LastName + ', ' + FirstName + ' ' + MiddleName,
FullName3 = LastName + ', ' + FirstName +
IIF(MiddleName IS NULL, '', ' ' + MiddleName)
FROM Person.Person p
WHERE MiddleName IS NULL;

SELECT ASCII('H'),
ASCII('e'),
ASCII('l'),
ASCII('l'),
ASCII('o');

SELECT CHAR(72),
CHAR(101),
CHAR(108),
CHAR(108),
CHAR(111) ;

SELECT UNICODE('G'),
UNICODE('o'),
UNICODE('o'),
UNICODE('d'),
UNICODE('!');

SELECT NCHAR(71),
NCHAR(111),
NCHAR(111),
NCHAR(100),
NCHAR(33) ;

--9-4. Locating Characters in a String
SELECT CHARINDEX('string to find','This is the bigger string to find something in.');

SELECT TOP 10
AddressID,
AddressLine1,
PATINDEX('%[0]%Olive%', AddressLine1)
FROM Person.Address
WHERE PATINDEX('%[0]%Olive%', AddressLine1) > 0;

--example of the wildcard searches that may be used within
--PATINDEX. PATINDEX supports the same wildcard functionality as the LIKE operator.

--9-5. Determining the Similarity of Strings
--The two functions SOUNDEX and DIFFERENCE both work with character strings and evaluate the strings based
--on English phonetic rules.

SELECT DISTINCT
SOUNDEX(LastName),
SOUNDEX('Smith'),
LastName
FROM Person.Person
WHERE SOUNDEX(LastName) = SOUNDEX('Smith');

SELECT DISTINCT
SOUNDEX(LastName),
SOUNDEX('Smith'),
DIFFERENCE(LastName, 'Smith'),
LastName
FROM Person.Person
WHERE DIFFERENCE(LastName, 'Smith') = 4;

--9-6. Returning the Leftmost or Rightmost Portion of a String

SELECT LEFT('I only want the leftmost 10 characters.', 10);
SELECT RIGHT('I only want the rightmost 10 characters.', 10);

SELECT TOP (5)
ProductNumber,
ProductName = LEFT(Name, 10)
FROM Production.Product;

SELECT TOP (5)
CustomerID,
AccountNumber = CONCAT('AW', RIGHT(REPLICATE('0', 8)
+ CAST(CustomerID AS VARCHAR(10)), 8))
FROM Sales.Customer;

/*When presenting data to end users or exporting data to external systems, you may sometimes need to
preserve or add leading values, such as leading zeros to fixed-length numbers or spaces to varchar fields.
CustomerID was zero-padded by first concatenating eight zeros in a string to the converted varchar(10)
value of the CustomerID. Then, outside of this concatenation, RIGHT was used to grab the last eight characters
of the concatenated string (thus taking leading zeros from the left side with it when the CustomerID fell short
of eight digits).*/

--9-7. Returning Part of a String

SELECT TOP (3)
PhoneNumber,
AreaCode = LEFT(PhoneNumber, 3),
Exchange = SUBSTRING(PhoneNumber, 5, 3)
FROM Person.PersonPhone
WHERE PhoneNumber LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]';

SUBSTRING ( expression, start, length )

--9-8. Counting Characters or Bytes in a String

--This first example returns the number of characters in the Unicode string (Unicode data takes two bytes for
--each character, whereas ASCII takes only one), with trailing spaces excluded:

SELECT LEN(N'She sells sea shells by the sea shore. ');
SELECT DATALENGTH(N'She sells sea shells by the sea shore. ');

SELECT DATALENGTH(123),
DATALENGTH(123.0),
DATALENGTH(GETDATE());

--We pass an int, a numeric, and a datetime value into DATALENGTH, and DATALENGTH returns 4, 5, and 8,
--respectively.

--9-9. Replacing Part of a String

SELECT REPLACE('The Classic Roadie is a stunning example of the bikes that AdventureWorks
have been producing for years – Order your classic Roadie today and experience
AdventureWorks history.', 'Classic', 'Vintage');


REPLACE ( string_expression , search_string , replacement_string );

--In this case this is an empty string ('') not a NULL value. If replacement_string is NULL the
--output of REPLACE will always be NULL.

--9-10. Stuffing a String into a String/ You need to insert a string into another string.

SELECT STUFF ( 'My cat''s name is X. Have you met him?', 18, 1, 'Edgar' );
SELECT STUFF ( 'My cat''s name is X. Have you met him?', 18, 0, 'Edgar' );
SELECT STUFF ( 'My cat''s name is X. Have you met him?', 18, 8, '' );
STUFF ( character_expression, start, length, character_expression )

/*Do you notice the two single quotes in the query above? This is not double quote but rather is an
“escaped” apostrophe. String literals in SQL Server are identified by single quotes. To specify an apostrophe in a
string literal you need to “escape” the apostrophe by placing two apostrophes next to each other. You can see in
the results listing: “cat”s” is displayed as “cat’s.”*/

--9-11. Changing Between Lowercase and Uppercase

SELECT DocumentSummary
FROM Production.Document
WHERE FileName = 'Installing Replacement Pedals.doc';

SELECT LOWER(DocumentSummary)
FROM Production.Document
WHERE FileName = 'Installing Replacement Pedals.doc';

SELECT UPPER(DocumentSummary)
FROM Production.Document
WHERE FileName = 'Installing Replacement Pedals.doc';

--9-12. Removing Leading and Trailing Blanks

SELECT CONCAT('''', LTRIM(' String with leading and trailing blanks. '), '''' );
SELECT CONCAT('''', RTRIM(' String with leading and trailing blanks. '), '''' );
SELECT CONCAT('''', LTRIM(RTRIM(' String with leading and trailing blanks. ')), '''' );

--9-13. Repeating an Expression N Times

SELECT REPLICATE ('W', 30) ;
SELECT REPLICATE ('W_', 30) ;
REPLICATE ( character_expression,integer_expression )

--9-14. Repeating a Blank Space N Times

DECLARE @animals TABLE
(
string1 VARCHAR(20),
string2 VARCHAR(20),
string3 VARCHAR(20)
);
INSERT @animals
VALUES ('elephant', 'dog', 'giraffe'),
('kitty', 'puppy', 'ant'),
('chicken', 'fish', 'marmacet');
SELECT CONCAT(string1, SPACE(20 - LEN(string1)),
string2, SPACE(20 - LEN(string2)),
string3, SPACE(20 - LEN(string3)))
AS formatted_string
FROM @animals;

--9-15. Reversing the Order of Characters in a String
SELECT REVERSE('Hello World');


--Working with Dates and Times

--10-1. Returning the Current Date and Time

SELECT 'GETDATE()' AS [Function], GETDATE() AS [Value];
SELECT 'CURRENT_TIMESTAMP'AS [Function], CURRENT_TIMESTAMP AS [Value];
SELECT 'GETUTCDATE()' AS [Function], GETUTCDATE() AS [Value];
SELECT 'SYSDATETIME()' AS [Function], SYSDATETIME() AS [Value];
SELECT 'SYSUTCDATETIME()' AS [Function], SYSUTCDATETIME() AS [Value];
SELECT 'SYSDATETIMEOFFSET()' AS [Function], SYSDATETIMEOFFSET() AS [Value];

/*Function Value
------------------- ----------------------------------
GETDATE() 2015-01-23 23:47:39.170
CURRENT_TIMESTAMP 2015-01-23 23:47:39.170
GETUTCDATE() 2015-01-24 04:47:39.170
SYSDATETIME() 2015-01-23 23:47:39.1728701
SYSUTCDATETIME() 2015-01-24 04:47:39.1728701
SYSDATETIMEOFFSET() 2015-01-23 23:47:39.1728701 -05:00*/

--10-2. Converting Between Time Zones

SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '+03:00');

--10-3. Converting a Date/Time Value to a Datetimeoffset Value

SELECT TODATETIMEOFFSET(GETDATE(), '-05:00') AS [Eastern Time Zone Time],
SYSDATETIMEOFFSET() [Current System Time];


--10-4. Incrementing or Decrementing a Date’s Value
SELECT DATEADD(YEAR, -1, '2009-04-02T00:00:00');

/*Datepart Abbreviations
Year yy, yyyy
quarter qq, q
month mm, m
dayofyear dy, y
Day dd, d
week wk, ww
weekday dw, w
hour hh
minute mi, n
second ss, s
millisecond ms
microsecond mcs
nanosecond ns*/

SELECT DATEADD(MONTH, -1, '2009-04-02T00:00:00');

--10-5. Finding the Difference Between Two Dates

SELECT TOP (5)
ProductID,
GETDATE() AS Today,
EndDate,
DATEDIFF(MONTH, EndDate, GETDATE()) AS ElapsedMonths
FROM Production.ProductCostHistory
WHERE EndDate IS NOT NULL
ORDER BY ProductID;


WITH cteDates (StartDate, EndDate) AS
(
SELECT CONVERT(DATETIME2, '2010-12-31T23:59:59.9999999'),
CONVERT(DATETIME2, '2011-01-01T00:00:00.0000000')
)
SELECT StartDate,
EndDate,
DATEDIFF(YEAR, StartDate, EndDate) AS Years,
DATEDIFF(QUARTER, StartDate, EndDate) AS Quarters,
DATEDIFF(MONTH, StartDate, EndDate) AS Months,
DATEDIFF(DAY, StartDate, EndDate) AS Days,
DATEDIFF(HOUR, StartDate, EndDate) AS Hours,
DATEDIFF(MINUTE, StartDate, EndDate) AS Minutes,
DATEDIFF(SECOND, StartDate, EndDate) AS Seconds,
DATEDIFF(MILLISECOND, StartDate, EndDate) AS Milliseconds,
DATEDIFF(MICROSECOND, StartDate, EndDate) AS MicroSeconds
FROM cteDates;

--10-6. Finding the Elapsed Time Between Two Dates

DECLARE @StartDate DATETIME2 = '2012-01-01T18:25:42.9999999',
@EndDate DATETIME2 = '2012-06-15T13:12:11.8675309';
WITH cte AS
(
SELECT DATEDIFF(SECOND, @StartDate, @EndDate) AS ElapsedSeconds,
DATEDIFF(SECOND, @StartDate, @EndDate)/60 AS ElapsedMinutes,
DATEDIFF(SECOND, @StartDate, @EndDate)/3600 AS ElapsedHours,
DATEDIFF(SECOND, @StartDate, @EndDate)/86400 AS ElapsedDays
)
SELECT @StartDate AS StartDate,
@EndDate AS EndDate,
CONVERT(VARCHAR(10), ElapsedDays) + ':' +
CONVERT(VARCHAR(10), ElapsedHours%24) + ':' +
CONVERT(VARCHAR(10), ElapsedMinutes%60) + ':' +
CONVERT(VARCHAR(10), ElapsedSeconds%60) AS [ElapsedTime (D:H:M:S)]
FROM cte;

--TOTAL DIFFERENCE IN SECONDS, COULD EASILY BE DIVIDED TO GET ELAPSED SECONDS, MINUTES, HOURS, DAYS

--10-7. Displaying the String Value for Part of a Date

SELECT TOP (5)
ProductID,
EndDate,
DATENAME(MONTH, EndDate) AS MonthName,
DATENAME(WEEKDAY, EndDate) AS WeekDayName
FROM Production.ProductCostHistory
WHERE EndDate IS NOT NULL
ORDER BY ProductID;

DECLARE @StartDate DATETIME2 = '2012-01-01T18:25:42.9999999';
SELECT @StartDate AS StartDate,
DATENAME(MONTH, @StartDate) AS MonthName,
DATENAME(WEEKDAY, @StartDate) AS WeekDayName;

--10-8. Displaying the Integer Representations for Parts of a Date
SELECT TOP (5)
ProductID,
EndDate,
DATEPART(YEAR, EndDate) AS [Year],
DATEPART(MONTH, EndDate) AS [Month],
DATEPART(DAY, EndDate) AS [Day]
FROM Production.ProductCostHistory
WHERE EndDate IS NOT NULL
ORDER BY ProductID;

DECLARE @StartDate DATETIME2 = '2012-01-01T18:25:42.9999999';
SELECT @StartDate AS StartDate,
DATEPART(YEAR,  @StartDate) AS [Year],
DATEPART(MONTH,  @StartDate) AS [Month],
DATEPART(DAY,  @StartDate) AS [Day];

--10-9. Determining Whether a String Is a Valid Date

SELECT MyData,
ISDATE(MyData) AS IsADate
FROM ( VALUES ( 'IsThisADate'),
( '2012-02-14'),
( '2012-01-01T00:00:00'),
( '2012-12-31T23:59:59.9999999') ) dt (MyData);

--10-10. Determining the Last Day of the Month

SELECT MyData,
EOMONTH(MyData) AS LastDayOfThisMonth,
EOMONTH(MyData, 1) AS LastDayOfNextMonth
FROM (VALUES ('2012-02-14T00:00:00' ),
('2012-01-01T00:00:00'),
('2012-12-31T23:59:59.9999999')) dt(MyData);

--10-11. Creating a Date from Numbers

SELECT 'DateFromParts' AS ConversionType,
DATEFROMPARTS(2012, 8, 15) AS [Value];
SELECT 'TimeFromParts' AS ConversionType,
TIMEFROMPARTS(18, 25, 32, 5, 1) AS [Value];
SELECT 'SmallDateTimeFromParts' AS ConversionType,
SMALLDATETIMEFROMPARTS(2012, 8, 15, 18, 25) AS [Value];
SELECT 'DateTimeFromParts' AS ConversionType,
DATETIMEFROMPARTS(2012, 8, 15, 18, 25, 32, 450) AS [Value];
SELECT 'DateTime2FromParts' AS ConversionType,
DATETIME2FROMPARTS(2012, 8, 15, 18, 25, 32, 5, 7) AS [Value];
SELECT 'DateTimeOffsetFromParts' AS ConversionType,
DATETIMEOFFSETFROMPARTS(2012, 8, 15, 18, 25, 32, 5, 4, 0, 7) AS [Value];

/*ConversionType Value
-------------- ----------
DateFromParts 2012-08-15
TimeFromParts 18:25:32.5
SmallDateTimeFromParts 2012-08-15 18:25:00
DateTimeFromParts 2012-08-15 18:25:32.450
DateTime2FromParts 2012-08-15 18:25:32.0000005
DateTimeOffsetFromParts 2012-08-15 18:25:32.0000005 +04:00*/

SELECT TIMEFROMPARTS(18, 25, 32, 5, 1);
SELECT TIMEFROMPARTS(18, 25, 32, 5, 2);
SELECT TIMEFROMPARTS(18, 25, 32, 5, 3);
SELECT TIMEFROMPARTS(18, 25, 32, 5, 4);
SELECT TIMEFROMPARTS(18, 25, 32, 5, 5);
SELECT TIMEFROMPARTS(18, 25, 32, 5, 6);
SELECT TIMEFROMPARTS(18, 25, 32, 5, 7);
SELECT TIMEFROMPARTS(18, 25, 32, 50, 2);
SELECT TIMEFROMPARTS(18, 25, 32, 500, 3);

/*18:25:32.5
18:25:32.05
18:25:32.005
18:25:32.0005
18:25:32.00005
18:25:32.000005
18:25:32.0000005
18:25:32.50
18:25:32.500*/

--10-12. Finding the Beginning Date of a Datepart

DECLARE @MyDate DATETIME2 = '2012-01-01T18:25:42.9999999',
@Base DATETIME = '1900-01-01T00:00:00',
@Base2 DATETIME = '2000-01-01T00:00:00';
-- Solution 1
SELECT MyDate,
DATEADD(YEAR, DATEDIFF(YEAR, @Base, MyDate), @Base) AS [FirstDayOfYear],
DATEADD(MONTH, DATEDIFF(MONTH, @Base, MyDate), @Base) AS [FirstDayOfMonth],
DATEADD(QUARTER,DATEDIFF(QUARTER, @Base, MyDate), @Base) AS [FirstDayOfQuarter]
FROM (VALUES ('1981-01-17T00:00:00'),
('1961-11-23T00:00:00'),
('1960-07-09T00:00:00'),
('1980-07-11T00:00:00'),
('1983-01-05T00:00:00'),
('2006-11-27T00:00:00'),
('2013-08-03T00:00:00')) dt (MyDate);

SELECT 'StartOfHour' AS ConversionType,
DATEADD(HOUR, DATEDIFF(HOUR, @Base, @MyDate), @Base) AS DateResult
UNION ALL
SELECT 'StartOfMinute',
DATEADD(MINUTE, DATEDIFF(MINUTE, @Base, @MyDate), @Base)
UNION ALL
SELECT 'StartOfSecond',
DATEADD(SECOND, DATEDIFF(SECOND, @Base2, @MyDate), @Base2);


/*Solution #2
Break the date down into the appropriate parts, then use the DATETIMEFROMPARTS function to build a new
date, with the parts that are being truncated set to 1 (for months/dates) or zero (for hours/minutes/seconds/
milliseconds).*/

SELECT MyDate,
DATETIMEFROMPARTS(ca.Yr, 1, 1, 0, 0, 0, 0) AS FirstDayOfYear,
DATETIMEFROMPARTS(ca.Yr, ca.Mn, 1, 0, 0, 0, 0) AS FirstDayOfMonth,
DATETIMEFROMPARTS(ca.Yr, ca.Qt, 1, 0, 0, 0, 0) AS FirstDayOfQuarter
FROM (VALUES ('1981-01-17T00:00:00'),
('1961-11-23T00:00:00'),
('1960-07-09T00:00:00'),
('1980-07-11T00:00:00'),
('1983-01-05T00:00:00'),
('2006-11-27T00:00:00'),
('2013-08-03T00:00:00')) dt (MyDate)
CROSS APPLY (SELECT DATEPART(YEAR, dt.MyDate) AS Yr,
DATEPART(MONTH, dt.MyDate) AS Mn,
((CEILING(MONTH(dt.MyDate)/3.0)*3)-2) AS Qt
) ca;

WITH cte AS
(
SELECT DATEPART(YEAR, @MyDate) AS Yr,
DATEPART(MONTH, @MyDate) AS Mth,
DATEPART(DAY, @MyDate) AS Dy,
DATEPART(HOUR, @MyDate) AS Hr,
DATEPART(MINUTE, @MyDate) AS Mn,
DATEPART(SECOND, @MyDate) AS Sec
)
SELECT 'StartOfHour' AS ConversionType,
DATETIMEFROMPARTS(cte.Yr, cte.Mth, cte.Dy, cte.Hr, 0, 0, 0) AS DateResult
FROM cte
UNION ALL
SELECT 'StartOfMinute',
DATETIMEFROMPARTS(cte.Yr, cte.Mth, cte.Dy, cte.Hr, cte.Mn, 0, 0)
FROM cte
UNION ALL
SELECT 'StartOfSecond',
DATETIMEFROMPARTS(cte.Yr, cte.Mth, cte.Dy, cte.Hr, cte.Mn, cte.Sec, 0)
FROM cte;


/*Solution #3
Use the FORMAT function to format the date, using default values for the parts to be truncated.*/

SELECT CONVERT(CHAR(10), ca.MyDate, 121) AS MyDate,
CAST(FORMAT(ca.MyDate, 'yyyy-01-01') AS DATETIME) AS FirstDayOfYear,
CAST(FORMAT(ca.MyDate, 'yyyy-MM-01') AS DATETIME) AS FirstDayOfMonth
FROM (VALUES ('1981-01-17T00:00:00'),
('1961-11-23T00:00:00'),
('1960-07-09T00:00:00'),
('1980-07-11T00:00:00'),
('1983-01-05T00:00:00'),
('2006-11-27T00:00:00'),
('2013-08-03T00:00:00')) dt (MyDate)
CROSS APPLY (SELECT CAST(dt.MyDate AS DATE)) AS ca(MyDate);

SELECT 'StartOfHour' AS ConversionType,
FORMAT(@MyDate, 'yyyy-MM-dd HH:00:00.000') AS DateResult
UNION ALL
SELECT 'StartOfMinute',
FORMAT(@MyDate, 'yyyy-MM-dd HH:mm:00.000')
UNION ALL
SELECT 'StartOfSecond',
FORMAT(@MyDate, 'yyyy-MM-dd HH:mm:ss.000');

---------------------------------------------------------------

DECLARE @MyDate DATETIME2 = '2012-01-01T18:25:42.9999999';
SELECT 'StartOfHour' AS ConversionType,
FORMAT(@MyDate, 'yyyy-MM-dd HH:00:00.000') AS DateResult
UNION ALL
SELECT 'StartOfMinute',
FORMAT(@MyDate, 'yyyy-MM-dd HH:mm:00.000')
UNION ALL
SELECT 'StartOfSecond',
FORMAT(@MyDate, 'yyyy-MM-dd HH:mm:ss.000');

DECLARE @MyDate DATETIME2 = '2012-09-01T18:25:42.9999999';
SELECT DATEPART(YEAR,  @MyDate) AS Yr,
DATEPART(MONTH,  @MyDate) AS Mn,
((CEILING(MONTH( @MyDate)/3.0)*3)-2) AS Qt;

CROSS APPLY (SELECT DATEPART(YEAR, dt.MyDate) AS Yr,
DATEPART(MONTH, dt.MyDate) AS Mn,
((CEILING(MONTH(dt.MyDate)/3.0)*3)-2) AS Qt

SELECT MyDate,
DATETIMEFROMPARTS(ca.Yr, 1, 1, 0, 0, 0, 0) AS FirstDayOfYear,
DATETIMEFROMPARTS(ca.Yr, ca.Mn, 1, 0, 0, 0, 0) AS FirstDayOfMonth,
DATETIMEFROMPARTS(ca.Yr, ca.Qt, 1, 0, 0, 0, 0) AS FirstDayOfQuarter
FROM (VALUES ('1981-01-17T00:00:00'),
('1961-11-23T00:00:00'),
('1960-07-09T00:00:00'),
('1980-07-11T00:00:00'),
('1983-01-05T00:00:00'),
('2006-11-27T00:00:00'),
('2013-08-03T00:00:00')) dt (MyDate)
CROSS APPLY (SELECT DATEPART(YEAR, dt.MyDate) AS Yr,
DATEPART(MONTH, dt.MyDate) AS Mn,
((CEILING(MONTH(dt.MyDate)/3.0)*3)-2) AS Qt
) ca;

----------------------------------------------------------------------

--10-13. Include Missing Dates

DECLARE @Base DATETIME = '1900-01-01T00:00:00';

WITH cteExpenses AS
(
SELECT ca.FirstOfMonth,
SUM(ExpenseAmount) AS MonthlyExpenses
FROM ( VALUES ('2012-01-15T00:00:00', 1250.00),
('2012-01-28T00:00:00', 750.00),
('2012-03-01T00:00:00', 1475.00),
('2012-03-23T00:00:00', 2285.00),
('2012-04-01T00:00:00', 1650.00),
('2012-04-22T00:00:00', 1452.00),
('2012-06-15T00:00:00', 1875.00),
('2012-07-23T00:00:00', 2125.00) ) dt (ExpenseDate, ExpenseAmount)
CROSS APPLY (SELECT DATEADD(MONTH,
DATEDIFF(MONTH, @Base, ExpenseDate), @Base) ) ca (FirstOfMonth)
GROUP BY ca.FirstOfMonth
), cteMonths AS
(
SELECT DATEFROMPARTS(2012, M, 1) AS FirstOfMonth
FROM ( VALUES (1), (2), (3), (4),
(5), (6), (7), (8),
(9), (10), (11), (12) ) Months (M)
)
SELECT CAST(FirstOfMonth AS DATE) AS FirstOfMonth,
MonthlyExpenses
FROM cteExpenses
UNION ALL
SELECT m.FirstOfMonth,
0
FROM cteMonths M
LEFT JOIN cteExpenses e
ON M.FirstOfMonth = e.FirstOfMonth
WHERE e.FirstOfMonth IS NULL
ORDER BY FirstOfMonth;


--10.14 You need to find the date of an arbitrary date, such as the third Thursday in November or the date for
--last Friday.

CREATE TABLE dbo.Calendar (
[Date] DATE CONSTRAINT PK_Calendar PRIMARY KEY CLUSTERED,
FirstDayOfYear DATE,
LastDayOfYear DATE,
FirstDayOfMonth DATE,
LastDayOfMonth DATE,
FirstDayOfWeek DATE,
LastDayOfWeek DATE,
DayOfWeekName NVARCHAR(20),
IsWeekDay BIT,
IsWeekEnd BIT);
GO
DECLARE @Base DATETIME = '1900-01-01T00:00:00',
@Start DATETIME = '2000-01-01T00:00:00';
INSERT INTO dbo.Calendar
SELECT TOP (9497)
ca.Date,
cy.FirstDayOfYear,
cyl.LastDayOfYear,
cm.FirstDayOfMonth,
cml.LastDayOfMonth,
cw.FirstDayOfWeek,
cwl.LastDayOfWeek,
cd.DayOfWeekName,
cwd.IsWeekDay,
CAST(cwd.IsWeekDay - 1 AS BIT) AS IsWeekEnd
FROM (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0))
FROM sys.all_columns t1
CROSS JOIN sys.all_columns t2) dt (RN)
CROSS APPLY (SELECT DATEADD(DAY, RN-1, @Start)) AS ca(Date)
CROSS APPLY (SELECT DATEADD(YEAR, DATEDIFF(YEAR, @Base, ca.Date), @Base)) AS cy(FirstDayOfYear)
CROSS APPLY (SELECT DATEADD(DAY, -1, DATEADD(YEAR, 1, cy.FirstDayOfYear))) AS cyl(LastDayOfYear)
CROSS APPLY (SELECT DATEADD(MONTH, DATEDIFF(MONTH, @Base, ca.Date), @Base)) AS
cm(FirstDayOfMonth)
CROSS APPLY (SELECT DATEADD(DAY, -1, DATEADD(MONTH, 1, cm.FirstDayOfMonth))) AS
cml(LastDayOfMonth)
CROSS APPLY (SELECT DATEADD(DAY,-(DATEPART(weekday ,ca.Date)-1),ca.Date)) AS cw(FirstDayOfWeek)
CROSS APPLY (SELECT DATEADD(DAY, 6, cw.FirstDayOfWeek)) AS cwl(LastDayOfWeek)
CROSS APPLY (SELECT DATENAME(weekday, ca.Date)) AS cd(DayOfWeekName)
CROSS APPLY (SELECT CASE WHEN cd.DayOfWeekName
IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
THEN 1
ELSE 0
END) AS cwd(IsWeekDay);
GO
WITH cte AS
(
SELECT FirstDayOfMonth,
Date,
RN = ROW_NUMBER() OVER (PARTITION BY FirstDayOfMonth ORDER BY Date)
FROM dbo.Calendar
WHERE DayOfWeekName = 'Thursday'
)
SELECT Date
FROM cte
WHERE RN = 3
AND FirstDayOfMonth = '2012-11-01T00:00:00';
SELECT c1.Date
FROM dbo.Calendar c1 -- prior week
JOIN dbo.Calendar c2 -- current week
ON c1.FirstDayOfWeek = DATEADD(DAY, -7, c2.FirstDayOfWeek)
WHERE c1.DayOfWeekName = 'Friday'
AND c2.Date = CAST(GETDATE() AS DATE);


--10-15. Querying for Intervals/ You want to count the number of employees that were employed during each month.
WITH cte AS
(
SELECT edh.BusinessEntityID,
c.FirstDayOfMonth
FROM HumanResources.EmployeeDepartmentHistory AS edh
JOIN dbo.Calendar AS c
ON c.Date BETWEEN edh.StartDate
AND ISNULL(edh.EndDate, GETDATE())
GROUP BY edh.BusinessEntityID,
c.FirstDayOfMonth
)
SELECT FirstDayOfMonth,
COUNT(*) AS EmployeeQty
FROM cte
GROUP BY FirstDayOfMonth
ORDER BY FirstDayOfMonth;


--10-16. Working with Dates and Times Across National
--Boundaries
--When exchanging data with a company in a different country, dates either are converted incorrectly or
--generate an error when being imported.

SELECT 'sysdatetime' AS ConversionType, 126 AS Style,
CONVERT(varchar(30), SYSDATETIME(), 126) AS [Value] UNION ALL
SELECT 'sysdatetime', 127,
CONVERT(varchar(30), SYSDATETIME(), 127) UNION ALL
SELECT 'getdate', 126,
CONVERT(varchar(30), GETDATE(), 126) UNION ALL
SELECT 'getdate', 127,
CONVERT(varchar(30), GETDATE(), 127);

---------------------------------Working with Numbers

--Choose one of the four integer data types provided in SQL Server. Here is a code block showing the four
--types and their range of valid values:
DECLARE @bip bigint, @bin bigint
DECLARE @ip int, @in int
DECLARE @sip smallint, @sin smallint
DECLARE @ti tinyint
SET @bip = 9223372036854775807 /* 2^63-1 */
SET @bin = -9223372036854775808 /* -2^63 */
SET @ip = 2147483647 /* 2^31-1 */
SET @in = -2147483648 /* -2^31 */
SET @sip = 32767 /* 2^15-1 */
SET @sin = -32768 /* -2^15 */
SET @ti = 255 /* 2^8-1 */
SELECT 'bigint' AS type_name, @bip AS max_value, @bin AS min_value
UNION ALL
SELECT 'int', @ip, @in
UNION ALL
SELECT 'smallint', @sip, @sin
UNION ALL
SELECT 'tinyint', @ti, 0
ORDER BY max_value DESC;

/*• bigint (eight bytes)
• int (four bytes)
• smallint (two bytes)
• tinyint (one byte)*/

DECLARE @sin smallint
SET @sin = -32769

--11-2. Creating Single-Bit Integers 
--Your application requires several on/off flags that you wish to store in the smallest possible space.
DECLARE @SunnyDayFlag bit
SET @SunnyDayFlag = 1;
SET @SunnyDayFlag = 'true'
SELECT @SunnyDayFlag;

--11-3. Representing Decimal and Monetary Amounts
--You are working with decimal data, such as monetary amounts, for which precise, base-10 representation is
--critical. You want to create a variable or table column of an appropriate type.

DECLARE @x0 decimal(7,0) = 1234567.
DECLARE @x1 decimal(7,1) = 123456.7
DECLARE @x2 decimal(7,2) = 12345.67
DECLARE @x3 decimal(7,3) = 1234.567
DECLARE @x4 decimal(7,4) = 123.4567
DECLARE @x5 decimal(7,5) = 12.34567
DECLARE @x6 decimal(7,6) = 1.234567
DECLARE @x7 decimal(7,7) = .1234567

--For example, a declaration of
--decimal(11,2) allows a range of values from -$999,999,999.99 to $999,999,999.99.

--11-4. Representing Floating-Point Values
--You are performing scientific calculations and need the ability to represent floating-point values.

DECLARE @x1 real /* same as float(24) */
DECLARE @x2 float /* same as float(53) */
DECLARE @x3 float(53)
DECLARE @x4 float(24)

/*Declaration Minimum Absolute Value Maximum Absolute Value
real 1.18E-38 3.40E+38
float 2.23E-308 1.79E+308
float(53) 2.23E-308 1.79E+308
float(24) 1.18E-38 3.40E+38*/

--11-5. Writing Mathematical Expressions
--You are working with number values and want to write expressions to compute new values.

DECLARE @cur_bal decimal(7,2) = 94235.49
DECLARE @new_bal decimal(7,2)
SET @new_bal = @cur_bal - (500.00 - ROUND(@cur_bal * 0.06 / 12.00, 2))
SELECT @new_bal;

/*Priority Level Operator Description
1 ~ Bitwise NOT
2 *, /, % Multiply, divide, modulo
3 +, - Positive sign, negative sign
3 +, - Add, subtract
3 + String concatenate
3 &, ^, | Bitwise AND, Bitwise exclusive OR, Bitwise OR
4 =, <, <=, !<, >, >=, !>, <>, != Equals, less than, less than or equal, not less than,
greater than, greater than or equal, not greater
than, not equal, not equal
5 NOT Logical NOT
6 AND Logical AND
7 ALL, ANY, BETWEEN, IN, LIKE, OR,
SOME
Logical OR and others
8 = Assignment*/

--11-6. Casting Between Data Types
--writing an expression involving values from more than one data type.

---------------------------------USE OF CAST AND CONVERT

SELECT 6/100,
CAST(6 AS DECIMAL(1,0)) / CAST(100 AS DECIMAL(3,0)),
CAST(6.0/100.0 AS DECIMAL(3,2));

SELECT 6/100,
CONVERT(DECIMAL(1,0), 6) / CONVERT(DECIMAL(3,0), 100),
CONVERT(DECIMAL(3,2), 6.0/100.0);

/*Precedence Level Data Type Precedence Level Data Type
1 Any user-defined type 16 int
2 sql_variant 17 smallint
3 xml 18 tinyint
4 datetimeoffset 19 bit
5 datetime2 20 ntext
6 datetime 21 text
7 smalldatetime 22 image
8 date 23 timestamp
9 time 24 unique
10 float 25 nvarchar
11 real 26 nchar
12 decimal 27 varchar
13 money 28 char
14 smallmoney 29 varbinary
15 bigint 30 binary*/

DECLARE @cur_bal decimal(7,2) = 94235.49
DECLARE @new_bal decimal(7,2)
SET @new_bal = @cur_bal - (500.00 - CAST(@cur_bal * (6.0/100.0) / 12.00 AS decimal(7,2)))
SELECT @new_bal;

--11-7. Converting Numbers to Text
--You have numeric values that you want to represent in human-readable form.

SELECT ProductID, Name,
CONVERT(NVARCHAR, ListPrice, 1) AS 'Price',
CONVERT(NVARCHAR, Weight) AS 'Weight'
FROM Production.Product
WHERE ListPrice > 0 AND Weight IS NOT NULL;

/*Type Family Style Number Result

Floating-point 
0 Gives zero to six digits and scientific notation when
needed. This is the default style when floating-point
values are converted to text.
1 Gives eight digits and scientific notation.
2 Gives 16 digits and scientific notation.

Money 
0 Allows two decimal digits. No commas used between
digit groups. This is the default style for non-floatingpoint
conversions.
1 Allows two decimal digits and includes commas
between digit groups.
2 Allows four decimal digits, but no commas.*/

--11-8. Converting from Text to a Number
--compute a human-readable representation of a number to one of the binary equivalents used
--by SQL Server to store numeric types.

SELECT 0-CONVERT(DECIMAL, NationalIDNumber) AS 'Negative ID'
FROM HumanResources.Employee;

--This query converts national ID numbers from text to decimal, and arbitrarily makes them negative.

--11-9. Rounding / You want to round a number value to a specific number of decimal places.

SELECT EndOfDayRate,
ROUND(EndOfDayRate,0) AS EODR_Dollar,
ROUND(EndOfDayRate,2) AS EODR_Cent
FROM Sales.CurrencyRate;

/*EndOfDayRate EODR_Dollar EODR_Cent
--------------------- --------------------- ---------------------
1.0002 1.00 1.00
1.55 2.00 1.55
1.9419 2.00 1.94
1.4683 1.00 1.47
8.2784 8.00 8.28*/

SELECT ROUND(500,-3);
SELECT ROUND(500.0,-4);

SELECT ROUND(500.0,-3);
SELECT ROUND(CAST(500.0 as DECIMAL(5,1)),-3)

--11-10. Rounding Always Up or Down
--You want to force a result to an integer value. You want to always round either up or down.

SELECT CEILING(-1.23), FLOOR (-1.23), CEILING(1.23), FLOOR(1.23);

SELECT CEILING(123.0043*100.0)/100.0 AS toCent,
CEILING(123.0043/100.0)*100.0 AS toHundred;

--123.0043--12300(CEILING SAME) --123
--123.0043--1.23(CEILING 2)--2--200

--11-11. Discarding Decimal Places
--You want to just “chop off” the digits past the decimal point. You don’t care about rounding at all. You just
--want zeros.

SELECT ROUND(123.99,0,1), ROUND(123.99,1,1), ROUND(123.99,-1,1);
--123.00 123.90 120.00

--11-12. Testing Equality of Binary Floating-Point Values
DECLARE @r1 real = 0.95
DECLARE @f1 float = 0.95
IF ABS(@r1-@f1) < 0.000001
SELECT 'Equal'
ELSE
SELECT 'Not Equal'

DECLARE @r1 real = 0.95
DECLARE @f1 float = 0.95
SELECT @r1, @f1, @r1-@f1;


/*The 00 fundamental problem is that the base-2 representation of 0.95 is a never-ending string of bits.
The float type is larger, allowing for more bits, which is the reason for the nonzero difference. By applying the
threshold method shown in the solution, you can pretend that the tiny difference does not exist.*/

-----11-13. Treating Nulls as Zeros

/*Invoke the COALESCE function to supply a value of zero in the event of a null. For example, the following
query returns the MaxQty column from Sales.SpecialOffer. That column is nullable. COALESCE is used to
supply a zero as an alternate value.*/
SELECT SpecialOfferID, MaxQty, COALESCE(MaxQty, 0) AS MaxQtyAlt
FROM Sales.SpecialOffer;

SELECT SpecialOfferID, MaxQty, ISNULL(MaxQty, 0) AS MaxQtyAlt
FROM Sales.SpecialOffer;


/*It’s generally good practice to avoid invoking either COALESCE or ISNULL within a WHERE clause predicate.
Applying functions to a column mentioned in a WHERE clause can inhibit the use of an index on the column.
Here’s an example of what we try to avoid:*/

SELECT SpecialOfferID
FROM Sales.SpecialOffer
WHERE COALESCE(MaxQty,0) = 0;

SELECT SpecialOfferID
FROM Sales.SpecialOffer
WHERE MaxQty = 0 OR MaxQty IS NULL;

--11-14. Generating a Row Set of Sequential Numbers

WITH ones AS (
SELECT *
FROM (VALUES (0), (1), (2), (3), (4),
(5), (6), (7), (8), (9)) AS numbers(x)
)
SELECT 1000*o1000.x + 100*o100.x + 10*o10.x + o1.x x
FROM ones o1, ones o10, ones o100, ones o1000
ORDER BY x;

WITH ones AS (
SELECT *
FROM (VALUES (0), (1), (2), (3), (4),
(5), (6), (7), (8), (9)) AS numbers(x)
)
SELECT n.x FROM (
SELECT 1000*o1000.x + 100*o100.x + 10*o10.x + o1.x x
FROM ones o1, ones o10, ones o100, ones o1000
) n
WHERE n.x < 5000             --TILL 5000
ORDER BY x;


SELECT DISTINCT HireDate
FROM HumanResources.Employee
WHERE HireDate >= '2012-01-01'
AND HireDate < '2013-01-01'
ORDER BY HireDate;


WITH ones AS (
SELECT *
FROM (VALUES (0), (1), (2), (3), (4),
(5), (6), (7), (8), (9)) AS numbers(x)
)
SELECT 100*o100.x + 10*o10.x + o1.x x
INTO SeqNum
FROM ones o1, ones o10, ones o100;

SELECT * FROM SeqNum


SELECT DATEADD(day, x, '2012-01-01'), HireDate
FROM SeqNum LEFT OUTER JOIN HumanResources.Employee
ON DATEADD(day, x, '2012-01-01') = HireDate
WHERE x < DATEDIFF (day, '2012-01-01', '2013-01-01')
ORDER BY x;

SELECT DATEADD(day, x, '2012-01-01'), COUNT(HireDate)
FROM SeqNum LEFT OUTER JOIN HumanResources.Employee
ON DATEADD(day, x, '2012-01-01') = HireDate
WHERE x < DATEDIFF (day, '2012-01-01', '2013-01-01')
GROUP BY x
ORDER BY x;

/*Results now show the number of hires per day. The following are results for the same days as in the
previous output. This time, the count of hires is zero on all days having only null hire dates. The count is 1 on
May 18, 2006, for the one person hired on that date.*/

----11-15. Generating Random Integers in a Row Set

/*You want each row returned by a query to include a random integer value. You further want to specify the
range within which those random values will fall. For example, you want to generate a random number
between 900 and 1,000 for each product.*/

DECLARE @rmin int, @rmax int;
SET @rmin = 900;
SET @rmax = 1000;
SELECT Name,
CAST(RAND(CHECKSUM(NEWID())) * (@rmax-@rmin) AS INT) + @rmin
FROM Production.Product;

SELECT Name, RAND()
FROM Production.Product;

/*What’s needed is a seed value that changes for each row. A common and useful approach is to base
the seed value on a call to NEWID(). NEWID() returns a value in a type not passable to RAND(). You can work
around that problem by invoking CHECKSUM() on the NEWID() value to generate an integer value acceptable
as a seed. Here’s an example:*/

SELECT Name, RAND(CHECKSUM(NEWID()))
FROM Production.Product;

DECLARE @rmin int, @rmax int;
SET @rmin = 900;
SET @rmax = 1000;
SELECT Name,
RAND(CHECKSUM(NEWID())) * (@rmax-@rmin)
FROM Production.Product;

DECLARE @rmin int, @rmax int;
SET @rmin = 900;
SET @rmax = 1000;
SELECT Name,
RAND(CHECKSUM(NEWID())) * (@rmax-@rmin) + @rmin
FROM Production.Product;

------------11-16. Reducing Space Used by Decimal Storage

--You have very large tables with a great many decimal columns holding values notably smaller than their
precisions allow. You want to reduce the amount of space to better reflect the actual values stored rather
than the possible maximums.


--Managing Tables
--13-1. Creating a Table

CREATE TABLE dbo.Person (
PersonID INT IDENTITY CONSTRAINT PK_Person PRIMARY KEY CLUSTERED,
BusinessEntityId INT NOT NULL
CONSTRAINT FK_Person REFERENCES Person.BusinessEntity (BusinessEntityID),
First_Name VARCHAR(50) NOT NULL);

/*This recipe creates a relatively simple table of three columns. The first column (PersonID) has an integer
data type, is automatically populated by having the IDENTITY property set, and has a clustered primary key
constraint on it. Since primary key constraints do not allow columns to be nullable, this column is implicitly
set to not allow NULL values.*/

CREATE TABLE dbo.Test (
Column1 INT NOT NULL,
Column2 INT NOT NULL,
CONSTRAINT PK_Test PRIMARY KEY CLUSTERED (Column1, Column2));

--13-2. Adding a Column

ALTER TABLE dbo.Person
ADD Last_Name VARCHAR(50) NULL;

--13-3. Adding a Column that Requires Data
--You need to add a new column to an existing table, and you need to create it so as to have NOT NULL values.

ALTER TABLE dbo.Person
ADD IsActive BIT NOT NULL
CONSTRAINT DF__Person__IsActive DEFAULT (0);

--13-4. Changing a Column
--You need to modify the data type or properties of an existing column in a table.

ALTER TABLE dbo.Person
ALTER COLUMN Last_Name VARCHAR(75) NULL;

/*f the existing column is specified with the NOT NULL attribute, you must specify NOT NULL for the
new column definition as well in order to retain the NOT NULL attribute on the column. Additionally, if the
existing column already has data in it, and the data is not able to be implicitly converted to the new data type,
then the ALTER TABLE statement will fail.*/

--13-5. Creating a Computed Column
--You need to save a calculation used when querying a table.

ALTER TABLE Production.TransactionHistory
ADD CostPerUnit AS (ActualCost/Quantity);
CREATE TABLE HumanResources.CompanyStatistic (
CompanylD int NOT NULL,
StockTicker char(4) NOT NULL,
SharesOutstanding int NOT NULL,
Shareholders int NOT NULL,
AvgSharesPerShareholder AS (SharesOutstanding/Shareholders) PERSISTED);

/*In the first example, a new computed column (CostPerUnit) is added to a table. When querying this
table, this column will be returned with the results of the calculation specified. The calculation results
themselves are not physically stored in the table.*/

SELECT TOP (1) CostPerUnit, Quantity, ActualCost
FROM Production.TransactionHistory
WHERE Quantity > 10
ORDER BY ActualCost DESC;

--13-6. Removing a Column

ALTER TABLE dbo.Person
DROP COLUMN Last_Name;

/*You can drop a column only if it isn’t being used in a PRIMARY KEY, FOREIGN KEY, UNIQUE, or CHECK
CONSTRAINT (these constraint types are all covered in this chapter). You also can’t drop a column being used in
an index or one that has a DEFAULT value bound to it.*/

--13-7. Removing a Table
DROP TABLE dbo.Person;

/*The DROP TABLE statement will fail if any other table is referencing the table to be dropped through a
foreign key constraint. If there are foreign key references, you must drop them first before dropping the primary
key table.*/

--13-8. Reporting on a Table’s Definition

--You need to see information about the metadata for a table.
EXECUTE sp_help 'Person.Person';

--13-9. Reducing Storage Used by NULL Columns
/*You have a table with hundreds (or even thousands) of columns (for example, a table in a SharePoint site
that stores data about uploaded documents, where different columns are used for data about different file
types), and most of these columns are NULL. However, this table still consumes extremely large amounts of
storage space. You need to reduce the storage needs of this table.
solution Specify the SPARSE column attribute for each of these nullable columns*/

CREATE TABLE dbo.WebsiteProduct (
WebsiteProductID int NOT NULL PRIMARY KEY IDENTITY(1,1),
ProductNM varchar(255) NOT NULL,
PublisherNM varchar(255) SPARSE NULL,
ArtistNM varchar(150) SPARSE NULL,
ISBNNBR varchar(30) SPARSE NULL,
DiscsNBR int SPARSE NULL,
MusicLabelNM varchar(255) SPARSE NULL);

INSERT dbo.WebsiteProduct (ProductNM, PublisherNM, ISBNNBR)
VALUES ('SQL Server Transact-SQL Recipes', 'Apress', '9781484200629');
INSERT dbo.WebsiteProduct (ProductNM, ArtistNM, DiscsNBR, MusicLabelNM)
VALUES ('Etiquette', 'Casiotone for the Painfully Alone', 1, 'Tomlab');

SELECT * FROM dbo.WebsiteProduct

SELECT ProductNM, PublisherNM,ISBNNBR FROM dbo.WebsiteProduct WHERE ISBNNBR IS NOT NULL;

ALTER TABLE dbo.WebsiteProduct
ADD ProductAttributeCS XML COLUMN_SET FOR ALL_SPARSE_COLUMNS;

/**Msg 1734, Level 16, State 1, Line 1
Cannot create the sparse column set 'ProductAttributeCS' in the table 'WebsiteProduct'
because the table already contains one or more sparse columns. A sparse column set cannot
be added to a table if the table contains a sparse column.*/

IF OBJECT_ID('dbo.WebsiteProduct', 'U') IS NOT NULL
DROP TABLE dbo.WebsiteProduct;
CREATE TABLE dbo.WebsiteProduct (
WebsiteProductID int NOT NULL PRIMARY KEY IDENTITY(1,1),
ProductNM varchar(255) NOT NULL,
PublisherNM varchar(255) SPARSE NULL,
ArtistNM varchar(150) SPARSE NULL,
ISBNNBR varchar(30) SPARSE NULL,
DiscsNBR int SPARSE NULL,
MusicLabelNM varchar(255) SPARSE NULL,
ProductAttributeCS xml COLUMN_SET FOR ALL_SPARSE_COLUMNS);

SELECT ProductNM, ProductAttributeCS
FROM dbo.WebsiteProduct
WHERE ISBNNBR IS NOT NULL;





--13-10. Adding a Constraint to a Table
--You need to add one or more constraints (PRIMARY KEY, UNIQUE, or FOREIGN KEY) to a table in order to
--enforce referential integrity rules on the table or between tables.

CREATE TABLE dbo.Person (
PersonID INT IDENTITY NOT NULL,
BusinessEntityId INT NOT NULL,
First_Name VARCHAR(50) NULL,
Last_Name VARCHAR(50) NULL);
ALTER TABLE dbo.Person
ADD CONSTRAINT PK_Person PRIMARY KEY CLUSTERED (PersonID),
CONSTRAINT FK_Person FOREIGN KEY (BusinessEntityId)
REFERENCES Person.BusinessEntity (BusinessEntityID),
CONSTRAINT UK_Person_Name UNIQUE (First_Name, Last_Name);

IF OBJECT_ID('dbo.Person','U') IS NOT NULL
DROP TABLE dbo.Person;
CREATE TABLE dbo.Person (
PersonID INT IDENTITY NOT NULL,
BusinessEntityId INT NOT NULL,
First_Name VARCHAR(50) NULL,
Last_Name VARCHAR(50) NULL,
CONSTRAINT PK_Person PRIMARY KEY CLUSTERED (PersonID),
CONSTRAINT FK_Person FOREIGN KEY (BusinessEntityId)
REFERENCES Person.BusinessEntity (BusinessEntityID),
CONSTRAINT UK_Person_Name UNIQUE (First_Name, Last_Name) );

/*Constraints place limitations on the data that can be entered into a column or columns. A constraint
on a single column can be created as either a table constraint or a column constraint; constraints being
implemented on more than one column must be created as table constraints.
A column constraint is specified in the CREATE TABLE statement as part of the definition of the column.
A column constraint applies to only the single column. In comparison, a table constraint is specified in the
CREATE TABLE statement after the comma separating the columns. Although not required, table constraints
are generally placed after all column definitions. In the previous example, the constraints are created as
table constraints. The same table, with column constraints used for the single-column constraints, is shown
here:*/

IF OBJECT_ID('dbo.Person','U') IS NOT NULL
DROP TABLE dbo.Person;
CREATE TABLE dbo.Person (
PersonID INT IDENTITY NOT NULL
CONSTRAINT PK_Person PRIMARY KEY CLUSTERED (PersonID),
BusinessEntityId INT NOT NULL
CONSTRAINT FK_Person FOREIGN KEY (BusinessEntityId)
REFERENCES Person.BusinessEntity (BusinessEntityID),
First_Name VARCHAR(50) NULL,
Last_Name VARCHAR(50) NULL,
CONSTRAINT UK_Person_Name UNIQUE (First_Name, Last_Name) );  ---------LOOK AT TWO COLUMNS BOTH HAVE SINGLE UNIQUE CONSTRAINT

--13-11. Creating a Recursive Foreign Key
/*You need to ensure that the values in a column exist in a different column in the same table. For example,
an employee table might contain a column for employee_id and another column for manager_id. The data
in manager_id column must exist in the employee_id column.*/

CREATE TABLE dbo.Employees (
employee_id INT IDENTITY PRIMARY KEY CLUSTERED,
manager_id INT NULL REFERENCES dbo.Employees (employee_id));

--ome people will call a recursive foreign key a self-referencing foreign key. Use whichever you want;
--they mean the same thing.
--When creating a FOREIGN KEY column constraint, the keywords FOREIGN KEY are optional.

INSERT INTO dbo.Employees DEFAULT VALUES;
INSERT INTO dbo.Employees (manager_id) VALUES (1);
SELECT * FROM dbo.Employees;

INSERT INTO dbo.Employees (manager_id) VALUES (10);
--SQL Server will generate an error since there is no employee_id with a value of 10:

/*13-12. Allowing Data Modifications to Foreign
Key Columns in the Referenced Table to Be Reflected
in the Referencing Table*/

/*You need to change the value of a column on a table that is involved in a foreign key relationship as the
referenced table, and there are rows in the referencing table using this value.
Create the foreign key with cascading changes*/

IF OBJECT_ID('dbo.PersonPhone','U') IS NOT NULL DROP TABLE dbo.PersonPhone;
IF OBJECT_ID('dbo.PhoneNumberType','U') IS NOT NULL DROP TABLE dbo.PhoneNumberType;
IF OBJECT_ID('dbo.Person','U') IS NOT NULL DROP TABLE dbo.Person;

CREATE TABLE dbo.Person (
BusinessEntityId INT PRIMARY KEY,
FirstName VARCHAR(25),
LastName VARCHAR(25));

CREATE TABLE dbo.PhoneNumberType (
PhoneNumberTypeId INT PRIMARY KEY,
Name VARCHAR(25));

INSERT INTO dbo.PhoneNumberType
SELECT PhoneNumberTypeId, Name
FROM Person.PhoneNumberType;

INSERT INTO dbo.Person
SELECT BusinessEntityId, FirstName, LastName
FROM Person.Person
WHERE BusinessEntityID IN (1,2);

SELECT * FROM dbo.PhoneNumberType
SELECT * FROM dbo.Person

CREATE TABLE dbo.PersonPhone (
[BusinessEntityID] [int] NOT NULL,
[PhoneNumber] [dbo].[Phone] NOT NULL,
[PhoneNumberTypeID] [int] NULL,
[ModifiedDate] [datetime] NOT NULL,
CONSTRAINT [UQ_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID]
UNIQUE CLUSTERED
([BusinessEntityID], [PhoneNumber], [PhoneNumberTypeID]),
CONSTRAINT [FK_PersonPhone_Person_BusinessEntityID]
FOREIGN KEY ([BusinessEntityID])
REFERENCES [dbo].[Person] ([BusinessEntityID])
ON DELETE CASCADE,
CONSTRAINT [FK_PersonPhone_PhoneNumberType_PhoneNumberTypeID]
FOREIGN KEY ([PhoneNumberTypeID])
REFERENCES [dbo].[PhoneNumberType] ([PhoneNumberTypeID])
ON UPDATE SET NULL
);

INSERT INTO dbo.PersonPhone (BusinessEntityId, PhoneNumber, PhoneNumberTypeId, ModifiedDate)
VALUES (1, '757-867-5309', 1, '2012-03-22T00:00:00'),
(2, '804-867-5309', 2, '2012-03-22T00:00:00');

SELECT 'Initial Data', * FROM dbo.PersonPhone;

DELETE FROM dbo.Person
WHERE BusinessEntityID = 1;

UPDATE dbo.PhoneNumberType
SET PhoneNumberTypeID = 4
WHERE PhoneNumberTypeID = 2;

SELECT 'Final Data', * FROM dbo.PersonPhone;

/*
BusinessEntityID PhoneNumber PhoneNumberTypeID ModifiedDate
------------ ---------------- ------------ ----------------- -----------------------
Initial Data 1 757-867-5309 1 2012-03-22 00:00:00.000
Initial Data 2 804-867-5309 2 2012-03-22 00:00:00.000
BusinessEntityID PhoneNumber PhoneNumberTypeID ModifiedDate
------------ ---------------- ------------ ----------------- -----------------------
Final Data 2 804-867-5309 NULL 2012-03-22 00:00:00.000
*/

--13-13. Specifying Default Values for a Column
--Create a DEFAULT constraint:

IF OBJECT_ID('dbo.Employees', 'U') IS NOT NULL
DROP TABLE dbo.Employees;
CREATE TABLE dbo.Employees (
EmployeeId INT PRIMARY KEY CLUSTERED,
First_Name VARCHAR(50) NOT NULL,
Last_Name VARCHAR(50) NOT NULL,
InsertedDate DATETIME DEFAULT GETDATE());

INSERT INTO dbo.Employees (EmployeeId, First_Name, Last_Name)
VALUES (1, 'Wayne', 'Sheffield');
INSERT INTO dbo.Employees (EmployeeId, First_Name, Last_Name, InsertedDate)
VALUES (2, 'Jim', 'Smith', NULL);
SELECT * FROM dbo.Employees;

--13-14. Validating Data as It Is Entered into a Column

--Create a CHECK constraint:

CREATE TABLE dbo.BooksRead (
ISBN VARCHAR(20),
StartDate DATETIME NOT NULL,
EndDate DATETIME NULL,
CONSTRAINT CK_BooksRead_EndDate CHECK (EndDate > StartDate));

INSERT INTO BooksRead (ISBN, StartDate, EndDate)
VALUES ('9781430242000', '2012-08-01T16:25:00', '2011-08-15T12:35:00 ');
---The INSERT statement conflicted with the CHECK constraint

CHECK ( logical_expression )

IF OBJECT_ID('dbo.Employees','U') IS NOT NULL
DROP TABLE dbo.Employees;
CREATE TABLE dbo.Employees (
EmployeeId INT IDENTITY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
PhoneNumber VARCHAR(12) CONSTRAINT CK_Employees_PhoneNumber
CHECK (PhoneNumber LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'));

INSERT INTO dbo.Employees (FirstName, LastName, PhoneNumber)
VALUES ('Wayne', 'Sheffield', '800-555-1212');
INSERT INTO dbo.Employees (FirstName, LastName, PhoneNumber)
VALUES ('Wayne', 'Sheffield', '555-1212');

--The INSERT statement conflicted with the CHECK constraint
SELECT * FROM dbo.Employees

DELETE FROM dbo.Employees
WHERE (PhoneNumber NOT LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]');

--13-15. Temporarily Turning Off a Constraint

--You need to temporarily turn off a constraint on a table. For instance, you are performing a bulk-load process
--where you don’t need to verify that each row meets the constraint requirements.

--Utilize the ALTER TABLE statement to disable a constraint:
ALTER TABLE dbo.Employees
NOCHECK CONSTRAINT CK_Employees_PhoneNumber;

ALTER TABLE dbo.Employees
NOCHECK CONSTRAINT ALL;

ALTER TABLE dbo.Employees
CHECK CONSTRAINT CK_Employees_PhoneNumber;

ALTER TABLE dbo.Employees
WITH CHECK CHECK CONSTRAINT ALL;

/*In this case, the record inserted from the second insert statement in Recipe 13-14 causes the check to
fail. This record needs to be updated to pass the constraint, or it needs to be deleted.*/

--13-16. Removing a Constraint
ALTER TABLE dbo.BooksRead
DROP CONSTRAINT CK_BooksRead_EndDate;

--13-17. Creating Auto-incrementing Columns

IF OBJECT_ID('dbo.Employees','U') IS NOT NULL
DROP TABLE dbo.Employees;
CREATE TABLE dbo.Employees (
employee_id INT IDENTITY PRIMARY KEY CLUSTERED,         ---------------IDENTITY AUTO INCREMENTING EMPLOYEE_ID
manager_id INT NULL REFERENCES dbo.Employees (employee_id),   
First_Name VARCHAR(50) NULL,
Last_Name VARCHAR(50) NULL,
CONSTRAINT UQ_Employees_Name UNIQUE (First_Name, Last_Name));

INSERT INTO dbo.Employees (manager_id, First_Name, Last_Name)
VALUES (NULL, 'Wayne', 'Sheffield')
BEGIN TRANSACTION
INSERT INTO dbo.Employees (manager_id, First_Name, Last_Name)
VALUES (1, 'Jim', 'Smith');
ROLLBACK TRANSACTION;
INSERT INTO dbo.Employees (manager_id, First_Name, Last_Name)
VALUES (1, 'Jane', 'Smith');

SELECT * FROM dbo.Employees

SELECT IDENTITYCOL, employee_id, Last_Name
FROM dbo.Employees
ORDER BY IDENTITYCOL;

--13-18. Obtaining the Identity Value Used
SELECT @@IDENTITY, SCOPE_IDENTITY(), IDENT_CURRENT('dbo.Employees');

--The @@IDENTITY, SCOPE_IDENTIY, and IDENT_CURRENT system functions return the last identity value
--generated by the INSERT, SELECT INTO, or bulk copy statement.

--13-19. Viewing or Changing the Seed Settings on an Identity Column

TRUNCATE TABLE dbo.Employees; ----------EMPTY TABLE
--he TRUNCATE TABLE statement, in addition to deleting all of the data in that table, also resets the
--identity seed to the initial setting, which in this case is 0.
INSERT INTO dbo.Employees (manager_id, First_Name, Last_Name)
VALUES (NULL, 'Wayne', 'Sheffield');
BEGIN TRANSACTION;
INSERT INTO dbo.Employees (manager_id, First_Name, Last_Name)
VALUES (1, 'Jim', 'Smith');
ROLLBACK TRANSACTION;
DBCC CHECKIDENT ('dbo.Employees', RESEED, 1);
INSERT INTO dbo.Employees (manager_id, First_Name, Last_Name)
VALUES (1, 'Jane', 'Smith');

SELECT * FROM dbo.Employees
DBCC CHECKIDENT ('dbo.Employees');

--13-20. Inserting Values into an Identity Column
SET IDENTITY_INSERT dbo.Employees ON;
INSERT INTO dbo.Employees (employee_id, manager_id, First_Name, Last_Name)
VALUES (5, 1, 'Joe', 'Smith');
SET IDENTITY_INSERT dbo.Employees OFF;

--13-21. Automatically Inserting Unique Values
CREATE TABLE HumanResources.BuildingAccess(
BuildingEntryExitID uniqueidentifier ROWGUIDCOL
CONSTRAINT DF_BuildingAccess_BuildingEntryExitID DEFAULT NEWID()
CONSTRAINT UK_BuildingAccess_BuildingEntryExitID UNIQUE,
EmployeeID int NOT NULL,
AccessTime datetime NOT NULL,
DoorID int NOT NULL);

INSERT HumanResources.BuildingAccess (EmployeeID, AccessTime, DoorID)
VALUES (32, GETDATE(), 2);
SELECT *
FROM HumanResources.BuildingAccess;
SELECT $ROWGUID
FROM HumanResources.BuildingAccess;

/*The UNIQUEIDENTIFIER data type is a 16-bit globally unique identifier (GUID) and is represented as
a 32-character hexadecimal string. The total number of unique keys is 2122. Since this number is so large, the
chances of randomly generating the same value twice are negligible. (Microsoft claims that it will be unique
for every database networked in the world.)
Just like an IDENTITY column, a column with the UNIQUEIDENTIFIER data type does not guarantee
uniqueness; a PRIMARY KEY or UNIQUE constraint must be used to guarantee the uniqueness of the values
in the column. Keep in mind that the UNIQUEIDENTIFIER data type does not generate new GUID values;
it simply stores the generated values. The UNIQUE constraint is necessary where you need to ensure that the
same generated value cannot be inserted into the table twice.
The ROWGUIDCOL indicates that the column is a row GUID column. There can be just one column per
table designated as a ROWGUIDCOL. Using ROWGUIDCOL allows one to use the $ROWGUID synonym for the column
designated as the ROWGUIDCOL.
To automatically insert values into the UNIQUEIDENTIFIER data-typed column, you need to use a
default constraint with either the NEWID or NEWSEQUENTIALID system function. NEWID generates a random
GUID; NEWSEQUENTIALID generates a GUID that is greater than any GUID previously generated by this
function on this computer since Windows was started. Since NEWSEQUENTIALID generates an increasing
value, its use can minimize page splits and fragmentation.
To show how this all works, the following statements insert one row into the previous table and then
select that row:*/

--13-22. Using Unique Identifiers Across Multiple Tables
--You need to have a unique identifier across multiple tables that is sequentially incremented.
CREATE SEQUENCE dbo.MySequence
AS INTEGER
START WITH 1
INCREMENT BY 1;
GO

CREATE TABLE dbo.Table1 (
Table1ID INTEGER NOT NULL,
Table1Data VARCHAR(50));

CREATE TABLE dbo.Table2 (
Table2ID INTEGER NOT NULL,
Table2Data VARCHAR(50));

INSERT INTO dbo.Table1 (Table1ID, Table1Data)
VALUES (NEXT VALUE FOR dbo.MySequence, 'Ferrari'),
(NEXT VALUE FOR dbo.MySequence, 'Lamborghini');

INSERT INTO dbo.Table2 (Table2ID, Table2Data)
VALUES (NEXT VALUE FOR dbo.MySequence, 'Apple'),
(NEXT VALUE FOR dbo.MySequence, 'Orange');

SELECT * FROM dbo.Table1;
SELECT * FROM dbo.Table2;

--13-23. Using Temporary Storage
--You need to temporarily store interim query results for further processing.
--Utilize a temporary table.
CREATE TABLE #temp (
Column1 INT,
Column2 INT);

--Utilize a table variable.
DECLARE @temp TABLE (
Column1 INT,
Column2 INT);

--Managing Views























