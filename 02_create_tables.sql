-- =====================================================================
-- Staff Demo — Step 2: create the tables
-- Slides: data types, CREATE TABLE, NULL / NOT NULL / DEFAULT,
--         AUTO_INCREMENT, PRIMARY KEY, FOREIGN KEY, constraints
-- =====================================================================
USE staff_demo;   -- make sure we're building inside the right database

-- ---------------------------------------------------------------------
-- Parent table: branch
-- Must be created FIRST, because employee points to it.
-- ---------------------------------------------------------------------
CREATE TABLE branch (
                        branch_id   INT          AUTO_INCREMENT,  -- unique ID, MySQL assigns it automatically, its like autonumber in Access
                        name        VARCHAR(50)  NOT NULL,        -- required: every branch needs a name, its like required YES in Access
                        address     VARCHAR(100),                 -- NULL allowed (address unknown)
                        PRIMARY KEY (branch_id)                   -- branch_id uniquely identifies each row
);

-- ---------------------------------------------------------------------
-- Child table: employee
-- Uses every idea from the presentation in one statement.
-- ---------------------------------------------------------------------
CREATE TABLE employee (
                          employee_id INT           AUTO_INCREMENT, -- unique ID, auto-assigned
                          full_name   VARCHAR(80)   NOT NULL,       -- required
                          email       VARCHAR(100)  NOT NULL UNIQUE,-- required, and no two employees can share one
                          branch_id   INT           NOT NULL,       -- which branch this employee works at
                          hourly_rate DECIMAL(6,2)  NOT NULL DEFAULT 15.00
                              CHECK (hourly_rate > 0), -- exact decimal for money; must be positive
                          hire_date   DATE,                         -- NULL allowed if unknown/not recorded
                          is_active   BOOLEAN       NOT NULL DEFAULT TRUE, -- defaults every new hire to active
                          PRIMARY KEY (employee_id),
                          FOREIGN KEY (branch_id)
                              REFERENCES branch(branch_id)            -- must match a real row in branch
                              ON DELETE RESTRICT                      -- block deleting a branch that still has employees
                              ON UPDATE CASCADE                       -- if a branch_id ever changes, update employees too
);

-- ---------------------------------------------------------------------
-- Composite primary key example (from the "Defining a PRIMARY KEY" slide)
-- One row per employee per training course; the PAIR must be unique.
-- ---------------------------------------------------------------------
CREATE TABLE training (
                          employee_id INT          NOT NULL,        -- which employee took the course
                          course_name VARCHAR(50)  NOT NULL,        -- which course
                          completed   DATE,                         -- NULL allowed if not finished yet
                          PRIMARY KEY (employee_id, course_name),   -- same employee can't repeat the same course
                          FOREIGN KEY (employee_id)
                              REFERENCES employee(employee_id)        -- must be a real employee
                              ON DELETE CASCADE                       -- deleting an employee removes their training rows too
);

-- Check our work: MySQL prints back each table's structure
SHOW TABLES;
DESCRIBE branch;
DESCRIBE employee;
DESCRIBE training;