-----------------------------User Views----------------------------
/*Uses NORTHWIND database*/

--Exercise Userview 1
CREATE VIEW Customer1998 AS
SELECT c.CustomerID, c.ContactName, o.OrderDate, p.ProductID, p.ProductName
FROM Customers c, Orders o, [Order Details] d, Products p
WHERE c.CustomerID = o.CustomerID
AND o.OrderDate LIKE '%1998%'
AND o.OrderID = d.OrderID
AND d.ProductID = p.ProductID



--Exercise Userview 2
--Here, we now retrieve our userview list but doing so by linking with the supplier's table
--cos we need to add the supplier's names for each of our item in our userview.
SELECT c.ContactName, c.ProductName, s.CompanyName
FROM Customer1998 c, Products p, Suppliers s
WHERE c.ProductID = p.ProductID
AND p.SupplierID = s.SupplierID
AND c.OrderDate LIKE '%1998%'   --This is just to ensure that its only in 1998
ORDER BY c.ContactName



--Exercise Userview 3
--Here we simply retrieve each customer and the number of products they each ordered in 1998
SELECT ContactName, Count(*) AS NoProductsOrdered
FROM Customer1998
WHERE OrderDate LIKE '%1998%'
GROUP BY ContactName

      --[To aid with Exercise1 to 3]--
SELECT * FROM Customer1998 Order BY CustomerID
DROP VIEW Customer1998



--Exercise Userview 4a
--Here, we are creating another UserView to contain total business by each customer
--Note that each order can contain more than one product. But customer still only 89 total.
CREATE VIEW TotalBusiness AS
SELECT SUM(d.UnitPrice * d.Quantity) AS TotalOrder, o.CustomerID
FROM Orders o, [Order Details] d
WHERE o.OrderID = d.OrderID
GROUP BY o.CustomerID



--Exercise Userview 4b
--Finding the average of all total business generated by retrieving the diff columns from
--the prev created UserView and inputting them into the diff aggregate functions.
SELECT AVG(t.TotalOrder) / COUNT(t.CustomerID)
AS AverageBusiness
FROM TotalBusiness t


SELECT * FROM TotalBusiness ORDER BY CustomerID
DROP VIEW TotalBusiness























-----------------------------Stored Procedures----------------------------
/*Uses Dafesty database*/
--This command to change your database without changing using GUI at the top left side.
USE DafestyBaby   


--Exercise Stored Procedures 1  [Creating sp without arguments]
  --Create sp
CREATE PROCEDURE sp_memA AS
BEGIN 
	SELECT * FROM Customers
	WHERE MemberCategory = 'A'
END
  --Calling sp
EXEC sp_memA

  --To drop the sp
DROP PROCEDURE sp_memA



--Exercise Stored Procedures 2  [Creating sp without arguments]
  --Create sp
CREATE PROCEDURE sp_memA (@var1 CHAR(1))
AS 
	SELECT * FROM Customers
	WHERE MemberCategory = @var1

  --Calling sp
EXEC sp_memA 'A'   --Can
EXEC sp_memA 'B'   --Can
EXEC sp_memA 'Z'   --Cannot cos no one with MemberCategory 'Z'

  --To drop the sp
DROP PROCEDURE sp_memA








