-- 중복 제거
SELECT DISTINCT
    employee_id
FROM
    job_history;

SELECT DISTINCT
    emp.job_id as "직업 번호",
    emp.salary as "연봉"
FROM
    employees emp
ORDER BY
    salary,
    job_id;

-- 매니저 아이디 중복 제거
SELECT DISTINCT
    EMP.MANAGER_ID
FROM
    EMPLOYEES EMP
ORDER BY
    EMP.MANAGER_ID;