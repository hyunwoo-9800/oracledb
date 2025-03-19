-- inner join
SELECT
    EMP.EMPLOYEE_ID,
    EMP.FIRST_NAME,
    EMP.LAST_NAME,
    EMP.EMAIL,
    EMP.PHONE_NUMBER,
    EMP.HIRE_DATE,
    EMP.JOB_ID,
    EMP.SALARY,
    EMP.COMMISSION_PCT,
    EMP.MANAGER_ID,
    EMP.DEPARTMENT_ID,
    DEP.DEPARTMENT_NAME
FROM
    EMPLOYEES   EMP,
    DEPARTMENTS DEP
WHERE
    EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
ORDER BY
    EMP.EMPLOYEE_ID;

 
-- left join    
SELECT
    EMP.EMPLOYEE_ID,
    EMP.FIRST_NAME,
    EMP.LAST_NAME,
    EMP.EMAIL,
    EMP.PHONE_NUMBER,
    EMP.HIRE_DATE,
    EMP.JOB_ID,
    EMP.SALARY,
    EMP.COMMISSION_PCT,
    EMP.MANAGER_ID,
    EMP.DEPARTMENT_ID,
    DEP.DEPARTMENT_NAME
FROM
    EMPLOYEES   EMP,
    DEPARTMENTS DEP
WHERE
    EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID(+)
ORDER BY
    EMP.EMPLOYEE_ID;
    
    
-- 부서가 100인 사원의 이름과 부서 이름
SELECT
    EMP.FIRST_NAME || ' ' || EMP.LAST_NAME AS NAME,
    DEP.DEPARTMENT_NAME
FROM
    EMPLOYEES   EMP
    LEFT JOIN DEPARTMENTS DEP
		ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
WHERE
    EMP.DEPARTMENT_ID = '100';

    
-- 급여가 10000이하인 사원의 사번 급여 부서이름 / 사번으로 정렬    
SELECT
    EMP.EMPLOYEE_ID,
    EMP.SALARY,
    DEP.DEPARTMENT_NAME
FROM
    EMPLOYEES   EMP
    LEFT JOIN DEPARTMENTS DEP
		ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
WHERE
    EMP.SALARY <= 10000
ORDER BY
    EMPLOYEE_ID;
    
    
-- 국가별 대륙 정보
SELECT
    CUN.COUNTRY_ID,
    CUN.COUNTRY_NAME,
    RG.REGION_ID,
    RG.REGION_NAME
FROM 
    COUNTRIES CUN
    LEFT JOIN REGIONS RG
		ON CUN.REGION_ID = RG.REGION_ID;


-- 사원의 사번, 급여, 직종, 이름, 해당 직종의 최소 급여, 최대 급여
SELECT
    EMP.EMPLOYEE_ID,
    EMP.SALARY,
    EMP.JOB_ID,
    JB.JOB_TITLE,
    JB.MIN_SALARY AS "최소 급여",
    JB.MAX_SALARY AS "최대 급여"
FROM
    EMPLOYEES   EMP
    LEFT JOIN JOBS JB
		ON EMP.JOB_ID = JB.JOB_ID
ORDER BY
    EMP.JOB_ID;

    
-- self join
SELECT
    EMP.EMPLOYEE_ID,
    EMP.FIRST_NAME || ' ' || EMP.LAST_NAME AS "JUNIOR NAME",
    EMP.MANAGER_ID,
--    EMP2.EMPLOYEE_ID,
    EMP2.FIRST_NAME || ' ' || EMP2.LAST_NAME AS "MGR NAME"
FROM 
    EMPLOYEES EMP
    LEFT JOIN EMPLOYEES EMP2
		ON EMP2.MANAGER_ID = EMP.MANAGER_ID
ORDER BY
    EMP.EMPLOYEE_ID;
    
    
-- 사원에 부서명을 출력, 부서가 없는 사원은 대기중으로 출력
SELECT
    EMP.*,
    NVL(DEP.DEPARTMENT_NAME, '대기중') AS DEPARTMENT_NAME
FROM
    EMPLOYEES   EMP
    LEFT JOIN DEPARTMENTS DEP
		ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
ORDER BY
    EMPLOYEE_ID;    
    

-- sub query   
SELECT
    *
FROM
    LOCATIONS
WHERE
    COUNTRY_ID IN (
					SELECT
						COUNTRY_ID
					FROM
						COUNTRIES
					WHERE
						REGION_ID = 2
				   );
    
    
SELECT
    *
FROM
    LOCATIONS L1,
    (
        SELECT
            COUNTRY_ID,
            COUNTRY_NAME
        FROM
            COUNTRIES 
        WHERE
            REGION_ID = 2
    ) SUB1
WHERE 
    L1.COUNTRY_ID =  SUB1.COUNTRY_ID;
    
    
-- Asia 대륙에 있는 모든 부서, 도시 이름 조회
SELECT
    *
FROM
    DEPARTMENTS
WHERE
    LOCATION_ID IN (
        SELECT
            LOCATION_ID
        FROM
            LOCATIONS
        WHERE
            COUNTRY_ID IN (
                SELECT
                    COUNTRY_ID
                FROM
                    COUNTRIES
                WHERE
                    REGION_ID IN (
                        SELECT
                            REGION_ID
                        FROM
                            REGIONS
                        WHERE
                           REGION_NAME = 'Asia')));

SELECT
    *
FROM
    DEPARTMENTS A
    LEFT JOIN LOCATIONS   B
        ON A.LOCATION_ID = B.LOCATION_ID
    LEFT JOIN COUNTRIES   C
        ON B.COUNTRY_ID = C.COUNTRY_ID
    LEFT JOIN REGIONS     D
        ON C.REGION_ID = D.REGION_ID
WHERE
    D.REGION_NAME = 'Asia';
    

-- 지역 아이디가 1700인 부서에서 일하는 사원 정보
SELECT
    EMP.EMPLOYEE_ID,
    EMP.FIRST_NAME || ' ' || EMP.LAST_NAME as name,
    EMP.EMAIL,
    EMP.PHONE_NUMBER,
    EMP.HIRE_DATE,
    EMP.JOB_ID,
    EMP.SALARY,
    EMP.COMMISSION_PCT,
    EMP.MANAGER_ID,
    EMP.DEPARTMENT_ID
FROM
    EMPLOYEES EMP
WHERE
    EMP.DEPARTMENT_ID IN (
							SELECT
								DEPARTMENT_ID
							FROM
								DEPARTMENTS
							WHERE
								LOCATION_ID = '1700'
						 )
ORDER BY
    EMPLOYEE_ID;

SELECT
    *
FROM
    EMPLOYEES   EMP
    LEFT JOIN DEPARTMENTS DEP
    ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
WHERE
    DEP.LOCATION_ID = '1700'
ORDER BY
    EMPLOYEE_ID;

-- 최대 급여를 받는 사원정보
SELECT
    EMP.EMPLOYEE_ID,
    EMP.FIRST_NAME || ' ' || EMP.LAST_NAME AS NAME,
    EMP.EMAIL,
    EMP.PHONE_NUMBER,
    EMP.HIRE_DATE,
    EMP.JOB_ID,
    EMP.SALARY,
    EMP.COMMISSION_PCT,
    EMP.MANAGER_ID,
    EMP.DEPARTMENT_ID
FROM
    EMPLOYEES EMP
WHERE
    SALARY IN (
				SELECT
					MAX(SALARY)
				FROM
					EMPLOYEES
			  )
ORDER BY
    EMP.EMPLOYEE_ID;


    
-- 평균 급여보다 급여를 더 많이 받는 사원
SELECT
    EMP.EMPLOYEE_ID,
    EMP.FIRST_NAME || ' ' || LAST_NAME as name,
    EMP.EMAIL,
    EMP.PHONE_NUMBER,
    EMP.HIRE_DATE,
    EMP.JOB_ID,
    EMP.SALARY,
    EMP.COMMISSION_PCT,
    EMP.MANAGER_ID
FROM
    EMPLOYEES EMP
WHERE
    EMP.SALARY >
				(
					SELECT
						AVG(SALARY)
					FROM
						EMPLOYEES
				)
ORDER BY
    SALARY;
    
    
    
-- exists
-- 특정 쿼리문을 실행한 결과가 있으면 실행, 아니면 실행 x
SELECT
    *
FROM
    EMPLOYEES
WHERE
    EXISTS
    (
        SELECT
            *
        FROM
            DEPARTMENTS
        WHERE
            DEPARTMENT_ID = 10
    );
    

-- 10부서가 존재하면 20번 부서의 사원의 정보 조회
SELECT
    *
FROM
    EMPLOYEES
WHERE
    EXISTS
    (
        SELECT
            *
        FROM
            EMPLOYEES
        WHERE
            DEPARTMENT_ID = 10
    )
    AND DEPARTMENT_ID = 20;
    
    
-- 사원이 존재하는 부서 정보만 조회
SELECT
    *
FROM
    DEPARTMENTS DEP
WHERE
    EXISTS
    (
        SELECT
            *
        FROM
            EMPLOYEES EMP
        WHERE
            EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID
    )
ORDER BY
    DEP.DEPARTMENT_ID;
    
    
-- any, some, all
-- any, some 여러 비교 대상 중 하나 이상이 일치하면 결과를 조회
-- all 여러 비교 대상 중 모두가 일치하면 결과를 조회

-- 부서가 50인 사원들 모두 보다 급여를 더 받는 사원 정보 조회
SELECT
    *
FROM
    EMPLOYEES EMP
WHERE
    EMP.SALARY > ALL
                (
                    SELECT
                        SALARY
                    FROM
                        EMPLOYEES
                        
                    WHERE
                        DEPARTMENT_ID = 50
                )
ORDER BY
    SALARY;
    
SELECT
    *
FROM
    EMPLOYEES EMP
WHERE
    EMP.SALARY > 
                (
                    SELECT
                        MAX(SALARY)
                    FROM
                        EMPLOYEES
                        
                    WHERE
                        DEPARTMENT_ID = 50
                )
ORDER BY
    SALARY;    