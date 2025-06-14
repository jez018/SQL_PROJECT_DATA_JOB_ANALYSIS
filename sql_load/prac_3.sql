CREATE TABLE january_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;


CREATE TABLE febuary_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;


CREATE TABLE march_jobs AS 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;

SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
 ) AS january_jobs;

 SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2
 ) AS febuary_jobs;

SELECT *
FROM (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3
 ) AS march_jobs;

WITH january_jobs2 AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
 )
SELECT *
FROM january_jobs2;

SELECT *
FROM company_dim
LIMIT 5;

SELECT name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT 
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
)

SELECT *
FROM company_dim


WITH companies_info AS (
    SELECT company_id, name, link
    FROM company_dim
    WHERE link IS NOT NULL
)
select job_title_short from job_postings_fact
where company_id in (
    select company_id from companies_info where name != 'USAA'
)

with company_job_count as      
    (select company_id, count(*)
    from job_postings_fact
    group by company_id)
select * from company_dim
left join company_job_count on company_job_count.company_id = company_dim.company_id
where company_dim.link is not null;


with company_job_count as      
    (select 
        company_id, 
        count(*) as total_jobs
    from 
        job_postings_fact
    group by 
        company_id)
select 
    company_dim.name as company_name, 
    company_job_count.total_jobs 
from 
    company_dim
left join company_job_count on company_job_count.company_id = company_dim.company_id
where company_dim.link is not null
order by total_jobs desc;


with remote_job_skills as 
    (select skill_id, count(*) as skill_count
    from skills_job_dim as skills_to_job
    inner join job_postings_fact as job_postings on job_postings.job_id = skills_to_job.job_id
    where job_postings.job_work_from_home = True and job_postings.job_title_short = 'Data Analyst'
    group by skill_id
    )

select 
    skills.skill_id,
    skills as skill_name,
    skill_count
from remote_job_skills
inner join skills_dim as skills on skills.skill_id = remote_job_skills.skill_id
order by skill_count desc
limit 5;

select * from skills_job_dim limit 5;