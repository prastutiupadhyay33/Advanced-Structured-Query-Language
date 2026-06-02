create database fn;
use fn;
# Write a function to print “Hello, World!”.
CREATE FUNCTION fn_hello()
RETURNS VARCHAR(20)
DETERMINISTIC
RETURN 'Hello, World!';
# Write a function to add two numbers. 
CREATE FUNCTION fn_add(a INT, b INT)
RETURNS INT
DETERMINISTIC
RETURN a + b;
# Write a function to find the square of a number. 
CREATE FUNCTION fn_square(n INT)
RETURNS INT
DETERMINISTIC
RETURN n * n;
# Write a function to find the factorial of a number. 
DELIMITER //
CREATE FUNCTION fn_factorial(n INT)
RETURNS BIGINT
DETERMINISTIC
BEGIN
    DECLARE fact BIGINT DEFAULT 1;
    DECLARE i INT DEFAULT 1;
	WHILE i <= n DO
        SET fact = fact * i;
        SET i = i + 1;
    END WHILE;
    RETURN fact;
END //
DELIMITER ;
# Write a function to check if a number is even or odd. 
CREATE FUNCTION fn_even_odd(n INT)
RETURNS VARCHAR(10)
DETERMINISTIC
RETURN IF(n % 2 = 0, 'Even', 'Odd');
# Write a function to find the maximum of three numbers. 
CREATE FUNCTION fn_max_three(a INT, b INT, c INT)
RETURNS INT
DETERMINISTIC
RETURN GREATEST(a, b, c);
# Write a function to check whether a number is prime. 
DELIMITER //
CREATE FUNCTION fn_prime(n INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 2;
	IF n < 2 THEN
        RETURN 'Not Prime';
    END IF;
    WHILE i <= SQRT(n) DO
        IF n % i = 0 THEN
            RETURN 'Not Prime';
        END IF;
        SET i = i + 1;
    END WHILE;
    RETURN 'Prime';
END //
DELIMITER ;
# Write a function to calculate the sum of first n natural numbers. 
CREATE FUNCTION fn_sum_n(n INT)
RETURNS INT
DETERMINISTIC
RETURN (n * (n + 1)) / 2;
# Write a function to count vowels in a string.
DELIMITER //
CREATE FUNCTION fn_count_vowels(str VARCHAR(255))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE cnt INT DEFAULT 0;
    DECLARE ch CHAR(1);
    WHILE i <= LENGTH(str) DO
        SET ch = LOWER(SUBSTRING(str, i, 1));
        IF ch IN ('a','e','i','o','u') THEN
            SET cnt = cnt + 1;
        END IF;
        SET i = i + 1;
    END WHILE;
    RETURN cnt;
END //
DELIMITER ;
# Write a function to reverse a string.
CREATE FUNCTION fn_reverse_string(str VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
RETURN REVERSE(str);