SELECT
    j.*,
    c.*
FROM job_postings_fact AS j
RIGHT JOIN company_dim AS c
ON j.company_id = c.company_id
LIMIT 20;

SELECT
    job_id,
    job_title_short,
    name AS company_name,
    job_location
FROM job_postings_fact AS j
LEFT JOIN company_dim AS c
ON j.company_id = c.company_id
LIMIT 20;

SELECT
    job_id,
    name AS company_name
FROM job_postings_fact AS j
LEFT JOIN company_dim AS c
ON j.company_id = c.company_id
LIMIT 20;

SELECT COUNT(*)
FROM job_postings_fact;

SELECT COUNT(*)
FROM company_dim;


SELECT
    j.job_id,
    j.job_title_short,
    c.name AS company_name,
    j.job_location,
    c.company_id
FROM job_postings_fact AS j
LEFT JOIN company_dim AS c
ON j.company_id = c.company_id;

SELECT
    j.job_id,
    j.job_title_short,
    c.name AS company_name,
    j.job_location,
    c.company_id
FROM job_postings_fact AS j
RIGHT JOIN company_dim AS c
ON j.company_id = c.company_id
LIMIT 20;

SELECT
    j.job_id,
    j.job_title_short,
    c.company_id,
    c.name AS company_name,
    j.job_location
    
FROM job_postings_fact AS j
INNER JOIN company_dim AS c
ON j.company_id = c.company_id;

-- OR-----
SELECT
    j.job_id,
    j.job_title_short,
    c.company_id,
    c.name AS company_name,
    j.job_location
    
FROM job_postings_fact AS j
JOIN company_dim AS c
ON j.company_id = c.company_id;

SELECT
    j.job_id,
    j.job_title_short,
    c.company_id,
    c.name AS company_name,
    j.job_location
    
FROM job_postings_fact AS j
FULL OUTER JOIN company_dim AS c
ON j.company_id = c.company_id;

-- OR-----
SELECT
    j.job_id,
    j.job_title_short,
    c.company_id,
    c.name AS company_name,
    j.job_location
    
FROM job_postings_fact AS j
FULL JOIN company_dim AS c
ON j.company_id = c.company_id;


-- LEFT OUTER JOIN --/ RIGHT OUTER JOIN

SELECT
    j.job_id,
    j.job_title_short,
    c.company_id,
    c.name AS company_name,
    j.job_location
    
FROM job_postings_fact AS j
LEFT OUTER JOIN company_dim AS c
ON j.company_id = c.company_id;

-- ERD 

SELECT *
FROM skills_job_dim
LIMIT 10;

SELECT *
FROM skills_dim
LIMIT 10;


SELECT
    j.job_id,
    j.job_title_short,
    s.skill_id,
    s.skills
FROM job_postings_fact AS j
LEFT JOIN skills_job_dim AS sj
ON j.job_id = sj.job_id

LEFT JOIN skills_dim AS s
ON sj.skill_id = s.skill_id;


SELECT
    j.job_id,
    j.job_title_short,
    s.skill_id,
    s.skills
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS sj
ON j.job_id = sj.job_id

INNER JOIN skills_dim AS s
ON sj.skill_id = s.skill_id;

SELECT
    j.job_id,
    j.job_title_short,
    s.skill_id,
    s.skills
FROM job_postings_fact AS j
FULL JOIN skills_job_dim AS sj
ON j.job_id = sj.job_id

FULL JOIN skills_dim AS s
ON sj.skill_id = s.skill_id;


