-- /src/main/webapp/WEB-INF/doc/์ปจํ์ธ?/contents_c.sql
DROP TABLE contents CASCADE CONSTRAINTS; -- ?? ๋ฌด์?๊ณ? ?ญ?  ๊ฐ??ฅ
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
        file1                                   VARCHAR(100)          NULL,  -- ?๋ณ? ??ผ๋ช? image
        file1saved                            VARCHAR(100)          NULL,  -- ???ฅ? ??ผ๋ช?, image
        thumb1                              VARCHAR(100)          NULL,   -- preview image
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  -- ??ผ ?ฌ?ด์ฆ?
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

COMMENT ON TABLE contents is '์ปจํ์ธ? - ?๋ก?๊ธ?';
COMMENT ON COLUMN contents.contentsno is '์ปจํ์ธ? ๋ฒํธ';
COMMENT ON COLUMN contents.memberno is '๊ด?๋ฆฌ์ ๋ฒํธ';
COMMENT ON COLUMN contents.cateno is '์นดํ๊ณ ๋ฆฌ ๋ฒํธ';
COMMENT ON COLUMN contents.title is '? ๋ช?';
COMMENT ON COLUMN contents.content is '?ด?ฉ';
COMMENT ON COLUMN contents.recom is '์ถ์ฒ?';
COMMENT ON COLUMN contents.cnt is '์กฐํ?';
COMMENT ON COLUMN contents.replycnt is '?๊ธ??';
COMMENT ON COLUMN contents.passwd is '?จ?ค??';
COMMENT ON COLUMN contents.word is '๊ฒ???ด';
COMMENT ON COLUMN contents.rdate is '?ฑ๋ก์ผ';
COMMENT ON COLUMN contents.file1 is '๋ฉ์ธ ?ด๋ฏธ์?';
COMMENT ON COLUMN contents.file1saved is '?ค?  ???ฅ? ๋ฉ์ธ ?ด๋ฏธ์?';
COMMENT ON COLUMN contents.thumb1 is '๋ฉ์ธ ?ด๋ฏธ์? Preview';
COMMENT ON COLUMN contents.size1 is '๋ฉ์ธ ?ด๋ฏธ์? ?ฌ๊ธ?';
COMMENT ON COLUMN contents.price is '? ๊ฐ?';
COMMENT ON COLUMN contents.dc is '? ?ธ๋ฅ?';
COMMENT ON COLUMN contents.saleprice is '?๋งค๊?';
COMMENT ON COLUMN contents.point is '?ฌ?ธ?ธ';
COMMENT ON COLUMN contents.salecnt is '?ฌ๊ณ? ??';
COMMENT ON COLUMN contents.map is '์ง??';
COMMENT ON COLUMN contents.youtube is 'Youtube ??';
COMMENT ON COLUMN contents.mp4 is '??';

DROP SEQUENCE contents_seq;

CREATE SEQUENCE contents_seq
  START WITH 1                -- ?? ๋ฒํธ
  INCREMENT BY 1            -- ์ฆ๊?๊ฐ?
  MAXVALUE 9999999999  -- ์ต๋?๊ฐ?: 9999999999 --> NUMBER(10) ???
  CACHE 2                        -- 2๋ฒ์? ๋ฉ๋ชจ๋ฆฌ์?๋ง? ๊ณ์ฐ
  NOCYCLE;                      -- ?ค? 1๋ถ??ฐ ??ฑ?? ๊ฒ์ ๋ฐฉ์?

-- ?ฑ๋ก? ?๋ฉ? ? ? 1: ์ปค๋?ค๋?ฐ(๊ณต์??ฌ?ญ, ๊ฒ์?, ?๋ฃ์ค, ๊ฐค๋ฌ๋ฆ?,  Q/A...)๊ธ? ?ฑ๋ก?
INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(contents_seq.nextval, 1, 1, '์ฒ?๊ณ์ฒ ๋งคํ ๊ฑฐ๋ฆฌ', '? ๊ธฐ๋?ญ?? ๊ฐ?๊น์? ๋ชํ ?ฐ์ฑ๋ก', 0, 0, 0, '123',
       '?ฐ์ฑ?', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

-- ? ? 1 ? ์ฒ? ๋ชฉ๋ก
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1
FROM contents
ORDER BY contentsno DESC;

SELECT contentsno, title, content, word, rdate
FROM contents
ORDER BY contentsno DESC;

SELECT * FROM contents;

-- ? ? 2 ์นดํ๊ณ ๋ฆฌ๋ณ? ๋ชฉ๋ก
INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(contents_seq.nextval, 1, 2, '????ฌ', '?????? ๊ธ์??? ?ฑ๊ณ? ?ค? ๋ฆ?', 0, 0, 0, '123',
       '??ผ๋ง?,K??ผ๋ง?,?ท?๋ฆ??ค', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);
            
INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(contents_seq.nextval, 1, 2, '?๊ธ?๋ก๋ฆฌ', '??ญ? ๊ฒฐ๋ง', 0, 0, 0, '123',
       '??ผ๋ง?,K??ผ๋ง?,?ท?๋ฆ??ค', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(contents_seq.nextval, 1, 2, '?๊ธ?๋ก๋ฆฌ', '??ญ? ๊ฒฐ๋ง', 0, 0, 0, '123',
       '??ผ๋ง?,K??ผ๋ง?,?ท?๋ฆ??ค', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

COMMIT;

-- ? ์ฒ? ๋ชฉ๋ก
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube mp4
FROM contents
ORDER BY contentsno DESC;

-- 1๋ฒ? cateno ๋ง? ์ถ๋ ฅ
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
        LOWER(file1) as file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=1
ORDER BY contentsno DESC;

-- 2๋ฒ? cateno ๋ง? ์ถ๋ ฅ
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
        LOWER(file1) as file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=2
ORDER BY contentsno ASC;

-- 3๋ฒ? cateno ๋ง? ์ถ๋ ฅ
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
        LOWER(file1) as file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=5
ORDER BY contentsno ASC;

commit;

-- ๋ชจ๋  ? ์ฝ๋ ?ญ? 
DELETE FROM contents;
commit;

-- ?ญ? 
DELETE FROM contents
WHERE contentsno = 25;
commit;

DELETE FROM contents
WHERE cateno=12 AND contentsno <= 41;

commit;


-- ----------------------------------------------------------------------------------------------------
-- ๊ฒ??, cateno๋ณ? ๊ฒ?? ๋ชฉ๋ก
-- ----------------------------------------------------------------------------------------------------
-- ๋ชจ๋ ๊ธ?
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, map, youtube
FROM contents
ORDER BY contentsno ASC;

-- ์นดํ๊ณ ๋ฆฌ๋ณ? ๋ชฉ๋ก
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=2
ORDER BY contentsno ASC;

-- 1) ๊ฒ??
-- ?  cateno๋ณ? ๊ฒ?? ๋ชฉ๋ก
-- word ์ปฌ๋ผ? ์กด์ฌ ?ด? : ๊ฒ?? ? ??๋ฅ? ??ด๊ธ? ???ฌ ์ค์ ?จ?ด๋ฅ? ๋ช์
-- ๊ธ?? 'swiss'?ผ? ?จ?ด๋ง? ?ฑ?ฅ?๋ฉ? ?๊ธ?๋ก? '?ค??ค'? ๊ฒ?? ??จ.
-- ?ด?ฐ ๋ฌธ์ ๋ฅ? ๋ฐฉ์??๊ธฐ์?ด 'swiss,?ค??ค,?ค??ค,???ค,? ?ฝ' ๊ฒ???ด๊ฐ? ?ค?ด๊ฐ? word ์ปฌ๋ผ? ์ถ๊??จ.
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=8 AND word LIKE '%๋ถ???์ฐ๊ฒ%'
ORDER BY contentsno DESC;

-- title, content, word column search
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=8 AND (title LIKE '%๋ถ???์ฐ๊ฒ%' OR content LIKE '%๋ถ???์ฐ๊ฒ%' OR word LIKE '%๋ถ???์ฐ๊ฒ%')
ORDER BY contentsno DESC;

-- ?ก ๊ฒ?? ? ์ฝ๋ ๊ฐ??
-- ? ์ฒ? ? ์ฝ๋ ๊ฐ??, ์ง๊ณ ?จ?
SELECT COUNT(*)
FROM contents
WHERE cateno=8;

  COUNT(*)  <- ์ปฌ๋ผ๋ช?
----------
         5
         
SELECT COUNT(*) as cnt -- ?จ? ?ฌ?ฉ?? ์ปฌ๋ผ ๋ณ๋ช? ? ?ธ?? ๊ฒ์ ๊ถ์ฅ
FROM contents
WHERE cateno=8;

       CNT <- ์ปฌ๋ผ๋ช?
----------
         5

-- cateno ๋ณ? ๊ฒ??? ? ์ฝ๋ ๊ฐ??
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=8 AND word LIKE '%๋ถ???์ฐ๊ฒ%';

SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=8 AND (title LIKE '%๋ถ???์ฐ๊ฒ%' OR content LIKE '%๋ถ???์ฐ๊ฒ%' OR word LIKE '%๋ถ???์ฐ๊ฒ%');

-- SUBSTR(์ปฌ๋ผ๋ช?, ?? index(1๋ถ??ฐ ??), ๊ธธ์ด), ๋ถ?๋ถ? ๋ฌธ์?ด ์ถ์ถ
SELECT contentsno, SUBSTR(title, 1, 4) as title
FROM contents
WHERE cateno=8 AND (content LIKE '%๋ถ???%');

-- SQL?? ???๋ฌธ์๋ฅ? ๊ตฌ๋ถ?์ง? ??ผ? WHERE๋ฌธ์ ๋ช์?? ๊ฐ์? ???๋ฌธ์๋ฅ? ๊ตฌ๋ถ??ฌ ๊ฒ??
SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (word LIKE '%FOOD%');

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (word LIKE '%food%'); 

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (LOWER(word) LIKE '%food%'); -- ???๋ฌธ์๋ฅ? ?ผ์น? ?์ผ์ ๊ฒ??

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (UPPER(word) LIKE '%' || UPPER('FOOD') || '%'); -- ???๋ฌธ์๋ฅ? ?ผ์น? ?์ผ์ ๊ฒ?? ?

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- ???๋ฌธ์๋ฅ? ?ผ์น? ?์ผ์ ๊ฒ??

SELECT contentsno || '. ' || title || ' ?๊ท?: ' || word as title -- ์ปฌ๋ผ? ๊ฒฐํฉ, ||
FROM contents
WHERE cateno=8 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- ???๋ฌธ์๋ฅ? ?ผ์น? ?์ผ์ ๊ฒ??


SELECT UPPER('?๊ธ?') FROM dual; -- dual: ?ค?ผ?ด?? SQL ??? ๋ง์ถ๊ธฐ์? ??ค? ??ด๋ธ?

-- ----------------------------------------------------------------------------------------------------
-- ๊ฒ?? + ??ด์ง? + ๋ฉ์ธ ?ด๋ฏธ์?
-- ----------------------------------------------------------------------------------------------------
-- step 1
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=1 AND (title LIKE '%?จ?%' OR content LIKE '%?จ?%' OR word LIKE '%?จ?%')
ORDER BY contentsno DESC;

-- step 2
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, rownum as r
FROM (
          SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                     file1, file1saved, thumb1, size1, map, youtube
          FROM contents
          WHERE cateno=1 AND (title LIKE '%?จ?%' OR content LIKE '%?จ?%' OR word LIKE '%?จ?%')
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
                     WHERE cateno=1 AND (title LIKE '%?จ?%' OR content LIKE '%?จ?%' OR word LIKE '%?จ?%')
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
                     WHERE cateno=1 AND (title LIKE '%?จ?%' OR content LIKE '%?จ?%' OR word LIKE '%?จ?%')
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 4 AND r <= 6;

-- ???๋ฌธ์๋ฅ? ์ฒ๋ฆฌ?? ??ด์ง? ์ฟผ๋ฆฌ
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1 AND (UPPER(title) LIKE '%' || UPPER('?จ?') || '%' 
                                         OR UPPER(content) LIKE '%' || UPPER('?จ?') || '%' 
                                         OR UPPER(word) LIKE '%' || UPPER('?จ?') || '%')
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- ----------------------------------------------------------------------------
-- ์กฐํ
-- ----------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE contentsno = 1;

-- ----------------------------------------------------------------------------
-- ?ค? ์ง??, MAP, ๋จผ์? ? ์ฝ๋๊ฐ? ?ฑ๋ก๋?ด ??ด?ผ?จ.
-- map                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- MAP ?ฑ๋ก?/?? 
UPDATE contents SET map='์นดํ?ฐ ์ง?? ?ค?ฌ๋ฆฝํธ' WHERE contentsno=1;

-- MAP ?ญ? 
UPDATE contents SET map='' WHERE contentsno=1;

commit;

-- ----------------------------------------------------------------------------
-- Youtube, ๋จผ์? ? ์ฝ๋๊ฐ? ?ฑ๋ก๋?ด ??ด?ผ?จ.
-- youtube                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- youtube ?ฑ๋ก?/?? 
UPDATE contents SET youtube='Youtube ?ค?ฌ๋ฆฝํธ' WHERE contentsno=1;

-- youtube ?ญ? 
UPDATE contents SET youtube='' WHERE contentsno=1;

commit;

-- ?จ?ค?? ๊ฒ??ฌ, id="password_check"
SELECT COUNT(*) as cnt 
FROM contents
WHERE contentsno=1 AND passwd='123';

-- ??ค?ธ ?? : ??ธ ์ปฌ๋ผ: ์ถ์ฒ?, ์กฐํ?, ?๊ธ? ?
UPDATE contents
SET title='๊ธฐ์ฐจ๋ฅ? ??๊ณ?', content='๊ณํ??ด ?ฌ? ์ถ๋ฐ',  word='?,๊ธฐ์ฐจ,?๊ฐ?' 
WHERE contentsno = 2;

-- ERROR, " ?ฌ?ฉ ??ฌ
UPDATE contents
SET title='๊ธฐ์ฐจ๋ฅ? ??๊ณ?', content="๊ณํ??ด '?ฌ?' ์ถ๋ฐ",  word='?,๊ธฐ์ฐจ,?๊ฐ?'
WHERE contentsno = 1;

-- ERROR, \' ??ฌ
UPDATE contents
SET title='๊ธฐ์ฐจ๋ฅ? ??๊ณ?', content='๊ณํ??ด \'?ฌ?\' ์ถ๋ฐ',  word='?,๊ธฐ์ฐจ,?๊ฐ?'
WHERE contentsno = 1;

-- SUCCESS, '' ?๋ฒ? ' ์ถ๋ ฅ?จ.
UPDATE contents
SET title='๊ธฐ์ฐจ๋ฅ? ??๊ณ?', content='๊ณํ??ด ''?ฌ?'' ์ถ๋ฐ',  word='?,๊ธฐ์ฐจ,?๊ฐ?'
WHERE contentsno = 1;

-- SUCCESS
UPDATE contents
SET title='๊ธฐ์ฐจ๋ฅ? ??๊ณ?', content='๊ณํ??ด "?ฌ?" ์ถ๋ฐ',  word='?,๊ธฐ์ฐจ,?๊ฐ?'
WHERE contentsno = 1;

commit;

-- ??ผ ?? 
UPDATE contents
SET file1='train.jpg', file1saved='train.jpg', thumb1='train_t.jpg', size1=5000
WHERE contentsno = 1;

-- ?ญ? 
DELETE FROM contents
WHERE contentsno = 42;

commit;

DELETE FROM contents
WHERE contentsno >= 7;

commit;

-- ์ถ์ฒ
UPDATE contents
SET recom = recom + 1
WHERE contentsno = 1;

-- cateno FK ?น?  ๊ทธ๋ฃน? ?? ? ์ฝ๋ ๊ฐ?? ?ฐ์ถ?
SELECT COUNT(*) as cnt 
FROM contents 
WHERE cateno=1;

-- memberno FK ?น?  ๊ด?๋ฆฌ์? ?? ? ์ฝ๋ ๊ฐ?? ?ฐ์ถ?
SELECT COUNT(*) as cnt 
FROM contents 
WHERE memberno=1;

-- cateno FK ?น?  ๊ทธ๋ฃน? ?? ? ์ฝ๋ ๋ชจ๋ ?ญ? 
DELETE FROM contents
WHERE cateno=1;

-- memberno FK ?น?  ๊ด?๋ฆฌ์? ?? ? ์ฝ๋ ๋ชจ๋ ?ญ? 
DELETE FROM contents
WHERE memberno=1;

commit;

-- ?ค?? ์นดํ๊ณ ๋ฆฌ? ?? ? ์ฝ๋ ๊ฐ?? ?ฐ์ถ?: IN
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno IN(1,2,3);

-- ?ค?? ์นดํ๊ณ ๋ฆฌ? ?? ? ์ฝ๋ ๋ชจ๋ ?ญ? : IN
SELECT contentsno, memberno, cateno, title
FROM contents
WHERE cateno IN(1,2,3);

CONTENTSNO    ADMINNO     CATENO TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           ?ธ?ฐ?ค??ผ                                                                                                                                                                                                                                                                                                  
         4             1                   2           ??ผ๋ง?                                                                                                                                                                                                                                                                                                      
         5             1                   3           ์ปจ์?๋ง?                                                                                                                                                                                                                                                                                                      
         6             1                   1           ๋ง์       
         
SELECT contentsno, memberno, cateno, title
FROM contents
WHERE cateno IN('1','2','3');

CONTENTSNO    ADMINNO     CATENO TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           ?ธ?ฐ?ค??ผ                                                                                                                                                                                                                                                                                                  
         4             1                   2           ??ผ๋ง?                                                                                                                                                                                                                                                                                                      
         5             1                   3           ์ปจ์?๋ง?                                                                                                                                                                                                                                                                                                      
         6             1                   1           ๋ง์       

-- ----------------------------------------------------------------------------------------------------
-- cate + contents INNER JOIN
-- ----------------------------------------------------------------------------------------------------
-- ๋ชจ๋ ๊ธ?
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
     WHERE cateno=14 AND (title LIKE '%?ผ๊ฒ?%' OR content LIKE '%?ผ๊ฒ?%' OR word LIKE '%?ผ๊ฒ?%')
)
WHERE r >= 1 AND r <= 3;

-- 2 page
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
       file1, file1saved, thumb1, size1, map, youtube, r
FROM (
     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
            file1, file1saved, thumb1, size1, map, youtube, rownum as r
     FROM vcontents -- View
     WHERE cateno=14 AND (title LIKE '%?ผ๊ฒ?%' OR content LIKE '%?ผ๊ฒ?%' OR word LIKE '%?ผ๊ฒ?%')
)
WHERE r >= 4 AND r <= 6;


-- ----------------------------------------------------------------------------------------------------
-- ๊ด??ฌ ์นดํ๊ณ ๋ฆฌ? ์ข์?(recom) ๊ธฐ์?, 1๋ฒ? ???ด 1๋ฒ? ์นดํ๊ณ ๋ฆฌ๋ฅ? ์ถ์ฒ ๋ฐ๋ ๊ฒฝ์ฐ, ์ถ์ฒ ???ด 7๊ฑด์ผ ๊ฒฝ์ฐ
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
-- ๊ด??ฌ ์นดํ๊ณ ๋ฆฌ? ?? (score) ๊ธฐ์?, 1๋ฒ? ???ด 1๋ฒ? ์นดํ๊ณ ๋ฆฌ๋ฅ? ์ถ์ฒ ๋ฐ๋ ๊ฒฝ์ฐ, ์ถ์ฒ ???ด 7๊ฑด์ผ ๊ฒฝ์ฐ
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
-- ๊ด??ฌ ์นดํ๊ณ ๋ฆฌ? ์ต์  ?? ๊ธฐ์?, 1๋ฒ? ???ด 1๋ฒ? ์นดํ๊ณ ๋ฆฌ๋ฅ? ์ถ์ฒ ๋ฐ๋ ๊ฒฝ์ฐ, ์ถ์ฒ ???ด 7๊ฑด์ผ ๊ฒฝ์ฐ
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
-- ๊ด??ฌ ์นดํ๊ณ ๋ฆฌ? ์กฐํ? ??? ??๊ธฐ์?, 1๋ฒ? ???ด 1๋ฒ? ์นดํ๊ณ ๋ฆฌ๋ฅ? ์ถ์ฒ ๋ฐ๋ ๊ฒฝ์ฐ, ์ถ์ฒ ???ด 7๊ฑด์ผ ๊ฒฝ์ฐ
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
-- ๊ด??ฌ ์นดํ๊ณ ๋ฆฌ? ?ฎ?? ๊ฐ?๊ฒ? ?? ์ถ์ฒ, 1๋ฒ? ???ด 1๋ฒ? ์นดํ๊ณ ๋ฆฌ๋ฅ? ์ถ์ฒ ๋ฐ๋ ๊ฒฝ์ฐ, ์ถ์ฒ ???ด 7๊ฑด์ผ ๊ฒฝ์ฐ
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
-- ๊ด??ฌ ์นดํ๊ณ ๋ฆฌ? ??? ๊ฐ?๊ฒ? ?? ์ถ์ฒ, 1๋ฒ? ???ด 1๋ฒ? ์นดํ๊ณ ๋ฆฌ๋ฅ? ์ถ์ฒ ๋ฐ๋ ๊ฒฝ์ฐ, ์ถ์ฒ ???ด 7๊ฑด์ผ ๊ฒฝ์ฐ
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
-- FK cateno ์ปฌ๋ผ? ????? ?? SQL
-----------------------------------------------------------
-- ?น?  ์นดํ๊ณ ๋ฆฌ? ?? ? ์ฝ๋ ๊ฐ??๋ฅ? ๋ฆฌํด
SELECT COUNT(*) as cnt 
FROM contents 
WHERE cateno=1;
  
-- ?น?  ์นดํ๊ณ ๋ฆฌ? ?? ๋ชจ๋  ? ์ฝ๋ ?ญ? 
DELETE FROM contents
WHERE cateno=1;

-----------------------------------------------------------
-- FK memberno ์ปฌ๋ผ? ????? ?? SQL
-----------------------------------------------------------
-- ?น?  ??? ?? ? ์ฝ๋ ๊ฐ??๋ฅ? ๋ฆฌํด
SELECT COUNT(*) as cnt 
FROM contents 
WHERE memberno=1;
  
-- ?น?  ??? ?? ๋ชจ๋  ? ์ฝ๋ ?ญ? 
DELETE FROM contents
WHERE memberno=1;
