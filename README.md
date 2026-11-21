# Staff Demo — CS377 Group 4 MySQL project

A tiny MySQL database used for every example in our presentation:
three tables (`branch`, `employee`, `training`) that cover all five required topics.

| File | What it shows | Slides |
|---|---|---|
| `01_create_database.sql` | `CREATE DATABASE`, `USE`, `SHOW TABLES` | Session 1, Part 2 |
| `02_create_tables.sql` | Data types, `NOT NULL`, `DEFAULT`, `AUTO_INCREMENT`, primary & foreign keys, `UNIQUE`, `CHECK`, composite key | Session 1, Parts 2–3 |
| `03_insert_data.sql` | Sample rows; auto-numbered IDs and defaults filling in | Session 1 & 2 |
| `04_queries.sql` | `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, `INSERT`/`UPDATE`/`DELETE`, aggregates, `GROUP BY`, `INNER JOIN` | Session 2, Part 4 |
| `05_indexes.sql` | `CREATE INDEX`, `EXPLAIN`, `SHOW INDEX` | Session 2, Part 5 |
| `06_error_demos.sql` | Foreign key, `NOT NULL`, `UNIQUE` and `CHECK` errors on purpose | Troubleshooting & constraints |

## Schema

```
branch                     employee                      training
--------------             ----------------              ----------------
branch_id  (PK)  <-----    branch_id   (FK)              employee_id (PK, FK) ---> employee
name                       employee_id (PK)  <---------  course_name (PK)
address                    full_name                     completed
                           email (UNIQUE)
                           hourly_rate (DEFAULT, CHECK)
                           hire_date
                           is_active (DEFAULT TRUE)
```

## How to run

Needs MySQL 8.0.16 or newer (for `CHECK` constraints).

```bash
mysql -u root -p < 01_create_database.sql
mysql -u root -p < 02_create_tables.sql
mysql -u root -p < 03_insert_data.sql
mysql -u root -p < 04_queries.sql
mysql -u root -p < 05_indexes.sql
```

Run `06_error_demos.sql` one statement at a time (in the `mysql>` prompt or Workbench),
because every statement except the last is meant to fail.

To start over, just run `01_create_database.sql` again — it drops and recreates `staff_demo`.

In MySQL Workbench: File → Open SQL Script, pick a file, then click the lightning-bolt button.
