-- 2000년에 입사해서 최고임금이 10000이 넘는 직종에서 일하고 있는 사원을 조회
-- 연도 지정이 1999년 이후의 연도로 지정하였음
SELECT
    A.EMPLOYEE_ID,
    A.FIRST_NAME,
    A.LAST_NAME,
    A.HIRE_DATE, 
    B.JOB_TITLE,
    B.MIN_SALARY,
    B.MAX_SALARY
FROM
    EMPLOYEES A
     LEFT JOIN JOBS B
        ON A.JOB_ID = B.JOB_ID
WHERE
    TO_CHAR(A.HIRE_DATE, 'YYYY') = '2000'
    AND B.MAX_SALARY > 10000;
    
    
select  first_name,job_id,salary, hire_date 
from employees 
where to_char(hire_date,'yyyy') = 2000 
and job_id in ( select job_id from jobs where max_salary > 10000);		


-- 매니저의 이름이 MICHAEL인 부서를 조회
-- 조인 조건과 where절이 잘못 지정되었음
SELECT
    B.*
FROM
    DEPARTMENTS   A
     LEFT JOIN EMPLOYEES B
        ON A.MANAGER_ID = B.EMPLOYEE_ID
WHERE
    UPPER(B.FIRST_NAME) LIKE '%MICHAEL%';
	
select * from departments where manager_id in 
(select employee_id 
from employees where  upper(first_name) like '%MICHAEL%');


-- 직종의 최저임금이 사번 105번 사원의 임금보다 적은 직종를 조회
-- 조인 조건 부정확, 조인시 중복 데이터 출력
SELECT
DISTINCT A.*     
FROM
    JOBS A
    LEFT JOIN EMPLOYEES B
        ON A.JOB_ID = B.JOB_ID        
WHERE
    A.MIN_SALARY < (
        SELECT
            SALARY
        FROM
            EMPLOYEES
        WHERE
            EMPLOYEE_ID = 105
    );
	
select * from jobs where min_salary < 
(select salary from employees where employee_id = 105);


-- 메일주소에 밑줄표시가 있는 사원을 조회
SELECT
    *
FROM
    EMPLOYEES
WHERE
    INSTR(EMAIL, '_') > 0;

select * from employees where email like '%\_%' ESCAPE '\';



-- 사원 이름과 해당 사원의 매니저 이름을 조회
-- left가 아니라 inner 조인을 썻어야 함
SELECT
    A.FIRST_NAME || ' ' || A.LAST_NAME AS "EMPLOYEE",
    B.FIRST_NAME || ' ' || B.LAST_NAME AS "MANAGER"
FROM
    EMPLOYEES A
     JOIN EMPLOYEES B
        ON A.MANAGER_ID = B.EMPLOYEE_ID
ORDER BY
    B.EMPLOYEE_ID;
		
select e1.first_name Employee, e2.first_name Manager 
from employees e1, employees e2 where  e1.manager_id  = e2.employee_id
ORDER BY
    e2.EMPLOYEE_ID;


-- 30번 부서에 입사한 사원의 수를 연도별로 조회
-- join이 필요 없었음
SELECT
    TO_CHAR(HIRE_DATE, 'YYYY'),
    COUNT(*)
FROM
    EMPLOYEES
WHERE
    DEPARTMENT_ID = 30
GROUP BY
    TO_CHAR(HIRE_DATE, 'YYYY')
ORDER BY
    TO_CHAR(HIRE_DATE, 'YYYY');
	
select to_char(hire_date,'yyyy') , count(*) from employees 
where department_id = 30 group by to_char(hire_date,'yyyy');


-- 각 부서의 직종별로 사원들의 총 급여합을 구해보자
-- DEPARTMENT_ID가 없었고, jobs를 조인할 이유가 없었음
SELECT
    B.DEPARTMENT_ID AS "부서",
    C.JOB_ID          AS "직종",
    SUM(SALARY)       AS "급여합"
FROM
    EMPLOYEES A
     LEFT JOIN DEPARTMENTS B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
     LEFT JOIN JOBS C
        ON A.JOB_ID = C.JOB_ID
GROUP BY
    B.DEPARTMENT_ID,
    C.JOB_ID
ORDER BY
    B.DEPARTMENT_ID,
    C.JOB_ID;

select department_id department, job_id job, sum(salary) TotalSalary 
from employees group by department_id, job_id 
order by department_id, job_id;


-- 업무별 최저임금과 최고임금 사이의 급여을 가지는 사원의 이름과 업무명을 조회
SELECT
    A.FIRST_NAME || ' ' || A.LAST_NAME AS "이름",
    B.JOB_TITLE    AS "업무명"
FROM
    EMPLOYEES A
     LEFT JOIN JOBS B
        ON A.JOB_ID = B.JOB_ID
WHERE
        B.MIN_SALARY >= A.SALARY
    AND A.SALARY <= B.MAX_SALARY;

select first_name, job_title from employees e, jobs j 
where salary between min_salary and max_salary order by first_name;


-- 커미션을 받은 사원과 받지 않은 사원이 각각 몇명인지 조회
SELECT
    COUNT(CASE WHEN COMMISSION_PCT IS NOT NULL THEN 'a' END) AS "커미션을 받는 사원",
    COUNT(CASE WHEN COMMISSION_PCT IS NULL THEN 'b' END) AS "커미션을 받지 않는 사원"
FROM
    EMPLOYEES;

select count(commission_pct) NoEmployeesWithCommission, 
count(*) - count(commission_pct) NoEmployeesWithoutCommssion 
from employees;


-- 2월 28일에 입사한 사원의 이름, 업무명, 부서명을 조회
-- 해당일에 입사한 사원이 없어서 2월달로 설정
-- job histoy까지 조인할 필요가 없었음
SELECT
    A.FIRST_NAME || ' ' || A.LAST_NAME AS "이름",
    B.JOB_TITLE,
    C.DEPARTMENT_NAME
FROM
    EMPLOYEES A
      JOIN JOBS B
        ON A.JOB_ID = B.JOB_ID
      JOIN DEPARTMENTS C
        ON A.DEPARTMENT_ID = C.DEPARTMENT_ID
WHERE
    TO_CHAR(A.HIRE_DATE) LIKE '_____02%';
	
select first_name || ' ' || LAST_NAME , job_title, department_name 
from employees e, jobs j, departments d 
where e.job_id = j.job_id and e.department_id = d.department_id 
and to_char(hire_date,'mm') = '02';	
	

-- 최저임금이 10000보다 높은 업무의 세부사항을 조회
-- 조인이 필요없음
SELECT
    *
FROM
    JOBS A
WHERE
    A.MIN_SALARY > 10000;
	
	
SELECT * FROM JOBS WHERE MIN_SALARY > 10000;

	

--  2002년~2005년 사이에 입사한 사원의 이름과 입사일을 조회
-- 날짜형식 지정을 제대로 안해줌
SELECT
    *
FROM
    EMPLOYEES
WHERE
    TO_CHAR(HIRE_DATE, 'YYYY') BETWEEN '2002' AND '2005'
ORDER BY
    HIRE_DATE;

SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES 
WHERE TO_CHAR(HIRE_DATE, 'YYYY') BETWEEN 2002 AND 2005 ORDER BY HIRE_DATE;


--  IT Programmer이거나 Sales Man인 사원의 이름과 입사일을 조회
SELECT
    A.FIRST_NAME || ' ' || A.LAST_NAME AS "이름",
    A.HIRE_DATE
FROM
    EMPLOYEES A
     LEFT JOIN JOBS C
        ON A.JOB_ID = C.JOB_ID
WHERE
    C.JOB_ID LIKE 'IT%PROG'
    OR C.JOB_ID LIKE 'SA%MAN';
	
SELECT FIRST_NAME, HIRE_DATE 
FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG', 'SA_MAN');
	

-- 2008년 1월 1일 이후에 입사한 사원을 조회
SELECT
    *
FROM
    EMPLOYEES
WHERE
    HIRE_DATE > '2008/01/01'
ORDER BY
    EMPLOYEE_ID;
	
SELECT * FROM EMPLOYEES where  HIRE_DATE >
to_date('01-jan-2008','DD-MON-RR','NLS_DATE_LANGUAGE=AMERICAN')
ORDER BY
    EMPLOYEE_ID;
	

-- 사번이 150,160번인 사원을 조회
SELECT
    *
FROM
    EMPLOYEES
WHERE
    EMPLOYEE_ID = 150
    OR EMPLOYEE_ID = 160;

SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID in (150,160);


-- 임금이 10000보다 적은 사원의 이름, 임금, 커미션, 입사일을 조회
SELECT
    FIRST_NAME || ' ' || LAST_NAME AS "이름",
    HIRE_DATE,
    SALARY,
    COMMISSION_PCT
FROM
    EMPLOYEES
WHERE
    SALARY < 10000;

SELECT FIRST_NAME, SALARY, COMMISSION_PCT, HIRE_DATE 
FROM EMPLOYEES WHERE SALARY < 10000;


-- 최고 임금이 10000~20000인 업무의 업무명, 최저임금과 최고임금의 차액을 조회
SELECT
    JOB_TITLE,
    ABS(MIN_SALARY - MAX_SALARY) AS "최저임금 - 최고금액"
FROM
    JOBS
WHERE
    MAX_SALARY BETWEEN 10000 AND 20000;

SELECT JOB_TITLE, MAX_SALARY-MIN_SALARY DIFFERENCE FROM JOBS WHERE MAX_SALARY 
BETWEEN 10000 AND 20000;



-- 사원 이름과 임금을 출력하되 임금을 1000단위로 조회
-- ROUND를 사용하지 않았음
SELECT
    FIRST_NAME || ' ' || LAST_NAME AS "이름",
    TO_CHAR(SALARY, 'FM999,999,999'),
    ROUND(SALARY, -3)
FROM
    EMPLOYEES;

SELECT FIRST_NAME, SALARY, ROUND(SALARY, -3) FROM EMPLOYEES;


-- 업무명을 기준으로 하여 내림차순으로 업무 세부사항을 조회
-- 세부사항이 JOB_HISTORY를 의미하는게 아니었음 > JOB_HISTORY와의 조인 불필요
SELECT
    *
FROM JOBS 
ORDER BY
    JOB_TITLE DESC;

SELECT * FROM JOBS ORDER BY JOB_TITLE desc;


--  성이나 이름이 S로 시작하는 사원을 조회
SELECT
    *
FROM
    EMPLOYEES
WHERE
    FIRST_NAME LIKE 'S%'
    OR LAST_NAME LIKE 'S%';


SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE FIRST_NAME LIKE 'S%' OR 
LAST_NAME LIKE 'S%';


-- 5월에 입사한 사원을 조회
SELECT
    *
FROM
    EMPLOYEES
WHERE
    TO_CHAR(HIRE_DATE) LIKE '_____05%';

SELECT * FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE, 'MON')= 'MAY';


-- 커미션을 받지 않고, 임금이 5000~10000이면서 30번 부서에 소속된 사원을 조회
-- EMPLOYEES에 부서 번호가 있어서 DEPARTMENTS와의 조인이 불필요
SELECT
    *
FROM
    EMPLOYEES
WHERE
    COMMISSION_PCT IS NULL
    AND SALARY BETWEEN 5000 AND 10000 
    AND DEPARTMENT_ID = 30;

SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL AND SALARY BETWEEN 5000 
AND 10000 AND DEPARTMENT_ID=30;


-- 사원들의 이름과 첫 월급날을 조회 매월 1일이 월급 날이다
-- 월급날을 해당 달의 첫날짜로 착각
SELECT
    FIRST_NAME || ' ' || LAST_NAME AS "이름",
    LAST_DAY(HIRE_DATE) + 1 AS "첫 월급날"
FROM
    EMPLOYEES;

SELECT FIRST_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)+1 FROM EMPLOYEES;


-- 사원의 이름과 근속연수를 조회
SELECT
    FIRST_NAME || ' ' || LAST_NAME AS "이름",
    TO_CHAR(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12)) || '년 ' ||
    TO_CHAR(TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12, 1) * 12))|| '월'
    AS "근속연수"
FROM
    EMPLOYEES;

SELECT FIRST_NAME, HIRE_DATE, FLOOR((SYSDATE-HIRE_DATE)/365)FROM EMPLOYEES;


-- 2001년에 입사한 사원의 이름을 조회
SELECT
    FIRST_NAME || ' ' || LAST_NAME AS "이름"
FROM
    EMPLOYEES
WHERE
    TO_CHAR(HIRE_DATE) LIKE '2001%';

SELECT FIRST_NAME, HIRE_DATE FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE, 'YYYY')=2001;


-- 첫 글자는 대문자로, 나머지 글자는 소문자로 변환하여 성과 이름을 조회, initcap 사용
SELECT
    INITCAP(FIRST_NAME) AS "성",
    INITCAP(LAST_NAME)  AS "이름"
FROM
    EMPLOYEES;

SELECT INITCAP(FIRST_NAME), INITCAP(LAST_NAME) FROM EMPLOYEES;


-- 업무명의 첫 단어를 조회
-- 첫 글자로 조회 했음
SELECT
    SUBSTR(JOB_TITLE, 1, INSTR(JOB_TITLE || ' ', ' ') -1) AS "업무명 첫 단어",
    job_title
FROM
    JOBS;


SELECT JOB_TITLE, SUBSTR( JOB_TITLE, 1, INSTR(JOB_TITLE || ' ', ' ')-1 ) FROM JOBS; 


-- 성의 3번째 문자 이후에 'b'가 포함된 사원의 이름의 길이를 조회
-- 전체적으로 잘못 만듬
SELECT
    FIRST_NAME || LAST_NAME AS "이름"
FROM
    EMPLOYEES
WHERE
    INSTR(LAST_NAME,'B') > 3;

SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE INSTR(LAST_NAME,'B') > 3;


-- 이름과 이메일주소가 대소문자 상관없이 같은 사원의 이름을 대문자로, 이메일주소는 소문자로 조회
-- where절 upper 안씀
SELECT
    UPPER(LAST_NAME),
    LOWER(EMAIL)
FROM
    EMPLOYEES
WHERE
    UPPER(LAST_NAME) = UPPER(EMAIL);

SELECT UPPER(FIRST_NAME), LOWER(EMAIL)
FROM EMPLOYEES
WHERE UPPER(FIRST_NAME)=UPPER(EMAIL); 


-- 올해 입사한 사원을 조회
SELECT
    *
FROM
    EMPLOYEES
WHERE
    TO_CHAR(HIRE_DATE, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY');


SELECT * FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'YYYY')=TO_CHAR(SYSDATE, 'YYYY'); 


-- 현재 날짜와 2011년 1월 1일이 며칠 차이인지 조회
SELECT
    TO_DATE(TO_CHAR(SYSDATE, 'YYYY-mm-DD')) - TO_DATE('2011-01-01', 'YYYY-mm-DD')
FROM
    DUAL;

SELECT SYSDATE -  to_date('01-jan-2011','DD-MON-RR','NLS_DATE_LANGUAGE=AMERICAN')
from dual;


-- 올해 각 달마다 몇 명의 사원이 입사하였는지 조회
-- 문자형의 형식이 잘못되었음
SELECT
    TO_CHAR(HIRE_DATE, 'mm'),
    COUNT(*) AS "입사한 사원 수"
FROM
    EMPLOYEES
WHERE
    TO_CHAR(HIRE_DATE, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY')
GROUP BY
    TO_CHAR(HIRE_DATE, 'mm');

SELECT
    TO_CHAR(HIRE_DATE,'MM'),
    COUNT (*)
FROM
    EMPLOYEES 
WHERE TO_CHAR(HIRE_DATE,'YYYY')= TO_CHAR(SYSDATE,'YYYY') 
GROUP BY TO_CHAR(HIRE_DATE,'MM');


-- 매니저 사번과 그 매니저가 총 몇명을 관리하는지 조회
SELECT
    A.MANAGER_ID,
    COUNT(A.MANAGER_ID)
FROM
    EMPLOYEES A
     LEFT JOIN EMPLOYEES B
        ON A.MANAGER_ID = B.EMPLOYEE_ID
GROUP BY
    A.MANAGER_ID;

SELECT MANAGER_ID, COUNT(*) FROM EMPLOYEES GROUP BY MANAGER_ID;


-- 사원 사번과 이전 업무를 종료한 날을 조회
-- EMPLOYEES가 필요 없음 > 조인 불필요
SELECT
    EMPLOYEE_ID,
    MAX(END_DATE)
FROM
    JOB_HISTORY
GROUP BY
    EMPLOYEE_ID
;


SELECT EMPLOYEE_ID, MAX(END_DATE) FROM JOB_HISTORY GROUP BY EMPLOYEE_ID;


-- 입사일이 n월 '15일' 이후인(몇월이든 월말에 입사한) 사원의 수를 조회
SELECT
    COUNT(*) AS "월말 입사 사원 수"
FROM
    EMPLOYEES
WHERE
    TO_CHAR(HIRE_DATE, 'dd') > 15;

SELECT COUNT(*) FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'DD') > 15;


-- 국가번호와 해당 국가에 있는 도시들의 개수를 조회
-- COUNTRIES가 필요없음 > 조인 불필요
SELECT
    COUNTRY_ID,
    COUNT(*) AS "도시 개수"
FROM
    LOCATIONS 
GROUP BY
    COUNTRY_ID;

SELECT COUNTRY_ID, COUNT(*) FROM LOCATIONS GROUP BY COUNTRY_ID;


-- 각 부서별로 커미션을 받은 사원들의 평균임금을 조회
-- DEPARTMENTS가 필요없음 > 조인 불필요
SELECT
    DEPARTMENT_ID AS "부서",
    AVG(SALARY)     AS "평균임금"
FROM
    EMPLOYEES
WHERE
    COMMISSION_PCT IS NOT NULL
GROUP BY
    DEPARTMENT_ID;

SELECT DEPARTMENT_ID, AVG(SALARY) FROM EMPLOYEES 
WHERE COMMISSION_PCT IS NOT NULL GROUP BY DEPARTMENT_ID;


-- 업무별로 업무명, 사원의 수, 임금의 합, 최고임금과 최저임금의 차액을 조회
-- 불필요한 조인절
SELECT
    JOB_ID,
    COUNT(*)                         "사원의 수",
    SUM(SALARY)                    AS "입금의 합",
    ABS(MAX(SALARY) - MIN(SALARY))   AS "차액"
FROM
    EMPLOYEES
GROUP BY
    JOB_ID;


SELECT JOB_ID, COUNT(*), SUM(SALARY), MAX(SALARY)-MIN(SALARY) SALARY FROM 
EMPLOYEES GROUP BY JOB_ID;

-- 평균임금이 10000을 넘는 업무의 업무ID와 평균임금을 조회
SELECT
    JOB_ID,
    AVG(SALARY)
FROM
    EMPLOYEES
GROUP BY
    JOB_ID
HAVING
    AVG(SALARY) > 10000;


SELECT JOB_ID, AVG(SALARY) FROM EMPLOYEES 
GROUP BY JOB_ID HAVING AVG(SALARY)>10000;

-- 10명이 넘는 사원이 입사한 연도를 조회
SELECT
    TO_CHAR(HIRE_DATE, 'YYYY') AS "입사년도"
FROM
    EMPLOYEES
GROUP BY
    TO_CHAR(HIRE_DATE, 'YYYY')
HAVING
    COUNT(TO_CHAR(HIRE_DATE, 'YYYY')) > 10;


SELECT TO_CHAR(HIRE_DATE,'YYYY') FROM EMPLOYEES 
GROUP BY TO_CHAR(HIRE_DATE,'YYYY') HAVING COUNT(EMPLOYEE_ID) > 10;

-- 커미션을 받은 사원이 5명 이상인 부서를 조회
-- 불필요한 조인절
SELECT
    DEPARTMENT_ID
FROM
    EMPLOYEES
WHERE
    COMMISSION_PCT IS NOT NULL 
GROUP BY
    DEPARTMENT_ID
HAVING
    COUNT(COMMISSION_PCT) > 5;


SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL 
GROUP BY DEPARTMENT_ID HAVING COUNT(COMMISSION_PCT)>5;


-- 과거에 하나가 넘는(하나 이상 말고 초과)의 업무를 하였던 사원의 사번을 조회
-- 불필요한 조인절
SELECT
    EMPLOYEE_ID
FROM
    JOB_HISTORY
GROUP BY
    EMPLOYEE_ID
HAVING
    COUNT(*) > 1;

SELECT EMPLOYEE_ID FROM JOB_HISTORY GROUP BY EMPLOYEE_ID HAVING COUNT(*) > 1;


-- 3명이 넘는 사원이 100일이 넘게 근무한 업무ID를 조회
-- 불필요한 조인절
SELECT
    JOB_ID
FROM
    JOB_HISTORY
WHERE
    TO_DATE(TO_CHAR(END_DATE, 'YYYY-mm-dd'))
    - TO_DATE(TO_CHAR(START_DATE, 'YYYY-mm-dd')) > 100
GROUP BY
    JOB_ID
HAVING
    COUNT(*) > 3;

SELECT JOB_ID FROM JOB_HISTORY WHERE END_DATE-START_DATE > 100 
GROUP BY JOB_ID HAVING COUNT(*)>3;


-- 부서 번호, 연도, 연도별 입사한 사원의 수를 조인하여 조회
-- 불필요한 조인절
SELECT
    DEPARTMENT_ID,
    TO_CHAR(HIRE_DATE, 'YYYY')        AS "입사년도",
    COUNT(TO_CHAR(HIRE_DATE, 'YYYY')) AS "사원 수"
FROM
    EMPLOYEES
GROUP BY
    DEPARTMENT_ID,
    TO_CHAR(HIRE_DATE, 'YYYY')
ORDER BY
    DEPARTMENT_ID;

SELECT DEPARTMENT_ID, TO_CHAR(HIRE_DATE,'YYYY'), COUNT(EMPLOYEE_ID) FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID, TO_CHAR(HIRE_DATE, 'YYYY') ORDER BY DEPARTMENT_ID;


-- 임의의 매니저가 5명 이상의 사원을 관리하고 있는 부서를 조회
-- 불필요한 조인절
SELECT
    DISTINCT
    DEPARTMENT_ID
FROM
    EMPLOYEES
GROUP BY
    DEPARTMENT_ID,
    MANAGER_ID
HAVING
    COUNT(EMPLOYEE_ID) > 5;
	
	
SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID, MANAGER_ID HAVING COUNT(EMPLOYEE_ID) > 5;	
	

-- 사번 115번 사원의 현재 임금이 6000미만일 경우 8000으로 변경하시오
SELECT
    SALARY
FROM
    EMPLOYEES
WHERE
    EMPLOYEE_ID = 115;

UPDATE EMPLOYEES
SET
    SALARY = 8000
WHERE
    EXISTS (
        SELECT
            SALARY
        FROM
            EMPLOYEES
        WHERE
                SALARY < 6000
            AND EMPLOYEE_ID = 115
    )
    AND EMPLOYEE_ID = 115;


UPDATE EMPLOYEES SET SALARY = 8000 WHERE EMPLOYEE_ID = 115 AND SALARY < 6000;

ROLLBACK;

-- 20번 부서를 삭제
SELECT
    *
FROM
    DEPARTMENTS
WHERE
    DEPARTMENT_ID = 20;

-- ORA-02292: 무결성 제약조건(HR.EMP_DEPT_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
--delete from departments where department_id = 20;

ROLLBACK;

DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID=20;

-- 사번 110번 사원이 10번 부서에 속해있고
-- 현재 업무ID가 IT로 시작하지 않으면 해당 사원의 업무ID를 'IT_PROG'로 변경
-- 누락
UPDATE
    EMPLOYEES
SET JOB_ID = 'IT_PROG' 
WHERE
    EMPLOYEE_ID = 110
    AND DEPARTMENT_ID = 10
    AND NOT JOB_ID LIKE 'IT%';

-- 부서 테이블에 매니저ID가 120이고 장소ID는 도쿄 시의 임의의 장소로 하는 행을 추가
SELECT
    *
FROM
    DEPARTMENTS;

INSERT INTO DEPARTMENTS VALUES ( 00,
                                 'TEST_DEP',
                                 120,
                                 (
                                     SELECT
                                         LOCATION_ID
                                     FROM
                                         LOCATIONS
                                     WHERE
                                         CITY = 'Tokyo'
                                 ) );

ROLLBACK;

-- 150부서가 이미 존재
INSERT INTO DEPARTMENTS VALUES (150,'SPORTS',120,1200);

-- 부서 이름과 해당 부서의 사원들 수를 조회
-- inner join을 안씀
SELECT
    B.DEPARTMENT_NAME        AS "부서명",
    COUNT(B.DEPARTMENT_NAME) AS "사원수"
FROM
    EMPLOYEES   A
     JOIN DEPARTMENTS B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
GROUP BY
    B.DEPARTMENT_NAME;
	
SELECT DEPARTMENT_NAME, COUNT(*) FROM EMPLOYEES JOIN DEPARTMENTS USING 
(DEPARTMENT_ID) GROUP BY DEPARTMENT_NAME;	
	

-- 업무기록에서 30번 부서의 모든 업무에 대하여 업무명, 사번, 시작일과 종료일 간 근무일수를 조회
-- 전체적으로 잘못 씀
SELECT
    EMPLOYEE_ID,
    JOB_TITLE,
    END_DATE - START_DATE AS "근무일수" 
FROM
    JOB_HISTORY
     NATURAL JOIN JOBS
WHERE DEPARTMENT_ID = 30;


-- 부서명과 매니저 이름을 조회
-- 조인 조건절 잘못
SELECT
    A.DEPARTMENT_NAME,
    B.FIRST_NAME || ' ' || B.LAST_NAME AS "이름"
FROM
    DEPARTMENTS A
     JOIN EMPLOYEES B
        ON A.MANAGER_ID = B.EMPLOYEE_ID;

SELECT DEPARTMENT_NAME, FIRST_NAME FROM DEPARTMENTS D JOIN EMPLOYEES E ON 
(D.MANAGER_ID=E.EMPLOYEE_ID);

-- 부서명과 매니저 이름, 도시를 조회
-- 잘못된 조인절
SELECT
    A.DEPARTMENT_NAME,
    B.FIRST_NAME || ' ' || B.LAST_NAME AS "이름",
    C.CITY
FROM
    DEPARTMENTS A
     JOIN EMPLOYEES B
        ON A.MANAGER_ID = B.EMPLOYEE_ID
     JOIN LOCATIONS C
        ON A.LOCATION_ID = C.LOCATION_ID;

SELECT DEPARTMENT_NAME, FIRST_NAME, CITY FROM DEPARTMENTS D JOIN EMPLOYEES E ON 
(D.MANAGER_ID=E.EMPLOYEE_ID) JOIN LOCATIONS L USING (LOCATION_ID);

-- 국가명, 도시, 부서명을 조회
-- 잘못된 조인절
SELECT
    A.COUNTRY_NAME,
    B.CITY,
    C.DEPARTMENT_NAME
FROM
    COUNTRIES A
     JOIN LOCATIONS B
        ON A.COUNTRY_ID = B.COUNTRY_ID
     JOIN DEPARTMENTS C
        ON B.LOCATION_ID = C.LOCATION_ID;

SELECT COUNTRY_NAME, CITY, DEPARTMENT_NAME 
FROM COUNTRIES JOIN LOCATIONS USING (COUNTRY_ID) 
JOIN DEPARTMENTS USING (LOCATION_ID);


-- 2000~2005년 사이의 모든 업무에 대하여 업무명, 부서명, 사원의 성, 업무시작일을 조회
-- 조건절과 where절 잘못적음
SELECT
    B.JOB_TITLE,
    C.DEPARTMENT_NAME,
    D.FIRST_NAME,
    A.START_DATE
FROM
    JOB_HISTORY A
     JOIN JOBS B
        ON A.JOB_ID = B.JOB_ID
     JOIN DEPARTMENTS C
        ON A.DEPARTMENT_ID = C.DEPARTMENT_ID
     JOIN EMPLOYEES D
        ON A.EMPLOYEE_ID = D.EMPLOYEE_ID
WHERE
    TO_CHAR(A.START_DATE, 'YYYY') BETWEEN '2000' AND '2005';


SELECT JOB_TITLE, DEPARTMENT_NAME, LAST_NAME, START_DATE 
FROM JOB_HISTORY JOIN JOBS USING (JOB_ID) JOIN DEPARTMENTS 
USING (DEPARTMENT_ID) JOIN EMPLOYEES USING (EMPLOYEE_ID) 
WHERE TO_CHAR(START_DATE,'YYYY') BETWEEN 2000 AND 2005;

-- 현재 임금이 15000 이상인 사원이 지금까지 수행했던 업무들을 조회
-- 잘못된 조인절
SELECT
    A.*
FROM
    JOB_HISTORY A 
     LEFT JOIN EMPLOYEES B
        ON A.EMPLOYEE_ID = B.EMPLOYEE_ID
WHERE
    B.SALARY >= 15000;


SELECT JH.* 
FROM JOB_HISTORY JH JOIN EMPLOYEES E ON (JH.EMPLOYEE_ID = E.EMPLOYEE_ID) 
WHERE SALARY > 15000;

-- 5년 이상 근무한 모든 매니저들의 부서명, 매니저 이름, 매니저의 임금을 조회
-- 조인절과 where절을 잘못 적음
SELECT
    A.DEPARTMENT_NAME,
    B.FIRST_NAME || ' ' || B.LAST_NAME AS "이름",
    B.SALARY
FROM
    DEPARTMENTS A
     JOIN EMPLOYEES B
        ON A.MANAGER_ID = B.MANAGER_ID
WHERE
    (SYSDATE - B.HIRE_DATE) / 365 > 5
ORDER BY
    A.DEPARTMENT_NAME;


SELECT DEPARTMENT_NAME, FIRST_NAME, SALARY 
FROM DEPARTMENTS D JOIN EMPLOYEES E ON (D.MANAGER_ID=E.MANAGER_ID) 
WHERE (SYSDATE-HIRE_DATE) / 365 > 5;


-- 자신의 매니저보다 먼저 입사한 사원 이름을 조회
SELECT
    A.FIRST_NAME || ' ' || A.LAST_NAME AS "이름"
FROM
    EMPLOYEES A
     LEFT JOIN EMPLOYEES B
        ON A.MANAGER_ID = B.EMPLOYEE_ID
WHERE
    A.HIRE_DATE < B.HIRE_DATE
ORDER BY
    A.HIRE_DATE,
    B.HIRE_DATE;

SELECT E1.FIRST_NAME FROM EMPLOYEES E1 JOIN EMPLOYEES E2 ON 
(E1.MANAGER_ID=E2.EMPLOYEE_ID) 
WHERE E1.HIRE_DATE < E2.HIRE_DATE;


-- 사원이 6개월 미만으로 근무한 업무에 대하여 사원 이름, 업무명을 조회
-- 조인절과 조건절 설정이 잘못됨
SELECT
    A.FIRST_NAME || ' ' || A.LAST_NAME AS "이름",
    C.JOB_TITLE
FROM
     EMPLOYEES A
     LEFT JOIN JOB_HISTORY B
        ON A.EMPLOYEE_ID = B.EMPLOYEE_ID
     LEFT JOIN JOBS C
        ON B.JOB_ID = C.JOB_ID
WHERE
    MONTHS_BETWEEN(B.END_DATE, B.START_DATE) < 6;


SELECT FIRST_NAME, JOB_TITLE FROM EMPLOYEES E JOIN JOB_HISTORY JH ON 
(JH.EMPLOYEE_ID = E.EMPLOYEE_ID) 
JOIN JOBS J ON( JH.JOB_ID = J.JOB_ID) WHERE 
MONTHS_BETWEEN(END_DATE,START_DATE) < 6;

-- 최고임금이 10000이 넘는 부서의 세부사항을 조회 
-- 불필요한 조인절과 잘못된 조건절
SELECT
    *
FROM
    DEPARTMENTS
WHERE
    DEPARTMENT_ID IN 
                    ( SELECT
                        DEPARTMENT_ID
                      FROM
                        EMPLOYEES 
                      GROUP BY
                        DEPARTMENT_ID
                      HAVING MAX(SALARY)>10000
                    );

-- 'Smith'에 의해 관리되는 부서의 세부사항을 조회
-- 불필요한 조인절과 잘못 설정된 조건절
SELECT
    *
FROM
    DEPARTMENTS
WHERE
    MANAGER_ID IN 
                    (
                        SELECT
                            EMPLOYEE_ID
                        FROM
                            EMPLOYEES
                        WHERE
                            FIRST_NAME = 'SMITH'
                    );


-- 과거에 다른 어떠한 업무도 수행하지 않은 사원을 조회
-- 불필요한 조건절과 잘못 설정된 조건절
SELECT
    *
FROM
    EMPLOYEES
WHERE
    EMPLOYEE_ID NOT IN 
                        (
                            SELECT
                                EMPLOYEE_ID
                            FROM
                                JOB_HISTORY
                        );


-- 과거에 다른 업무를 수행했던 사원들 중에 최고임금이 10000 이상인 사원이 속한 부서의 세부사항을 조회
-- 전체적으로 잘못된 쿼리 
SELECT
    *
FROM
    DEPARTMENTS 
WHERE
    DEPARTMENT_ID IN 
                    (
                        SELECT
                            DEPARTMENT_ID
                        FROM
                            EMPLOYEES 
                        WHERE
                            EMPLOYEE_ID IN (
                                                SELECT
                                                   EMPLOYEE_ID
                                                FROM
                                                 JOB_HISTORY) 
                                                GROUP BY
                                                    DEPARTMENT_ID
                                                HAVING MAX(SALARY) >10000
                                            );
 
    
-- 과거에 IT Programmer로 일했던 사원들의 현재 업무를 조회
-- 전체적으로 잘못된 쿼리문
SELECT
    *
FROM
    JOBS
WHERE
    JOB_ID IN (
                    SELECT
                        JOB_ID
                    FROM
                        EMPLOYEES
                    WHERE
                        EMPLOYEE_ID IN 
                                        (
                                            SELECT
                                                EMPLOYEE_ID
                                            FROM
                                                JOB_HISTORY
                                            WHERE
                                                JOB_ID = 'IT_PROG'
                                        )
                );	