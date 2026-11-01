
    --Subquery with Filtering

    SELECT *
    FROM(
        SELECT *
        FROM job_postings_fact
        WHERE salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL

    )AS valid_salary
    LIMIT 10;


-- Check annual salary records
SELECT COUNT(*) AS annual_salary_count
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL;

-- Check hourly salary records
-- SELECT COUNT(*) AS hourly_salary_count
-- FROM job_postings_fact
-- WHERE salary_hour_avg IS NOT NULL;

-- -- Check records where both salaries exist
-- SELECT COUNT(*) AS both_salary_count
-- FROM job_postings_fact
-- WHERE salary_year_avg IS NOT NULL
--    OR salary_hour_avg IS NOT NULL;

-- CTE Query with Filtering CTE (with)

     WITH valid_salary AS(
            SELECT *
        FROM job_postings_fact
        WHERE salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL
    )
    SELECT *
    FROM valid_salary
    LIMIT 20;

--Subqueris 1 - Subquery 'SELECT'
-- Show each job's salary next in overall market median
    SELECT
        job_title_short,
        salary_year_avg,
        (
            SELECT MEDIAN(salary_year_avg)
            FROM job_postings_fact
        )AS market_median_salary
        FROM job_postings_fact
        WHERE salary_year_avg IS NOT NULL
        LIMIT 20;
        
--Subqueris 2 - Subquery in 'FROM'
-- Stage only jobs that are remote before aggregation
        SELECT
        job_title_short,
        MEDIAN(salary_year_avg),
        (
            SELECT MEDIAN(salary_year_avg)
            FROM job_postings_fact
            WHERE job_work_from_home = TRUE
        )AS market_remote_median_salary

        FROM (
            SELECT
                job_title_short,
                salary_year_avg
                FROM job_postings_fact
                WHERE job_work_from_home = TRUE
        )AS clean_jobs
        
        GROUP BY job_title_short
        LIMIT 20;

--Subqueris 3 - Subquery 'HAVING'
-- Keep only job title whose salary is above the overall median

    SELECT
        job_title_short,
        MEDIAN(salary_year_avg),
        (
            SELECT MEDIAN(salary_year_avg)
            FROM job_postings_fact
            WHERE job_work_from_home = TRUE
        )AS market_remote_median_salary

        FROM (
            SELECT
                job_title_short,
                salary_year_avg
                FROM job_postings_fact
                WHERE job_work_from_home = TRUE
        )AS clean_jobs
        
        GROUP BY job_title_short
        HAVING MEDIAN(salary_year_avg) > (
             SELECT MEDIAN(salary_year_avg)
            FROM job_postings_fact
            WHERE job_work_from_home = TRUE
        )
        LIMIT 20;

-- CTE Example
-- Compare how much more (or less) remote role pay compare to onsit roles for each job title.
-- Use a CTE to calculate the median salary by job title and with arrangement, then compare these medians.

    WITH title_median AS (
        SELECT 
        job_title_short,
        job_work_from_home,
        MEDIAN(salary_year_avg)::INT AS median_salary
    FROM job_postings_fact
    WHERE job_country = 'United States'
    GROUP BY
        job_title_short,
        job_work_from_home
    )
    SELECT
        r.job_title_short,
        r.median_salary AS remote_median_salary,
        o.median_salary AS onsit_median_salary,
        (r.median_salary - o.median_salary)AS remote_premium
    FROM title_median AS r
    INNER JOIN title_median AS o
    ON r.job_title_short = o.job_title_short
    WHERE r.job_work_from_home = TRUE
        AND o.job_work_from_home = FALSE
        ORDER BY remote_premium DESC;

--For India CTE
    WITH title_median AS (
        SELECT 
        job_title_short,
        job_work_from_home,
        MEDIAN(salary_year_avg)::INT AS median_salary
    FROM job_postings_fact
    WHERE job_country = 'India'
    GROUP BY
        job_title_short,
        job_work_from_home
    )
    SELECT
        r.job_title_short,
        r.median_salary AS remote_median_salary,
        o.median_salary AS onsit_median_salary,
        (r.median_salary - o.median_salary)AS remote_premium
    FROM title_median AS r
    INNER JOIN title_median AS o
    ON r.job_title_short = o.job_title_short
    WHERE r.job_work_from_home = TRUE
        AND o.job_work_from_home = FALSE
        ORDER BY remote_premium DESC;


--Source Table & Terget Tables

    SELECT *
    FROM range(3)AS src(key);

--Terget Tables

    SELECT *
    FROM range(3)AS tgt(key);

    SELECT *
    FROM range(3)AS src(key)
    WHERE EXISTS(
        SELECT 1
        FROM range(2)AS tgt(key)
        WHERE tgt.key = src.key
    );

    SELECT *
    FROM range(3)AS src(key)
    WHERE NOT EXISTS(
        SELECT 1
        FROM range(2)AS tgt(key)
        WHERE tgt.key = src.key
    );

--Final Example
--Identify job postings that have no associate skills before loading them into a data mart

    SELECT *
    FROM job_postings_fact
    ORDER BY job_id
    LIMIT 10;

    SELECT *
    FROM skills_job_dim
    ORDER BY job_id
    LIMIT 20;

    SELECT *
    FROM job_postings_fact AS tgt
    WHERE NOT EXISTS(
        SELECT 1
        FROM skills_job_dim AS src
        WHERE tgt.job_id = src.job_id
    )
    ORDER BY job_id;

     SELECT *
    FROM job_postings_fact AS tgt
    WHERE EXISTS(
        SELECT 1
        FROM skills_job_dim AS src
        WHERE tgt.job_id = src.job_id
    )
    ORDER BY job_id;




    -- SELECT 
    --     job_title_short,
    --     job_work_from_home,
    --     MEDIAN(salary_year_avg):: INT AS market_median_salary
    -- FROM job_postings_fact
    -- WHERE job_country = 'United States'
    -- GROUP BY
    --     job_title_short,
    --     job_work_from_home;





   


