   --UNION
    -- SELECT (1, 1, 1, 2);

    -- SELECT UNNEST([1, 1, 1, 2])
    -- UNION ALL
    -- SELECT UNNEST([1, 1, 3]);

    SELECT UNNEST([1, 1, 1, 2])
    UNION
    SELECT UNNEST([1, 1, 3]);

--INTERSECT ALL

    SELECT UNNEST([1, 1, 1, 2])
    INTERSECT ALL
    SELECT UNNEST([1, 1, 3]);

--EXCEPT ALL

    SELECT UNNEST([1, 1, 1, 2])
    EXCEPT ALL
    SELECT UNNEST([1, 1, 3]);

    CREATE TEMP TABLE jobs_2023 AS
    -- DESCRIBE
    SELECT * EXCLUDE (job_id, job_posted_date)
    FROM job_postings_fact
    WHERE EXTRACT(YEAR FROM job_posted_date)=2023;

    SELECT * FROM jobs_2023;

    SELECT COUNT(*) AS total_jobs_2023
    FROM jobs_2023; 

SELECT *
FROM jobs_2023
LIMIT 10;

-- CREATE OR REPLACE TEMP TABLE jobs_2023 AS
-- SELECT * EXCLUDE (job_id, job_posted_date)
-- FROM job_postings_fact
-- WHERE job_posted_date >= DATE '2023-01-01'
--   AND job_posted_date <  DATE '2024-01-01';



    CREATE TEMP TABLE jobs_2024 AS
    -- DESCRIBE
    SELECT * EXCLUDE (job_id, job_posted_date)
    FROM job_postings_fact
    WHERE EXTRACT(YEAR FROM job_posted_date)=2024;

    SELECT COUNT(*) AS total_jobs_2024
    FROM jobs_2024; 

    SELECT * FROM jobs_2024;


-- Which unique jobs postings appeared in either 2023 or 2024
    -- SELECT COUNT(*) FROM jobs_2023
    -- UNION
    -- SELECT COUNT(*) FROM jobs_2024;

    SELECT 
        'jobs_2023' AS table_name,
    COUNT(*) AS recode_count
    FROM jobs_2023
    UNION
    SELECT
        'jobs_2024' AS table_name, 
    COUNT(*) 
    FROM jobs_2024;

    
    SELECT * FROM jobs_2023
    UNION
    SELECT * FROM jobs_2024;

    SELECT * FROM jobs_2023
    UNION ALL
    SELECT * FROM jobs_2024;

-- Which job postings appeared to 2023 but not in 2024

    SELECT * FROM jobs_2023
    EXCEPT
    SELECT * FROM jobs_2024;

--  Which job postings from 2023 remain after subtracting matching 2024 postings, one - for - one?
    SELECT * FROM jobs_2023
    EXCEPT ALL
    SELECT * FROM jobs_2024;

--  Which job postings appeared in both 2023 and 2024 ?

    SELECT * FROM jobs_2023
    INTERSECT
    SELECT * FROM jobs_2024;

--  Which job postings appeared in both years, presrving duplicate counts?

    SELECT * FROM jobs_2023
    INTERSECT ALL
    SELECT * FROM jobs_2024;


 


