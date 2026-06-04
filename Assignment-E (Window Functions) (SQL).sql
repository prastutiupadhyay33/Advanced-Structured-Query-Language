create database Sales;
use Sales;
create table Sales (
    sale_id INT,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    sale_amount INT,
    sale_date DATE
);
INSERT INTO Sales VALUES
(1, 'Aman', 'IT', 5000, '2025-01-01'),
(2, 'Aman', 'IT', 7000, '2025-01-03'),
(3, 'Riya', 'HR', 4000, '2025-01-02'),
(4, 'Riya', 'HR', 6000, '2025-01-05'),
(5, 'Karan', 'Finance', 8000, '2025-01-04'),
(6, 'Karan', 'Finance', 9000, '2025-01-06');

#1 Total sales per employee (Running Total).

SELECT employee_name, sale_date, sale_amount,
SUM(sale_amount) OVER(
    PARTITION BY employee_name
    ORDER BY sale_date
) AS running_total
FROM Sales;

#2 Row number per employee.

SELECT employee_name, sale_amount,
ROW_NUMBER() OVER(
    PARTITION BY employee_name
    ORDER BY sale_amount DESC
) AS row_num
FROM Sales;

#3 Rank of sales per department.

SELECT department, employee_name, sale_amount,
RANK() OVER(
    PARTITION BY department
    ORDER BY sale_amount DESC
) AS rank_no
FROM Sales;

#3 Lead (next sale) per employee.

SELECT employee_name, sale_date, sale_amount,
LEAD(sale_amount) OVER(
    PARTITION BY employee_name
    ORDER BY sale_date
) AS next_sale
FROM Sales;

#4 Lag (previous sale) per employee.

SELECT employee_name, sale_date, sale_amount,
LAG(sale_amount) OVER(
    PARTITION BY employee_name
    ORDER BY sale_date
) AS previous_sale
FROM Sales;

#5 Average sales per employee.

SELECT employee_name, sale_amount,
AVG(sale_amount) OVER(
    PARTITION BY employee_name
) AS avg_sale
FROM Sales;

#6 First and last sales per employee.
SELECT employee_name, sale_date, sale_amount,
FIRST_VALUE(sale_amount) OVER(
    PARTITION BY employee_name
    ORDER BY sale_date
) AS first_sale,
LAST_VALUE(sale_amount) OVER(
    PARTITION BY employee_name
    ORDER BY sale_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
) AS last_sale
FROM Sales;

#7 Dense rank (no gaps).
SELECT department, employee_name, sale_amount,
DENSE_RANK() OVER(
    PARTITION BY department
    ORDER BY sale_amount DESC
) AS dense_rank_no
FROM Sales;

#8 Cumulative average per employee.

SELECT employee_name, sale_date, sale_amount,
AVG(sale_amount) OVER(
    PARTITION BY employee_name
    ORDER BY sale_date
) AS cumulative_avg
FROM Sales;

#9 Find highest sale per employee.

SELECT employee_name, sale_amount
FROM (
    SELECT employee_name, sale_amount,
    RANK() OVER(
        PARTITION BY employee_name
        ORDER BY sale_amount DESC
    ) AS rnk
    FROM Sales
) x
WHERE rnk = 1;

#10 Sales difference from previous record.

SELECT employee_name, sale_date, sale_amount,
sale_amount - LAG(sale_amount) OVER(
    PARTITION BY employee_name
    ORDER BY sale_date
) AS difference
FROM Sales;

#11 Cumulative count of sales per employee.

SELECT employee_name, sale_date,
COUNT(*) OVER(
    PARTITION BY employee_name
    ORDER BY sale_date
) AS cumulative_count
FROM Sales;

#12 Show if sale is above average per employee.
    
SELECT employee_name, sale_amount,
AVG(sale_amount) OVER(
    PARTITION BY employee_name
) AS avg_sale,
CASE
    WHEN sale_amount >
         AVG(sale_amount) OVER(PARTITION BY employee_name)
    THEN 'Above Average'
    ELSE 'Below Average'
END AS status
FROM Sales;

#13 Find second highest sale per employee.

SELECT employee_name, sale_amount
FROM (
    SELECT employee_name, sale_amount,
    DENSE_RANK() OVER(
        PARTITION BY employee_name
        ORDER BY sale_amount DESC
    ) AS rnk
    FROM Sales
) x
WHERE rnk = 2;

