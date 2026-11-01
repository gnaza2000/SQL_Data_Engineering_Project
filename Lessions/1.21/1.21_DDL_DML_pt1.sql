-- Lessions/1.21/1.21_DDL_DML_pt1.sql

-- DROP DATABASE job_mart;

-- DROP DATABASE IF EXISTS job_mart;
-- DROP SCHEMA staging;

-- DROP SCHEMA IF NOT EXISTS staging;

-- DROP DATABASE job_mart;

-- DROP DATABASE IF EXISTS job_mart;

-- DROP SCHEMA staging;

-- DROP SCHEMA IF NOT EXISTS staging;
-- DROP TABLE preferred_roles;

    --  DROP TABLE IF EXISTS preferred_roles;
    --  DROP TABLE IF EXISTS main.preferred_roles;
    --  DROP TABLE IF EXISTS staging.preferred_roles;


-- USE data_jobs

-- DROP DATABASE IF EXISTS jobs_mart;

-- CREATE DATABASE IF NOT EXISTS jobs_mart;

-- CREATE DATABASE IF NOT EXISTS jobs_mart;


--     SELECT *
--     FROM information_schema.schemata;

--     CREATE SCHEMA jobs_mart.staging;

    SHOW DATABASES;

    



   


    -- CREATE TABLE IF NOT EXISTS staging.preferred_roles(
    --     role_id INTEGER,
    --     role_name VARCHAR
    -- );


    -- CREATE SCHEMA jobs_mart.staging;
    -- USE jobs_mart;
    -- CREATE SCHEMA IF NOT EXISTS staging;

    -- CREATE TABLE IF NOT EXISTS staging.preferred_roles(
    --     role_id INTEGER,
    --     role_name VARCHAR
    -- );

    -- INSERT INTO staging.preferred_roles (role_id, role_name)
    -- VALUES
    --     (3, 'Data Engineer'),
    --     (4, 'Data Analyst'); 
    
    -- SELECT *
    -- FROM staging.preferred_roles;

    CREATE DATABASE IF NOT EXISTS jobs_mart;

    USE jobs_mart;

    CREATE SCHEMA staging;
    CREATE SCHEMA staging;
    CREATE SCHEMA IF NOT EXISTS staging;

    SELECT *
    FROM information_schema.schemata;


    CREATE TABLE staging.preferred_roles(
        role_id INTEGER PRIMARY KEY,
        role_name VARCHAR
    );





    SELECT *
    FROM information_schema.schemata;

    -- DROP TABLE preferred_roles;

    SELECT *
    FROM information_schema.tables
    WHERE table_catalog = 'jobs_mart';



    -- CREATE TABLE IF NOT EXISTS jobs_mart.staging.preferred_roles(
    --     role_id INTEGER PRIMARY KEY,
    --     role_name VARCHAR
    -- );

    INSERT INTO staging.preferred_roles (role_id, role_name)
    VALUES
        (1, 'Data Engineer'),
        (2, 'Senior Data Engineer'),
        (3, 'Software Engineer'); 
        
        
    
    SELECT *
    FROM staging.preferred_roles;


    ALTER TABLE staging.preferred_roles
    ADD COLUMN preferred_role BOOLEAN;

    ALTER TABLE staging.preferred_roles
    DROP COLUMN preferred_role;

    DELETE FROM staging.preferred_roles
    WHERE role_id = 3;    

        -- ALTER TABLE staging.preferred_roles
        -- DROP COLUMN role_id;

        SELECT *
        FROM staging.preferred_roles;
   

    UPDATE staging.preferred_roles
    SET preferred_role = TRUE
    WHERE role_id=1 OR role_id=2;

    UPDATE staging.preferred_roles
    SET preferred_role = FALSE
    WHERE role_id=3;


    ALTER TABLE staging.preferred_roles
    RENAME TO priority_roles;

    SELECT *
        FROM staging.priority_roles;

    ALTER TABLE staging.priority_roles
    RENAME COLUMN preferred_role TO priority_lvl;


    ALTER TABLE staging.priority_roles
    ALTER COLUMN priority_lvl TYPE INTEGER;


     UPDATE staging.priority_roles
     SET priority_lvl = 3
     WHERE role_id = 3;

      SELECT *
        FROM staging.priority_roles;









    

    

   

    


