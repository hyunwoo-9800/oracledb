-- Department 테이블의 모든 데이터를 조회
SELECT
    *
FROM
    DEPARTMENT;

-- Professor 테이블의 중복되지 않은 Dept_Id 컬럼의 값들을 조회
SELECT DISTINCT
    DEPT_ID
FROM
    PROFESSOR;

-- Professor 테이블의 중복되지 않은 Dept_Id 컬럼의 값들을 조회, 단 '소속학과' 로 출력
SELECT DISTINCT
    DEPT_ID AS "소속학과"
FROM
    PROFESSOR;

-- Course 테이블에서 과목코드(Course_Id),  과목명(Title), 학점수(C_Number) 로 조회해 주세요
SELECT
    CUR.COURSE_ID,
    CUR.TITLE,
    CUR.C_NUMBER
FROM
    COURSE CUR;

-- Course 테이블에서 과목코드(Course_Id),  과목명(Title), 학점수(C_Number) 를 과목명(title) 오름차순으로 조회
SELECT
    CUR.COURSE_ID,
    CUR.TITLE,
    CUR.C_NUMBER
FROM
    COURSE CUR
ORDER BY
    TITLE;

-- Course 테이블에서 과목코드(Course_Id),  과목명(Title), 학점수(C_Number),과목별 수강료(학점수 * 30000 + 추가수강료) 로 조회하되, 과목별 수강료를 내림차순, 과목코드는 오름차순으로 조회해 주세요 
SELECT
    CUR.COURSE_ID AS "과목코드",
    CUR.TITLE AS "과목명",
    CUR.C_NUMBER AS "학점수",
    ( ( C_NUMBER * 30000 ) + COURSE_FEES ) AS "과목별 수강료"
FROM
    COURSE CUR
ORDER BY
    ( ( C_NUMBER * 30000 ) + COURSE_FEES ) DESC,
    COURSE_ID ASC;

-- Professor 테이블로부터 '컴공' 학과의 교수명을 조회
SELECT
    *
FROM
    PROFESSOR
WHERE
    DEPT_ID = '컴공';

-- Course 테이블로부터 추가 수강료가 30000원 이상인 과목명을 조회하되, 추가 수강료를 내림차순으로 조회
SELECT
    CUR.TITLE
FROM
    COURSE CUR
WHERE
    COURSE_FEES >= 30000
ORDER BY
    COURSE_FEES DESC;

-- Student 테이블에서 '컴공' 학과 2학년 학생의 학과, 학년, 성명을 조회
SELECT
    STD.DEPT_ID,
    STD.YEAR,
    STD.NAME
FROM
    STUDENT STD
WHERE
        DEPT_ID = '컴공'
    AND YEAR = 2;

-- Student 테이블에서 '컴공'학과 2학년 학생을 다중 컬럼으로 검색하여 조회
SELECT
    *
FROM
    STUDENT
WHERE
        DEPT_ID = '컴공'
    AND YEAR = 2;

-- Professor 테이블에서 xxxx(Dept_ID)  학과 xxx(교수명) xxx(Position) 의 전화번호는 xxx(Telephone) 이다  정보로 출력
SELECT
    DEPT_ID || '학과 ' || NAME || POSITION || '의 전화 번호는 ' || TELEPHONE || ' 이다' AS PRINT
FROM
    PROFESSOR;

-- Student 테이블로부터 '이'씨 성의 학생 명단을 조회
SELECT
    *
FROM
    STUDENT
WHERE
    NAME LIKE '이%';

-- Student 테이블로부터 성명(name) 컬럼의 중간 글자가 '정' 자인 학생을 조회
SELECT
    *
FROM
    STUDENT
WHERE
    NAME LIKE '_정%';

-- Student 테이블로부터 '이'씨와 '김'씨 성을 제외한 학생 명단을 조회
SELECT
    *
FROM
    STUDENT
WHERE
    NAME NOT LIKE '이%'
    AND NAME NOT LIKE '김%';

-- Professor 테이블에서 학과 코드(Dept_ID) 가 '컴공', '정통' 학과에 재직중인 교수의 명단을 학과 코드순으로 조회 
SELECT
    *
FROM
    PROFESSOR
WHERE
    DEPT_ID IN ( '컴공', '정통' )
ORDER BY
    MGR;

-- Professor 테이블에서 학과 코드(Dept_ID) 가 '컴공', '정통' 학과가 아닌 교수의 명단을 학과 코드순으로 조회
SELECT
    *
FROM
    PROFESSOR
WHERE
    DEPT_ID NOT IN ( '컴공', '정통' )
ORDER BY
    MGR;

-- SG_Scores 테이블에서 성적(Score) 이 90점 부터 94점까지 성적을 성적 내림차순으로 조회
SELECT
    *
FROM
    SG_SCORES
WHERE
    SCORE BETWEEN 90 AND 94
ORDER BY
    SCORE DESC;

-- SG_Scores 테이블에서 성적(Score) 이 60점부터 100점까지 제외한 성적을 성적순으로 조회
SELECT
    *
FROM
    SG_SCORES
WHERE
    SCORE NOT BETWEEN 60 AND 100
ORDER BY
    SCORE;

-- Course 테이블로부터 추가수강료가 null 인 행을 조회하여 과목명순으로 조회
SELECT
    *
FROM
    COURSE
WHERE
    COURSE_FEES IS NULL
ORDER BY
    TITLE;

-- Course 테이블로부터 추가수강료가 null 이 아닌 행을 조회하여 과목명순으로 조회
SELECT
    *
FROM
    COURSE
WHERE
    COURSE_FEES IS NOT NULL
ORDER BY
    TITLE;