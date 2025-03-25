-- view
-- 하나 이상의 테이블이나 다른 view를 기반으로 하는 가상 테이블
-- 실제 데이터를 저장하지 않고, 기존 테이블의 데이터를 특정 방식으로 보여주는 논리적인 구조

-- 사원의 이름과 해당 사원이 일하는 부서 이름 정보 뷰
CREATE OR REPLACE VIEW VIEW_ED AS
    SELECT
        A.FIRST_NAME,
        B.DEPARTMENT_NAME
    FROM
        EMPLOYEES A
         JOIN DEPARTMENTS B
            ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
    ORDER BY
        A.EMPLOYEE_ID;
       

-- 조회
SELECT
    *
FROM
    VIEW_ED;

-- 삭제    
--DROP VIEW VIEW_ED;

CREATE OR REPLACE VIEW VIEW_ED AS
SELECT
    A.FIRST_NAME || ' ' || A.LAST_NAME AS "FULL_NAME",
    A.SALARY,
    B.DEPARTMENT_NAME,
    C.JOB_TITLE,
    D.CITY,
    E.COUNTRY_NAME
FROM
    EMPLOYEES A
     JOIN DEPARTMENTS B 
        ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
     JOIN JOBS C 
        ON A.JOB_ID = C.JOB_ID
     JOIN LOCATIONS D 
        ON B.LOCATION_ID = D.LOCATION_ID
     JOIN COUNTRIES E 
        ON D.COUNTRY_ID = E.COUNTRY_ID;

        
-- sequence, 시퀀스
-- 고유한 숫자 값을 자동으로 생성하는 데이터베이스 객체
-- 주로 PK 또는 고유 식별자를 생성하는 데 사용
-- 항상 고유값
-- 증가 또는 감소 가능
-- 순환 옵션, 최대값 도달 후 처음 부터 다시 시작
-- nextval 시퀀스가 가지고 있는 현재 카운트 수에서 하나를 증가시켜서 반납
-- currval 현재 시퀀스가 가지고 있는 카운트 수를 리턴

-- 시퀀스 생성
CREATE SEQUENCE TESTSEQUENCE;

-- nextval
SELECT
    TESTSEQUENCE.NEXTVAL
FROM
    DUAL;

-- currval
SELECT
    TESTSEQUENCE.CURRVAL
FROM
    DUAL;

-- 초기화(현재 카운트가 1이 되도록 마이너스)
ALTER SEQUENCE TESTSEQUENCE INCREMENT BY - 9;

-- 다시 1씩 증가하게 변경
ALTER SEQUENCE TESTSEQUENCE INCREMENT BY 1;


DROP SEQUENCE TESTSEQUENCE;


















