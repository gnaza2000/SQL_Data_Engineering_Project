    SELECT LENGTH('PYTHON');

    SELECT LOWER('PYTHON');

    SELECT UPPER('Sql');

    SELECT LEFT('PYTHON',2);

    SELECT RIGHT('PYTHON',3);

    SELECT SUBSTRING('PYTHON',3, 2);

    SELECT CONCAT('PYTHON', '-' 'FUNCTION');

    SELECT 'SOL' || '-' || 'FUNCTION';

    SELECT TRIM('SQL');

    SELECT REPLACE('SQL', 'Q', '_');

    SELECT REGEXP_REPLACE('data.nerd@gmail.com', '^.*(0)', '\1');

-- Final Example - Clean this using using text Functions
    WITH title_lower AS (
        SELECT 
            job_title,
            LOWER(TRIM(job_title))AS job_title_clean
        FROM job_postings_fact
    )
    SELECT
        job_title,
        CASE
        WHEN job_title_clean LIKE '%data%'
            AND job_title_clean LIKE 'analyst' THEN 'Data Engineer'
        WHEN job_title_clean LIKE '%data%' 
            AND job_title_clean LIKE '%scientis%' THEN 'Data Scientis'
        WHEN job_title_clean LIKE '%data%'
            AND job_title_clean LIKE '%engineer%' THEN 'Data Engineer'
        ELSE  'other'
        END AS job_title_category
    FROM title_lower
    ORDER BY 
        RANDOM()
    LIMIT 30;

    DESCRIBE job_postings_fact;


    SELECT NULLIF(10,10);

    SELECT NULLIF(10 + 15,20);


-- Clean 0 values
    SELECT
        MEDIAN(NULLIF(salary_year_avg, 0)),
        MEDIAN(NULLIF(salary_hour_avg, 0))
    FROM job_postings_fact
    WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
    LIMIT 10;
-- improve 0 values to NULL VALUES
    SELECT
        salary_year_avg, 
        salary_hour_avg
    FROM job_postings_fact
    WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg
    LIMIT 10;

    SELECT COALESCE(0, 1, 2);

    SELECT COALESCE(NULL, 1, 2);

    SELECT COALESCE(NULL, NULL, 2);

    SELECT
        salary_year_avg, 
        salary_hour_avg,
        COALESCE(salary_year_avg, salary_year_avg * 2080)
    FROM job_postings_fact
    WHERE salary_hour_avg IS NOT NULL OR salary_year_avg
    LIMIT 10;
    



   SELECT
            job_title_short,
            salary_hour_avg,
            salary_year_avg,
            COALESCE(salary_year_avg, salary_year_avg * 2080)AS standardized_salary,
    CASE
        WHEN COALESCE(salary_year_avg, salary_year_avg * 2080) IS NULL THEN 'Missing'
        WHEN standardized_salary < 75_000 THEN 'Low'
        WHEN standardized_salary < 150_000 THEN 'Medium'
        ELSE 'High'
        END AS salary_bucket
    FROM job_postings_fact
    ORDER BY standardized_salary DESC;



