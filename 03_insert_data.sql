-- =====================================================================
-- Staff Demo — Step 3: sample data
-- Slides: AUTO_INCREMENT, DEFAULT, INSERT
-- Notice we never give branch_id / employee_id — MySQL numbers them.
-- =====================================================================
USE staff_demo;

-- Insert 3 rows into branch in one statement.
-- Columns listed are (name, address) -- branch_id is left out on purpose:
-- it's AUTO_INCREMENT, so MySQL assigns 1, 2, 3 automatically in this order.
INSERT INTO branch (name, address) VALUES
                                       ('Downtown',   '100 Main St'),
                                       ('Harbor',     '25 Marine Dr'),
                                       ('Airport',    NULL);            -- address unknown -> NULL

-- Insert 6 employees, explicitly giving every column that doesn't have a default.
-- branch_id here is a FOREIGN KEY value -- it must match an id that already
-- exists in branch (1 = Downtown, 2 = Harbor, 3 = Airport from above).
-- hourly_rate and hire_date are supplied for every row, so no defaults kick in.
INSERT INTO employee (full_name, email, branch_id, hourly_rate, hire_date) VALUES
                                                                               ('Luffy Monkey',   'luffy@example.com',   1, 18.50, '2024-01-15'),
                                                                               ('Zoro Roronoa',   'zoro@example.com',    1, 22.00, '2023-06-01'),
                                                                               ('Sanji Vinsmoke', 'sanji@example.com',   2, 24.75, '2022-11-20'),
                                                                               ('Usopp God',      'usopp@example.com',   2, 16.25, '2025-03-10'),
                                                                               ('Robin Nico',     'robin@example.com',   3, 27.00, '2021-09-05'),
                                                                               ('Chopper Tony',   'chopper@example.com', 3, 19.00, '2025-08-18');

-- This INSERT only lists 3 columns (full_name, email, branch_id), so the
-- columns we skipped -- hourly_rate and is_active -- aren't left blank.
-- MySQL fills them in from the table's own DEFAULT values instead:
-- hourly_rate becomes 15.00 and is_active becomes TRUE.
-- No hourly_rate or is_active given -> DEFAULT 15.00 and TRUE fill in
INSERT INTO employee (full_name, email, branch_id)
VALUES ('Brook Soul', 'brook@example.com', 1);

-- Insert training records. employee_id here is a FOREIGN KEY pointing back
-- into the employee table (1 = Luffy, 2 = Zoro, 5 = Robin -- numbering follows
-- the insert order above). completed holds the date a course was finished;
-- NULL in the last row just means Robin hasn't finished "Management" yet.
INSERT INTO training (employee_id, course_name, completed) VALUES
                                                               (1, 'Safety',          '2024-02-01'),
                                                               (1, 'Customer Service','2024-03-12'),
                                                               (2, 'Safety',          '2023-07-01'),
                                                               (5, 'Management',      NULL);

-- Pull everything back so we can eyeball that the inserts worked and see
-- the auto-generated ids (branch_id, employee_id) MySQL assigned.
-- prints all 3 tables
SELECT * FROM branch;
SELECT * FROM employee;
SELECT * FROM training;