CREATE DATABASE supermarket
GO

USE supermarket
GO

CREATE TABLE departments
(
	id int IDENTITY(1,1) NOT NULL,
	[name] NVARCHAR(MAX) NOT NULL,
	countOfBars INT NOT NULL,
	numberOfRoom INT NOT NULL,
)
GO

CREATE TABLE positions
(
	id INT IDENTITY(1,1) NOT NULL,
	name NVARCHAR(MAX) NOT NULL,
	[sum] INT NOT NULL,
)
GO

CREATE TABLE employees
(
	id INT IDENTITY(1,1) NOT NULL,
	surname NVARCHAR(MAX) NOT NULL,
	[name] NVARCHAR(MAX) NOT NULL,
	lastName NVARCHAR(MAX) NOT NULL,
	departmentid INT NOT NULL,
	yearOfBirth INT NOT NULL,
	startYearWork INT NOT NULL,
	experience INT NOT NULL,
	positionid INT NOT NULL,
	sex NVARCHAR(MAX) NOT NULL,
	[address] NVARCHAR(MAX) NOT NULL,
	city NVARCHAR(MAX) NOT NULL,
	mobilePhone NVARCHAR(MAX) NOT NULL,
)
GO

ALTER TABLE employees  WITH CHECK ADD  CONSTRAINT FK_employees_departments_departmentid FOREIGN KEY(departmentid)
REFERENCES departments (id)
ON DELETE CASCADE
GO

ALTER TABLE employees  WITH CHECK ADD  CONSTRAINT FK_employees_positions_positionid FOREIGN KEY(positionid)
REFERENCES positions (id)
ON DELETE CASCADE
GO

CREATE TABLE products
(
	id INT IDENTITY(1,1) NOT NULL,
	[name] NVARCHAR(MAX) NOT NULL,
	departmentid INT NOT NULL,
	country NVARCHAR(MAX) NOT NULL,
	storageConditions NVARCHAR(MAX) NOT NULL,
	endDate DATETIME2(7) NOT NULL,
)
GO

ALTER TABLE products  WITH CHECK ADD  CONSTRAINT FK_products_departments_departmentid FOREIGN KEY(departmentid)
REFERENCES departments (id)
ON DELETE CASCADE
GO

CREATE TABLE supplyProducts
(
	id INT IDENTITY(1,1) NOT NULL,
	employeeid INT NOT NULL,
	productid INT NOT NULL,
	[date] DATETIME2(7) NOT NULL,
	[count] INT NOT NULL,
	price INT NOT NULL,
)
GO

ALTER TABLE supplyProducts  WITH CHECK ADD  CONSTRAINT FK_supplyProducts_employees_employeeid FOREIGN KEY(employeeid)
REFERENCES employees (id)
GO

ALTER TABLE supplyProducts  WITH CHECK ADD  CONSTRAINT FK_supplyProducts_products_productid FOREIGN KEY(productid)
REFERENCES products (id)
GO

EXEC sp_addrole 'manager'
GO

EXEC sp_addrole 'clientist'
GO

GRANT DELETE, INSERT, UPDATE, SELECT ON departments TO manager 
GRANT DELETE, INSERT, UPDATE, SELECT ON employees TO manager 
GRANT DELETE, INSERT, UPDATE, SELECT ON positions TO manager 
GRANT DELETE, INSERT, UPDATE, SELECT ON products TO manager 
GRANT DELETE, INSERT, UPDATE, SELECT ON supplyProducts TO manager 
GRANT EXECUTE TO manager
GO

GRANT SELECT ON products TO clientist 
GRANT EXECUTE TO clientist
GO

EXEC sp_addrolemember 'manager', 'director'
GO

EXEC sp_addrolemember 'clientist', 'client'
GO

SELECT *
FROM region
WHERE city != 'ыва' OR city != 'qwe'