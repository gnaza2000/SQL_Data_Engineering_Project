--Lessions/1.22/1.22_DDL_DML_pt2.sql
-- Lessions/1.22/1.22_DDL_DML_pt2.sql

-- CREATE SCHEMA IF NOT EXISTS staging;
-- DESCRIBE
-- SELECT
--     jpf.*,
--     cd.*
-- FROM data_jobs.job_postings_fact AS jpf
-- LEFT JOIN data_jobs.company_dim AS cd
--     ON jpf.company_id = cd.company_id
-- LIMIT 20;

    -- SHOW ALL TABLES;


    DROP TABLE IF EXISTS staging.priority_job_flat_view;
    DROP TABLE IF EXISTS staging.job_postings_flat;

    CREATE TABLE IF NOT EXISTS staging.job_postings_flat AS
    SELECT
        jpf.job_id,
        jpf.job_title_short,
        jpf.job_title,
        jpf.job_location,
        jpf.job_via,
        jpf.job_work_from_home,
        jpf.search_location,
        jpf.job_posted_date,
        jpf.job_no_degree_mention,
        jpf.job_health_insurance,
        jpf.job_country,
        jpf.salary_rate,
        jpf.salary_year_avg,
        jpf.salary_hour_avg,
        cd.name
    FROM data_jobs.job_postings_fact AS jpf
    LEFT JOIN data_jobs.company_dim AS cd
        ON jpf.company_id = cd.company_id;

    SELECT COUNT(*)
    FROM staging.job_postings_flat;

    SELECT  * 
    FROM staging.job_postings_flat
    LIMIT 10;

        -- SHOW ALL TABLES;

        -- DROP TABLE IF EXISTS staging.priority_job_flat_view;
    
        CREATE TABLE IF NOT EXISTS  staging.priority_job_flat_view AS
        SELECT
        jpf.*
        FROM staging.job_postings_flat AS jpf
        INNER JOIN staging.priority_roles AS r
            ON jpf.job_title_short = r.role_name
        WHERE r.priority_lvl = 1;

        SELECT 
            job_title_short,
            COUNT(*) AS job_count
            FROM staging.priority_job_flat_view
            GROUP BY job_title_short
            ORDER BY job_count DESC;

            SELECT  * 
            FROM staging.priority_job_flat_view
            LIMIT 10;
            SELECT  COUNT(*) 
            FROM staging.priority_job_flat_view;

            -- SELECT DISTINCT
            --     job_title_short
            -- FROM staging.priority_job_flat_view
            -- ORDER BY job_title_short;

            -- SELECT DISTINCT
            --     job_title_short
            -- FROM staging.priority_job_flat_view
            -- WHERE job_title_short ILIKE '%Senior%'
            -- OR job_title_short ILIKE '%Engineer%'
            -- ORDER BY job_title_short;

            -- SHOW ALL TABLES;

            CREATE OR REPLACE TEMPORARY TABLE senior_jobs_flat_temp AS
            SELECT *
            FROM staging.priority_job_flat_view
            WHERE job_title_short = 'Senior Data Engineer';


            SELECT
                job_title_short,
                COUNT(*) AS job_count
            FROM senior_jobs_flat_temp
            GROUP BY job_title_short
            ORDER BY job_count DESC;

            SELECT COUNT(*) AS total_rows
            FROM senior_jobs_flat_temp;

            SELECT *
            FROM senior_jobs_flat_temp
            LIMIT 10;

            SELECT  COUNT(*) 
            FROM senior_jobs_flat_temp;

            -- SHOW ALL TABLES;


         SELECT COUNT(*) FROM staging.job_postings_flat;
         SELECT COUNT(*) FROM staging.priority_job_flat_view;
         SELECT COUNT(*) FROM senior_jobs_flat_temp;

        --  DELETE FROM staging.job_postings_flat
        --  WHERE job_posted_date < '2024-01-01';

        --  SELECT COUNT(*) FROM staging.job_postings_flat;
        --  SELECT COUNT(*) FROM staging.priority_job_flat_view;
        --  SELECT COUNT(*) FROM senior_jobs_flat_temp;

        --  TRUNCATE TABLE staging.job_postings_flat;

        --  TRUNCATE TABLE staging.priority_job_flat_view;

        --  TRUNCATE TABLE senior_jobs_flat_temp;

        -- TRUNCATE TABLE staging.job_postings_flat;

        INSERT INTO staging.job_postings_flat
        SELECT
        jpf.job_id,
        jpf.job_title_short,
        jpf.job_title,
        jpf.job_location,
        jpf.job_via,
        jpf.job_work_from_home,
        jpf.search_location,
        jpf.job_posted_date,
        jpf.job_no_degree_mention,
        jpf.job_health_insurance,
        jpf.job_country,
        jpf.salary_rate,
        jpf.salary_year_avg,
        jpf.salary_hour_avg,
        cd.name
    FROM data_jobs.job_postings_fact AS jpf
    LEFT JOIN data_jobs.company_dim AS cd
        ON jpf.company_id = cd.company_id
    WHERE job_posted_date < '2024-01-01';

    SELECT COUNT(*) FROM staging.job_postings_flat;
    SELECT COUNT(*) FROM staging.priority_job_flat_view;
    SELECT COUNT(*) FROM senior_jobs_flat_temp;




            
         

        


   

    



