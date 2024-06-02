-- /src/main/webapp/WEB-INF/doc/컨텐�?/contents_c.sql
DROP TABLE contents CASCADE CONSTRAINTS; -- ?��?�� 무시?���? ?��?�� �??��
DROP TABLE contents;

CREATE TABLE contents(
        contentsno                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        memberno                              NUMBER(10)     NOT NULL , -- FK
        cateno                                NUMBER(10)         NOT NULL , -- FK
        title                                 VARCHAR2(100)         NOT NULL,
        content                               CLOB                  NOT NULL,
        recom                                 NUMBER(7)         DEFAULT 0         NOT NULL,
        cnt                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        replycnt                              NUMBER(7)         DEFAULT 0         NOT NULL,
        passwd                                VARCHAR2(15)         NOT NULL,
        word                                  VARCHAR2(100)         NULL ,
        rdate                                 DATE               NOT NULL,
        file1                                   VARCHAR(100)          NULL,  -- ?���? ?��?���? image
        file1saved                            VARCHAR(100)          NULL,  -- ???��?�� ?��?���?, image
        thumb1                              VARCHAR(100)          NULL,   -- preview image
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  -- ?��?�� ?��?���?
        price                                 NUMBER(10)      DEFAULT 0 NULL,  
        dc                                    NUMBER(10)      DEFAULT 0 NULL,  
        saleprice                            NUMBER(10)      DEFAULT 0 NULL,  
        point                                 NUMBER(10)      DEFAULT 0 NULL,  
        salecnt                               NUMBER(10)      DEFAULT 0 NULL,
        map                                   VARCHAR2(1000)            NULL,
        youtube                               VARCHAR2(1000)            NULL,
        mp4                                  VARCHAR2(100)            NULL,
        FOREIGN KEY (memberno) REFERENCES member (memberno),
        FOREIGN KEY (cateno) REFERENCES cate (cateno)
);

COMMENT ON TABLE contents is '컨텐�? - ?���?�?';
COMMENT ON COLUMN contents.contentsno is '컨텐�? 번호';
COMMENT ON COLUMN contents.memberno is '�?리자 번호';
COMMENT ON COLUMN contents.cateno is '카테고리 번호';
COMMENT ON COLUMN contents.title is '?���?';
COMMENT ON COLUMN contents.content is '?��?��';
COMMENT ON COLUMN contents.recom is '추천?��';
COMMENT ON COLUMN contents.cnt is '조회?��';
COMMENT ON COLUMN contents.replycnt is '?���??��';
COMMENT ON COLUMN contents.passwd is '?��?��?��?��';
COMMENT ON COLUMN contents.word is '�??��?��';
COMMENT ON COLUMN contents.rdate is '?��록일';
COMMENT ON COLUMN contents.file1 is '메인 ?��미�?';
COMMENT ON COLUMN contents.file1saved is '?��?�� ???��?�� 메인 ?��미�?';
COMMENT ON COLUMN contents.thumb1 is '메인 ?��미�? Preview';
COMMENT ON COLUMN contents.size1 is '메인 ?��미�? ?���?';
COMMENT ON COLUMN contents.price is '?���?';
COMMENT ON COLUMN contents.dc is '?��?���?';
COMMENT ON COLUMN contents.saleprice is '?��매�?';
COMMENT ON COLUMN contents.point is '?��?��?��';
COMMENT ON COLUMN contents.salecnt is '?���? ?��?��';
COMMENT ON COLUMN contents.map is '�??��';
COMMENT ON COLUMN contents.youtube is 'Youtube ?��?��';
COMMENT ON COLUMN contents.mp4 is '?��?��';

DROP SEQUENCE contents_seq;

CREATE SEQUENCE contents_seq
  START WITH 1                -- ?��?�� 번호
  INCREMENT BY 1            -- 증�?�?
  MAXVALUE 9999999999  -- 최�?�?: 9999999999 --> NUMBER(10) ???��
  CACHE 2                        -- 2번�? 메모리에?���? 계산
  NOCYCLE;                      -- ?��?�� 1�??�� ?��?��?��?�� 것을 방�?

-- ?���? ?���? ?��?�� 1: 커�?�니?��(공�??��?��, 게시?��, ?��료실, 갤러�?,  Q/A...)�? ?���?
INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(contents_seq.nextval, 1, 1, '�?계천 매화 거리', '?��기동?��?��?�� �?까�? 명품 ?��책로', 0, 0, 0, '123',
       '?���?', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

-- ?��?�� 1 ?���? 목록
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1
FROM contents
ORDER BY contentsno DESC;

SELECT contentsno, title, content, word, rdate
FROM contents
ORDER BY contentsno DESC;

SELECT * FROM contents;

-- ?��?�� 2 카테고리�? 목록
INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(contents_seq.nextval, 1, 2, '???��?��', '?��?��???? 금수???�� ?���? ?��?���?', 0, 0, 0, '123',
       '?��?���?,K?��?���?,?��?���??��', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);
            
INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(contents_seq.nextval, 1, 2, '?���?로리', '?��?��?�� 결말', 0, 0, 0, '123',
       '?��?���?,K?��?���?,?��?���??��', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(contents_seq.nextval, 1, 2, '?���?로리', '?��?��?�� 결말', 0, 0, 0, '123',
       '?��?���?,K?��?���?,?��?���??��', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

COMMIT;

-- ?���? 목록
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube mp4
FROM contents
ORDER BY contentsno DESC;

-- 1�? cateno �? 출력
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
        LOWER(file1) as file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=1
ORDER BY contentsno DESC;

-- 2�? cateno �? 출력
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
        LOWER(file1) as file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=2
ORDER BY contentsno ASC;

-- 3�? cateno �? 출력
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
        LOWER(file1) as file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=5
ORDER BY contentsno ASC;

commit;

-- 모든 ?��코드 ?��?��
DELETE FROM contents;
commit;

-- ?��?��
DELETE FROM contents
WHERE contentsno = 25;
commit;

DELETE FROM contents
WHERE cateno=12 AND contentsno <= 41;

commit;


-- ----------------------------------------------------------------------------------------------------
-- �??��, cateno�? �??�� 목록
-- ----------------------------------------------------------------------------------------------------
-- 모든�?
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, map, youtube
FROM contents
ORDER BY contentsno ASC;

-- 카테고리�? 목록
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=2
ORDER BY contentsno ASC;

-- 1) �??��
-- ?�� cateno�? �??�� 목록
-- word 컬럼?�� 존재 ?��?��: �??�� ?��?��?���? ?��?���? ?��?��?�� 중요 ?��?���? 명시
-- �??�� 'swiss'?��?�� ?��?���? ?��?��?���? ?���?�? '?��?��?��'?�� �??�� ?��?��.
-- ?��?�� 문제�? 방�??��기위?�� 'swiss,?��?��?��,?��?��?��,?��?��?��,?��?��' �??��?���? ?��?���? word 컬럼?�� 추�??��.
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=8 AND word LIKE '%�???찌게%'
ORDER BY contentsno DESC;

-- title, content, word column search
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=8 AND (title LIKE '%�???찌게%' OR content LIKE '%�???찌게%' OR word LIKE '%�???찌게%')
ORDER BY contentsno DESC;

-- ?�� �??�� ?��코드 �??��
-- ?���? ?��코드 �??��, 집계 ?��?��
SELECT COUNT(*)
FROM contents
WHERE cateno=8;

  COUNT(*)  <- 컬럼�?
----------
         5
         
SELECT COUNT(*) as cnt -- ?��?�� ?��?��?��?�� 컬럼 별명?�� ?��?��?��?�� 것을 권장
FROM contents
WHERE cateno=8;

       CNT <- 컬럼�?
----------
         5

-- cateno �? �??��?�� ?��코드 �??��
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=8 AND word LIKE '%�???찌게%';

SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=8 AND (title LIKE '%�???찌게%' OR content LIKE '%�???찌게%' OR word LIKE '%�???찌게%');

-- SUBSTR(컬럼�?, ?��?�� index(1�??�� ?��?��), 길이), �?�? 문자?�� 추출
SELECT contentsno, SUBSTR(title, 1, 4) as title
FROM contents
WHERE cateno=8 AND (content LIKE '%�???%');

-- SQL?? ???��문자�? 구분?���? ?��?��?�� WHERE문에 명시?��?�� 값�? ???��문자�? 구분?��?�� �??��
SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (word LIKE '%FOOD%');

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (word LIKE '%food%'); 

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (LOWER(word) LIKE '%food%'); -- ???��문자�? ?���? ?��켜서 �??��

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (UPPER(word) LIKE '%' || UPPER('FOOD') || '%'); -- ???��문자�? ?���? ?��켜서 �??�� ?��

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- ???��문자�? ?���? ?��켜서 �??��

SELECT contentsno || '. ' || title || ' ?���?: ' || word as title -- 컬럼?�� 결합, ||
FROM contents
WHERE cateno=8 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- ???��문자�? ?���? ?��켜서 �??��


SELECT UPPER('?���?') FROM dual; -- dual: ?��?��?��?��?�� SQL ?��?��?�� 맞추기위?�� ?��?��?�� ?��?���?

-- ----------------------------------------------------------------------------------------------------
-- �??�� + ?��?���? + 메인 ?��미�?
-- ----------------------------------------------------------------------------------------------------
-- step 1
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=1 AND (title LIKE '%?��?��%' OR content LIKE '%?��?��%' OR word LIKE '%?��?��%')
ORDER BY contentsno DESC;

-- step 2
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, rownum as r
FROM (
          SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                     file1, file1saved, thumb1, size1, map, youtube
          FROM contents
          WHERE cateno=1 AND (title LIKE '%?��?��%' OR content LIKE '%?��?��%' OR word LIKE '%?��?��%')
          ORDER BY contentsno DESC
);

-- step 3, 1 page
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1 AND (title LIKE '%?��?��%' OR content LIKE '%?��?��%' OR word LIKE '%?��?��%')
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- step 3, 2 page
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1 AND (title LIKE '%?��?��%' OR content LIKE '%?��?��%' OR word LIKE '%?��?��%')
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 4 AND r <= 6;

-- ???��문자�? 처리?��?�� ?��?���? 쿼리
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1 AND (UPPER(title) LIKE '%' || UPPER('?��?��') || '%' 
                                         OR UPPER(content) LIKE '%' || UPPER('?��?��') || '%' 
                                         OR UPPER(word) LIKE '%' || UPPER('?��?��') || '%')
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- ----------------------------------------------------------------------------
-- 조회
-- ----------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE contentsno = 1;

-- ----------------------------------------------------------------------------
-- ?��?�� �??��, MAP, 먼�? ?��코드�? ?��록되?�� ?��?��?��?��.
-- map                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- MAP ?���?/?��?��
UPDATE contents SET map='카페?�� �??�� ?��?��립트' WHERE contentsno=1;

-- MAP ?��?��
UPDATE contents SET map='' WHERE contentsno=1;

commit;

-- ----------------------------------------------------------------------------
-- Youtube, 먼�? ?��코드�? ?��록되?�� ?��?��?��?��.
-- youtube                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- youtube ?���?/?��?��
UPDATE contents SET youtube='Youtube ?��?��립트' WHERE contentsno=1;

-- youtube ?��?��
UPDATE contents SET youtube='' WHERE contentsno=1;

commit;

-- ?��?��?��?�� �??��, id="password_check"
SELECT COUNT(*) as cnt 
FROM contents
WHERE contentsno=1 AND passwd='123';

-- ?��?��?�� ?��?��: ?��?�� 컬럼: 추천?��, 조회?��, ?���? ?��
UPDATE contents
SET title='기차�? ??�?', content='계획?��?�� ?��?�� 출발',  word='?��,기차,?���?' 
WHERE contentsno = 2;

-- ERROR, " ?��?�� ?��?��
UPDATE contents
SET title='기차�? ??�?', content="계획?��?�� '?��?��' 출발",  word='?��,기차,?���?'
WHERE contentsno = 1;

-- ERROR, \' ?��?��
UPDATE contents
SET title='기차�? ??�?', content='계획?��?�� \'?��?��\' 출발',  word='?��,기차,?���?'
WHERE contentsno = 1;

-- SUCCESS, '' ?���? ' 출력?��.
UPDATE contents
SET title='기차�? ??�?', content='계획?��?�� ''?��?��'' 출발',  word='?��,기차,?���?'
WHERE contentsno = 1;

-- SUCCESS
UPDATE contents
SET title='기차�? ??�?', content='계획?��?�� "?��?��" 출발',  word='?��,기차,?���?'
WHERE contentsno = 1;

commit;

-- ?��?�� ?��?��
UPDATE contents
SET file1='train.jpg', file1saved='train.jpg', thumb1='train_t.jpg', size1=5000
WHERE contentsno = 1;

-- ?��?��
DELETE FROM contents
WHERE contentsno = 42;

commit;

DELETE FROM contents
WHERE contentsno >= 7;

commit;

-- 추천
UPDATE contents
SET recom = recom + 1
WHERE contentsno = 1;

-- cateno FK ?��?�� 그룹?�� ?��?�� ?��코드 �??�� ?���?
SELECT COUNT(*) as cnt 
FROM contents 
WHERE cateno=1;

-- memberno FK ?��?�� �?리자?�� ?��?�� ?��코드 �??�� ?���?
SELECT COUNT(*) as cnt 
FROM contents 
WHERE memberno=1;

-- cateno FK ?��?�� 그룹?�� ?��?�� ?��코드 모두 ?��?��
DELETE FROM contents
WHERE cateno=1;

-- memberno FK ?��?�� �?리자?�� ?��?�� ?��코드 모두 ?��?��
DELETE FROM contents
WHERE memberno=1;

commit;

-- ?��?��?�� 카테고리?�� ?��?�� ?��코드 �??�� ?���?: IN
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno IN(1,2,3);

-- ?��?��?�� 카테고리?�� ?��?�� ?��코드 모두 ?��?��: IN
SELECT contentsno, memberno, cateno, title
FROM contents
WHERE cateno IN(1,2,3);

CONTENTSNO    ADMINNO     CATENO TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           ?��?��?��?��?��                                                                                                                                                                                                                                                                                                  
         4             1                   2           ?��?���?                                                                                                                                                                                                                                                                                                      
         5             1                   3           컨�?�?                                                                                                                                                                                                                                                                                                      
         6             1                   1           마션       
         
SELECT contentsno, memberno, cateno, title
FROM contents
WHERE cateno IN('1','2','3');

CONTENTSNO    ADMINNO     CATENO TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           ?��?��?��?��?��                                                                                                                                                                                                                                                                                                  
         4             1                   2           ?��?���?                                                                                                                                                                                                                                                                                                      
         5             1                   3           컨�?�?                                                                                                                                                                                                                                                                                                      
         6             1                   1           마션       

-- ----------------------------------------------------------------------------------------------------
-- cate + contents INNER JOIN
-- ----------------------------------------------------------------------------------------------------
-- 모든�?
SELECT c.name,
       t.contentsno, t.memberno, t.cateno, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.map, t.youtube
FROM cate c, contents t
WHERE c.cateno = t.cateno
ORDER BY t.contentsno DESC;

-- contents, member INNER JOIN
SELECT t.contentsno, t.memberno, t.cateno, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.map, t.youtube,
       a.mname
FROM member a, contents t
WHERE a.memberno = t.memberno
ORDER BY t.contentsno DESC;

SELECT t.contentsno, t.memberno, t.cateno, t.title, t.content, t.recom, t.cnt, t.replycnt, t.word, t.rdate,
       t.file1, t.file1saved, t.thumb1, t.size1, t.map, t.youtube,
       a.mname
FROM member a INNER JOIN contents t ON a.memberno = t.memberno
ORDER BY t.contentsno DESC;

-- ----------------------------------------------------------------------------------------------------
-- View + paging
-- ----------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW vcontents
AS
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
        file1, file1saved, thumb1, size1, map, youtube
FROM contents
ORDER BY contentsno DESC;
                     
-- 1 page
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
       file1, file1saved, thumb1, size1, map, youtube, r
FROM (
     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
            file1, file1saved, thumb1, size1, map, youtube, rownum as r
     FROM vcontents -- View
     WHERE cateno=14 AND (title LIKE '%?���?%' OR content LIKE '%?���?%' OR word LIKE '%?���?%')
)
WHERE r >= 1 AND r <= 3;

-- 2 page
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
       file1, file1saved, thumb1, size1, map, youtube, r
FROM (
     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
            file1, file1saved, thumb1, size1, map, youtube, rownum as r
     FROM vcontents -- View
     WHERE cateno=14 AND (title LIKE '%?���?%' OR content LIKE '%?���?%' OR word LIKE '%?���?%')
)
WHERE r >= 4 AND r <= 6;


-- ----------------------------------------------------------------------------------------------------
-- �??�� 카테고리?�� 좋아?��(recom) 기�?, 1�? ?��?��?�� 1�? 카테고리�? 추천 받는 경우, 추천 ?��?��?�� 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, thumb1, r
FROM (
           SELECT contentsno, memberno, cateno, title, thumb1, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, thumb1
                     FROM contents
                     WHERE cateno=1
                     ORDER BY recom DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- �??�� 카테고리?�� ?��?��(score) 기�?, 1�? ?��?��?�� 1�? 카테고리�? 추천 받는 경우, 추천 ?��?��?�� 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1
                     ORDER BY score DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- �??�� 카테고리?�� 최신 ?��?�� 기�?, 1�? ?��?��?�� 1�? 카테고리�? 추천 받는 경우, 추천 ?��?��?�� 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1
                     ORDER BY rdate DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- �??�� 카테고리?�� 조회?�� ?��?? ?��?��기�?, 1�? ?��?��?�� 1�? 카테고리�? 추천 받는 경우, 추천 ?��?��?�� 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1
                     ORDER BY cnt DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- �??�� 카테고리?�� ?��?? �?�? ?��?�� 추천, 1�? ?��?��?�� 1�? 카테고리�? 추천 받는 경우, 추천 ?��?��?�� 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1
                     ORDER BY price ASC
           )          
)
WHERE r >= 1 AND r <= 7;

-- ----------------------------------------------------------------------------------------------------
-- �??�� 카테고리?�� ?��?? �?�? ?��?�� 추천, 1�? ?��?��?�� 1�? 카테고리�? 추천 받는 경우, 추천 ?��?��?�� 7건일 경우
-- ----------------------------------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1
                     ORDER BY price DESC
           )          
)
WHERE r >= 1 AND r <= 7;

-----------------------------------------------------------
-- FK cateno 컬럼?�� ???��?��?�� ?��?�� SQL
-----------------------------------------------------------
-- ?��?�� 카테고리?�� ?��?�� ?��코드 �??���? 리턴
SELECT COUNT(*) as cnt 
FROM contents 
WHERE cateno=1;
  
-- ?��?�� 카테고리?�� ?��?�� 모든 ?��코드 ?��?��
DELETE FROM contents
WHERE cateno=1;

-----------------------------------------------------------
-- FK memberno 컬럼?�� ???��?��?�� ?��?�� SQL
-----------------------------------------------------------
-- ?��?�� ?��?��?�� ?��?�� ?��코드 �??���? 리턴
SELECT COUNT(*) as cnt 
FROM contents 
WHERE memberno=1;
  
-- ?��?�� ?��?��?�� ?��?�� 모든 ?��코드 ?��?��
DELETE FROM contents
WHERE memberno=1;
