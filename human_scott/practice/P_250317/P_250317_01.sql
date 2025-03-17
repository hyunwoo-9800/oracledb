-- 모든 부서 정보 조회
SELECT
    *
FROM
    DEPT;

-- 모든 사원 정보 조회
SELECT
    *
FROM
    EMP;

-- 모든 사원의 이름을 조회
SELECT
    ENAME
FROM
    EMP;

-- 회사의 부서번호를 조회
SELECT
    DEPTNO
FROM
    DEPT;

-- 사원의 관리자, 월급, 커미션 조회
SELECT
    E.MGR,
    E.SAL,
    E.COMM
FROM
    EMP E;

-- 부서의 이름과 지역 조회
SELECT
    D.DNAME,
    D.LOC
FROM
    DEPT D;

-- 연봉등급과 최저 금액을 조회
SELECT
    SAL.GRADE,
    SAL.LOSAL
FROM
    SALGRADE SAL;

-- 회사에 존재하는 사원의 작업 조회
SELECT
    E.JOB
FROM
    EMP E;

-- 사원이 존재하는 부서 번호를 중복없이 조회
SELECT
    DISTINCT E.DEPTNO
FROM
    EMP E;

-- 관리하는 사원이 존재하는 관리자 아이디를 중복없이 조회 
SELECT
    DISTINCT E.MGR
FROM
    EMP E;

-- 연봉 등급이 3일 때 받을 수 있는 최대, 최소 금액을 조회
SELECT
    SAL.HISAL,
    SAL.LOSAL
FROM
    SALGRADE SAL
WHERE
    GRADE = '3';

-- 연봉이 2100 이상인 사원의 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    SAL >= 2100;

-- 부서가 20인 곳에서 일하는 사원의 정보 조회
SELECT
    *
FROM
    EMP
WHERE
    DEPTNO = '20';

-- 관리자가 없는 사원의 정보 조회
SELECT
    *
FROM
    EMP
WHERE
    MGR IS NULL;

-- 커미션이 없는 사원의 정보 조회
SELECT
    *
FROM
    EMP
WHERE
    COMM IS NULL;

-- 사원의 연봉이 50 증가한 형태를 조회
SELECT
    SAL + 50 AS "연봉 50 증가"
FROM
    EMP;

-- 사원의 현 급여보다 10% 증가한 형태를 조회
SELECT
    SAL * 1.1
FROM
    EMP;

-- 사원의 급여를 50 증가한 형태로 컬럼명을 upgradeSalary 로 조회
SELECT
    SAL + 50 AS UPGRADESALARY
FROM
    EMP;

-- 사원의 급여와 커미션을 합한 형태로 컬럼명을 upgradeSalary 로 조회
SELECT
    SAL || COMM AS UPGRADESALARY
FROM
    EMP;

-- 'XXXx 사번의 사원은 관리자가 xxx 사번 입니다' 의 형태로 결과를 출력
SELECT
    EMPNO || ' 사번의 사원은 관리자가 ' || MGR || ' 사번 입니다.' AS PRINT
FROM
    EMP;

-- 급여가 800보다 같거나 많고 1000보다 같거나 작은 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
        SAL >= 800
    AND SAL <= 1000;

-- 부서 번호가 20이면서 직업이 MANAGER인 사원 정보 조회
SELECT
    *
FROM
    EMP
WHERE
        DEPTNO = '20'
    AND JOB = 'MANAGER';

-- 부서 번호가 20 이거나 직업이 MANAGER 인 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    DEPTNO = '20'
    OR JOB = 'MANAGER';

-- 직업이 MANAGER 가 아닌 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    JOB <> 'MANAGER';

-- 커미션이 0, 500, 1400 와 같은 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    COMM IN ( 0, 500, 1400 );

-- 급여가 8000보다 같거나 많고 10000보단 같거나 작은 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
        SAL >= 800
    AND SAL <= 1000;

-- 급여가 700보다 작거나 1000보다 큰 사원 정보를 조회 
SELECT
    *
FROM
    EMP
WHERE
    SAL <= 700
    OR SAL >= 1000;

-- 사원의 이름이 SCOTT 인 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    ENAME LIKE '%SCOTT%';

-- 사원 이름이 'A' 로 시작하는 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    ENAME LIKE 'A%';

-- 이름에 S 가 들어가는 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    ENAME LIKE '%S%';

-- 이름에 L이 들어가지 않은 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    ENAME NOT LIKE '%L%';

-- 이름에 세번째 문자가 I 인 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    ENAME LIKE '__I%';

-- 사원의 이름이 E~G로 시작하는 사원정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    ENAME BETWEEN 'E%' AND 'G%';

-- 사원의 입사일이 2004년 5월 20일 ~ 2007년 10월 10일까지의 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    HIREDATE BETWEEN '2004/05/20' AND '2007/10/10';

-- 입사일이 83년 이후이거나 job 이 SLAESAMN 인 모든 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    HIREDATE >= '1983/01/01'
    OR JOB = 'SALESMAN';

-- 20번 부서가 아닌 모든 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    DEPTNO <> '20';

-- 급여가 600에서 3000사이가 아닌 사원의 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    SAL NOT BETWEEN 600 AND 3000;

-- 상사가 없는 사원 정보 조회
SELECT
    *
FROM
    EMP
WHERE
    MGR IS NULL;

-- 매니저가 7782, 2902, 2698, 7566 인 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    MGR IN ( 7782, 2902, 2698, 7566 );

-- 부서번호가 40,10,20이 아닌 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    DEPTNO NOT IN ( 40, 10, 20 );

-- 사원 이름이 5글자인 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    ENAME LIKE '_____';

-- 직업이 N으로 끝나는 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    JOB LIKE '%N';

-- 사원 이름에 A가 들어간 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    ENAME LIKE '%A%';

-- 이름이 S로 시작하는 사원 정보를 조회
SELECT
    *
FROM
    EMP
WHERE
    ENAME LIKE 'S%';

-- 관리자 번호를 내림차순으로 정렬하여 사원 정보 조회
SELECT
    *
FROM
    EMP
ORDER BY
    MGR DESC;

-- 급여가 많은 순으로 사원 정보를 조회
SELECT
    *
FROM
    EMP
ORDER BY
    SAL DESC;

-- 사번, 이름, 관리자 번호, 급여 정보가 출력되고 관리자 번호를 오름차순, 부서번호는 오름차순으로 정렬하여 사원정보가 조회
SELECT
    EMPNO,
    ENAME,
    MGR,
    SAL
FROM
    EMP
ORDER BY
    MGR,
    DEPTNO;

-- 사원 정보를 부서는 알파벳순으로 정렬하고 같은 부서 사원은 사원번호로 오름차순으로 정렬
SELECT
    *
FROM
    EMP  A
    LEFT JOIN DEPT B
    ON A.DEPTNO = B.DEPTNO
ORDER BY
    B.DNAME,
    A.EMPNO;
    
-- 사원 정보를 부서는 오름차순으로 정렬하고 같은 부서 사원은 사원번호로 오름차순으로 정렬
SELECT
    *
FROM
    EMP
ORDER BY
    DEPTNO,
    EMPNO;

-- 직급이 'SALESMAN' 이면 15%, 'MANAGER'이면 10%, 이외의 직종은 5% 급여를 인상하여 사원 정보를 조회
SELECT
    E.EMPNO,
    E.ENAME,
    E.JOB,
    E.MGR,
    E.HIREDATE,
    E.SAL,
    E.COMM,
    E.DEPTNO,
--    E.*,
    (
        CASE
            WHEN JOB = 'SALESMAN' THEN ( E.SAL * 0.15 ) + E.SAL
            WHEN JOB = 'MANAGER'  THEN ( E.SAL * 0.1 ) + E.SAL
            ELSE ( E.SAL * 0.05 ) + E.SAL
        END
    ) AS "급여 인상"
FROM
    EMP E;