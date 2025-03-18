-- abs : 절대값
SELECT
    -10,
    ABS(-10)
FROM
    DUAL;

    
-- floor 소수점 아래 버림
SELECT
    11.123,
    FLOOR(11.123)
FROM
    DUAL;


-- round 반올림, 소수점 반올림
SELECT
    11.123,
    ROUND(11.123),
    ROUND(11.123, 1),
    ROUND(11.123, 2),
    ROUND(11.123, 3)
FROM
    DUAL
    
UNION ALL
    
SELECT
    11.456,
    ROUND(11.456),
    ROUND(11.456, 1),
    ROUND(11.456, 2),
    ROUND(11.456, 3)
FROM
    DUAL;

    
-- trunc 소수점 버리기
SELECT
    11.123,
    TRUNC(11.123),
    TRUNC(11.123, 1),
    TRUNC(11.123, 2),
    TRUNC(11.123, 3)
FROM
    DUAL
    
UNION ALL 

SELECT
    11.456,
    TRUNC(11.456),
    TRUNC(11.456, 1),
    TRUNC(11.456, 2),
    TRUNC(11.456, 3)
FROM
    DUAL

UNION ALL 

SELECT
    123.129,
    TRUNC(123.129),
    TRUNC(123.129, -1),
    TRUNC(123.129, -2),
    TRUNC(123.129, -3)
FROM
    DUAL;

    
-- mod 나머지
SELECT
    MOD(7, 2),
    MOD(5, 3),
    MOD(10, 3)
FROM
    DUAL;

    
-- lower 소문자 / upper 대문자 / initcap 시작부분만 대문자
SELECT
    LOWER('HELLO world') AS "소문자",
    UPPER('HELLO world') AS "대문자",
    INITCAP('HELLO world') AS "시작만 대문자"
FROM
    DUAL;


-- concat 문자열 합치기
SELECT
    'he' || 'llo',
    CONCAT('he', 'llo')
FROM
    DUAL;

    
-- substr 문자열 자르기
SELECT
    SUBSTR('Hello world', 2, 4)
FROM
    DUAL;

    
-- length 문자열 길이
SELECT
    LENGTH('Hello world') AS "문자열 길이"
FROM
    DUAL;


-- ltrim 왼쪽 공백 삭제, rtrim 오른쪽 공백 삭제, trim 양쪽 공백 삭제
SELECT
    LTRIM('     hello     ') AS T1,
    RTRIM('     hello     ') AS T2,
    TRIM('     hello     ') AS T3
FROM
    DUAL;


-- instr 특정 문자열의 위치를 찾음
-- instr(검색할 문자열, 찾고 싶은 문자열, 검색시작 위치, 몇 번째 인덱스를 가져올지)
SELECT
    INSTR(UPPER('WO 둘리 HELLO world'), 'WO', 1, 2),
    INSTR(UPPER('wo 둘리 HELLO Donur Wo'), 'WO', 1, 2)
FROM
    DUAL;
    
    
-- months_between 두 날짜의 월차 구함
SELECT
    SYSDATE AS "현재 날짜",
    SYSDATE + 60 AS "+60한 날짜",
    MONTHS_BETWEEN(SYSDATE, SYSDATE + 60),
    MONTHS_BETWEEN(SYSDATE + 60, SYSDATE)
FROM
    DUAL;


-- add_months 월을 더할 때
SELECT
    SYSDATE AS "현재 날짜",
    SYSDATE + 2 AS "+2한 날짜",
    ADD_MONTHS(SYSDATE, 2),
    ADD_MONTHS(SYSDATE, -2)
FROM  
    DUAL;
  
    
-- next_day 다음 요일의 날짜를 구함(요일에 해당하는 날짜)
-- 1일요일 2월요일 ''' 7토요일 순
SELECT
    SYSDATE AS "현재 날짜",
    NEXT_DAY(SYSDATE, 7) AS "가장 가까운 토요일",
    NEXT_DAY(SYSDATE, 3) AS "가장 가까운 화요일",
    NEXT_DAY(SYSDATE, 4) AS "가장 가까운 수요일"
FROM  
    DUAL;   
    
    
-- last_day 달의 마지막 일을 구함
SELECT
    SYSDATE AS "현재 날짜",
    LAST_DAY(SYSDATE) AS "현재 날짜의 마지막 달 일",
    LAST_DAY(TO_DATE('2025-02-28', 'YYYY-mm-DD')) AS "설정한 달의 마지막 날짜"
FROM  
    DUAL;   
    
    
-- to_char 문자로 변환
SELECT
    50 AS "숫자열",
    TO_CHAR(50) AS "문자열",
    TO_CHAR(560, '$999,999.99') AS "달러1",
    TO_CHAR(560, '$000,000.00') AS "달러2",
    TO_CHAR(560.1, '$999,999.09') AS "달러3"
FROM
    DUAL;
    
SELECT
    TO_CHAR(sysdate, 'YYYY-mm-DD HH24:MI:SS') AS "날짜를 문자열로"
FROM
    DUAL;


-- to_date 날짜형으로 변환
SELECT
    TO_DATE('2025-03-18 12:20:31', 'YYYY-mm-DD HH24:MI:SS') AS "문자를 날짜로"
FROM
    DUAL;


-- to_number 숫자형을 변환
SELECT
    '50'                AS N1,
    '50' + 1            AS N2,
    CONCAT('50', 1)     AS N3,
    TO_NUMBER('50')     AS N4,
    TO_NUMBER('50') + 1 AS N4
FROM
    DUAL;
    
    
-- cocnat a b c 합치기
SELECT
    CONCAT(CONCAT('a', 'b'), 'c') AS "문자열 합치기"
FROM
    DUAL;
    
    
-- salary에서 10000빼고 음수일 때는 양수로
SELECT
    SALARY - 10000      AS "원래 값",
    ABS(SALARY - 10000) AS "절대 값"
FROM
    EMPLOYEES;


-- 시간 날짜
SELECT
    sysdate AS "현재 날짜",
    sysdate + 1 AS "내일 날짜",
    sysdate - 1 AS "어제 날짜"
FROM
    DUAL;

SELECT
    sysdate - 1 / 24 AS "한 시간전",
    sysdate + 1 / 24 AS "한 시간후"
FROM
    DUAL;
    
SELECT
    ADD_MONTHS(sysdate, 1) AS "한달 후",
    ADD_MONTHS(sysdate, -1) AS "한달 전",
    ADD_MONTHS(sysdate, 12) AS "1년 후",
    ADD_MONTHS(sysdate, -12) AS "1년 전"
FROM
    DUAL;


-- 현재 시간의 요일
SELECT
    TO_CHAR(sysdate, 'DAY') AS "요일"
FROM
    DUAL;


-- 그룹 함수

-- 합계
SELECT
    SUM(SALARY) AS "총 급여"
FROM
    EMPLOYEES;


-- 평균
SELECT
    AVG(SALARY) AS "급여평균"
FROM
    EMPLOYEES;


-- 카운트
SELECT
    COUNT(SALARY) AS "전체 사원수"
FROM
    EMPLOYEES;
    
    
SELECT
    SUM(SALARY) AS "총 급여",
    COUNT(SALARY) AS "전체 사원수",
    SUM(SALARY) / COUNT(SALARY) AS "평균 테스트",
    AVG(SALARY) AS "급여평균"
FROM
    EMPLOYEES;
    

-- 최댓값
SELECT
    MAX(SALARY) AS "최고 급여 금액"
FROM
    EMPLOYEES

UNION ALL

-- 최솟값
SELECT
    MIN(SALARY) AS "최고 급여 금액"
FROM
    EMPLOYEES;


SELECT
    COUNT(*) AS CNT,
    COUNT(NVL(COMMISSION_PCT, 0)) AS CNT2
FROM
    EMPLOYEES;
    
SELECT
    AVG(COMMISSION_PCT) AS "합계",
    AVG(NVL(COMMISSION_PCT, 0)) AS "합계2"
FROM
    EMPLOYEES;


-- group by
SELECT
    DEPARTMENT_ID,
    AVG(SALARY) AS "급여 평균",
    COUNT(SALARY) AS  "사원수"
FROM
    EMPLOYEES
WHERE
    DEPARTMENT_ID IN (60, 90, 100)
GROUP BY
    DEPARTMENT_ID
ORDER BY
    DEPARTMENT_ID;
    
SELECT
    DEPARTMENT_ID,
    AVG(SALARY) AS "급여 평균",
    COUNT(SALARY) AS  "사원수"
FROM
    EMPLOYEES
GROUP BY
    DEPARTMENT_ID
ORDER BY
    DEPARTMENT_ID;    
   

-- 부서번호가 100보다 작은 데이터를 부서번호로 그룹지어 사원의 급여 평균 조회
SELECT
    DEPARTMENT_ID AS "부서 번호",
    AVG(SALARY)   AS "급여 평균"
FROM
    EMPLOYEES
WHERE
    DEPARTMENT_ID < 100
GROUP BY
    DEPARTMENT_ID
ORDER BY
    DEPARTMENT_ID;

 
-- having group by로 그룹 지어진 컬럼의 대표값 비교 
SELECT
    DEPARTMENT_ID AS "부서 번호",
    AVG(SALARY)   AS "급여 평균"
FROM
    EMPLOYEES
WHERE
    DEPARTMENT_ID < 100
GROUP BY
    DEPARTMENT_ID
HAVING AVG(SALARY) >= 8000
ORDER BY 
    DEPARTMENT_ID;




























 
 
 
    