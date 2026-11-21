-- =====================================================================
-- Staff Demo — Step 4: using SQL (Session 2 live demo)
-- Slides: SELECT, WHERE / ORDER BY / LIMIT, INSERT / UPDATE / DELETE,
--         aggregates & GROUP BY, INNER JOIN
-- =====================================================================
USE staff_demo;

-- ---- SELECT -------------------------------------------------------
-- Just reading data back -- neither line changes anything in the table.
SELECT * FROM employee;                          -- every column, every row
SELECT full_name, hourly_rate FROM employee;     -- only the columns you ask for

-- ---- WHERE, ORDER BY, LIMIT ---------------------------------------
-- WHERE filters which rows come back -- only employees at branch_id 1.
SELECT * FROM employee WHERE branch_id = 1;

-- Combine all three: filter first (WHERE), then sort the survivors
-- (ORDER BY ... DESC = highest first), then only keep the top 5 (LIMIT).
SELECT * FROM employee
WHERE hourly_rate > 20
ORDER BY hourly_rate DESC
LIMIT 5;

-- ---- INSERT, then UPDATE, then DELETE -----------------------------
-- Add one brand-new employee row. branch_id must already exist in branch,
-- or this fails with the same FK error you just saw (1452).
INSERT INTO employee (full_name, email, branch_id, hourly_rate)
VALUES ('Nami Swan', 'nami@example.com', 1, 18.50);

-- Give the new hire a raise (always use WHERE!)
-- Without WHERE, UPDATE would overwrite hourly_rate for EVERY employee --
-- WHERE narrows it down to just the one row matching this email.
UPDATE employee SET hourly_rate = 19.25 WHERE email = 'nami@example.com';
-- Read the row back to confirm the raise actually took (19.25, not 18.50).
SELECT * FROM employee WHERE email = 'nami@example.com';

-- Remove the test row again (always use WHERE!)
-- Same warning as UPDATE -- no WHERE here would delete every employee.
DELETE FROM employee WHERE email = 'nami@example.com';

-- ---- Aggregates & GROUP BY ----------------------------------------
-- Aggregate functions compute one summary value across many rows --
-- a count, average, min, and max, all in a single query.
SELECT COUNT(*)          AS total_staff,
       AVG(hourly_rate)  AS avg_rate,
       MIN(hourly_rate)  AS lowest_rate,
       MAX(hourly_rate)  AS highest_rate
FROM employee;

-- GROUP BY buckets rows by branch_id first, then COUNT(*) runs separately
-- within each bucket -- one row of output per distinct branch_id.
SELECT branch_id, COUNT(*) AS staff_count
FROM employee
GROUP BY branch_id;

-- ---- INNER JOIN ---------------------------------------------------
-- Lines up matching rows from employee and branch using the FK
-- relationship (employee.branch_id = branch.branch_id), so you get an
-- employee's name next to their branch's actual name, not just its id.
SELECT employee.full_name, branch.name AS branch_name
FROM employee
         INNER JOIN branch
                    ON employee.branch_id = branch.branch_id;

-- JOIN + GROUP BY together: staff count per branch, by name
-- Same join as above, but then grouped and counted -- answers "how many
-- employees work at each branch," using the branch's real name instead
-- of its raw branch_id.
SELECT branch.name AS branch_name, COUNT(*) AS staff_count
FROM employee
         INNER JOIN branch ON employee.branch_id = branch.branch_id
GROUP BY branch.name
ORDER BY staff_count DESC;