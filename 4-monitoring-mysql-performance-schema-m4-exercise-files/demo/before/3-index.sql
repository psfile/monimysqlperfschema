-- Index
EXPLAIN SELECT a.first_name, a.last_name
FROM sakila.actor a
CROSS JOIN sakila.actor b
ORDER BY a.last_name DESC;

-- No Index
EXPLAIN SELECT *
FROM sakila.film a;

-- No Index
EXPLAIN SELECT a.first_name, a.last_name
FROM sakila.actor a
CROSS JOIN sakila.actor b
ORDER BY b.last_update DESC;

-- Create Index
CREATE INDEX IX_Last_Update 
ON sakila.actor (last_update);

-- USE Index
EXPLAIN SELECT a.first_name, a.last_name
FROM sakila.actor a
CROSS JOIN sakila.actor b
ORDER BY b.last_update DESC;

-- Drop Index
DROP INDEX IX_Last_Update ON sakila.actor;