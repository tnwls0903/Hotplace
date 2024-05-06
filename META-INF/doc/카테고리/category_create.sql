/**********************************/
/* Table Name: 오버렌딩 카테고리 */
/**********************************/
DROP TABLE CATEGORY CASCADE CONSTRAINTS; -- 자식 테이블을 무시하고삭제

CREATE TABLE CATEGORY(
        CATEGORYNO                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        NAME                                  VARCHAR2(30)         NOT NULL,
        NAMESUB                               VARCHAR2(30)         DEFAULT '-'         NOT NULL,
        CNT                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        RDATE                                 DATE         NOT NULL,
        SEQNO                                 NUMBER(5)         DEFAULT 0         NOT NULL,
        VISIBLE                               CHAR(1)         DEFAULT 'N'         NOT NULL
);

COMMENT ON TABLE CATEGORY is '카테고리';
COMMENT ON COLUMN CATEGORY.CATEGORYNO is '카테고리번호';
COMMENT ON COLUMN CATEGORY.NAME is '중분류명';
COMMENT ON COLUMN CATEGORY.NAMESUB is '소분류명';
COMMENT ON COLUMN CATEGORY.CNT is '관련 자료수';
COMMENT ON COLUMN CATEGORY.RDATE is '등록일';
COMMENT ON COLUMN CATEGORY.SEQNO is '출력 순서';
COMMENT ON COLUMN CATEGORY.VISIBLE is '출력 모드';

DROP SEQUENCE CATEGORY_SEQ;

CREATE SEQUENCE CATEGORY_SEQ
    START WITH 1         -- 시작 번호
    INCREMENT BY 1       -- 증가값
    MAXVALUE 9999999999  -- 최대값: 9999999999 --> NUMBER(10) 대응
    CACHE 2              -- 2번은 메모리에서만 계산
    NOCYCLE;             -- 다시 1부터 생성되는 것을 방지
       
-- CREATE
INSERT INTO category(categoryno, name, namesub, cnt, rdate, seqno, visible)
VALUES(CATEGORY_SEQ.nextval, '서울', '-', 0, sysdate, 1, 'Y');

INSERT INTO category(categoryno, name, namesub, cnt, rdate, seqno, visible)
VALUES(CATEGORY_SEQ.nextval, '경기도', '-', 0, sysdate, 2, 'Y');

INSERT INTO category(categoryno, name, namesub, cnt, rdate, seqno, visible)
VALUES(CATEGORY_SEQ.nextval, '서울', '영등포구', 0, sysdate, 31, 'Y');

INSERT INTO category(categoryno, name, namesub, cnt, rdate, seqno, visible)
VALUES(CATEGORY_SEQ.nextval, '서울', '종로구', 0, sysdate, 32, 'Y');

INSERT INTO category(categoryno, name, namesub, cnt, rdate, seqno, visible)
VALUES(CATEGORY_SEQ.nextval, '경기도', '기흥군', 0, sysdate, 61, 'Y');

INSERT INTO category(categoryno, name, namesub, cnt, rdate, seqno, visible)
VALUES(CATEGORY_SEQ.nextval, '경기도', '처인구', 0, sysdate, 62, 'Y');

SELECT * FROM category;

COMMIT;


-- READ: 목록
SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
ORDER BY categoryno ASC;

SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
ORDER BY name ASC, namesub ASC;


-- 대분류
SELECT DISTINCT name, categoryno
FROM category
ORDER BY name ASC;

SELECT DISTINCT name
FROM category
ORDER BY name ASC;


-- 서울 그룹
SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
WHERE name='서울' AND namesub != '-';


-- 경기도 그룹
SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
WHERE name='경기도' AND namesub != '-';

SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category 
WHERE name IN (
    SELECT DISTINCT name
    FROM category
) AND namesub = '-';

SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
WHERE namesub = '-'
ORDER BY name ASC;

-- READ: 조회
SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
WHERE categoryno=1;

-- UPDATE: 수정
UPDATE category
SET name='서울', namesub='마포구', cnt=10, rdate=sysdate, seqno=32, visible='Y'
WHERE category=3;

SELECT * FROM category;

COMMIT;


-- DELETE: 삭제
DELETE FROM category WHERE categoryno=62;

SELECT * FROM category;

rollback;

SELECT COUNT(*) as cnt FROM category;


-- 관련 글수 증가
UPDATE category SET cnt = cnt + 1 WHERE categoryno = 1;
SELECT * FROM category;

-- 관련 글수 감소
UPDATE category SET cnt = cnt - 1 WHERE categoryno = 1;
SELECT * FROM category;


-- 출력 순서 높임: seqno 10 -> 1
UPDATE category SET seqno = seqno - 1 WHERE categoryno = 1;

SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
ORDER BY name ASC, seqno ASC;

-- 출력 순서 낮춤: seqno 1 -> 10
UPDATE category SET seqno = seqno + 1 WHERE categoryno = 1;

SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
ORDER BY name ASC, seqno ASC;


-- 카테고리 공개 설정
UPDATE category SET visible='Y' WHERE categoryno = 1;

SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
ORDER BY seqno ASC;

-- 카테고리 비공개 설정         
UPDATE category SET visible='N' WHERE categoryno = 1;

SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
ORDER BY seqno ASC;

commit;


-- 중분류 출력, 2단 메뉴
-- 중복 출력
SELECT categoryno, name, categoryno
FROM category
ORDER BY seqno ASC;

SELECT DISTINCT name
FROM category
ORDER BY name ASC;

SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category 
WHERE name IN (
    SELECT DISTINCT name
    FROM category
) AND namesub = '-'
ORDER BY seqno ASC;


-- 소분류 출력 
-- 서울 그룹
SELECT categoryno, name, cnt, rdate, seqno, visible
FROM category
WHERE name='서울' AND namesub != '-'
ORDER BY seqno ASC;

-- 경기도 그룹
SELECT categoryno, name, cnt, rdate, seqno, visible
FROM category
WHERE name='경기도' AND namesub != '-'
ORDER BY seqno ASC;


-- 회원/비회원에게 공개할 중분류 목록
SELECT categoryno, name, seqno, visible
FROM category 
WHERE name IN (
    SELECT DISTINCT name
    FROM category
) AND namesub = '-' AND visible='Y'
ORDER BY seqno ASC;

-- 회원/비회원에게 공개할 소분류 목록
SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category 
WHERE name = '서울' AND namesub != '-' AND visible = 'Y'
ORDER BY seqno ASC;


-- 검색: 중분류, 소분류
-- 대소문자 구분함
-- Yeongdeungpo
SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
WHERE name LIKE 'Yeongdeungpo%'
ORDER BY categoryno ASC;

-- YEONGDEUNGPO으로 시작하는 레코드
SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
WHERE UPPER(namesub) LIKE UPPER('yeongdeungpo%')
ORDER BY categoryno ASC;

-- YEONGDEUNGPO으로 끝나는 레코드
SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
WHERE UPPER(namesub) LIKE UPPER('%yeongdeungpo')
ORDER BY categoryno ASC;

-- YEONGDEUNGPO이란 단어가 있는 경우
SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
WHERE UPPER(name) LIKE UPPER('%yeongdeungpo%') OR UPPER(namesub) LIKE UPPER('%YEONGDEUNGPO%')
ORDER BY categoryno ASC;

-- 한글은 대소문자 관련 없음
SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
WHERE UPPER(name) LIKE UPPER('%영등포%') OR UPPER(namesub) LIKE UPPER('%영등포%')
ORDER BY category ASC;


-- MyBATIS 사용
SELECT categoryno, name, namesub, cnt, rdate, seqno, visible
FROM category
WHERE UPPER(name) LIKE '%' || UPPER('영등포') || '%' OR UPPER(namesub) LIKE '%' || UPPER('영등포') || '%'
ORDER BY categoryno ASC;

