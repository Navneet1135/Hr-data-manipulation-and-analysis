use sample_schema;
show tables;

select*from abc_inc_employees_master limit 5;
select count(*) as total_employees
from abc_inc_employees_master;

select count(*) as total_reviews
from abc_inc_performance_reviews_2024;

SELECT *
FROM abc_inc_employees_master
WHERE location IS NULL
OR location='';

SELECT *
FROM abc_inc_employees_master
WHERE manager_id IS NULL;

SELECT *
FROM abc_inc_employees_master
WHERE monthly_salary_bdt <= 0;

SELECT *
FROM abc_inc_performance_reviews_2024
WHERE YEAR(review_period_start) <> 2024
OR YEAR(review_period_end) <> 2024;


SELECT p.employee_id
FROM abc_inc_performance_reviews_2024 p
LEFT JOIN abc_inc_employees_master e
ON p.employee_id = e.employee_id
WHERE e.employee_id IS NULL;

select department,
count(*) as total_employees
from abc_inc_employees_master
group by department;

SELECT department,
employment_type,
COUNT(*) AS total
FROM abc_inc_employees_master
GROUP BY department,
employment_type;
         
         
SELECT department,
       COUNT(*) AS headcount
FROM abc_inc_employees_master
GROUP BY department
ORDER BY headcount DESC
LIMIT 1;

select department,
round(avg(monthly_salary_bdt),2) as avg_salary
from abc_inc_employees_master
group by department;

SELECT location,
ROUND(AVG(monthly_salary_bdt),2) AS avg_salary
FROM abc_inc_employees_master
GROUP BY location
ORDER BY avg_salary DESC;

SELECT e.department,
ROUND(AVG(p.performance_rating),2) AS avg_rating
FROM abc_inc_employees_master e
JOIN abc_inc_performance_reviews_2024 p
ON e.employee_id = p.employee_id
GROUP BY e.department;


SELECT e.department,
ROUND(AVG(p.manager_score),2) AS avg_manager_score,
ROUND(AVG(p.peer_score),2) AS avg_peer_score
FROM abc_inc_employees_master e
JOIN abc_inc_performance_reviews_2024 p
ON e.employee_id = p.employee_id
GROUP BY e.department;

SELECT attrition_risk,
COUNT(*) AS total_employees
FROM abc_inc_performance_reviews_2024
GROUP BY attrition_risk;

SELECT e.department,
p.attrition_risk,
COUNT(*) AS total
FROM abc_inc_employees_master e
JOIN abc_inc_performance_reviews_2024 p
ON e.employee_id = p.employee_id
GROUP BY e.department,
p.attrition_risk
ORDER BY e.department;

SELECT e.employee_id,
e.full_name,
e.department,
e.monthly_salary_bdt,
p.bonus_pct,
ROUND(e.monthly_salary_bdt * p.bonus_pct/100,2) AS bonus_amount
FROM abc_inc_employees_master e
JOIN abc_inc_performance_reviews_2024 p
ON e.employee_id = p.employee_id
ORDER BY bonus_amount DESC
LIMIT 10;

SELECT e.department,
ROUND(AVG(e.monthly_salary_bdt * p.bonus_pct/100),2) AS avg_bonus
FROM abc_inc_employees_master e
JOIN abc_inc_performance_reviews_2024 p
ON e.employee_id = p.employee_id
GROUP BY e.department
ORDER BY avg_bonus DESC;

SELECT trainings_completed,
ROUND(AVG(leaves_taken),2) AS avg_leaves
FROM abc_inc_performance_reviews_2024
GROUP BY trainings_completed
ORDER BY trainings_completed;

SELECT e.department,
ROUND(AVG(p.trainings_completed),2) AS avg_trainings,
SUM(CASE
WHEN p.attrition_risk='High' THEN 1
ELSE 0
END) AS high_risk_count
FROM abc_inc_employees_master e
JOIN abc_inc_performance_reviews_2024 p
ON e.employee_id = p.employee_id
GROUP BY e.department;

SELECT manager_id,
COUNT(*) AS direct_reports
FROM abc_inc_employees_master
WHERE manager_id IS NOT NULL
GROUP BY manager_id
ORDER BY direct_reports DESC;

SELECT manager_id,
COUNT(*) AS direct_reports
FROM abc_inc_employees_master
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING COUNT(*) > 10;

SELECT employee_id,
full_name,
department,
TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS tenure_years
FROM abc_inc_employees_master;

SELECT department,
ROUND(AVG(TIMESTAMPDIFF(YEAR, hire_date, CURDATE())),2) AS avg_tenure
FROM abc_inc_employees_master
GROUP BY department;


SELECT p.attrition_risk,
ROUND(AVG(TIMESTAMPDIFF(YEAR, e.hire_date, CURDATE())),2) AS avg_tenure
FROM abc_inc_employees_master e
JOIN abc_inc_performance_reviews_2024 p
ON e.employee_id = p.employee_id
GROUP BY p.attrition_risk;