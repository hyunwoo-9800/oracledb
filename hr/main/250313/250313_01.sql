-- 나라조회
SELECT
    *
FROM
    COUNTRIES;

-- 지역조회
SELECT
    *
FROM
    REGIONS;

-- 회사 관련 건물들의 거리 주소
SELECT
    LOC.STREET_ADDRESS AS 거리주소
FROM
    LOCATIONS LOC;

--회사에 존재하는 모든 직무 이름
SELECT
    JOB.JOB_TITLE as 직무이름
FROM
    JOBS JOB;

-- 회사에 존재하는 모든 작업 아이디
SELECT
    JOB.JOB_ID AS 직무이름
FROM
    JOBS JOB;

-- 모든 사원들의 이름과 성
SELECT
    EMP.FIRST_NAME AS 성,
    EMP.LAST_NAME  AS 이름
FROM
    EMPLOYEES EMP;

-- 사원의 사번과 이메일
SELECT
    EMP.EMPLOYEE_ID AS 사번,
    EMP.EMAIL       AS 이메일
FROM
    EMPLOYEES EMP;

-- 사번, 작업시작일, 작업종료일
SELECT
    JOB.EMPLOYEE_ID AS 사번,
    JOB.START_DATE  AS 작업시작일,
    JOB.END_DATE    AS 작업종료일
FROM
    JOB_HISTORY JOB;

-- 직업별 직업명, 최소, 최대
SELECT 
    JOB.JOB_TITLE AS 직업명,
    JOB.MIN_SALARY AS 최소급여,
    JOB.MAX_SALARY AS 최대급여
FROM JOBS JOB;