-- =====================================================================
-- Staff Demo — Step 1: create the database
-- Slides: "CREATE DATABASE and USE", "Let's build it together"
-- Run with:  mysql -u root -p < 01_create_database.sql
-- =====================================================================

-- Start fresh every time we run the demo
DROP DATABASE IF EXISTS staff_demo;

CREATE DATABASE staff_demo;  -- Create the database and switch into it
USE staff_demo;   -- everything after this runs against staff_demo

-- Should print an empty list — we haven't made any tables yet
SHOW TABLES;
