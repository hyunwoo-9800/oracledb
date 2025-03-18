-- 사원 이름의 길이가 6 이상인 사원의 수를 조회
SELECT
    *
FROM
    EMP
WHERE
    LENGTH(ENAME) >= 6;

-- 사원의 이름을 소문자로 출력
SELECT
    LOWER(ENAME) AS "사원이름"
FROM
    EMP;

-- 다음날 날짜를 출력
SELECT
    SYSDATE + 1 AS "다음날 날짜"
FROM
    DUAL;

-- 사원의 근무년수, 월수, 일수를 조회
SELECT
    MONTHS_BETWEEN(SYSDATE, HIREDATE) / 12           AS "근무년수",
    MONTHS_BETWEEN(SYSDATE, HIREDATE)                AS "근무월수",
    MONTHS_BETWEEN(SYSDATE, HIREDATE) * ( 365 / 12 ) AS "근무일수"
FROM
    EMP;

-- 사원들의 입사일로 부터 1년 6개월이 지난 날을 조회
SELECT
    HIREDATE,
    ADD_MONTHS(HIREDATE, 18) AS "입사일 1년 6개월 후"
FROM
    EMP;

-- 입사일 달의 마지막 날을 조회
SELECT
    LAST_DAY(HIREDATE) AS "입사일 달의 마지막 날"
FROM
    EMP;

-- 오늘부터 3개월 후 돌아오는 토요일 날짜를 조회
SELECT
    NEXT_DAY(ADD_MONTHS(SYSDATE, 3), 7) AS "가장 가까운 토요일"
FROM
    DUAL;

-- 현재 시간을 'XXXX-XX-XX XX:XX:XX' 문자열로 조회 '2020-6-7   22:12:11' 문자열 데이터를 시간 데이터로 만들어 주세요
SELECT
    TO_CHAR(SYSDATE, 'YYYY-mm-DD HH24:MI:SS') AS "현재 시간"
FROM
    DUAL;

-- 20번 부서의 커미션을 받는 사원의 수를 조회
SELECT
    COUNT(COMM) AS CNT
FROM
    EMP
WHERE
    DEPTNO = 20;

-- job 이 CLERK 인 사원의 평균 급여를 조회
SELECT
    AVG(SAL) AS "평균 급여"
FROM
    EMP
WHERE
    JOB = 'CLERK';

-- 사원들이 받는 커미션의 총합을 조회
SELECT
    SUM(NVL(COMM, 0)) AS "커미션 총합"
FROM
    EMP;

-- 사원들이 받는 최대 최소 급여를 조회
SELECT
    MAX(SAL) AS "최대 급여",
    MIN(SAL) AS "최소 급여"
FROM
    EMP;

-- 부서별 급여 평균을 조회
SELECT
    DEPTNO   AS "부서",
    AVG(NVL(SAL, 0)) AS "급여 평균"
FROM
    EMP
GROUP BY
    DEPTNO;

-- 급여별 커미션을 받는 사원의 수를 조회
SELECT
    SAL         AS "급여",
    COUNT(COMM) AS "커미션 받는 사원 수"
FROM
    EMP
GROUP BY
    SAL;

-- 급여가 2000이상인 부서별 사원 수를 조회
SELECT
    DEPTNO   AS "부서",
    COUNT(*) AS "사원 수"
FROM
    EMP
WHERE
    SAL >= 2000
GROUP BY
    DEPTNO;

-- 부서별 평균 급여가 1700이상인 부서번호와 평균급여를 조회
SELECT
    DEPTNO   AS "부서",
    AVG(SAL) AS "평균급여"
FROM
    EMP
GROUP BY
    DEPTNO
HAVING
    AVG(SAL) >= 1700;

-- 1200이상의 급여를 받는 사원들의 부서별 평균 급여가 1900이상인 부서번호와 평균급여를 조회
SELECT
    DEPTNO   AS "부서",
    AVG(SAL) AS "평균급여"
FROM
    EMP
WHERE
    SAL >= 1200
GROUP BY
    DEPTNO
HAVING
    AVG(SAL) >= 1900;

-- 직책이 PRESIDENT 가 아닌 사원에 대한 부서별 급여 합이 6000이상인 부서와 급여합을 조회
SELECT
    DEPTNO   AS "부서",
    SUM(SAL) AS "급여 합"
FROM
    EMP
WHERE
    JOB <> 'PRESIDENT'
GROUP BY
    DEPTNO
HAVING
    SUM(SAL) >= 6000;

20과 30 부서에서 최대 급여를 받는 사람의 최대 급여를 조회
SELECT
    DEPTNO   AS "부서",
    MAX(SAL) AS "최대 급여"
FROM
    EMP
WHERE
    DEPTNO IN ( 20, 30 )
GROUP BY
    DEPTNO;
