SELECT *
FROM skills_job_dim
LIMIT 100

SELECT 
    job_title_short AS title, 
    job_location AS location, 
    job_posted_date::DATE AS date 
FROM 
    job_postings_fact 

SELECT 
    job_title_short AS title, 
    job_location AS location, 
    job_posted_date AS date_time 
FROM 
    job_postings_fact

SELECT 
    job_title_short AS title, 
    job_location AS location, 
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time 
FROM 
    job_postings_fact

SELECT 
    job_title_short AS title, 
    job_location AS location, 
    job_posted_date AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS month,
    EXTRACT(YEAR FROM job_posted_date) AS year
FROM 
    job_postings_fact
LIMIT 10;

SELECT
    count(job_id) AS job_posted_count, 
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact 
GROUP BY 
    month
ORDER BY 
job_posted_count DESC;

    EXTRACT(YEAR FROM job_posted_date) AS year
FROM 
    job_postings_fact
LIMIT 10;

SELECT
    COUNT(job_id) AS job_posted_count,
    -- job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS month
FROM 
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') = 2023
GROUP BY
    month
ORDER BY 
    job_posted_count DESC;