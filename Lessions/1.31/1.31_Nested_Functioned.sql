-- Array Intro

    SELECT[1, 2, 3];

     SELECT['sql','python','r']AS skills_arrary;

     SELECT 'python'AS skill
     UNION 
     SELECT 'sql'
     UNION ALL
     SELECT 'r';

    WITH skills AS(
     SELECT 'python'AS skill
     UNION 
     SELECT 'sql'
     UNION ALL
     SELECT 'r'
    )
    SELECT ARRAY_AGG(skill)AS skills_arrary
    FROM skills;

    --  WITH skills AS(
    --  SELECT 'python'AS skill
    --  UNION 
    --  SELECT 'sql'
    --  UNION ALL
    --  SELECT 'r'
    -- )
    -- SELECT LIST(skill)AS skills_arrary
    -- FROM skills;

     WITH skills AS(
     SELECT 'python'AS skill
     UNION 
     SELECT 'sql'
     UNION ALL
     SELECT 'r'
    ), skills_array AS(
    SELECT ARRAY_AGG(skill ORDER BY skill)AS skills
    FROM skills
    )
    SELECT
        skills[1]AS frist_skill,
         skills[2]AS seconds_skill,
          skills[3]AS third_skill,
    FROM skills_array;

-- STRUCT INTRO
    SELECT {skill: 'python', type:'programing'}AS skill_struct;

    SELECT
        STRUCT_PACK(
            skill := 'python',
            type := 'programming'
        )AS s;

    WITH skill_struct AS(
    SELECT
        STRUCT_PACK(
            skill := 'python',
            type := 'programming'
        )AS s
    )
    SELECT 
        s.skill,
        s.type
    FROM skill_struct;

    WITH skill_table AS (
    SELECT 'python'AS skills, 'programming' AS types
     UNION 
     SELECT 'sql', 'query language'
     UNION ALL
     SELECT 'r', 'programming'
    )
    SELECT
        STRUCT_PACK(
            skill := skills,
            type := types
        )
        FROM skill_table;


    -- Array of Structs

SELECT [
    {skill: 'python', type:'programing'},
    {skill: 'sql', type:'query language'}
]AS skills_array_of_structs;


    WITH skill_table AS (
    SELECT 'python'AS skills, 'programming' AS types
     UNION 
     SELECT 'sql', 'query language'
     UNION ALL
     SELECT 'r', 'programming'
    ), skills_array_struct AS (
    SELECT
        ARRAY_AGG(
        STRUCT_PACK(
            skill := skills,
            type := types
        )
    )array_struct
        FROM skill_table
    ) 
    SELECT
        array_struct[1].skill,
        array_struct[2].type,
        array_struct[3]
    FROM skills_array_struct;

-- MAP TYPE

    WITH skill_map AS(
    SELECT MAP{'skill' : 'python', 'type' : 'programming'}AS skill_type
    )
    SELECT
        skill_type['skill'],
        skill_type['type']
    FROM skill_map;

-- JSON 
    WITH raw_skill_json AS(
        SELECT
            '{"skill":"python", "type": "programming"}'::JSON AS skill_json
    )
    SELECT
        STRUCT_PACK(
            skill := json_extract_string(skill_json, '$.skill'),
            type := json_extract_string(skill_json, '$.type')
        )

    FROM
        raw_skill_json;




    
WITH raw_skill_json AS (
    SELECT
        '[
            {"skill": "python", "type": "programming"},
            {"skill": "sql", "type": "query language"},
            {"skill": "r", "type": "programming"}
        ]'::JSON AS skill_json
)
SELECT
    ARRAY_AGG(
        STRUCT_PACK(
            skill := json_extract_string(e.value, '$.skill'),
            type := json_extract_string(e.value, '$.type')
        )
        ORDER BY json_extract_string(e.value, '$.skill')
    ) AS skills
FROM raw_skill_json AS r,
     json_each(r.skill_json) AS e;


-- ARRAY FINAL EXAMPLE
-- BUILD A FLAT SKILL TABLE FOR CO-WORKER TO ACCESS JOB TITLE, SALARY INFO AND SKILLS IN ONE TABLE

    CREATE OR REPLACE TEMP TABLE job_skills_array AS
    SELECT
        j.job_id,
        j.job_title_short,
        j.salary_year_avg,
       ARRAY_AGG(s.skills)AS skills_array
    FROM job_postings_fact AS j
    LEFT JOIN skills_job_dim AS sj
        ON j.job_id = sj.job_id
    LEFT JOIN skills_dim AS s
        ON s.skill_id = sj.skill_id
    GROUP BY ALL;

    SELECT COUNT(*)
    FROM job_skills_array;

    -- DESCRIBE
    -- SELECT 
    --     job_title_short,
    --     salary_year_avg
    -- FROM job_skills_array
    -- WHERE salary_year_avg IS NOT NULL
    -- LIMIT 20;

 -- From the perspective of a Data Analyst the medium salary per skill

    
    --  WITH skills AS(
    --  SELECT 'python'AS skill
    --  UNION 
    --  SELECT 'sql'
    --  UNION ALL
    --  SELECT 'r'
    -- ), skills_array AS(
    -- SELECT ARRAY_AGG(skill ORDER BY skill)AS skills
    -- FROM skills
    -- )
    -- SELECT
    --     UNNEST(skills)
    -- FROM skills_array;

    WITH flat_skills AS(
        SELECT
            job_id,
            job_title_short,
            salary_year_avg,
        UNNEST(skills_array)AS skill
        FROM 
            job_skills_array
       
    )
    SELECT
        skill,
        MEDIAN(salary_year_avg)AS median_salary
    FROM flat_skills
    WHERE salary_year_avg IS NOT NULL 
    GROUP BY skill
    ORDER BY median_salary DESC;


-- Array of Structs - Example
-- Build a flat table for co-worker to access job title, salary info, and type in one table

    SELECT
        *
    FROM
        skills_dim
    LIMIT 20;



    CREATE OR REPLACE TEMP TABLE job_skills_struct AS
    SELECT
        j.job_id,
        j.job_title_short,
        j.salary_year_avg,
        j.salary_hour_avg,
       ARRAY_AGG(
            STRUCT_PACK(
                skill_type := s.type,
                skill_name := s.skills
            )
       )AS skills_type
    FROM job_postings_fact AS j
    LEFT JOIN skills_job_dim AS sj
        ON j.job_id = sj.job_id
    LEFT JOIN skills_dim AS s
        ON s.skill_id = sj.skill_id
    GROUP BY ALL;


    -- SELECT
    --     COUNT(*)
    -- FROM 
    --     job_skills_struct;


 -- From the perspective of a Data Analyst, the median salary per type of skill

    SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        UNNEST(skills_type).skill_type AS skill_type,
        UNNEST(skills_type).skill_name AS skill_name
    FROM 
        job_skills_struct;

    
    WITH flat_skills AS(
        SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        UNNEST(skills_type).skill_type AS skill_type,
        UNNEST(skills_type).skill_name AS skill_name
    FROM 
        job_skills_struct
       
    )
    SELECT
        skill_type,
        MEDIAN(salary_year_avg)AS median_salary
    FROM flat_skills
    -- WHERE salary_year_avg IS NOT NULL 
    GROUP BY skill_type
    ORDER BY median_salary DESC;