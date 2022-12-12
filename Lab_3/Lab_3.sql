USE supermarket
GO

-- part 2

-- 1

SELECT *
FROM positions 
WHERE positions.sum = 100

SELECT *
FROM positions 
WHERE positions.sum > 100

SELECT *
FROM positions 
WHERE positions.sum <= 100

-- 2

SELECT *
FROM products
WHERE storageConditions = 'Yes' AND country = 'Russia'

SELECT *
FROM products
WHERE storageConditions = 'Yes' OR country = 'Uzbekistan'

SELECT *
FROM products
WHERE name = 'Sugar' AND country = 'Russia'

-- 3

SELECT * 
FROM supplyProducts
WHERE count BETWEEN 10 AND 1000 OR productid = 4

SELECT * 
FROM supplyProducts
WHERE productid = 3 AND count BETWEEN 10 AND 1000

-- 4

SELECT id, (count * price) AS 'cost'
FROM supplyProducts

SELECT *
FROM supplyProducts
WHERE (count * price) > 250

-- 5

SELECT *
FROM employees
WHERE experience IN (2, 3)

SELECT *
FROM employees
WHERE departmentid IN (1, 2, 3, 4)

-- 6

SELECT * 
FROM supplyProducts
WHERE date BETWEEN '2020-01-01' AND '2023-01-01'

SELECT *
FROM employees
WHERE departmentid BETWEEN 1 AND 4

-- 7

SELECT * 
FROM employees
WHERE name LIKE 'A%'

SELECT * 
FROM employees
WHERE name LIKE '[A-M]%'

-- 8

SELECT * 
FROM employees
WHERE name IS NULL

SELECT * 
FROM employees
WHERE name IS NOT NULL

-- part 3

-- 1

SELECT *
FROM  employees 
CROSS JOIN departments

SELECT * 
FROM employees 
CROSS JOIN positions

-- 2

SELECT *
FROM  employees 
JOIN departments ON employees.departmentid = departments.id

SELECT *
FROM  employees 
JOIN positions ON employees.positionid = positions.id

SELECT *
FROM  supplyProducts 
JOIN products ON supplyProducts.productid = products.id

-- 3

SELECT *
FROM  employees 
JOIN departments ON employees.departmentid = departments.id
WHERE experience > 2

SELECT *
FROM  employees 
JOIN positions ON employees.positionid = positions.id
WHERE sum = 100

-- 4

SELECT*
FROM  employees 
JOIN departments ON employees.departmentid = departments.id
JOIN positions ON employees.positionid = positions.id

SELECT *
FROM  supplyProducts 
JOIN products ON supplyProducts.productid = products.id
JOIN employees ON supplyProducts.employeeid = employees.id

-- 4

SELECT *
FROM  employees 
FULL JOIN departments ON employees.departmentid = departments.id

SELECT *
FROM  employees 
FULL JOIN positions ON employees.positionid = positions.id

SELECT *
FROM  supplyProducts 
FULL JOIN products ON supplyProducts.productid = products.id

-- 5

SELECT *
FROM  employees 
LEFT JOIN departments ON employees.departmentid = departments.id

SELECT *
FROM  employees 
LEFT JOIN positions ON employees.positionid = positions.id

-- 6

SELECT *
FROM  employees 
RIGHT JOIN departments ON employees.departmentid = departments.id

SELECT *
FROM  employees 
RIGHT JOIN positions ON employees.positionid = positions.id

-- part 4

-- 1

SELECT COUNT(*)
FROM employees

SELECT COUNT(*)
FROM  employees 
JOIN positions ON employees.positionid = positions.id
WHERE sum = 100

-- 2

SELECT UPPER (name)
FROM employees

SELECT LOWER (name)
FROM employees

-- 3

SELECT YEAR(endDate)
FROM products

SELECT DAY(endDate)
FROM products

-- 4

-- 5

-- 6

SELECT * 
FROM employees
ORDER BY name

SELECT * 
FROM positions
ORDER BY name

-- 7

INSERT INTO positions (name, sum)
VALUES ('qwe', 123)

INSERT INTO departments (name, countOfBars, numberOfRoom)
VALUES ('qwe', 1, 1)

-- 8

UPDATE positions
SET name = 'asd'
WHERE name LIKE 'qwe'

UPDATE departments
SET name = 'asd'
WHERE name LIKE 'qwe'

-- 9

DELETE FROM positions
WHERE name = 'asd'

DELETE FROM departments
WHERE name = 'asd'