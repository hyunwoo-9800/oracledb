-- null 처리
SELECT
    COMMISSION_PCT,
    NVL(COMMISSION_PCT, 0) * 2                     AS COMM1,
    NVL2(COMMISSION_PCT, COMMISSION_PCT, 1000) * 2 AS COMM2
FROM
    EMPLOYEES;
    
-- 급여와 커미션 비율을 이용해서 1년동안 받은 전체 금액 조회 
SELECT
    SALARY,
    COMMISSION_PCT,
    SALARY * 12 + ( SALARY * 12 + NVL(COMMISSION_PCT, 0) ) AS YEAR_SALARY
FROM
    EMPLOYEES
ORDER BY
    EMPLOYEE_ID;
    
-- 커미션을 받으면 yes, 없으면 no인 isCommition 컬럼 조회
SELECT
    EMPLOYEE_ID,
    JOB_ID,
    FIRST_NAME,
    CASE
        WHEN COMMISSION_PCT IS NULL THEN
            'no'
        ELSE
            'yes'
    END AS ISCOMMITION
FROM
    EMPLOYEES
ORDER BY
    JOB_ID,
    EMPLOYEE_ID;
    
SELECT
    COMMISSION_PCT,
    NVL2(COMMISSION_PCT, 'yes', 'no') AS ISCOMMITION
FROM
    EMPLOYEES;
    
-- decode, case
SELECT
    DECODE(COMMISSION_PCT, NULL, 'no', 'yes') AS ISCOMMITION
FROM
    EMPLOYEES;
    

SELECT
    EMPLOYEE_ID,
    JOB_ID,
    FIRST_NAME,
    DECODE(JOB_ID, 'IT_PROG', 'developer',
                   'SA_REP', 'Sales Representative',
                   'Other Job') AS JOB_TITLE
FROM
    EMPLOYEES
ORDER BY
    JOB_ID,
    EMPLOYEE_ID;
    

SELECT
    EMPLOYEE_ID,
    JOB_ID,
    FIRST_NAME,
    (
        CASE
            WHEN JOB_ID = 'IT_PROG' THEN 'developer'
            WHEN JOB_ID = 'SA_REP'  THEN 'Sales Representative'
            ELSE 'Other Job'
        END
    ) AS JOB_TITLE
FROM
    EMPLOYEES
ORDER BY
    JOB_ID,
    EMPLOYEE_ID;
    
SELECT
    DEP.DEPARTMENT_NAME,
    DEP.LOCATION_ID,
    (
        CASE
             WHEN DEP.LOCATION_ID = 1500 THEN 'SanFrancisco'
             WHEN DEP.LOCATION_ID = 1700 THEN 'Seattle'
             WHEN DEP.LOCATION_ID = 2400 THEN 'London'
             ELSE 'ETC CITY'
        END
    ) AS DEPARTMENT_CITY,
    DECODE(
            DEP.LOCATION_ID,
            1500, 'SanFrancisco',
            1700, 'Seattle',
            2400, 'London',
            'ETC CITY'
    ) AS DEPARTMENT_CITY2
FROM
    DEPARTMENTS DEP
ORDER BY
    DEP.LOCATION_ID;
    
SELECT
    EMP.COMMISSION_PCT AS COMMISSION_PCT,
    (
        CASE
             WHEN EMP.COMMISSION_PCT > 0.2 THEN '상'
             WHEN EMP.COMMISSION_PCT <= 0.2 AND EMP.COMMISSION_PCT > 0.1 THEN '중'
             WHEN EMP.COMMISSION_PCT <= 0.1 THEN '하'
             WHEN EMP.COMMISSION_PCT IS NULL THEN 'null!'
             ELSE '선택받지 못한 데이터'
        END
    ) AS PCT1,
    (
        CASE
            WHEN EMP.COMMISSION_PCT <= 0.1 THEN '하'
            WHEN EMP.COMMISSION_PCT <= 0.2 THEN '중'
            WHEN EMP.COMMISSION_PCT > 0.2 THEN '상'
            WHEN EMP.COMMISSION_PCT IS NULL THEN 'null!'
            ELSE '선택받지 못한 데이터'
        END
    ) AS PCT2
FROM
    EMPLOYEES EMP
ORDER BY
    EMP.COMMISSION_PCT;

