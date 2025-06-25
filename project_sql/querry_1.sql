/*
Question: What are the top-paying data analyst jobs?
- Identify the top highest paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why Highlight the top paying opportunities for Data Analysts, offering insights into employment
*/
select * from job_postings_fact limit 10;

-- THis gives us the top paying analyst jobs for remote work
select 
    job_title,
    --job_title_short,
    AVG(salary_year_avg) as salary_avg
from 
    job_postings_fact
where 
    job_title_short = 'Data Analyst' and
    salary_year_avg is not null and 
    job_work_from_home = true
group by 
    job_title
order by salary_avg desc;

-- THis gives us the top paying analyst jobs
select 
    job_title,
    --job_title_short,
    AVG(salary_year_avg) as salary_avg
from 
    job_postings_fact
where 
    job_title_short = 'Data Analyst' and
    salary_year_avg is not null
group by 
    job_title
order by salary_avg desc;


select * from skills_job_dim limit 10;

