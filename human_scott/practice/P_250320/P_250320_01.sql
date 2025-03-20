-- join 형태로 조회해 주세요
-- 사원들의 부서 이름과 부서 번호를 조회
SELECT
    A.EMPNO,
    A.ENAME,
    A.JOB,
    A.MGR,
    A.HIREDATE,
    A.SAL,
    A.COMM,
    B.DEPTNO,
    B.DNAME
FROM
    EMP  A
    LEFT JOIN DEPT B
        ON A.DEPTNO = B.DEPTNO;

-- job 이 CLERK 사원들의 이름과 부서명을 조회
SELECT
    A.EMPNO,
    A.ENAME,
    A.JOB,
    A.MGR,
    A.HIREDATE,
    A.SAL,
    A.COMM,
    B.DEPTNO,
    B.DNAME
FROM
    EMP  A
    LEFT JOIN DEPT B
        ON A.DEPTNO = B.DEPTNO
WHERE
    A.JOB = 'CLERK';

-- 급여가 2600 이상인 사원의 이름과 부서명을 조회
SELECT
    A.EMPNO,
    A.ENAME,
    A.JOB,
    A.MGR,
    A.HIREDATE,
    A.SAL,
    A.COMM,
    B.DEPTNO,
    B.DNAME
FROM
    EMP  A
    LEFT JOIN DEPT B
        ON A.DEPTNO = B.DEPTNO
WHERE
    A.SAL >= 2600;

-- 사원의 이름과 급여, 급여 등급을 조회
SELECT
    A.EMPNO,
    A.ENAME,
    A.JOB,
    A.SAL,
    B.GRADE
FROM
    EMP A
    LEFT JOIN SALGRADE B
        ON B.LOSAL <= A.SAL AND A.SAL <= B.HISAL
ORDER BY
    B.GRADE,
    A.SAL;

-- 사원의 급여와 상사의 급여를 조회
SELECT
    A.SAL AS "사원 급여",
    B.SAL AS "상사 급여"
FROM
    EMP A
    LEFT JOIN EMP B
        ON A.MGR = B.MGR;

-- 사원번호와 관리자의 사원번호를 조회, 단 , 관리자가 없어도 조회
SELECT
    A.EMPNO,
    B.MGR
FROM
    EMP A
    LEFT JOIN EMP B
        ON A.MGR = B.MGR;

-- 사원 이름과 사원이 다니는 부서명을 조회. 단, 사원이 존재하지 않는 부서는 부서명만 조회
SELECT
    B.ENAME,
    A.DNAME
FROM
    DEPT A
    LEFT JOIN EMP  B
        ON A.DEPTNO = B.DEPTNO;  

-- 부서번호가 20인 사원의 사번, 부서번호, 부서 위치를 조회
SELECT
    A.EMPNO,
    B.DEPTNO,
    B.LOC
FROM
    EMP  A
    LEFT JOIN DEPT B
        ON A.DEPTNO = B.DEPTNO
WHERE
    B.DEPTNO = '20';

--< 서브 쿼리를 사용해 조회해 주세요>
-- JAMES 사원의 부서 이름을 조회
SELECT
    DNAME
FROM
    DEPT
WHERE
    DEPTNO IN (
                SELECT
                    DEPTNO
                FROM
                    EMP
                WHERE
                    ENAME = 'JAMES'
              );

-- 평균급여보다 많이 받는 사원의 이름과 급여를 이름과 급여순으로 내림차순으로 정렬
SELECT
    A.ENAME,
    A.SAL
FROM
    EMP A
WHERE
    A.SAL > (
                SELECT
                    AVG(SAL)
                FROM
                    EMP
            )
ORDER BY
    A.ENAME DESC,
    A.SAL DESC;

-- 10번 부서의 최대 급여와 같은 급여를 받는 사원번호와 이름 조회
SELECT
    A.EMPNO,
    A.ENAME
FROM
    EMP A
WHERE
    SAL = (
            SELECT
                MAX(SAL)
            FROM
                EMP
            WHERE
                DEPTNO = '10'
           );

-- 20번 부서의 최대 급여보다 많이 받는 사원 번호와 이름을 조회
SELECT
    A.EMPNO,
    A.ENAME
FROM
    EMP A
WHERE
    SAL > (
            SELECT
                MAX(SAL)
            FROM
                EMP
            WHERE
                DEPTNO = '20'
            );
-- BLAKE 를 상사로 둔 사원 정보를 조회
SELECT
    A.*
FROM
    EMP A
WHERE
    A.MGR = (
                SELECT
                    B.EMPNO
                FROM
                    EMP B
                WHERE
                    B.ENAME = 'BLAKE'
             );

-- 부하직원이 있는 사원 정보를 조회
SELECT
    A.*
FROM
    EMP A
WHERE
    A.MGR IN (
                SELECT
                    B.EMPNO
                FROM
                    EMP B
             );

-- 부하직원이 없는 사원 정보를 조회

SELECT
    A.*
FROM
    EMP A
WHERE
    A.MGR NOT IN (
                    SELECT
                        B.EMPNO
                    FROM
                        EMP B
                 );