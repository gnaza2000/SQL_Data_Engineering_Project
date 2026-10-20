        SELECT 
            job_id,
            job_title_short,
            salary_year_avg,
            company_id
        FROM job_postings_fact
        WHERE salary_year_avg IS NOT NULL 
        LIMIT 10;

        SELECT 
            company_id
        FROM company_dim
        LIMIT 10;

        SELECT COUNT(*)

        FROM job_postings_fact;

        SELECT *
        FROM company_dim;

        SELECT *
        FROM skills_job_dim
        LIMIT 10;

        SELECT (*)
        FROM skills_job_dim;

        SELECT *
        FROM skills_dim
        LIMIT 20;

        SELECT *
        FROM information_schema.tables
        WHERE table_catalog = 'sales_data';

        SELECT *
        FROM information_schema.tables
        WHERE table_catalog = 'my_db';

        SELECT *
        FROM information_schema.tables
        WHERE table_catalog = 'sample_data';

        SELECT *
        FROM information_schema.columns
        WHERE table_catalog = 'sample_data';

        SELECT *
        FROM information_schema.columns
        WHERE table_catalog = 'data_jobs';

            -- duckdb.org/docs/sql/meta/information_schema

        SELECT 
            table_name, column_name, data_type
        FROM information_schema.columns
        WHERE table_catalog = 'data_jobs';

        SELECT *
        FROM information_schema.table_constraints
        WHERE table_catalog = 'data_jobs';



        SELECT *
        FROM information_schema.key_column_usage
        WHERE table_catalog = 'data_jobs';


         -- duckdb.org/docs/stable/configuration/pragmas
        -- duckdb md:my_db
         -- duckdb md:data_jobs
         PRAGMA show_tables;

         PRAGMA show_tables_expanded;

        -- DESCRIBE table_name;

         DESCRIBE job_postings_fact;
