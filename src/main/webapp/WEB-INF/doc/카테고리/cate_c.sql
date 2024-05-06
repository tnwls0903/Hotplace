/**********************************/
/* Table Name: 카테고리 */
/**********************************/
DROP TABLE CATE CASCADE CONSTRAINTS; -- 자식 테이블을 무시하고삭제

CREATE TABLE CATE(
		CATENO                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		NAME                          		VARCHAR2(30)		 NOT NULL,
		NAMESUB                       		VARCHAR2(30)		 DEFAULT '-'		 NOT NULL,
		CNT                           		NUMBER(7)		 DEFAULT 0		 NOT NULL,
		RDATE                         		DATE		 NOT NULL,
		SEQNO                         		NUMBER(5)		 DEFAULT 0		 NOT NULL,
		VISIBLE                       		CHAR(1)		 DEFAULT 'N'		 NOT NULL
);

COMMENT ON TABLE CATE is '카테고리';
COMMENT ON COLUMN CATE.CATENO is '카테고리번호';
COMMENT ON COLUMN CATE.NAME is '중분류명';
COMMENT ON COLUMN CATE.NAMESUB is '소분류명';
COMMENT ON COLUMN CATE.CNT is '관련 자료수';
COMMENT ON COLUMN CATE.RDATE is '등록일';
COMMENT ON COLUMN CATE.SEQNO is '출력 순서';
COMMENT ON COLUMN CATE.VISIBLE is '출력 모드';

DROP SEQUENCE CATE_SEQ;

CREATE SEQUENCE CATE_SEQ
    START WITH 1         -- 시작 번호
    INCREMENT BY 1       -- 증가값
    MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
    CACHE 2              -- 2번은 메모리에서만 계산
    NOCYCLE;             -- 다시 1부터 생성되는 것을 방지
       
-- CREATE
INSERT INTO cate(cateno, name, namesub, cnt, rdate, seqno, visible)
VALUES(CATE_SEQ.nextval, '개발', '-', 0, sysdate, 1, 'Y');

INSERT INTO cate(cateno, name, namesub, cnt, rdate, seqno, visible)
VALUES(CATE_SEQ.nextval, '오버렌딩', '-', 0, sysdate, 1, 'Y');

INSERT INTO cate(cateno, name, namesub, cnt, rdate, seqno, visible)
VALUES(CATE_SEQ.nextval, '개발', 'JAVA', 0, sysdate, 1, 'Y');

INSERT INTO cate(cateno, name, namesub, cnt, rdate, seqno, visible)
VALUES(CATE_SEQ.nextval, '개발', 'Python', 0, sysdate, 1, 'Y');

INSERT INTO cate(cateno, name, namesub, cnt, rdate, seqno, visible)
VALUES(CATE_SEQ.nextval, '오버렌딩', '홍천군', 0, sysdate, 1, 'Y');

INSERT INTO cate(cateno, name, namesub, cnt, rdate, seqno, visible)
VALUES(CATE_SEQ.nextval, '오버렌딩', '평창군', 0, sysdate, 1, 'Y');

SELECT * FROM cate;

COMMIT;

-- READ: 목록
SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
ORDER BY cateno ASC;

--    CATENO NAME                           NAMESUB                               CNT RDATE                    SEQNO V
------------ ------------------------------ ------------------------------ ---------- ------------------- ---------- -
--         1 개발                           -                                       0 2024-03-13 03:12:17          1 Y
--         2 오버렌딩                       -                                       0 2024-03-13 03:12:17          1 Y
--         3 개발                           JAVA                                    0 2024-03-13 03:13:05          1 Y
--         4 개발                           Python                                  0 2024-03-13 03:13:05          1 Y
--         5 오버렌딩                       홍천군                                  0 2024-03-13 03:14:30          1 Y
--         6 오버렌딩                       평창군                                  0 2024-03-13 03:14:30          1 Y

-- 목록 ★
SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
ORDER BY seqno ASC;

-- 중분류, 소분류 기준 정렬
SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
ORDER BY name ASC, namesub ASC;

--    CATENO NAME                           NAMESUB                               CNT RDATE                    SEQNO V
------------ ------------------------------ ------------------------------ ---------- ------------------- ---------- -
--         1 개발                           -                                       0 2024-03-13 03:12:17          1 Y
--         3 개발                           JAVA                                    0 2024-03-13 03:13:05          1 Y
--         4 개발                           Python                                  0 2024-03-13 03:13:05          1 Y
--         2 오버렌딩                       -                                       0 2024-03-13 03:12:17          1 Y
--         6 오버렌딩                       평창군                                  0 2024-03-13 03:14:30          1 Y
--         5 오버렌딩                       홍천군                                  0 2024-03-13 03:14:30          1 Y

-- 출력 순서에 따른 정렬(권장)
SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
ORDER BY seqno ASC;


-- 대분류
-- ERROR
SELECT cateno, DISTINCT name
FROM cate
ORDER BY name ASC;

SELECT DISTINCT name, cateno
FROM cate
ORDER BY name ASC;

--NAME                               CATENO
-------------------------------- ----------
--개발                                    1
--개발                                    3
--개발                                    4
--오버렌딩                                5
--오버렌딩                                6
--오버렌딩                                2

SELECT DISTINCT name
FROM cate
ORDER BY name ASC;
NAME                          
------------------------------
개발
오버렌딩

-- 개발 그룹
SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
WHERE name='개발' AND namesub != '-';
--    CATENO NAME                           NAMESUB                               CNT RDATE                    SEQNO V
------------ ------------------------------ ------------------------------ ---------- ------------------- ---------- -
--         3 개발                           JAVA                                    0 2024-03-13 03:13:05          1 Y
--         4 개발                           Python                                  0 2024-03-13 03:13:05          1 Y

-- 오버렌딩 그룹
SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
WHERE name='오버렌딩' AND namesub != '-';

    CATENO NAME                           NAMESUB                               CNT RDATE                    SEQNO V
---------- ------------------------------ ------------------------------ ---------- ------------------- ---------- -
         5 오버렌딩                       홍천군                                  0 2024-03-13 03:14:30          1 Y
         6 오버렌딩                       평창군                                  0 2024-03-13 03:14:30          1 Y

SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate 
WHERE name IN (
    SELECT DISTINCT name
    FROM cate
) AND namesub = '-';

--     CATENO NAME                           NAMESUB                               CNT RDATE                    SEQNO V
-- ---------- ------------------------------ ------------------------------ ---------- ------------------- ---------- -
--          1 개발                           -                                       0 2024-03-13 03:12:17          1 Y
--          2 오버렌딩                       -                                       0 2024-03-13 03:12:17          1 Y

SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate 
WHERE namesub = '-'
ORDER BY name ASC;

--     CATENO NAME                           NAMESUB                               CNT RDATE                    SEQNO V
-- ---------- ------------------------------ ------------------------------ ---------- ------------------- ---------- -
--          1 개발                           -                                       0 2024-03-13 03:12:17          1 Y
--          2 오버렌딩                       -                                       0 2024-03-13 03:12:17  

-- READ: 조회
SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
WHERE cateno=1;

-- UPDATE: 수정
UPDATE cate
SET name='오버렌딩', namesub='서산', cnt=100, rdate=sysdate, seqno=5, visible='Y'
WHERE cateno=5;

SELECT * FROM cate;

COMMIT;

-- DELETE: 삭제
DELETE FROM cate WHERE cateno=3;

SELECT * FROM cate;

rollback;

SELECT COUNT(*) as cnt FROM cate;

--       CNT
------------
--         3

-- 관련 글수 증가
UPDATE cate SET cnt = cnt + 1 WHERE cateno = 1;
SELECT * FROM cate;

-- 관련 글수 감소
UPDATE cate SET cnt = cnt - 1 WHERE cateno = 1;
SELECT * FROM cate;

-- 출력 순서 높임: seqno 10 -> 1
UPDATE cate SET seqno = seqno - 1 WHERE cateno = 1;

SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
ORDER BY name ASC, seqno ASC;

-- 출력 순서 낮춤: seqno 1 -> 10
UPDATE cate SET seqno = seqno + 1 WHERE cateno = 1;

SELECT cateno, name, cnt, rdate, seqno, visible
FROM cate
ORDER BY seqno ASC;

-- 카테고리 공개 설정
UPDATE cate SET visible='Y' WHERE cateno = 1;

SELECT cateno, name, cnt, rdate, seqno, visible
FROM cate
ORDER BY seqno ASC;

-- 카테고리 비공개 설정         
UPDATE cate SET visible='N' WHERE cateno = 1;

SELECT cateno, name, cnt, rdate, seqno, visible
FROM cate
ORDER BY seqno ASC;     

commit;

-- 2단 메뉴
-- 중복 출력
SELECT cateno, name, seqno
FROM cate
ORDER BY seqno ASC;

-- ERROR
SELECT DISTINCT name
FROM cate
ORDER BY seqno ASC;

SELECT DISTINCT name
FROM cate
ORDER BY name ASC;

NAME                          
------------------------------
개발
오버렌딩

SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate 
WHERE name IN (
    SELECT DISTINCT name
    FROM cate
) AND namesub = '-'
ORDER BY seqno ASC;

-- 소분류 출력
SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
WHERE name='개발' AND namesub != '-'
ORDER BY seqno ASC;

SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
WHERE name='오버렌딩' AND namesub != '-'
ORDER BY seqno ASC;

-- 회원/비회원에게 공개할 중분류 목록
SELECT cateno, name, seqno, visible
FROM cate 
WHERE name IN (
    SELECT DISTINCT name
    FROM cate
) AND namesub = '-' AND visible='Y'
ORDER BY seqno ASC;

    CATENO NAME                                SEQNO V
---------- ------------------------------ ---------- -
         2 오버렌딩                                2 Y

-- 회원/비회원에게 공개할 소분류 목록
SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
WHERE name='개발' AND namesub != '-' AND visible='Y'
ORDER BY seqno ASC;

    CATENO NAME                           NAMESUB                               CNT RDATE                    SEQNO V
---------- ------------------------------ ------------------------------ ---------- ------------------- ---------- -
        27 개발                           JAVA                                    0 2024-03-20 02:36:05         31 Y
        28 개발                           Python                                  0 2024-03-20 02:36:23         33 Y

-- 검색: 중분류, 소분류
-- 대소문자 구분
SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
WHERE namesub LIKE 'SPRING%'
ORDER BY cateno ASC;

-- SPRING으로 시작하는 레코드
SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
WHERE UPPER(namesub) LIKE UPPER('SPRING%') 
ORDER BY cateno ASC;

-- SPRING으로 끝나는 레코드
SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
WHERE UPPER(namesub) LIKE UPPER('%SPRING') 
ORDER BY cateno ASC;

-- SPRING이란 단어가 있는 경우
SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
WHERE UPPER(name) LIKE UPPER('%SPRING%') OR UPPER(namesub) LIKE UPPER('%SPRING%')
ORDER BY cateno ASC;

-- 한글은 대소문자 관련 없음
SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
WHERE UPPER(name) LIKE UPPER('%개발%') OR UPPER(namesub) LIKE UPPER('%개발%')
ORDER BY cateno ASC;

-- MyBATIS 사용
SELECT cateno, name, namesub, cnt, rdate, seqno, visible
FROM cate
WHERE UPPER(name) LIKE '%' || UPPER('개발') || '%' OR UPPER(namesub) LIKE '%' || UPPER('개발') || '%'
ORDER BY cateno ASC;

-- 페이징
SELECT cateno, name, namesub, cnt, rdate, seqno, visible, r
FROM (
    SELECT cateno, name, namesub, cnt, rdate, seqno, visible, rownum as r
    FROM (
        SELECT cateno, name, namesub, cnt, rdate, seqno, visible
        FROM cate
        WHERE UPPER(name) LIKE '%' || UPPER('개발') || '%' OR UPPER(namesub) LIKE '%' || UPPER('개발') || '%'
        ORDER BY seqno ASC
    )
)
WHERE r >= 1 AND r <= 3;

SELECT cateno, name, namesub, cnt, rdate, seqno, visible, r
FROM (
    SELECT cateno, name, namesub, cnt, rdate, seqno, visible, rownum as r
    FROM (
        SELECT cateno, name, namesub, cnt, rdate, seqno, visible
        FROM cate
        WHERE UPPER(name) LIKE '%' || UPPER('개발') || '%' OR UPPER(namesub) LIKE '%' || UPPER('개발') || '%'
        ORDER BY seqno ASC
    )
)
WHERE r >= 4 AND r <= 6;

-- 검색된 레코드 수
SELECT COUNT(*) as cnt
FROM cate
WHERE UPPER(name) LIKE '%' || UPPER('개발') || '%' OR UPPER(namesub) LIKE '%' || UPPER('개발') || '%'
ORDER BY cateno ASC;











