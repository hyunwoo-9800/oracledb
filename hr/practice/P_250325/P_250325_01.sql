-- 2000년에 입사해서 최고임금이 10000이 넘는 직종에서 일하고 있는 사원을 조회
SELECT
    A.*,
    B.*
FROM
    EMPLOYEES A
     LEFT JOIN JOBS B
        ON A.JOB_ID = B.JOB_ID
WHERE
    A.HIRE_DATE > '1999/12/31'
    AND B.MAX_SALARY > 10000;

-- 매니저의 이름이 MICHAEL인 부서를 조회
SELECT
    A.*,
    B.*
FROM
    EMPLOYEES   A
     LEFT JOIN DEPARTMENTS B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHERE
    A.MANAGER_ID IN (
        SELECT
            EMPLOYEE_ID
        FROM
            EMPLOYEES
        WHERE
            FIRST_NAME = 'Michael'
    );

-- 직종의 최저임금이 사번 105번 사원의 임금보다 적은 직종를 조회
SELECT
    *
FROM
    DEPARTMENTS A
    LEFT JOIN EMPLOYEES B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
    LEFT JOIN JOBS C
        ON B.JOB_ID = C.JOB_ID
WHERE
    C.MIN_SALARY < (
        SELECT
            SALARY
        FROM
            EMPLOYEES
        WHERE
            EMPLOYEE_ID = 105
    );

-- 메일주소에 밑줄표시가 있는 사원을 조회
SELECT
    *
FROM
    EMPLOYEES
WHERE
    INSTR(EMAIL, '_') > 0;

-- 사원 이름과 해당 사원의 매니저 이름을 조회
SELECT
    A.*,
    B.FIRST_NAME || ' ' || B.LAST_NAME AS "FULL_NAME"
FROM
    EMPLOYEES A
     LEFT JOIN EMPLOYEES B
        ON A.MANAGER_ID = B.EMPLOYEE_ID;

-- 30번 부서에 입사한 사원의 수를 연도별로 조회
SELECT
    A.EMPLOYEE_ID,
    A.FIRST_NAME,
    A.LAST_NAME,
    A.EMAIL,
    A.PHONE_NUMBER,
    A.HIRE_DATE,
    A.JOB_ID,
    A.SALARY,
    A.COMMISSION_PCT,
    A.MANAGER_ID,
    A.DEPARTMENT_ID,
    COUNT(*)
FROM
    EMPLOYEES A
     LEFT JOIN DEPARTMENTS B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHERE
    B.DEPARTMENT_ID = 30
GROUP BY
    A.EMPLOYEE_ID,
    A.FIRST_NAME,
    A.LAST_NAME,
    A.EMAIL,
    A.PHONE_NUMBER,
    A.HIRE_DATE,
    A.JOB_ID,
    A.SALARY,
    A.COMMISSION_PCT,
    A.MANAGER_ID,
    A.DEPARTMENT_ID
ORDER BY
    A.HIRE_DATE;

-- 각 부서의 직종별로 사원들의 총 급여합을 구해보자
SELECT
    B.DEPARTMENT_NAME AS "부서",
    C.JOB_ID          AS "직종",
    SUM(SALARY)       AS "급여합"
FROM
    EMPLOYEES A
     LEFT JOIN DEPARTMENTS B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
     LEFT JOIN JOBS C
        ON A.JOB_ID = C.JOB_ID
GROUP BY
    B.DEPARTMENT_NAME,
    C.JOB_ID
ORDER BY
    B.DEPARTMENT_NAME,
    C.JOB_ID;

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

-- 커미션을 받은 사원과 받지 않은 사원이 각각 몇명인지 조회
SELECT
    COUNT(CASE WHEN COMMISSION_PCT IS NOT NULL THEN 'a' END) AS "커미션을 받는 사원",
    COUNT(CASE WHEN COMMISSION_PCT IS NULL THEN 'b' END) AS "커미션을 받지 않는 사원"
FROM
    EMPLOYEES;

-- 2월 28일에 입사한 사원의 이름, 업무명, 부서명을 조회
-- 해당일에 입사한 사원이 없어서 2월달로 설정
SELECT
    A.FIRST_NAME || ' ' || A.LAST_NAME AS "이름",
    C.JOB_TITLE,
    D.DEPARTMENT_NAME
FROM
    EMPLOYEES A
     LEFT JOIN JOB_HISTORY B
        ON A.JOB_ID = B.JOB_ID
        AND A.EMPLOYEE_ID = B.EMPLOYEE_ID
     LEFT JOIN JOBS C
        ON B.JOB_ID = C.JOB_ID
     LEFT JOIN DEPARTMENTS D
        ON A.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE
    TO_CHAR(A.HIRE_DATE) LIKE '_____02%';

-- 최저임금이 10000보다 높은 업무의 세부사항을 조회
SELECT
    B.*
FROM
    JOBS A
     LEFT JOIN JOB_HISTORY B
        ON A.JOB_ID = B.JOB_ID
WHERE
    A.MIN_SALARY > 10000;

--  2002년~2005년 사이에 입사한 사원의 이름과 입사일을 조회
SELECT
    *
FROM
    EMPLOYEES
WHERE
    TO_CHAR(HIRE_DATE) BETWEEN '2002' AND '2005'
ORDER BY
    HIRE_DATE;

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

-- 2008년 1월 1일 이후에 입사한 사원을 조회
SELECT
    *
FROM
    EMPLOYEES
WHERE
    HIRE_DATE > '2008/01/01';

-- 사번이 150,160번인 사원을 조회
SELECT
    *
FROM
    EMPLOYEES
WHERE
    EMPLOYEE_ID = 150
    OR EMPLOYEE_ID = 160;

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

-- 최고 임금이 10000~20000인 업무의 업무명, 최저임금과 최고임금의 차액을 조회
SELECT
    JOB_TITLE,
    ABS(MIN_SALARY - MAX_SALARY) AS "최저임금 - 최고금액"
FROM
    JOBS
WHERE
    MAX_SALARY BETWEEN 10000 AND 20000;

-- 사원 이름과 임금을 출력하되 임금을 1000단위로 조회
SELECT
    FIRST_NAME || ' ' || LAST_NAME AS "이름",
    TO_CHAR(SALARY, 'FM999,999,999')
FROM
    EMPLOYEES;

-- 업무명을 기준으로 하여 내림차순으로 업무 세부사항을 조회
SELECT
    *
FROM
    JOB_HISTORY A
     LEFT JOIN JOBS B
        ON A.JOB_ID = B.JOB_ID
ORDER BY
    B.JOB_TITLE DESC;

--  성이나 이름이 S로 시작하는 사원을 조회
SELECT
    *
FROM
    EMPLOYEES
WHERE
    FIRST_NAME LIKE 'S%'
    OR LAST_NAME LIKE 'S%';

-- 5월에 입사한 사원을 조회
SELECT
    *
FROM
    EMPLOYEES
WHERE
    TO_CHAR(HIRE_DATE) LIKE '_____05%';

-- 커미션을 받지 않고, 임금이 5000~10000이면서 30번 부서에 소속된 사원을 조회
SELECT
    *
FROM
    EMPLOYEES A
     LEFT JOIN DEPARTMENTS B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHERE
    ( A.COMMISSION_PCT IS NULL
      AND A.SALARY BETWEEN 5000 AND 10000 )
    AND B.DEPARTMENT_ID = 30;

-- 사원들의 이름과 첫 월급날을 조회 매월 1일이 월급 날이다
SELECT
    FIRST_NAME || ' ' || LAST_NAME AS "이름",
    TRUNC(HIRE_DATE, 'MM') AS "첫 월급날"
FROM
    EMPLOYEES;

-- 사원의 이름과 근속연수를 조회
SELECT
    FIRST_NAME || ' ' || LAST_NAME AS "이름",
    TO_CHAR(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12)) || '년 ' ||
    TO_CHAR(TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12, 1) * 12))|| '월'
    AS "근속연수"
FROM
    EMPLOYEES;

-- 2001년에 입사한 사원의 이름을 조회
SELECT
    FIRST_NAME || ' ' || LAST_NAME AS "이름"
FROM
    EMPLOYEES
WHERE
    TO_CHAR(HIRE_DATE) LIKE '2001%';

-- 첫 글자는 대문자로, 나머지 글자는 소문자로 변환하여 성과 이름을 조회, initcap 사용
SELECT
    INITCAP(FIRST_NAME) AS "성",
    INITCAP(LAST_NAME)  AS "이름"
FROM
    EMPLOYEES;

-- 업무명의 첫 단어를 조회
SELECT
    SUBSTR(JOB_TITLE, 1, 1) AS "업무명 첫 단어"
FROM
    JOBS;

-- 성의 3번째 문자 이후에 'b'가 포함된 사원의 이름의 길이를 조회
SELECT
    LENGTH(LAST_NAME)
FROM
    EMPLOYEES
WHERE
    FIRST_NAME LIKE '___b%';

-- 이름과 이메일주소가 대소문자 상관없이 같은 사원의 이름을 대문자로, 이메일주소는 소문자로 조회
SELECT
    UPPER(LAST_NAME),
    LOWER(EMAIL)
FROM
    EMPLOYEES
WHERE
    INITCAP(LAST_NAME) = INITCAP(EMAIL);

-- 올해 입사한 사원을 조회
SELECT
    *
FROM
    EMPLOYEES
WHERE
    TO_CHAR(HIRE_DATE, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY');

-- 현재 날짜와 2011년 1월 1일이 며칠 차이인지 조회
SELECT
    TO_DATE(TO_CHAR(SYSDATE, 'YYYY-mm-DD')) - TO_DATE('2011-01-01', 'YYYY-mm-DD')
FROM
    DUAL;

-- 올해 각 달마다 몇 명의 사원이 입사하였는지 조회
SELECT
    TO_CHAR(HIRE_DATE, 'YY/mm'),
    COUNT(*) AS "입사한 사원 수"
FROM
    EMPLOYEES
--where to_char(HIRE_DATE, 'YY') = to_char(sysdate, 'YY')
GROUP BY
    TO_CHAR(HIRE_DATE, 'YY/mm');

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

-- 사원 사번과 이전 업무를 종료한 날을 조회
SELECT
    A.EMPLOYEE_ID,
    B.END_DATE
FROM
    EMPLOYEES   A
     LEFT JOIN JOB_HISTORY B
        ON A.JOB_ID = B.JOB_ID;

-- 입사일이 n월 '15일' 이후인(몇월이든 월말에 입사한) 사원의 수를 조회
SELECT
    COUNT(*) AS "월말 입사 사원 수"
FROM
    EMPLOYEES
WHERE
    TO_CHAR(HIRE_DATE, 'dd') > 15;

-- 국가번호와 해당 국가에 있는 도시들의 개수를 조회
SELECT
    A.COUNTRY_ID,
    COUNT(*) AS "도시 개수"
FROM
    COUNTRIES A
     LEFT JOIN LOCATIONS B
        ON A.COUNTRY_ID = B.COUNTRY_ID
GROUP BY
    A.COUNTRY_ID;

-- 각 부서별로 커미션을 받은 사원들의 평균임금을 조회
SELECT
    A.DEPARTMENT_ID AS "부서",
    AVG(SALARY)     AS "평균임금"
FROM
    EMPLOYEES A
        LEFT JOIN DEPARTMENTS B
     ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHERE
    A.COMMISSION_PCT IS NOT NULL
GROUP BY
    A.DEPARTMENT_ID;


-- 업무별로 업무명, 사원의 수, 임금의 합, 최고임금과 최저임금의 차액을 조회
SELECT
    A.DEPARTMENT_ID,
    COUNT(*)                         "사원의 수",
    SUM(A.SALARY)                    AS "입금의 합",
    ABS(C.MAX_SALARY - C.MIN_SALARY) AS "차액"
FROM
    EMPLOYEES A
     LEFT JOIN DEPARTMENTS B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
     LEFT JOIN JOBS C
        ON A.JOB_ID = C.JOB_ID
GROUP BY
    A.DEPARTMENT_ID,
    ABS(C.MAX_SALARY - C.MIN_SALARY);

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

-- 10명이 넘는 사원이 입사한 연도를 조회
SELECT
    TO_CHAR(HIRE_DATE, 'YYYY') AS "입사년도"
FROM
    EMPLOYEES
GROUP BY
    TO_CHAR(HIRE_DATE, 'YYYY')
HAVING
    COUNT(TO_CHAR(HIRE_DATE, 'YYYY')) > 10;

-- 커미션을 받은 사원이 5명 이상인 부서를 조회
SELECT
    B.DEPARTMENT_ID,
    B.DEPARTMENT_NAME
FROM
    EMPLOYEES A
     LEFT JOIN DEPARTMENTS B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
GROUP BY
    B.DEPARTMENT_ID,
    B.DEPARTMENT_NAME
HAVING
    COUNT(A.COMMISSION_PCT) >= 5;

-- 과거에 하나가 넘는(하나 이상 말고 초과)의 업무를 하였던 사원의 사번을 조회
SELECT
    A.EMPLOYEE_ID
FROM
    EMPLOYEES A
     LEFT JOIN JOB_HISTORY B
        ON A.EMPLOYEE_ID = B.EMPLOYEE_ID
WHERE
    A.JOB_ID <> B.JOB_ID
GROUP BY
    A.EMPLOYEE_ID
HAVING
    COUNT(A.EMPLOYEE_ID) > 1;

-- 3명이 넘는 사원이 100일이 넘게 근무한 업무ID를 조회
SELECT
    B.JOB_ID
FROM
    JOBS A
     LEFT JOIN EMPLOYEES B
        ON A.JOB_ID = B.JOB_ID
WHERE
    TO_DATE(TO_CHAR(SYSDATE, 'YYYY-mm-dd')) - TO_DATE(TO_CHAR(HIRE_DATE, 'YYYY-mm-dd')) > 100
GROUP BY
    B.JOB_ID
HAVING
    COUNT(B.JOB_ID) > 3;

-- 부서 번호, 연도, 연도별 입사한 사원의 수를 조인하여 조회
SELECT
    B.DEPARTMENT_ID,
    TO_CHAR(A.HIRE_DATE, 'YYYY')        AS "입사년도",
    COUNT(TO_CHAR(A.HIRE_DATE, 'YYYY')) AS "사원 수"
FROM
    EMPLOYEES A
     LEFT JOIN DEPARTMENTS B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
GROUP BY
    B.DEPARTMENT_ID,
    TO_CHAR(A.HIRE_DATE, 'YYYY')
ORDER BY
    TO_CHAR(A.HIRE_DATE, 'YYYY'),
    B.DEPARTMENT_ID;

-- 임의의 매니저가 5명 이상의 사원을 관리하고 있는 부서를 조회
SELECT
    C.DEPARTMENT_NAME
FROM
    EMPLOYEES   A
    LEFT JOIN EMPLOYEES   B ON A.MANAGER_ID = B.EMPLOYEE_ID
    LEFT JOIN DEPARTMENTS C ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
GROUP BY
    C.DEPARTMENT_NAME
HAVING
    COUNT(A.MANAGER_ID) > 5;

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

-- 사번 110번 사원이 10번 부서에 속해있고
-- 현재 업무ID가 IT로 시작하지 않으면 해당 사원의 업무ID를 'IT_PROG'로 변경
SELECT
    *
FROM
    EMPLOYEES A
     LEFT JOIN DEPARTMENTS B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHERE
        A.EMPLOYEE_ID = 110
    AND B.DEPARTMENT_ID = 10;

-- 부서 테이블에 매니저ID가 120이고 장소ID는 도쿄 시의 임의의 장소로 하는 행을 추가
-- 부서 번호가 없어서 00으로 insert test
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

-- 부서 이름과 해당 부서의 사원들 수를 조회
SELECT
    B.DEPARTMENT_NAME        AS "부서명",
    COUNT(B.DEPARTMENT_NAME) AS "사원수"
FROM
    EMPLOYEES   A
     LEFT JOIN DEPARTMENTS B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
GROUP BY
    B.DEPARTMENT_NAME;

-- 업무기록에서 30번 부서의 모든 업무에 대하여 업무명, 사번, 시작일과 종료일 간 근무일수를 조회
SELECT
    B.DEPARTMENT_NAME,
    A.EMPLOYEE_ID,
    ABS(A.START_DATE - A.END_DATE) AS "근무일수"
FROM
    JOB_HISTORY A
     LEFT JOIN DEPARTMENTS B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID;

-- 부서명과 매니저 이름을 조회
SELECT
    B.DEPARTMENT_NAME,
    A.FIRST_NAME || ' ' || A.LAST_NAME AS "이름"
FROM
    EMPLOYEES A
     LEFT JOIN DEPARTMENTS B
        ON A.MANAGER_ID = B.MANAGER_ID;

SELECT
    A.DEPARTMENT_NAME,
    B.FIRST_NAME || ' ' || B.LAST_NAME AS "이름"
FROM
    DEPARTMENTS A
     LEFT JOIN EMPLOYEES B
        ON A.MANAGER_ID = B.MANAGER_ID;

-- 부서명과 매니저 이름, 도시를 조회
SELECT
    B.DEPARTMENT_NAME,
    A.FIRST_NAME || ' ' || A.LAST_NAME AS "이름",
    C.CITY
FROM
    EMPLOYEES A
     LEFT JOIN DEPARTMENTS B
        ON A.MANAGER_ID = B.MANAGER_ID
     LEFT JOIN LOCATIONS C
        ON B.LOCATION_ID = C.LOCATION_ID;

SELECT
    A.DEPARTMENT_NAME,
    B.FIRST_NAME || ' ' || B.LAST_NAME AS "이름",
    C.CITY
FROM
    DEPARTMENTS A
     LEFT JOIN EMPLOYEES B
        ON A.MANAGER_ID = B.MANAGER_ID
     LEFT JOIN LOCATIONS C
        ON A.LOCATION_ID = C.LOCATION_ID;

-- 국가명, 도시, 부서명을 조회
SELECT
    A.COUNTRY_NAME,
    B.CITY,
    C.DEPARTMENT_NAME
FROM
    COUNTRIES A
     LEFT JOIN LOCATIONS B
        ON A.COUNTRY_ID = B.COUNTRY_ID
     LEFT JOIN DEPARTMENTS C
        ON B.LOCATION_ID = C.LOCATION_ID;

-- 2000~2005년 사이의 모든 업무에 대하여 업무명, 부서명, 사원의 성, 업무시작일을 조회
SELECT
    B.JOB_TITLE,
    C.DEPARTMENT_NAME,
    D.FIRST_NAME,
    A.START_DATE
FROM
    JOB_HISTORY A
     LEFT JOIN JOBS B
        ON A.JOB_ID = B.JOB_ID
     LEFT JOIN DEPARTMENTS C
        ON A.DEPARTMENT_ID = C.DEPARTMENT_ID
     LEFT JOIN EMPLOYEES D
        ON C.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE
    TO_CHAR(A.END_DATE, 'YYYY') BETWEEN '2000' AND '2005';

-- 현재 임금이 15000 이상인 사원이 지금까지 수행했던 업무들을 조회
SELECT
    B.JOB_ID
FROM
    EMPLOYEES A
     LEFT JOIN JOB_HISTORY B
        ON A.EMPLOYEE_ID = B.EMPLOYEE_ID
WHERE
    A.SALARY >= 15000;

-- 5년 이상 근무한 모든 매니저들의 부서명, 매니저 이름, 매니저의 임금을 조회
SELECT DISTINCT
    C.DEPARTMENT_NAME,
    B.FIRST_NAME || ' ' || B.LAST_NAME AS "이름",
    B.SALARY
FROM
    EMPLOYEES A
     LEFT JOIN EMPLOYEES B
        ON A.MANAGER_ID = B.EMPLOYEE_ID
     LEFT JOIN DEPARTMENTS C
        ON A.MANAGER_ID = C.MANAGER_ID
WHERE
    TO_CHAR(TRUNC(MONTHS_BETWEEN(SYSDATE, B.HIRE_DATE) / 12)) >= 5
ORDER BY
    C.DEPARTMENT_NAME;

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

-- 사원이 6개월 미만으로 근무한 업무에 대하여 사원 이름, 업무명을 조회
SELECT
    B.FIRST_NAME || ' ' || B.LAST_NAME AS "이름",
    C.JOB_TITLE
FROM
    JOB_HISTORY A
     LEFT JOIN EMPLOYEES B
        ON A.EMPLOYEE_ID = B.EMPLOYEE_ID
     LEFT JOIN JOBS C
        ON A.JOB_ID = C.JOB_ID
WHERE
    TO_CHAR(TRUNC(MOD(MONTHS_BETWEEN(A.END_DATE, A.START_DATE) / 12, 1) * 12)) < 6;

-- 최고임금이 10000이 넘는 부서의 세부사항을 조회 
SELECT
    A.*
FROM
    DEPARTMENTS A
     LEFT JOIN EMPLOYEES B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
     LEFT JOIN JOBS C
        ON B.JOB_ID = C.JOB_ID
WHERE
    C.MAX_SALARY > 10000;

-- 'Smith'에 의해 관리되는 부서의 세부사항을 조회
SELECT
    *
FROM
    EMPLOYEES A
     LEFT JOIN DEPARTMENTS B
        ON A.EMPLOYEE_ID = B.MANAGER_ID
WHERE
    LAST_NAME = 'Smith';

-- 과거에 다른 어떠한 업무도 수행하지 않은 사원을 조회
SELECT
    DISTINCT A.*
FROM
    EMPLOYEES A
     LEFT JOIN JOB_HISTORY B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
WHERE
    A.EMPLOYEE_ID <> B.EMPLOYEE_ID;

-- 과거에 다른 업무를 수행했던 사원들 중에 최고임금이 10000 이상인 사원이 속한 부서의 세부사항을 조회
SELECT
    DISTINCT D.*
FROM
    EMPLOYEES A
     LEFT JOIN JOB_HISTORY B
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
     LEFT JOIN JOBS C
        ON B.JOB_ID = C.JOB_ID
     LEFT JOIN DEPARTMENTS D
        ON A.DEPARTMENT_ID = D.DEPARTMENT_ID        
WHERE
    A.EMPLOYEE_ID = B.EMPLOYEE_ID
    AND C.MAX_SALARY >= 10000;
    
    
-- 과거에 IT Programmer로 일했던 사원들의 현재 업무를 조회
SELECT
    C.JOB_ID
FROM
    EMPLOYEES   A
    LEFT JOIN JOB_HISTORY B ON A.JOB_ID = B.JOB_ID
    LEFT JOIN JOBS        C ON A.JOB_ID = C.JOB_ID
WHERE
    B.JOB_ID = 'IT_PROG';