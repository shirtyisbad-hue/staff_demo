-- =====================================================================
-- Staff Demo — Step 6: errors on purpose
-- Slides: "Foreign key errors you'll actually hit", "Constraints"
-- Run these ONE AT A TIME in the mysql prompt or Workbench —
-- each one is SUPPOSED to fail. Read the error message out loud.
-- =====================================================================
USE staff_demo;

-- 1) FOREIGN KEY: branch 99 doesn't exist
--    ERROR 1452: Cannot add or update a child row: a foreign key constraint fails
-- branch_id is a FOREIGN KEY referencing branch.branch_id -- MySQL checks
-- that 99 actually exists over there before allowing this row in, and it
-- doesn't, so the insert is rejected before anything is written.
INSERT INTO employee (full_name, email, branch_id)
VALUES ('Ghost Worker', 'ghost@example.com', 99);

-- 2) FOREIGN KEY: branch 1 still has employees (ON DELETE RESTRICT)
--    ERROR 1451: Cannot delete or update a parent row: a foreign key constraint fails
-- Same constraint, opposite direction: this time we're deleting the PARENT
-- row instead of inserting a bad child. Any employee still pointing at
-- branch_id = 1 would be left referencing a branch that no longer exists,
-- so ON DELETE RESTRICT blocks the delete outright instead of allowing that.
DELETE FROM branch WHERE branch_id = 1;

-- 3) NOT NULL: full_name is required
--    ERROR 1364 / 1048: Field 'full_name' doesn't have a default value / cannot be null
-- full_name isn't in the column list at all here, and it has no DEFAULT
-- value defined -- since it's declared NOT NULL, MySQL has nothing valid
-- to put there and refuses the row instead of leaving it blank.
INSERT INTO employee (email, branch_id) VALUES ('noname@example.com', 1);

-- 4) UNIQUE: that email is already taken
--    ERROR 1062: Duplicate entry 'luffy@example.com' for key 'employee.email'
-- luffy@example.com already belongs to the real Luffy row from
-- 03_insert_data.sql. The UNIQUE constraint on email means no two rows can
-- share this value, so a second row using it -- even with a different
-- name -- is rejected.
INSERT INTO employee (full_name, email, branch_id)
VALUES ('Luffy Clone', 'luffy@example.com', 1);

-- 5) CHECK: pay rate must be positive  (MySQL 8.0.16+)
--    ERROR 3819: Check constraint 'employee_chk_1' is violated
-- hourly_rate has a CHECK (hourly_rate > 0) constraint in 02_create_tables.sql.
-- -5.00 fails that rule directly -- every other column here is perfectly
-- valid, but CHECK alone is enough to block the whole row.
INSERT INTO employee (full_name, email, branch_id, hourly_rate)
VALUES ('Free Labor', 'free@example.com', 1, -5.00);

-- 6) Composite PRIMARY KEY: employee 1 already has 'Safety'
--    ERROR 1062: Duplicate entry '1-Safety' for key 'training.PRIMARY'
-- training's primary key isn't one column -- it's the PAIR
-- (employee_id, course_name) together. Employee 1 (Luffy) already has a
-- 'Safety' row from 03_insert_data.sql, so this exact pair already exists
-- and a second copy collides with the primary key.
INSERT INTO training (employee_id, course_name) VALUES (1, 'Safety');

-- 7) ON UPDATE CASCADE (this one SUCCEEDS): renumber branch 3,
--    and every employee at that branch follows automatically
-- Unlike the six errors above, this is meant to work cleanly. Changing
-- branch_id from 3 to 30 would normally orphan every employee who had
-- branch_id = 3 -- but ON UPDATE CASCADE tells MySQL to automatically
-- update those employee rows to match, in the same operation, with no
-- error and no manual fixup needed.
UPDATE branch SET branch_id = 30 WHERE branch_id = 3;
-- Confirms the cascade actually happened: any employee that used to show
-- branch_id = 3 should now show branch_id = 30 instead.
SELECT full_name, branch_id FROM employee WHERE branch_id = 30;