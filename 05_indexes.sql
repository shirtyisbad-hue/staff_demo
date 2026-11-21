-- =====================================================================
-- Staff Demo — Step 5: indexes
-- Slides: "What is an index?", "CREATE INDEX, and seeing it work",
--         "Unique indexes vs. the primary key index"
-- =====================================================================
USE staff_demo;

-- Before: look at the "type" and "key" columns of the EXPLAIN output
EXPLAIN SELECT * FROM employee WHERE hire_date > '2024-01-01';
-- type = ALL  -> full table scan

CREATE INDEX idx_employee_hire_date ON employee (hire_date);

-- After: MySQL can now use the index (type = range, key = idx_employee_hire_date)
-- Note: with only 7 rows MySQL may still choose a full scan — tiny tables
-- are fast either way (see the "When indexing helps" slide).
EXPLAIN SELECT * FROM employee WHERE hire_date > '2024-01-01';

-- branch_id already has an index: MySQL builds one automatically for
-- every FOREIGN KEY column (and for every PRIMARY KEY).
EXPLAIN SELECT * FROM employee WHERE branch_id = 1;

-- email already has a UNIQUE index because of the UNIQUE constraint.
-- List every index on the table:
SHOW INDEX FROM employee;
