-- t_course insert
INSERT INTO T_COURSE VALUES ('L3001', '스프링 프로젝트', 3, 'P11', 50000);
INSERT INTO T_COURSE VALUES ('L3002', '모바일프로그래밍', 3, 'P12', NULL);
INSERT INTO T_COURSE VALUES ('L3003', '데이터베이스튜닝', 2, 'P13', 50000);
INSERT INTO T_COURSE VALUES ('L3004', '빅데이터 개론', 2, 'P14', 30000);

-- 값 확인용
SELECT * FROM T_COURSE;


-- t_sg_scores insert
INSERT INTO T_SG_SCORES VALUES ('C1801', 'L3001', NULL, 3, '2018/02/23');
INSERT INTO T_SG_SCORES VALUES ('C1801', 'L3002', NULL, 3, '2018/02/23');
INSERT INTO T_SG_SCORES VALUES ('C1801', 'L3003', NULL, 2, '2018/02/23');
INSERT INTO T_SG_SCORES VALUES ('C1801', 'L4001', NULL, 2, '2018/02/23');

INSERT INTO T_SG_SCORES VALUES ('C1802', 'L3001', NULL, 3, '2018/02/24');
INSERT INTO T_SG_SCORES VALUES ('C1802', 'L3002', NULL, 3, '2018/02/24');
INSERT INTO T_SG_SCORES VALUES ('C1802', 'L3003', NULL, 2, '2018/02/24');
INSERT INTO T_SG_SCORES VALUES ('C1802', 'L1051', NULL, 2, '2018/02/24');

-- 값 확인용
SELECT * FROM T_SG_SCORES;


-- t_sg_scores update
UPDATE T_SG_SCORES
SET
    COURSE_ID = 'L3004'
WHERE
        STUDENT_ID = 'C1802'
    AND COURSE_ID = 'L1051';

-- 값 확인용
SELECT * FROM t_sg_scores;


-- t_sg_scores insert
INSERT INTO T_SG_SCORES VALUES ('C1001', 'L3001', 98, 3, '2018/06/28');
INSERT INTO T_SG_SCORES VALUES ('C1002', 'L3001', 88, 3, '2018/06/28');
INSERT INTO T_SG_SCORES VALUES ('C1001', 'L3002', 87, 3, '2018/06/28');
INSERT INTO T_SG_SCORES VALUES ('C1002', 'L3002', 92, 3, '2018/06/28');
INSERT INTO T_SG_SCORES VALUES ('C1001', 'L3003', 92, 2, '2018/06/28');
INSERT INTO T_SG_SCORES VALUES ('C1002', 'L3003', 93, 2, '2018/06/28');
INSERT INTO T_SG_SCORES VALUES ('C1001', 'L3004', 89, 2, '2018/06/28');
INSERT INTO T_SG_SCORES VALUES ('C1002', 'L3004', 97, 2,'2018/06/28');

-- 값 확인용
SELECT * FROM t_sg_scores;

-- 게임프로그래밍 삭제
DELETE FROM T_COURSE
WHERE
    COURSE_ID = 'L2033';

-- 값 확인용
SELECT * FROM T_COURSE;

-- 추가수강료 수정
UPDATE T_COURSE
SET
    COURSE_FEES = 30000
WHERE
    COURSE_ID = 'L1031';

-- 값 확인용
SELECT * FROM T_COURSE;

-- L4 과목 삭제
DELETE FROM T_COURSE
WHERE
    COURSE_ID LIKE 'L4%';

-- 값 확인용
SELECT * FROM T_COURSE;

-- 삭제한 과목 복구
ROLLBACK;


-- 대소문자 변경
SELECT
    LOWER('HELLO'),
    UPPER('welcome')
FROM
    DUAL;


-- Course 테이블의 Title과 Title 컬럼의 문자열 길이 정보를 문자열 길이 내림 차순으로 조회
SELECT
    TITLE,
    LENGTH(TITLE) AS "문자열 길이1",
    LENGTHB(TITLE) AS "문자열 길이2"
FROM
    COURSE
ORDER BY
    LENGTH(TITLE) DESC;


-- Professor 테이블의 교수명에서 교수의 성을 추출하고, Email 주소에서 '@' 문자가 나타나는 위치를 교수명순으로 조회
SELECT
    SUBSTR(NAME, 0, 1) AS "성씨",
    INSTR(EMAIL, '@')  AS "문자 위치"
FROM
    PROFESSOR
ORDER BY
    NAME;

-- 'xyxyxHello' 문자열에서 'x' 나 'y' 문자를 제거하시오
SELECT
    REGEXP_REPLACE('xyxyxHello', 'x|y'),
    LTRIM('xyxyxHello', 'xy')
FROM
    DUAL;

-- 'Oracle Serverkkkkk' 문자열의 'k' 문자를 제거하시오
SELECT
    REGEXP_REPLACE('Oracle Serverkkkkk', 'k')
FROM
    DUAL;


-- Professor 테이블의 교수명, 직위, 교수명과 직위를 결합하여 교수번호순으로 조회
SELECT
    NAME,
    POSITION,
    NAME || POSITION AS "직위명 + 교수"
FROM
    PROFESSOR
ORDER BY
    PROFESSOR_ID;

-- 교수용 Email 서버의 도메인명이 'cyber' 에서 'dream' 으로 변경되었다. 이를 변경하여 교수명순으로 조회
UPDATE PROFESSOR
SET
    EMAIL = REPLACE(EMAIL, 'cyber', 'dream')
WHERE
    EMAIL LIKE '%cyber%';

SELECT * FROM PROFESSOR;

-- 12.345 의 값을 round(), trunc() 함수 사용하여 조회 
SELECT
    ROUND(12.345, 2),
    TRUNC(12.345, 2)
FROM
    DUAL;

-- 12.345 의 값을 ceil(), floor() 함수 사용하여 조회
SELECT
    CEIL(12.345),
    FLOOR(12.345)
FROM
    DUAL;

-- 100을 3으로 나누어 몫과 나머지를 조회해 주세요
SELECT
    100 / 3        AS "확인용 값",
    FLOOR(100 / 3) AS "몫1",
    TRUNC(100 / 3) AS "몫2",
    MOD(100, 3)    AS "나머지"
FROM
    DUAL;


-- 위의 표를 참고하여 현재 날짜와 시간을 조회해 주세요
SELECT
    TO_CHAR(SYSDATE, 'YYYY-mm-DD') AS "현재 날짜",
    TO_CHAR(SYSDATE, 'HH:MI:SS')   AS "현재 시간",
    CURRENT_DATE,
    CURRENT_TIMESTAMP
FROM
    DUAL;

-- 날짜형 형식을 'YYYY/MM/DD HH24:MI:SS'로 지정하여 시스템 날짜와 지역시간대의 날짜와 시간을 조회
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD HH24:MI:SS';

SELECT
    TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-mm-DD') AS "현재 날짜",
    TO_CHAR(CURRENT_TIMESTAMP, 'HH:MI:SS')   AS "현재 시간"
FROM
    DUAL;

SELECT
    SYSDATE,
    CURRENT_TIMESTAMP
FROM
    DUAL;

-- 현재 날짜에 10개월을 더하여 조회
SELECT
    ADD_MONTHS(SYSDATE, 10) AS "10개월 뒤"
FROM
    DUAL;

SELECT
    CURRENT_DATE,
    ADD_MONTHS(CURRENT_DATE, 10) AS "10개월 뒤"
FROM
    DUAL;
    

-- Student 테이블의 '컴공' 학과 학생들에 대한 재적월수를 계산하여 조회. 기준일은 CURRENT_DATE 임.
SELECT
    ROUND(MONTHS_BETWEEN(CURRENT_DATE, I_DATE)) AS "재적월수"
FROM
    STUDENT
WHERE
    DEPT_ID = '컴공';

-- 현재시간에 4시간을 더하여 조회
SELECT
    SYSDATE + 4 / 24 AS "네 시간후"
FROM
    DUAL;
    
SELECT
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP + NUMTODSINTERVAL(4, 'HOUR') AS "네 시간후"
FROM
    DUAL;    

-- 'C1802' 학번의 '신지애' 학생이 2018년 7월 15일부로 1년간 휴학하였다. 복학 예정일을 조회해 주세요
SELECT
    A.*,
    '2018/07/15'                          AS "휴학 날짜",
    ADD_MONTHS(TO_DATE('2018/07/15'), 12) AS "복학 예정일"
FROM
    STUDENT A
WHERE
    STUDENT_ID = 'C1802';

SELECT
    A.*,
    '2018/07/15'                          AS "휴학 날짜",
    TO_DATE('180715', 'YYMMDD') + NUMTOYMINTERVAL(1, 'YEAR') AS "복학 예정일"
FROM
    STUDENT A
WHERE
    STUDENT_ID = 'C1802';

-- Student 테이블의 주민등록번호를 이용하여 생년월일을 추출하고, 날짜형 데이터로 'YYMMDD' 로 변환하여 'YYYY/MM/DD' 형식으로 조회
SELECT
    A.*,
    TO_CHAR(TO_DATE(SUBSTR(A.ID_NUMBER, 1, 6), 'rrMMDD'), 'YYYY/MM/DD') AS "생년월일"
FROM
    STUDENT A;


-- 현재 날짜와 시간을 'YYYY-MM-DD HH24:MI:SS FF3' 형식으로 변환하여 조회
SELECT
    TO_TIMESTAMP(SYSDATE, 'YYYY-mm-DD HH24:MI:SS.FF3'),
    TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-mm-DD HH24:MI:SS.FF3')
FROM
    DUAL;


-- Student 테이블의 입학날짜(I_Date) 컬럼을 'YYYY/MM/DD(DAY)' 형식으로 변환하여 입학일자순으로 조회
SELECT
    DEPT_ID,
    YEAR,
    STUDENT_ID,
    NAME,
    ID_NUMBER,
    ADDRESS,
    TELEPHONE,
    EMAIL,
    STATUS,
    TO_CHAR(I_DATE, 'YYYY-mm-DD DY') AS "입학 일자"
FROM
    STUDENT
ORDER BY
    TO_CHAR(I_DATE, 'YYYY-mm-DD DY');
    
    
-- SG_Scores 테이블의 성적(Score) 이 98점 이상자에 대하여 성적 취득일자를 'YYYY/MM/DD' 형식의 문자형으로 변환화여 조회
SELECT
    STUDENT_ID,
    COURSE_ID,
    SCORE,
    GRADE,
    TO_CHAR(SCORE_ASSIGNED, 'YYYY/mm/DD') AS "성적 취득 일자"
FROM
    SG_SCORES
WHERE
    SCORE >= 90;


-- SG_Scores 테이블로부터 점수가 98점 이상의 점수를 문자형으로 변환하여 조회
SELECT
    STUDENT_ID,
    COURSE_ID,
    TO_CHAR(SCORE),
    GRADE,
    SCORE_ASSIGNED
FROM
    SG_SCORES
WHERE
    SCORE >= 98;


-- SG_Scores 테이블의 성적이 98점 이상인 행에 대하여 성적을 'S999','B999','0.99.99' 형식으로 변환하여 조회
SELECT
    STUDENT_ID,
    COURSE_ID,
    TO_CHAR(SCORE, 'S999'),
    TO_CHAR(-SCORE, 'S999'),
    TO_CHAR(SCORE, 'B999.9'),
    TO_CHAR(SCORE, '099.99'),
    GRADE,
    SCORE_ASSIGNED
FROM
    SG_SCORES
WHERE
    SCORE >= 98;


-- Course 테이블의 추가 수강료가 4만원 과목에 대하여 문자열로 변환하여 '999,999', 'L999,999', 'C999G999' 형식으로 조회
-- 4만원 과목이 없어서 where절 주석처리
SELECT
    COURSE_ID,
    TITLE,
    C_NUMBER,
    PROFESSOR_ID,
    TO_CHAR(COURSE_FEES, '999,999'),
    TO_CHAR(COURSE_FEES, 'L999,999'),
    TO_CHAR(COURSE_FEES, 'C999G999')
FROM
    COURSE;
--where course_fees = 40000

-- '$123.45' 문자열을 숫자형으로 변환하여 조회
SELECT
    TO_NUMBER('$123.45', '$999,999.99')
FROM
    DUAL;


-- Course 테이블의 데이터를 조회할 때 Course_fees 가 null 일 때 0 으로 변환하여 조회
SELECT
    COURSE_ID,
    TITLE,
    C_NUMBER,
    PROFESSOR_ID,
    COALESCE(COURSE_FEES, 0)
FROM
    COURSE;


-- Course 테이블에서 추가수강료가 null 이 아닌 과목 중에서 4만원 미만인 행을 조회
SELECT
    COURSE_ID,
    TITLE,
    C_NUMBER,
    PROFESSOR_ID,
    COURSE_FEES
FROM
    COURSE
WHERE
    COURSE_FEES IS NOT NULL
    AND COURSE_FEES < 40000;


-- Course 테이블의 추가수강료를 5% 인상 금액을 조회
SELECT
    COURSE_ID,
    TITLE,
    C_NUMBER,
    PROFESSOR_ID,
    COURSE_FEES AS "원래 금액",
    ( COURSE_FEES * 0.05 ) + COURSE_FEES AS "인상 금액"  
FROM
    COURSE;


-- Student 테이블에서 학생의 전화번호, 이메일주소, 주소 순으로 대표 연락처를 조회
SELECT
    NAME,
    TELEPHONE,
    EMAIL,
   COALESCE(TELEPHONE, EMAIL, ADDRESS) AS "대표 연락처"
FROM
    STUDENT;


-- '컴퓨터공학과' 학생의 주민등록번호를 이용하여 성별코드가 '1','3' 일 때 '남', '2','4' 일 때 '여'로 변환하여 조회
SELECT
    DEPT_ID,
    YEAR,
    STUDENT_ID,
    NAME,
       (
       CASE
           WHEN SUBSTR(ID_NUMBER, 8, 1) IN ( '1', '3' ) THEN '남'
           WHEN SUBSTR(ID_NUMBER, 8, 1) IN ( '2', '4' ) THEN '여'
       END
        ) AS "성별",
    ADDRESS,
    TELEPHONE,
    EMAIL,
    STATUS,
    I_DATE
FROM
    STUDENT;


-- 'C1601' 학번에 대하여 SG_Scores 테이블의 성적을 'A'(90-100), 'B'(80-89), 'C'(70-79), 'D'(60-69), 'F'(0-59) 등급으로 변환하여 과목코드순으로 조회
SELECT
    STUDENT_ID,
    COURSE_ID,
    SCORE,
    (
     CASE
        WHEN SCORE BETWEEN 90 AND 100 THEN 'A'
        WHEN SCORE BETWEEN 80 AND 89  THEN 'B'
        WHEN SCORE BETWEEN 70 AND 79  THEN 'C'
        WHEN SCORE BETWEEN 60 AND 69  THEN 'D'
        ELSE 'F'
     END
     )AS "GRADE",
    SCORE_ASSIGNED
FROM
    SG_SCORES
WHERE
    STUDENT_ID = 'C1601'
ORDER BY
    COURSE_ID;


-- Professor 테이블에서 직위를 '총장','교수','부교수','조교수','초빙교수' 의 직위별 , 학과 코드순으로 조회
SELECT
    *
FROM
    PROFESSOR
ORDER BY
    DECODE(POSITION, '총장', 1,
                     '교수', 2,
                     '부교수', 3,
                     '조교수', 4,
                     '초빙교수'),
    DEPT_ID;


-- 서울 거주자 성씨 추출
SELECT
    NAME AS "이름",
    SUBSTR(NAME, 1, 1) AS "성",
    TELEPHONE,
    ADDRESS
FROM
    EC_MEMBER
WHERE
    ADDRESS LIKE '서울%';


-- 컴퓨터 제품의 재고수량을 단위와 결합
SELECT
    PRODUCT_CODE,
    PRODUCT_NAME,
    UNIT,
    LEFT_QTY,
    COMPANY,
    CONCAT(LEFT_QTY, UNIT) AS "갯수"
FROM
    EC_PRODUCT
WHERE PRODUCT_NAME LIKE '%컴퓨터%';
    

-- 100만원 이상 주문자 년월 변환
SELECT
    ORDER_NO,
    ORDER_ID,
    PRODUCT_CODE,
    ORDER_QTY,
    CSEL,
    CMONEY,
    TO_CHAR(CDATE, 'YYYY-mm') AS "결제일자",
    MDATE,
    GUBUN
FROM
    EC_ORDER
WHERE
    CMONEY >= 1000000;
    
    
-- 회원가입 기간 1년 이상인 회원
SELECT
    USERID,
    PASSWD,
    NAME,
    REGIST_NO,
    EMAIL,
    TELEPHONE,
    ADDRESS,
    BUYCASH,
    TIMESTAMP    AS "가입일자",
    TRUNC(MONTHS_BETWEEN(CURRENT_DATE, TIMESTAMP) / 12) || '년 ' || MOD(TRUNC(MONTHS_BETWEEN(CURRENT_DATE, TIMESTAMP)), 12) || '개월' AS 가입기간,
    CURRENT_DATE AS "기준일자"
FROM
    EC_MEMBER
WHERE
    TRUNC(MONTHS_BETWEEN(CURRENT_DATE, TIMESTAMP) / 12) >= 1;


-- '신용카드'로 결제한 회원에 대하여 EXTRACT() 함수를 이용하여 결제년도와 결제 월을 추출
SELECT
    ORDER_NO,
    ORDER_ID,
    PRODUCT_CODE,
    ORDER_QTY,
    CSEL,
    CMONEY,
    CDATE,
    MDATE,
    GUBUN,
    EXTRACT(YEAR FROM CDATE) AS "결제년도",
    EXTRACT(MONTH FROM CDATE) AS "결제 월"
FROM
    EC_ORDER
WHERE CSEL = '신용카드';
    
    
-- 등급 산출
SELECT
    STUDENT_ID,
    COURSE_ID,
    SCORE,
    (
        CASE
            WHEN SCORE BETWEEN 90 AND 100 THEN
                'A'
            WHEN SCORE BETWEEN 80 AND 89  THEN
                'B'
            WHEN SCORE BETWEEN 70 AND 79  THEN
                'C'
            WHEN SCORE BETWEEN 60 AND 69  THEN
                'D'
            ELSE
                'F'
        END
    ) AS "GRADE",
    SCORE_ASSIGNED
FROM
    T_SG_SCORES;
    
-- 등급 산출
UPDATE T_SG_SCORES
SET GRADE = 
        CASE
            WHEN SCORE BETWEEN 95 AND 100 THEN
                'A+'
            WHEN SCORE BETWEEN 90 AND 94 THEN
                'A'
            WHEN SCORE BETWEEN 85 AND 89  THEN
                'B+'
            WHEN SCORE BETWEEN 80 AND 84  THEN
                'B'
            WHEN SCORE BETWEEN 75 AND 79  THEN
                'C+'
            WHEN SCORE BETWEEN 70 AND 74  THEN
                'C'
            WHEN SCORE BETWEEN 65 AND 69  THEN
                'D+'    
            WHEN SCORE BETWEEN 60 AND 64  THEN
                'D'
            ELSE
                'F'
        END
WHERE
    GRADE IS NULL;    
    


-- 수강임시(T_SG_Scroes)테이블에서 'C1801'학번의 성적을 5로 나누어 몫과 나머지를 계산하여 [학번, 과목코드, 성적, 몫, 나머지]를 출력하시오.
SELECT
    STUDENT_ID,
    COURSE_ID,
    SCORE,
    FLOOR(SCORE / 5) AS "몫",
    MOD(SCORE, 5)    AS "나머지"
FROM
    T_SG_SCORES
WHERE
    STUDENT_ID = 'C1801';


-- 학점 출력
SELECT
    STUDENT_ID,
    COURSE_ID,
    GRADE,
    (
     CASE
        GRADE WHEN 'A+' THEN '4.5'
        WHEN 'A ' THEN '4.0'
        WHEN 'B+' THEN '3.5'
        WHEN 'B ' THEN '3.0'
        WHEN 'C+' THEN '2.5'
        WHEN 'C ' THEN '2.0'
        WHEN 'D+' THEN '1.5'
        WHEN 'D ' THEN '1.0'
        ELSE '0.0'
    END
    ) AS "학점"
FROM
    T_SG_SCORES
WHERE
    STUDENT_ID = 'C1801';


-- 널 값 0으로
SELECT
    COURSE_ID,
    TITLE,
    C_NUMBER,
    PROFESSOR_ID,
    COALESCE(COURSE_FEES, 0)
FROM
    T_COURSE;


-- 5일 더하고 4시간 더하기
SELECT
    SUBSTR(TO_CHAR(CURRENT_DATE + 5) , 1 ,10) || SUBSTR(TO_CHAR(CURRENT_DATE + 4 / 24),11) AS "날짜"
FROM
    DUAL;
    

-- 사용자 지정 출력
SELECT
    *
FROM
    EC_PRODUCT
ORDER BY
    DECODE(PRODUCT_NAME, '개인용컴퓨터', 1,
                         '노트북컴퓨터', 2,
                         '프린터', 3,
                         'TV', 4),
    UNIT_PRICE DESC;


-- Student 테이블의 행의 수와 Email이 저장된 행의 수를 조회
SELECT
    COUNT(*) AS "전체 행",
    COUNT(EMAIL) AS "이메일 행"
FROM
    STUDENT
WHERE
    EMAIL IS NOT NULL;


-- SG_Scores 테이블에서 'C1701' 학번의 취득과목수를 조회
SELECT
    COUNT(*) AS CNT
FROM
    SG_SCORES
WHERE
    STUDENT_ID = 'C1701' AND GRADE IS NOT NULL;


-- 최고 최저 점수
SELECT
    MAX(SCORE) AS "최고 점수",
    MIN(SCORE) AS "최저 점수"
FROM
    SG_SCORES
    WHERE COURSE_ID = 'L1031';


-- 표준편차, 분산
SELECT
    STDDEV(SCORE) AS "표준편차",
    VARIANCE(SCORE) AS "분산"
FROM
    SG_SCORES
    WHERE COURSE_ID = 'L1031';


-- Professor 테이블을 이용하여 학과별 교수 인원수를 조회
SELECT
    DEPT_ID AS "학과",
    COUNT(DEPT_ID) AS "인원수"
FROM
    PROFESSOR
GROUP BY
    DEPT_ID;


-- Professor 테이블을 이용하여 학과별 교수 인원수가 1명인 학과를 조회
SELECT
    DEPT_ID AS "학과",
    COUNT(DEPT_ID) AS "인원수"
FROM
    PROFESSOR
GROUP BY
    DEPT_ID
HAVING COUNT(DEPT_ID) = 1 ;


-- SG_Scores 테이블에서 학번별의 8과목 이상을 취득한 학번의 과목수와 평균을 학번순으로 조회
SELECT
    STUDENT_ID,
    COUNT(1) AS "취득 과목수",
    TO_CHAR(AVG(SCORE), '99.99') AS "평균"
FROM
    SG_SCORES
GROUP BY
STUDENT_ID
HAVING COUNT(1) >= 8
ORDER BY 1;


-- 학과별 학년별 인원수
--SELECT
--    DEPT_ID,
--    COUNT(DEPT_ID) AS "학과별 인원수",
--    CASE WHEN YEAR = 1 THEN CONCAT('1학년 인원수 ',COUNT(YEAR))
--    WHEN YEAR = 2 THEN CONCAT('2학년 인원수 ', COUNT(YEAR))
--    ELSE CONCAT('3학년 인원수 ', COUNT(YEAR))
--     END AS "인원수"
--FROM
--    STUDENT
--GROUP BY
--    DEPT_ID,
--    YEAR
--ORDER BY
--    YEAR;
    
SELECT
    DEPT_ID,
    YEAR,
    COUNT(*) AS "인원 수"
FROM
    STUDENT
GROUP BY
    DEPT_ID,
    YEAR;
    

-- 총 회원수
SELECT
    COUNT(*) AS "총 회원수"
FROM
    EC_MEMBER;
    

-- 최고 최저
SELECT
    MAX(CMONEY) AS "최고 금액",
    MIN(CMONEY) AS "최저 금액"
FROM
    EC_ORDER;
    

-- 남녀 회원수    
SELECT
    COUNT((CASE WHEN SUBSTR(REGIST_NO, 8, 1) IN ( '1', '3' ) THEN '남'  END)) AS "남자 회원수",
    COUNT((CASE WHEN SUBSTR(REGIST_NO, 8, 1) IN ( '2', '4' ) THEN '여'  END)) AS "여자 회원수"
FROM
    EC_MEMBER;    


-- 년월별 결제금액이 가장 많은 금액
SELECT
    TO_CHAR(Cdate, 'YYYY/MM') AS "결제년월",
    TO_CHAR(MAX(CMoney),'L999,999,999') AS "결제최대금액"
FROM
    EC_ORDER
WHERE 
    CDATE IS NOT NULL
GROUP BY
    TO_CHAR(Cdate, 'YYYY/MM');
    
    
-- 과목 합계 평균 계산
SELECT
    STUDENT_ID,
    COUNT(*) AS "과목수",
    SUM(SCORE) AS "총점",
    AVG(SCORE) AS "평균"
FROM 
    T_SG_SCORES
WHERE
    SCORE IS NOT NULL
GROUP BY
    STUDENT_ID;
    
    
-- 게시물 행
SELECT
    COUNT(*) AS "총게시물수"
FROM
    FREE_BOARD;
SELECT
    CASE
        WHEN MAX(B_ID) IS NULL THEN 1
        ELSE MAX(B_ID) + 1
    END AS "게시물번호"
FROM
    FREE_BOARD;
    
    
-- 담당하고 있는 과목
SELECT
    A.PROFESSOR_ID,
    A.NAME,
    A.POSITION,
    A.DEPT_ID,
    B.TITLE,
    B.C_NUMBER
FROM
    PROFESSOR A
    LEFT JOIN COURSE B
        ON A.PROFESSOR_ID = B.PROFESSOR_ID
WHERE
    COURSE_ID IS NOT NULL;
    

-- 취득한 과목
SELECT
    B.YEAR,
    B.NAME,
    C.COURSE_ID,
    C.TITLE,
    C.C_NUMBER,
    A.SCORE,
    A.GRADE
FROM
    SG_SCORES A
    LEFT JOIN STUDENT   B ON A.STUDENT_ID = B.STUDENT_ID
    LEFT JOIN COURSE    C ON A.COURSE_ID = C.COURSE_ID
WHERE
    A.STUDENT_ID = 'C1701';


-- 교수가 개설한 과목
SELECT
    A.PROFESSOR_ID,
    A.NAME,
    A.POSITION,
    B.TITLE,
    B.C_NUMBER
FROM
    PROFESSOR A
    LEFT JOIN COURSE B
        ON A.PROFESSOR_ID = B.PROFESSOR_ID
WHERE
    A.PROFESSOR_ID IN (
        SELECT
            B.PROFESSOR_ID
        FROM
            COURSE B
    )
ORDER BY
    PROFESSOR_ID;


-- 과목을 개설하지 않은 교수
SELECT
    A.PROFESSOR_ID,
    A.NAME,
    A.POSITION,
    B.TITLE,
    B.C_NUMBER
FROM
    PROFESSOR A
    LEFT JOIN COURSE B
        ON A.PROFESSOR_ID = B.PROFESSOR_ID
WHERE
    B.TITLE IS NULL
ORDER BY
    PROFESSOR_ID;


-- 교수의 관리자명
SELECT
    A.NAME     AS "교수명",
    A.POSITION AS "직위",
    B.NAME     AS "관리자명",
    B.POSITION AS "관리자 직위"
FROM
    PROFESSOR A
    LEFT JOIN PROFESSOR B ON A.MGR = B.PROFESSOR_ID
ORDER BY
    A.MGR;
    
SELECT
    A.PROFESSOR_ID,
    A.DEPT_ID,
    A.DUTY,
    A.NAME  ||   A.POSITION AS "교수명",
    B.NAME  ||   B.DUTY AS "관리자명"
FROM
    PROFESSOR A
    LEFT JOIN PROFESSOR B ON A.MGR = B.PROFESSOR_ID
ORDER BY
    A.MGR;   
    
    
-- 추가 수강료 5만원 담당 교수
SELECT
    A.DEPT_ID,
    A.NAME,
    A.POSITION
FROM
    PROFESSOR A
    LEFT JOIN COURSE    B ON A.PROFESSOR_ID = B.PROFESSOR_ID
WHERE
    B.COURSE_FEES = 50000;
    
SELECT
    A.DEPT_ID,
    A.NAME,
    A.POSITION
FROM
    PROFESSOR A
WHERE
    EXISTS (
            SELECT
                *
            FROM
                COURSE B
            WHERE A.PROFESSOR_ID = B.PROFESSOR_ID
            AND COURSE_FEES = 50000
            );
    
    
-- 담당교수가 없는 과목
SELECT
    A.COURSE_ID,
    A.TITLE,
    A.C_NUMBER,
    A.PROFESSOR_ID,
    A.COURSE_FEES
FROM
    COURSE A
    LEFT JOIN PROFESSOR B
        ON A.PROFESSOR_ID = B.PROFESSOR_ID
WHERE
    A.PROFESSOR_ID IS NULL;
    
    
SELECT
    *
FROM
    COURSE
WHERE
    PROFESSOR_ID NOT IN( SELECT PROFESSOR_ID FROM PROFESSOR);


-- 한번 이상 거래한 회원
SELECT
    A.NAME,
    A.REGIST_NO,
    C.PRODUCT_NAME,
    B.ORDER_QTY,
    B.CMONEY
FROM
    EC_MEMBER A
    LEFT JOIN EC_ORDER B
        ON A.USERID = B.ORDER_ID
    LEFT JOIN EC_PRODUCT C
        ON B.PRODUCT_CODE = C.PRODUCT_CODE
WHERE
    B.ORDER_QTY >= 1;
    
SELECT
    A.NAME,
    A.REGIST_NO,
    B.ORDER_QTY,
    B.CMONEY
FROM
    EC_MEMBER A
    INNER JOIN EC_ORDER B
        ON A.USERID = B.ORDER_ID
WHERE
    B.ORDER_QTY >= 1;    


-- 한번도 주문하지 않은 회원
SELECT
    A.NAME,
    A.REGIST_NO,
    A.TELEPHONE
FROM
    EC_MEMBER A
    LEFT JOIN EC_ORDER B
        ON A.USERID = B.ORDER_ID
WHERE
    B.ORDER_QTY IS NULL OR B.ORDER_QTY = 0;


-- 한번 이상 거래한 회원중 서울에 사는 사람
SELECT
    A.NAME,
    A.REGIST_NO,
    C.PRODUCT_NAME,
    B.ORDER_QTY,
    C.UNIT_PRICE,
    A.ADDRESS
FROM
    EC_MEMBER A
    JOIN EC_ORDER B
        ON A.USERID = B.ORDER_ID
    JOIN EC_PRODUCT C
        ON B.PRODUCT_CODE = C.PRODUCT_CODE
WHERE
    B.ORDER_QTY >= 1
    AND A.ADDRESS LIKE '%서울%';


-- C1801의 수강신청 과목
SELECT
    C.DEPT_ID,
    C.YEAR,
    B.STUDENT_ID,
    C.NAME,
    B.COURSE_ID,
    A.TITLE,
    A.C_NUMBER,
    B.GRADE,
    B.SCORE
FROM
    T_COURSE A
        JOIN T_SG_SCORES B
            ON A.COURSE_ID = B.COURSE_ID
        JOIN STUDENT C
            ON B.STUDENT_ID = C.STUDENT_ID
WHERE
    C.STUDENT_ID = 'C1801';
    
SELECT
    DEPT_ID,
    YEAR,
    STUDENT_ID,
    NAME,
    COURSE_ID,
    TITLE,
    C_NUMBER,
    GRADE
FROM T_SG_SCORES
    INNER JOIN STUDENT USING(STUDENT_ID)
    INNER JOIN T_COURSE USING(COURSE_ID)
WHERE
    STUDENT_ID = 'C1801';
    
    
-- C1801의 성적
SELECT
    C.DEPT_ID,
    C.YEAR,
    B.STUDENT_ID,
    C.NAME,
    B.COURSE_ID,
    A.TITLE,
    A.C_NUMBER,
    B.GRADE,
    B.SCORE
FROM
    T_COURSE A
        JOIN T_SG_SCORES B
            ON A.COURSE_ID = B.COURSE_ID
        JOIN STUDENT C
            ON B.STUDENT_ID = C.STUDENT_ID
WHERE
    C.STUDENT_ID = 'C1801'; 
    
SELECT
    DEPT_ID,
    YEAR,
    STUDENT_ID,
    NAME,
    COURSE_ID,
    TITLE,
    C_NUMBER,
    GRADE
FROM T_SG_SCORES
    INNER JOIN STUDENT USING(STUDENT_ID)
    INNER JOIN T_COURSE USING(COURSE_ID)
WHERE
    STUDENT_ID = 'C1801';    

-- 평점
SELECT 
    A.Student_ID,
    A.Course_ID,
    C.Title,
    C.C_Number AS "학점",
    A.Grade,
    CASE
        A.Grade WHEN 'A+' THEN 4.5
              WHEN 'A' THEN 4.0
              WHEN 'B+' THEN 3.5
              WHEN 'B' THEN 3.0
              WHEN 'C+' THEN 2.5
              WHEN 'C' THEN 2.0
              WHEN 'D+' THEN 1.5
              WHEN 'D' THEN 1.0
              ELSE 0.0  END AS "등급평점",
    CASE
        A.Grade WHEN 'A+' THEN 4.5
              WHEN 'A' THEN 4.0
              WHEN 'B+'  THEN 3.5
              WHEN 'B' THEN 3.0
              WHEN 'C+' THEN 2.5
              WHEN 'C' THEN 2.0
              WHEN 'D+' THEN 1.5
              WHEN 'D' THEN 1.0 
              ELSE 0.0 END * C.C_Number AS "과목평점"
FROM
    T_SG_Scores A
    JOIN Student B
        ON A.Student_ID = B.Student_ID
    JOIN T_Course C 
        ON A.Course_ID = C.Course_ID
WHERE
    A.Student_ID = 'C1802';
    
SELECT 
    Student_ID,
    Course_ID,
    Title,
    C_Number AS "학점",
    Grade,
    CASE
        Grade WHEN 'A+' THEN 4.5
              WHEN 'A' THEN 4.0
              WHEN 'B+' THEN 3.5
              WHEN 'B' THEN 3.0
              WHEN 'C+' THEN 2.5
              WHEN 'C' THEN 2.0
              WHEN 'D+' THEN 1.5
              WHEN 'D' THEN 1.0
              ELSE 0.0  END "등급평점",
    CASE
        Grade WHEN 'A+' THEN 4.5
              WHEN 'A' THEN 4.0
              WHEN 'B+'  THEN 3.5
              WHEN 'B' THEN 3.0
              WHEN 'C+' THEN 2.5
              WHEN 'C' THEN 2.0
              WHEN 'D+' THEN 1.5
              WHEN 'D' THEN 1.0 
              ELSE 0.0 END * C_Number AS "과목평점"
FROM
    T_SG_Scores 
    JOIN Student USING(Student_ID)
    JOIN T_Course USING(Course_ID)
WHERE
    Student_ID = 'C1802';    


-- 합계와 평균
SELECT
    B.DEPT_ID,
    B.YEAR,
    B.STUDENT_ID,
    B.NAME,
    COUNT(*)   AS "과목수",
    SUM(A.SCORE) AS "총점",
    TO_CHAR(ROUND(AVG(A.SCORE),2),'999.99') AS "평균"
FROM T_SG_SCORES A
    JOIN STUDENT B
        ON A.STUDENT_ID = B.STUDENT_ID
WHERE
    A.SCORE IS NOT NULL
GROUP BY
    B.DEPT_ID,
    B.YEAR,
    B.STUDENT_ID,
    B.NAME
ORDER BY
    TO_CHAR(ROUND(AVG(A.SCORE),2),'999.99') DESC;

  
-- 평균점수보다 높은 점수
SELECT
    *
FROM
    SG_SCORES
WHERE
        COURSE_ID = 'L1031'
    AND SCORE > (
                    SELECT
                        AVG(SCORE)
                    FROM
                        SG_SCORES
                 );
  
    
-- 최고점을 받은 학생 
SELECT
    STUDENT_ID,
    COURSE_ID,
    SCORE,
    SCORE_ASSIGNED
FROM
    SG_SCORES
WHERE
    SCORE = (
        SELECT
            MAX(SCORE)
        FROM
            SG_SCORES
        WHERE
            COURSE_ID = 'L1031'
    );
  
    
-- 최고점을 받은 학생의 성적 취득 년월
SELECT
    STUDENT_ID,
    COURSE_ID,
    SCORE,
    TO_CHAR(SCORE_ASSIGNED, 'yy') AS "취득 년",
    TO_CHAR(SCORE_ASSIGNED, 'mm') AS "취득 월"
FROM
    SG_SCORES
WHERE
    SCORE in  (
        SELECT
            MAX(SCORE)
        FROM
            SG_SCORES
        GROUP BY
            TO_CHAR(SCORE_ASSIGNED, 'yy'),
            TO_CHAR(SCORE_ASSIGNED, 'mm')
    );  
    
 
-- any 사용 / 최하 점수 보다 높은 점수 학생 출력
SELECT
    STUDENT_ID,
    COURSE_ID,
    SCORE,
    SCORE_ASSIGNED
FROM
    SG_SCORES
WHERE
    SCORE > ANY (
        SELECT
            MIN(SCORE)
        FROM
            SG_SCORES
        WHERE
            COURSE_ID = 'L1031'
    )
AND COURSE_ID = 'L1031';
 
     
-- all 사용 / 년도별 최고 점수    
SELECT
    STUDENT_ID,
    COURSE_ID,
    SCORE,
    SCORE_ASSIGNED
FROM
    SG_SCORES
WHERE
    SCORE >= ALL (
        SELECT
            MAX(SCORE)
        FROM
            SG_SCORES
        GROUP BY
            TO_CHAR(SCORE_ASSIGNED, 'yy')
    );


-- exists 사용 / 강의를 담당하지 않은 교수
SELECT
    *
FROM
    PROFESSOR A
WHERE
    EXISTS (
        SELECT
            *
        FROM
            COURSE B
        WHERE
            B.PROFESSOR_ID = A.PROFESSOR_ID
    )
    AND A.PROFESSOR_ID IS NOT NULL;
    
SELECT
    *
FROM
    PROFESSOR A
WHERE
     NOT EXISTS (
        SELECT
            *
        FROM
            COURSE B
        WHERE
            B.PROFESSOR_ID = A.PROFESSOR_ID
    )
    AND A.PROFESSOR_ID IS NOT NULL;    


-- select 서브쿼리로 조회
SELECT
    NAME,
    DEPT_ID,
    (
        SELECT
            COUNT(DEPT_ID)
        FROM
            PROFESSOR
        WHERE
            DEPT_ID = (
                        SELECT
                            DEPT_ID
                        FROM
                            PROFESSOR
                        WHERE
                            PROFESSOR_ID = 'P12'
                        )
    ) AS "소속 학과의 교수 수"
FROM
    PROFESSOR
WHERE
    PROFESSOR_ID = 'P12';



-- 한 과목 초과 학점 취득자 > ??
SELECT
    M.STUDENT_ID,
    NAME,
    COUNT(*) AS "취득 과목수",
    (
    SELECT
        SUM(C_NUMBER)
    FROM
        SG_SCORES
        INNER JOIN COURSE USING(COURSE_ID)
    WHERE
        STUDENT_ID = M.STUDENT_ID
    GROUP BY
        STUDENT_ID 
    ) AS "취득 학점수"
FROM SG_SCORES M
INNER JOIN STUDENT S
    ON M.STUDENT_ID = S.STUDENT_ID
GROUP BY
    M.STUDENT_ID,
    NAME
HAVING COUNT(*) > 1
ORDER BY
    4 DESC;




-- 총 취득 학점 ??
SELECT
    STUDENT_ID,
    SUM(C_NUMBER)
FROM
    SG_SCORES
INNER JOIN COURSE USING(COURSE_ID)
GROUP BY
    STUDENT_ID
HAVING SUM(C_NUMBER) > (
                        SELECT
                            SUM(C_NUMBER)
                        FROM SG_SCORES
                            INNER JOIN COURSE
                                USING(COURSE_ID)
                        WHERE STUDENT_ID = 'C1602'
                        );


-- Create select
CREATE TABLE STUDENT_COMUPUTER
    AS
        SELECT
            *
        FROM
            STUDENT
        WHERE
            DEPT_ID = '컴공';

SELECT
    *
FROM
    STUDENT_COMUPUTER;
    
    
-- 주문처리(EC_Order) 테이블로부터 'jupark' 가 주문한 상품과 동일한 상품의 구매자수를 조회
SELECT
    COUNT(*) AS "구매자수"
FROM
    EC_ORDER
WHERE
    PRODUCT_CODE IN (
        SELECT
            PRODUCT_CODE
        FROM
            EC_ORDER
        WHERE
            ORDER_ID = 'jupark'
    )
    AND ORDER_ID <> 'jupark';
    
SELECT
    ORDER_ID,
    PRODUCT_CODE,
    (
    SELECT
        COUNT(*)
    FROM
        EC_ORDER A
    WHERE
        A.PRODUCT_CODE = B.PRODUCT_CODE
    ) AS "동일상품 구매자수"
FROM
    EC_ORDER B
WHERE
    ORDER_ID = 'jupark';
   


-- 추가 수강료가 평균 수강료보다 높은 과목
SELECT
    AVG(COURSE_FEES)
FROM
    T_COURSE
WHERE
    COURSE_FEES > (
        SELECT
            AVG(COURSE_FEES)
        FROM
            T_COURSE
    );


-- any / 가장 낮은 금액보다 많은 과목을 추가수강료 역순
SELECT
    *
FROM
    T_COURSE
WHERE
    COURSE_FEES > ANY (
        SELECT
            MIN(COURSE_FEES)
        FROM
            T_COURSE
    )
ORDER BY
    COURSE_FEES DESC;
    
SELECT
    *
FROM
    T_COURSE
WHERE
    COURSE_ID LIKE 'L1%'
    AND
    COURSE_FEES > ANY (
        SELECT
            COURSE_FEES
        FROM
            T_COURSE
    )
ORDER BY
    COURSE_FEES DESC;    
    
    
-- any 과목코드별 최고점    
SELECT
    COURSE_ID,
    STUDENT_ID,
    SCORE,
    SCORE_ASSIGNED
FROM
    T_SG_SCORES
WHERE
    ( COURSE_ID, SCORE ) = ANY (
                                SELECT
                                    COURSE_ID, MAX(SCORE)
                                FROM
                                    T_SG_SCORES
                                WHERE
                                    TO_CHAR(SCORE_ASSIGNED, 'YY/MM') = '18/06'
                                GROUP BY
                                    COURSE_ID
                             )
ORDER BY
    COURSE_ID;
    

-- exists 사용 / 한 명 이상 수강한 과목 과목코드순 출력
SELECT
    *
FROM
    T_Course A
WHERE
    EXISTS (
                SELECT
                    *
                FROM T_SG_Scores B
                WHERE B.Course_ID = A.Course_ID
            )
ORDER BY
    A.COURSE_ID;
    

-- 한번도 수강하지 않은 과목    
SELECT
    *
FROM
    T_Course A
WHERE
    NOT EXISTS(
                SELECT *
                    FROM T_SG_Scores B
                WHERE B.Course_ID = A.Course_ID
                 )
ORDER BY
    A.COURSE_ID;   