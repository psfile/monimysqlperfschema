SELECT *
FROM sakila.actor a
CROSS JOIN sakila.actor b;

-- Using Temp Table
CREATE TEMPORARY TABLE sakila.TempActor (FirstName VARCHAR(100), LastName VARCHAR(100));
INSERT INTO sakila.TempActor (FirstName, LastName)
SELECT a.first_name, a.last_name
FROM sakila.actor a
CROSS JOIN sakila.actor b;

-- Order by
SELECT a.first_name, a.last_name
FROM sakila.actor a
CROSS JOIN sakila.actor b
ORDER BY a.last_name DESC;

