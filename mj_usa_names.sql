-- 1. How many rows are in the names table?

SELECT COUNT(*) AS names_records
FROM names;

-- 1957046 rows

-- 2. How many total registered people appear in the dataset?

SELECT SUM(num_registered) 
FROM names;

-- 351653025

-- 3. Which name had the most appearances in a single year in the dataset?

SELECT year, name, sum(num_registered) AS appearances
FROM names
GROUP BY year, name
ORDER BY sum(num_registered) DESC;

-- Linda with 99,905 appearances in 1947

-- 4. What range of years are included?

SELECT MIN(year) AS min_year, MAX(year) AS max_year
FROM names;

-- 1880-2018

-- 5. What year has the largest number of registrations?

SELECT year, SUM(num_registered) as total
FROM names
GROUP BY year
ORDER BY SUM(num_registered) DESC 
LIMIT 1;

-- 1957 with 4200022

-- 6. How many different (distinct) names are contained in the dataset?

SELECT COUNT(DISTINCT name) AS count_distinct_names
FROM names;

-- 98,400 

-- 7. Are there more males or more females registered?

SELECT gender, SUM(num_registered)
FROM names
GROUP BY gender;

-- More Males. F 174079232, M 177573793

-- 8. What are the most popular male and female names overall (i.e., the most total registrations)?

(
SELECT gender, name, SUM(num_registered) AS total_registrations
FROM names
WHERE gender = 'M'
GROUP BY name, gender
ORDER BY total_registrations DESC
LIMIT 1
)
UNION
(
SELECT gender, name, SUM(num_registered) AS total_registrations
FROM names
WHERE gender = 'F'
GROUP BY name, gender
ORDER BY total_registrations DESC
LIMIT 1
)

-- Mary (F) 4125675, James (M) 5164280


-- 9. What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?

(
SELECT gender, name, SUM(num_registered) AS total_registrations
FROM names
WHERE gender = 'M' AND year
	BETWEEN 2000 and 2009
GROUP BY name, gender
ORDER BY total_registrations DESC
LIMIT 1
)
UNION
(
SELECT gender, name, SUM(num_registered) AS total_registrations
FROM names
WHERE gender = 'F' AND year
	BETWEEN 2000 and 2009
GROUP BY name, gender
ORDER BY total_registrations DESC
LIMIT 1
)

-- Emily 223690, Jacob 273844


-- 10. Which year had the most variety in names (i.e. had the most distinct names)?

SELECT year, COUNT(DISTINCT name)
FROM names
GROUP BY year
ORDER BY count DESC
LIMIT 1;

-- 2008 with 32518


-- 11. What is the most popular name for a girl that starts with the letter X?

SELECT name, SUM(num_registered) as total
FROM names
WHERE name LIKE 'X%' AND 
	gender = 'F'
GROUP BY name
ORDER BY total DESC
LIMIT 1;

-- Ximena with 26,145


-- 12. How many distinct names appear that start with a 'Q', but whose second letter is not 'u'?

SELECT COUNT(DISTINCT name) 
FROM names
WHERE name LIKE 'Q%' 
	AND name NOT LIKE '_u%';
	
-- 46 names


-- 13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.

SELECT name, SUM(num_registered)
FROM names
WHERE name IN ('Stephen','Steven')
GROUP BY name;

-- Steven with 1286951


-- 14. What percentage of names are "unisex" - that is what percentage of names have been used both for boys and for girls?

WITH gender_count AS(
	SELECT COUNT(DISTINCT gender) as count
	FROM names
	GROUP BY name
)

SELECT COUNT(*) * 100.0 / (SELECT COUNT(*) FROM gender_count) AS percentage
FROM gender_count
WHERE count = 2;

-- 10.94%


-- 15. How many names have made an appearance in every single year since 1880?

SELECT name, COUNT(DISTINCT year) as count, MIN(year), MAX(year)
FROM names
GROUP BY name
HAVING COUNT(DISTINCT year) = 139;

-- 921 

-- 16. How many names have only appeared in one year?

SELECT name, COUNT(DISTINCT year) as count
FROM names
GROUP BY name
HAVING COUNT(DISTINCT year) = 1;

-- 21,123

-- 17. How many names only appeared in the 1950s?

SELECT name, MIN(year), MAX(year)
FROM names
GROUP BY name
HAVING MIN(year) >= 1950 AND MAX(year) <= 1959;

-- 661

-- 18. How many names made their first appearance in the 2010s?

SELECT name, MIN(year), MAX(year)
FROM names
GROUP BY name
HAVING MIN(year) >= 2010;

-- 11,270

-- 19. Find the names that have not be used in the longest.

SELECT name, MAX(year) as max_yr
FROM names
GROUP BY name
ORDER BY max_yr ASC;

-- 20. Come up with a question that you would like to answer using this dataset. 
-- Then write a query to answer this question.
-- How many names start with 'Marie'? Which deviation is most popular?

SELECT name, SUM(num_registered) AS total, MIN(year) AS min_yr, MAX(year) AS max_yr
FROM names
WHERE name LIKE 'Marie%'
GROUP BY name
ORDER BY total DESC;

-- 48 names. Marie is most popular. 

