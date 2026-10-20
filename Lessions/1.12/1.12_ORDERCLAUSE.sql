SELECT *
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
OR salary_hour_avg IS NOT NULL
ORDER BY job_postings_fact;

-- PARSER ERROR
SELECT
LIMIT 10
FROM job_postings_fact;

/*
    Find the Top 10 Companies for
    Postings Jobs They must have
    > 3000 postings
    only for USA/ India
*/
SELECT 
    c.name AS company_name,
    COUNT(j.job_id)AS postings_count
FROM job_postings_fact AS j
LEFT JOIN company_dim AS c
ON j.company_id = c.company_id
GROUP BY c.name; 

-- Link duckdb.org/2022/05/04/friendlier-sql

-- GROUP BY AND ORDER BY

SELECT 
    c.name AS company_name,
    COUNT(j.job_id)AS postings_count
FROM job_postings_fact AS j
LEFT JOIN company_dim AS c
ON j.company_id = c.company_id
GROUP BY c.name
ORDER BY postings_count DESC;

-- HAVING AND ORDER BY, LIMIT

SELECT 
    c.name AS company_name,
    COUNT(j.job_id)AS postings_count
FROM job_postings_fact AS j
LEFT JOIN company_dim AS c
ON j.company_id = c.company_id
GROUP BY c.name
HAVING COUNT(j.job_id) > 3000
ORDER BY postings_count DESC
LIMIT 50;


-- duckdb.org/docs/stable/guides/meta/explain
-- syantex EXPLAIN SELECT * FROM tbl;


EXPLAIN 
SELECT 
    c.name AS company_name,
    COUNT(j.job_id)AS postings_count
FROM job_postings_fact AS j
LEFT JOIN company_dim AS c
ON j.company_id = c.company_id
WHERE job_country ='United States'
GROUP BY c.name
HAVING COUNT(j.job_id) > 3000
ORDER BY postings_count DESC
LIMIT 10;

-- duckdb.org/docs/stable/guides/meta/explain_analyze

EXPLAIN ANALYZE
SELECT 
    c.name AS company_name,
    COUNT(j.job_id)AS postings_count
FROM job_postings_fact AS j
LEFT JOIN company_dim AS c
ON j.company_id = c.company_id
WHERE job_country ='India'
GROUP BY c.name
HAVING COUNT(j.job_id) > 500
ORDER BY postings_count DESC
LIMIT 10;