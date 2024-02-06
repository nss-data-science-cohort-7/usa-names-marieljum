-- 1. How many rows are in the names table?

SELECT COUNT(*) AS names_records
FROM names;

-- 2. How many total registered people appear in the dataset?

SELECT COUNT(DISTINCT name) AS count_distinct_names
FROM names;

-- 3. Which name had the most appearances in a single year in the dataset?

SELECT COUNT(MAX(name)) AS max_name_count
FROM names;

