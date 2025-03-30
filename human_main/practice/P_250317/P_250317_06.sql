-- 새로운 개설 과목을 T_Course 테이블에 저장해 주세요,
-- 과목코드는 'L1061', 과목명 'ERP 실문', 3학점, 담당교수가 'P12' 이고 추가 수강료가 50000원 이다 
SELECT
    *
FROM
    T_COURSE;

INSERT INTO T_COURSE VALUES ( 'L1061',
                              'ERP 실무',
                              3,
                              'P12',
                              50000 );

-- 새로운 개설 과목을 T_Course 테이블에 저장해 주세요.
-- 과목코드 'L1062',  과목명 '그룹웨어구축', 3학점, 담당교수가 'P13', 추가 수강료가 40000원 이다
INSERT INTO T_COURSE VALUES ( 'L1062', '그룹웨어구축', 3, 'P13', 40000 );

-- SG_Scores 테이블에 저장해 주세요.
-- 학번이 'B1701', 과목코드가 'L1051', 성적이 85점, 성적취득날짜는 2018년 6월 28일
-- 날짜 기본 형식으로 'YY/MM/DD'
SELECT
    *
FROM
    SG_SCORES;

INSERT INTO SG_SCORES VALUES ( 'B1701', 'L1051', 85, NULL, '2018/06/28' );

 
-- Course 테이블에 저장해 주세요.
--과목코드 'L3041', 과목명이 'JQUERY', 3학점, 교수번호가 'P31' , 추가수강료가 30000원
SELECT
    *
FROM
    COURSE;

-- ORA-02291: 무결성 제약조건(C##HUMAN.COURSE_FK)이 위배되었습니다- 부모 키가 없습니다
-- Professor테이블에  professor_id = 'P31'이 없음
INSERT INTO COURSE VALUES ( 'L3041', 'JQUERY', 3, 'P31', 30000 );

SELECT
    *
FROM
    PROFESSOR;

-- Course 테이블에 과목코드가 'L1031', 과목명이 'SQL', 3학점, 담당교수가 'P12', 추가수강료가 30000원
-- Course에이블에 과목코드가 'L1031'인 데이터가 이미 있음
INSERT INTO COURSE VALUES ( 'L1031', 'SQL', 3, 'P12', 30000 );

SELECT
    *
FROM
    COURSE;

-- Course 테이블에 과목명이 '정보보안', 3학점, 담당교수가 'P22', 추가 수강료는 30000원
-- pk를 지정지 않았음
INSERT INTO COURSE VALUES ( '정보보안', 3, 'P22', 30000 );

-- Professor 테이블에 컴퓨터공학과의 신임교수번호로
--'P14', 교수명은 '조성우', 직위는 '조교수', 전화번호는 '765-4114'
SELECT
    *
FROM
    PROFESSOR;

INSERT INTO PROFESSOR (PROFESSOR_ID, NAME, POSITION, TELEPHONE) VALUES
                      ( 'p14', '조성우', '조교수', '765-4114' );

-- '컴공'학과 2학년에 '박은혜' 학생이 편입하였다.
-- 학번은 'C1731', 주민번호는 ' 011119-4** ',  이메일 주소는 'c1731@cyber.ac.kr' 를 Student 테이블에 저장
SELECT
    *
FROM
    STUDENT;

INSERT INTO STUDENT ( DEPT_ID, YEAR, STUDENT_ID, NAME, ID_NUMBER, EMAIL) VALUES
                    ( '컴공', 2, 'C1731', '박은혜', '011119-4**', 'c1731@cyber.ac.kr' );

-- 컴퓨터공학과 시간강사를 위촉하였다.
-- 교수번호가 'P91', 교수명은 'Bob Miner', 직위는 '시간강사', 전화번호는 '765-4119' 정보를 Professor 테이블에 저장
SELECT
    *
FROM
    PROFESSOR;

-- POSITION 열에 대한 값이 너무 큼(실제: 12, 최대값: 10)
INSERT INTO PROFESSOR VALUES ( 'P91', 'Bob Miner', '초빙교수', '컴공', '765-4119',  NULL, NULL, NULL );

-- 학번이 'C1731', 과목코드가 'L1021', 성적이 97점, 성적취득일자가 2018년 6월 28일을 SG_Scrores 테이블에 저장
SELECT
    *
FROM
    SG_SCORES;

INSERT INTO SG_SCORES VALUES ( 'C1731', 'L1021', 97, NULL, '2018/06/28' );

-- Department 테이블의 학과명(dept_name) 을 '컴퓨터정보계열' 로 수정 한후
-- Department 테이블을 전체 조회해서 결과를 카피해서 주석에 붙여넣기 하고
-- rollback 해서 원 데이터로 돌려놓기

--대학	컴퓨터정보계열	765-4000
--컴공	컴퓨터정보계열	765-4100
--정통	컴퓨터정보계열	765-4200
--경영	컴퓨터정보계열	765-4400
--행정	컴퓨터정보계열	765-4500
SELECT
    *
FROM
    DEPARTMENT;
    
UPDATE DEPARTMENT
SET
    DEPT_NAME = '컴퓨터정보계열';
    
ROLLBACK;

-- Course 테이블의 과목명 'Delpi' 를 '델파이'로 변경
SELECT
    *
FROM
    COURSE;

UPDATE COURSE
SET
    TITLE = '델파이'
WHERE
    TITLE = 'Delphi';


-- 학번이 'C1601', 과목코드가 'L1021' 의 성적이 85점을 105점으로 잘못 입력하였다.
--SG_Scores 테이블의 성적을 수정해 주세요
SELECT
    *
FROM
    SG_SCORES
WHERE
        STUDENT_ID = 'C1601'
    AND COURSE_ID = 'L1021';

UPDATE SG_SCORES
SET
    SCORE = 85
WHERE
        STUDENT_ID = 'C1601'
    AND COURSE_ID = 'L1021';

-- SG_Scores 테이블에서 'L2601' 과목의 수강신청자를 검색하여 확인하고 SG_Scores 테이블 정보를 수정해 주세요
SELECT
    *
FROM
    SG_SCORES
WHERE
    COURSE_ID = 'L2061';

UPDATE SG_SCORES
SET
    SCORE = 87, SCORE_ASSIGNED = '2018/12/26'
WHERE
        COURSE_ID = 'L2061'
    AND STUDENT_ID = 'C1701';

UPDATE SG_SCORES
SET
    SCORE = 95, SCORE_ASSIGNED = '2018/12/26'
WHERE
        COURSE_ID = 'L2061'
    AND STUDENT_ID = 'C1702';

UPDATE SG_SCORES
SET
    SCORE = 99, SCORE_ASSIGNED = '2018/12/26'
WHERE
        COURSE_ID = 'L2061'
    AND STUDENT_ID = 'C1601';

UPDATE SG_SCORES
SET
    SCORE = 93, SCORE_ASSIGNED = '2018/12/26'
WHERE
        COURSE_ID = 'L2061'
    AND STUDENT_ID = 'C1602';

-- Course 테이블의 과목코드(Course_ID)가 'L0012', 과목명(Title) 이 '문학과 여행' 인 과목을 삭제
SELECT
    *
FROM
    COURSE;

DELETE FROM COURSE
WHERE
        COURSE_ID = 'L0012'
    AND TITLE = '문학과 여행';

SELECT
    *
FROM
    EC_PRODUCT;


-- EC_PRODUCT에 값 넣기
INSERT INTO EC_PRODUCT VALUES ( 'SP01',
                                '아이폰',
                                'IPHONE8+64G',
                                NULL,
                                816000,
                                10,
                                'APPLE',
                                'sp01.jpg',
                                NULL,
                                NULL );

INSERT INTO EC_PRODUCT VALUES ( 'SP02',
                                '갤럭시노트',
                                'NOTE8+256G',
                                NULL,
                                829000,
                                15,
                                'SAMSUNG',
                                'sp02.jpg',
                                NULL,
                                NULL );

INSERT INTO EC_PRODUCT VALUES ( 'SP03',
                                'G7 ThingQ',
                                'G7+128G',
                                NULL,
                                822000,
                                10,
                                'LG전자',
                                'sp03.jpg',
                                NULL,
                                NULL );

-- 들어간 값 확인
SELECT
    *
FROM
    EC_ORDER
WHERE
    MDATE = '2018/05/10';


-- EC_ORDER에 값 넣기
INSERT INTO EC_ORDER VALUES ( '180505002',
                              'kcchoi',
                              'DK01',
                              1,
                              NULL,
                              NULL,
                              NULL,
                              '2018/05/10',
                              '배달' );

INSERT INTO EC_ORDER VALUES ( '180505003',
                              'kcchoi',
                              'CH01',
                              1,
                              NULL,
                              NULL,
                              NULL,
                              '2018/05/10',
                              '배달' );

-- EC_ORDER.CSEL 열에 대한 값이 너무 큼(실제: 12, 최대값: 10)
INSERT INTO EC_ORDER VALUES ( '180707001',
                              'jupark',
                              ' ',
                              0,
                              '신용카드',
                              3735000,
                              NULL,
                              '2018/07/12',
                              '결제' );

-- EC_ORDER.CSEL 열에 대한 값이 너무 큼(실제: 12, 최대값: 10)
INSERT INTO EC_ORDER VALUES ( '180707002',
                              'jupark',
                              ' ',
                              0,
                              '신용카드',
                              4300000,
                              NULL,
                              '2018/07/12',
                              '결제' );

-- EC_ORDER.CSEL 열에 대한 값이 너무 큼(실제: 12, 최대값: 10)
INSERT INTO EC_ORDER VALUES ( '180707003',
                              'cscho',
                              ' ',
                              0,
                              '신용카드',
                              747000,
                              NULL,
                              '2018/07/12',
                              '결제' );

-- 주문처리(EC_Order) 테이블로 부터 2018년 7월 12일 결제한 주문번호, 상품코드, 주문수량, 결제금액, 결제방법, 결제일자를 주문번호순으로 조회
SELECT
    ORD.ORDER_NO,
    ORD.PRODUCT_CODE,
    ORD.ORDER_QTY,
    ORD.CMONEY,
    ORD.CSEL,
    ORD.MDATE
FROM
    EC_ORDER ORD
ORDER BY
    ORDER_NO;

SELECT
    *
FROM
    EC_MEMBER;

-- 회원관리(EC_Member) 테이블의 구매실적(BuyCash) 컬럼이 null 인 행으로 0 으로 수정
UPDATE EC_MEMBER
SET
    BUYCASH = 0
WHERE
    BUYCASH IS NULL;