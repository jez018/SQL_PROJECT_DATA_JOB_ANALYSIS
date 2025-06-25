with skills_demand as (
    select 
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) as demand_count
    from job_postings_fact
    inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    where 
        job_title_short = 'Data Analyst' and 
        job_work_from_home = True
        and salary_year_avg is not null
    group by 
        skills_dim.skill_id
    limit 25
), average_salary as (
    select 
        skills_job_dim.skill_id,
        round(avg(salary_year_avg), 0) as avg_salary
    from job_postings_fact
    inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    where 
        job_title_short = 'Data Analyst'
        and salary_year_avg is not null
        and job_work_from_home = True
    group by 
        skills_job_dim.skill_id
    limit 25
)

select 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
from 
    skills_demand
inner join average_salary on skills_demand.skill_id = average_salary.skill_id
where
    demand_count > 10
ORDER BY 
    avg_salary desc,
    demand_count desc