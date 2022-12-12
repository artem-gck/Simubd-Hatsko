USE supermarket
GO

-- part 1

-- 1

DECLARE @mytable TABLE (
	id		INT, 
	name	NVARCHAR(MAX) DEFAULT 'Temporary table name'
)

INSERT INTO @mytable(id) 
VALUES (1)

INSERT INTO @mytable(id, name) 
VALUES (2, 'name') 

SELECT * 
FROM @mytable
GO

-- 2

DECLARE @a		INT 
DECLARE @str	NVARCHAR(MAX)

SET @a = (SELECT COUNT(*) 
	      FROM departments)

IF @a > 5 
BEGIN
	SET @str = 'Count of lines less then 5' 
	PRINT @str
END 
ELSE 
BEGIN
	SET @str = 'Count of lines = ' + str(@a) 
	PRINT @str
END
GO

DECLARE @b INT 
DECLARE @string NVARCHAR(MAX)

SET @b = (SELECT COUNT(*) 
		  FROM employees) 

IF @b < 1 BEGIN
	SET @string = 'Zero emloyees in database'
	PRINT @string
END ELSE BEGIN
	SET @string = 'Count of emloyees =' + str(@b)
	PRINT @string
END
GO

-- 3

DECLARE @n INT 

SET @n = 1 

WHILE @n <100
BEGIN
	PRINT @n
IF (@n > 40) AND (@n < 50)
	BREAK
ELSE
	SET @n = @n + rand() * 10 
	CONTINUE
END
PRINT @n
GO


DECLARE @number INT 
DECLARE @factorial INT

SET @factorial = 1;
SET @number = 10;

WHILE @number > 0
BEGIN
    SET @factorial = @factorial * @number
    SET @number = @number - 1
END
PRINT @factorial
GO

-- 4

CREATE FUNCTION GetSumm (@productId INT)
RETURNS INT
BEGIN
	DECLARE @Summ INT
	
	SELECT @Summ = count * price
	FROM supplyProducts

	RETURN @Summ
END
GO

-- 5

CREATE FUNCTION [dbo].[test_tabl] ( @id INT)
RETURNS TABLE
AS
	RETURN ( SELECT * FROM products WHERE name = 'Milk')
GO

SELECT * FROM dbo.test_tabl (1)
GO

-- 6

CREATE PROCEDURE count_employees 
AS
	SELECT COUNT(*) FROM employees
GO

EXEC count_employees
GO

CREATE PROCEDURE count_positions AS
	SELECT COUNT(*) FROM positions
GO

EXEC count_positions
GO

-- 7

CREATE PROCEDURE count_products_by_price 
	@price INT 
AS
BEGIN
	SELECT count(*) 
	FROM supplyProducts
	WHERE price <= @price 
END
GO

EXEC count_products_by_price 80
GO

CREATE PROCEDURE count_by_sallary 
	@sallary INT
AS
	SELECT COUNT(*) 
	FROM positions 
	WHERE sum <= @sallary
GO

EXEC count_by_sallary 100
GO

-- 8

CREATE PROCEDURE checkname 
	@param NVARCHAR(MAX)
AS
	IF (SELECT sex 
		FROM employees 
		WHERE name = @param) = 'male'
		RETURN 1
	ELSE
		RETURN -1

DECLARE @return INT

EXEC @return = checkname 'Artem'

SELECT 'Return Status' = @return
GO


CREATE PROCEDURE checknametour 
	@param INT
AS
	IF (SELECT name
		FROM employees
		WHERE yearOfBirth = @param) = 'Artem'
		
		RETURN 1
	ELSE
		RETURN 2

DECLARE @return_status INT

EXEC @return_status = checkname 1

SELECT 'Return Status' = @return_status
GO

-- 9

CREATE PROC update_proc 
AS
	UPDATE positions 
	SET sum = sum + 50
GO

CREATE PROC update_products_name_plus
AS
	UPDATE products 
	SET name = name + '+'
GO

-- 10

CREATE PROCEDURE departments_select
AS
	SELECT * 
	FROM departments 
GO

CREATE PROCEDURE positions_select
AS
	SELECT * 
	FROM positions 
GO

-- part 2

-- 1

CREATE FUNCTION Calculator
	(@oprd_1 BIGINT,
	 @oprd_2 BIGINT,
	 @operator NVARCHAR(1)) 
	RETURNS BIGINT
BEGIN
	DECLARE @result BIGINT
	
	SET @result = 
		CASE @operator
			WHEN '+' THEN @oprd_1 + @oprd_2
			WHEN '-' THEN @oprd_1 - @oprd_2
			WHEN '*' THEN @oprd_1 * @oprd_2
			WHEN '/' THEN @oprd_1 / @oprd_2
			ELSE 0
END 
RETURN @result
END

SELECT [dbo].[Calculator](1, 2, '+') 
GO

-- 2	

CREATE FUNCTION DYNTAB 
	(@state NVARCHAR(MAX))
	RETURNS TABLE 
AS
RETURN 
	SELECT * 
	FROM employees 
	WHERE sex = @state
GO

SELECT * FROM DYNTAB('male')
GO

-- 3

CREATE FUNCTION parse_string 
	(@input_string nvarchar(500))
	RETURNS @tabl TABLE (
							Number INT IDENTITY(1,1) NOT NULL,
							Substr NVARCHAR(MAX)
					    ) 
AS
BEGIN
	DECLARE @string NVARCHAR(MAX)
	DECLARE @pos INT 

	WHILE CHARINDEX(' ', @input_string) > 0
	BEGIN
		SET @pos  = CHARINDEX(' ', @input_string)  
		SET @string = SUBSTRING(@input_string, 1, @pos - 1)

		INSERT INTO @tabl 
		VALUES(@string)

		SET @input_string = SUBSTRING(@input_string, @pos+1, LEN(@input_string) - @pos)
	END
	
	INSERT INTO @tabl VALUES(@input_string)
	RETURN 
END
GO

SELECT * 
FROM dbo.parse_string('Hello my name is Artem')
GO

-- 8

CREATE PROCEDURE Calculator_out
	(@oprd_1 BIGINT,
	 @oprd_2 BIGINT,
	 @operator NVARCHAR(1),
	 @result BIGINT OUTPUT) 
AS
BEGIN

	SET @result = 
		CASE @operator
			WHEN '+' THEN @oprd_1 + @oprd_2
			WHEN '-' THEN @oprd_1 - @oprd_2
			WHEN '*' THEN @oprd_1 * @oprd_2
			WHEN '/' THEN @oprd_1 / @oprd_2
			ELSE 0
	END 
END
GO