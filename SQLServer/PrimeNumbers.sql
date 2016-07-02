DECLARE @maxPrime INT = 1000
DECLARE @prime INT = 1
DECLARE @isPrime BIT
DECLARE @divisor INT
DECLARE @primeTable TABLE(PrimeNumber INT)
WHILE @prime <= @maxPrime
BEGIN
	SET @isPrime = 1
	SET @divisor = 2
	WHILE @divisor < @prime AND @isPrime != 0
	BEGIN
		SET @isPrime = @prime % @divisor
		SET @divisor = @divisor + 1
	END
	IF @isPrime != 0
	BEGIN
		INSERT INTO @primeTable VALUES(@prime)
	END
	SET @prime = @prime + 1
END
SELECT PrimeNumber FROM @primeTable