-- /src/main/webapp/WEB-INF/doc/ì»¨í…ì¸?/contents_c.sql
DROP TABLE contents CASCADE CONSTRAINTS; -- ??‹ ë¬´ì‹œ?•˜ê³? ?‚­? œ ê°??Š¥
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
        file1                                   VARCHAR(100)          NULL,  -- ?›ë³? ?ŒŒ?¼ëª? image
        file1saved                            VARCHAR(100)          NULL,  -- ???¥?œ ?ŒŒ?¼ëª?, image
        thumb1                              VARCHAR(100)          NULL,   -- preview image
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  -- ?ŒŒ?¼ ?‚¬?´ì¦?
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

COMMENT ON TABLE contents is 'ì»¨í…ì¸? - ?ˆœë¡?ê¸?';
COMMENT ON COLUMN contents.contentsno is 'ì»¨í…ì¸? ë²ˆí˜¸';
COMMENT ON COLUMN contents.memberno is 'ê´?ë¦¬ì ë²ˆí˜¸';
COMMENT ON COLUMN contents.cateno is 'ì¹´í…Œê³ ë¦¬ ë²ˆí˜¸';
COMMENT ON COLUMN contents.title is '? œëª?';
COMMENT ON COLUMN contents.content is '?‚´?š©';
COMMENT ON COLUMN contents.recom is 'ì¶”ì²œ?ˆ˜';
COMMENT ON COLUMN contents.cnt is 'ì¡°íšŒ?ˆ˜';
COMMENT ON COLUMN contents.replycnt is '?Œ“ê¸??ˆ˜';
COMMENT ON COLUMN contents.passwd is '?Œ¨?Š¤?›Œ?“œ';
COMMENT ON COLUMN contents.word is 'ê²??ƒ‰?–´';
COMMENT ON COLUMN contents.rdate is '?“±ë¡ì¼';
COMMENT ON COLUMN contents.file1 is 'ë©”ì¸ ?´ë¯¸ì?';
COMMENT ON COLUMN contents.file1saved is '?‹¤? œ ???¥?œ ë©”ì¸ ?´ë¯¸ì?';
COMMENT ON COLUMN contents.thumb1 is 'ë©”ì¸ ?´ë¯¸ì? Preview';
COMMENT ON COLUMN contents.size1 is 'ë©”ì¸ ?´ë¯¸ì? ?¬ê¸?';
COMMENT ON COLUMN contents.price is '? •ê°?';
COMMENT ON COLUMN contents.dc is '?• ?¸ë¥?';
COMMENT ON COLUMN contents.saleprice is '?Œë§¤ê?';
COMMENT ON COLUMN contents.point is '?¬?¸?Š¸';
COMMENT ON COLUMN contents.salecnt is '?¬ê³? ?ˆ˜?Ÿ‰';
COMMENT ON COLUMN contents.map is 'ì§??„';
COMMENT ON COLUMN contents.youtube is 'Youtube ?˜?ƒ';
COMMENT ON COLUMN contents.mp4 is '?˜?ƒ';

DROP SEQUENCE contents_seq;

CREATE SEQUENCE contents_seq
  START WITH 1                -- ?‹œ?‘ ë²ˆí˜¸
  INCREMENT BY 1            -- ì¦ê?ê°?
  MAXVALUE 9999999999  -- ìµœë?ê°?: 9999999999 --> NUMBER(10) ???‘
  CACHE 2                        -- 2ë²ˆì? ë©”ëª¨ë¦¬ì—?„œë§? ê³„ì‚°
  NOCYCLE;                      -- ?‹¤?‹œ 1ë¶??„° ?ƒ?„±?˜?Š” ê²ƒì„ ë°©ì?

-- ?“±ë¡? ?™”ë©? ?œ ?˜• 1: ì»¤ë?¤ë‹ˆ?‹°(ê³µì??‚¬?•­, ê²Œì‹œ?Œ, ?ë£Œì‹¤, ê°¤ëŸ¬ë¦?,  Q/A...)ê¸? ?“±ë¡?
INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(contents_seq.nextval, 1, 1, 'ì²?ê³„ì²œ ë§¤í™” ê±°ë¦¬', '? œê¸°ë™?—­?—?„œ ê°?ê¹Œì? ëª…í’ˆ ?‚°ì±…ë¡œ', 0, 0, 0, '123',
       '?‚°ì±?', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

-- ?œ ?˜• 1 ? „ì²? ëª©ë¡
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1
FROM contents
ORDER BY contentsno DESC;

SELECT contentsno, title, content, word, rdate
FROM contents
ORDER BY contentsno DESC;

SELECT * FROM contents;

-- ?œ ?˜• 2 ì¹´í…Œê³ ë¦¬ë³? ëª©ë¡
INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(contents_seq.nextval, 1, 2, '???–‰?‚¬', '?™?ˆ˜???? ê¸ˆìˆ˜???˜ ?„±ê³? ?Š¤?† ë¦?', 0, 0, 0, '123',
       '?“œ?¼ë§?,K?“œ?¼ë§?,?„·?”Œë¦??Š¤', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);
            
INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(contents_seq.nextval, 1, 2, '?”ê¸?ë¡œë¦¬', '?•™?­?˜ ê²°ë§', 0, 0, 0, '123',
       '?“œ?¼ë§?,K?“œ?¼ë§?,?„·?”Œë¦??Š¤', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

INSERT INTO contents(contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, 
                     word, rdate, file1, file1saved, thumb1, size1)
VALUES(contents_seq.nextval, 1, 2, '?”ê¸?ë¡œë¦¬', '?•™?­?˜ ê²°ë§', 0, 0, 0, '123',
       '?“œ?¼ë§?,K?“œ?¼ë§?,?„·?”Œë¦??Š¤', sysdate, 'space.jpg', 'space_1.jpg', 'space_t.jpg', 1000);

COMMIT;

-- ? „ì²? ëª©ë¡
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube mp4
FROM contents
ORDER BY contentsno DESC;

-- 1ë²? cateno ë§? ì¶œë ¥
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
        LOWER(file1) as file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=1
ORDER BY contentsno DESC;

-- 2ë²? cateno ë§? ì¶œë ¥
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
        LOWER(file1) as file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=2
ORDER BY contentsno ASC;

-- 3ë²? cateno ë§? ì¶œë ¥
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
        LOWER(file1) as file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=5
ORDER BY contentsno ASC;

commit;

-- ëª¨ë“  ? ˆì½”ë“œ ?‚­? œ
DELETE FROM contents;
commit;

-- ?‚­? œ
DELETE FROM contents
WHERE contentsno = 25;
commit;

DELETE FROM contents
WHERE cateno=12 AND contentsno <= 41;

commit;


-- ----------------------------------------------------------------------------------------------------
-- ê²??ƒ‰, catenoë³? ê²??ƒ‰ ëª©ë¡
-- ----------------------------------------------------------------------------------------------------
-- ëª¨ë“ ê¸?
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, map, youtube
FROM contents
ORDER BY contentsno ASC;

-- ì¹´í…Œê³ ë¦¬ë³? ëª©ë¡
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
       file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=2
ORDER BY contentsno ASC;

-- 1) ê²??ƒ‰
-- ?‘  catenoë³? ê²??ƒ‰ ëª©ë¡
-- word ì»¬ëŸ¼?˜ ì¡´ì¬ ?´?œ : ê²??ƒ‰ ? •?™•?„ë¥? ?†’?´ê¸? ?œ„?•˜?—¬ ì¤‘ìš” ?‹¨?–´ë¥? ëª…ì‹œ
-- ê¸??— 'swiss'?¼?Š” ?‹¨?–´ë§? ?“±?¥?•˜ë©? ?•œê¸?ë¡? '?Š¤?œ„?Š¤'?Š” ê²??ƒ‰ ?•ˆ?¨.
-- ?´?Ÿ° ë¬¸ì œë¥? ë°©ì??•˜ê¸°ìœ„?•´ 'swiss,?Š¤?œ„?Š¤,?Š¤?˜?Š¤,?ˆ˜?˜?Š¤,?œ ?Ÿ½' ê²??ƒ‰?–´ê°? ?“¤?–´ê°? word ì»¬ëŸ¼?„ ì¶”ê??•¨.
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=8 AND word LIKE '%ë¶???ì°Œê²Œ%'
ORDER BY contentsno DESC;

-- title, content, word column search
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=8 AND (title LIKE '%ë¶???ì°Œê²Œ%' OR content LIKE '%ë¶???ì°Œê²Œ%' OR word LIKE '%ë¶???ì°Œê²Œ%')
ORDER BY contentsno DESC;

-- ?‘¡ ê²??ƒ‰ ? ˆì½”ë“œ ê°??ˆ˜
-- ? „ì²? ? ˆì½”ë“œ ê°??ˆ˜, ì§‘ê³„ ?•¨?ˆ˜
SELECT COUNT(*)
FROM contents
WHERE cateno=8;

  COUNT(*)  <- ì»¬ëŸ¼ëª?
----------
         5
         
SELECT COUNT(*) as cnt -- ?•¨?ˆ˜ ?‚¬?š©?‹œ?Š” ì»¬ëŸ¼ ë³„ëª…?„ ?„ ?–¸?•˜?Š” ê²ƒì„ ê¶Œì¥
FROM contents
WHERE cateno=8;

       CNT <- ì»¬ëŸ¼ëª?
----------
         5

-- cateno ë³? ê²??ƒ‰?œ ? ˆì½”ë“œ ê°??ˆ˜
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=8 AND word LIKE '%ë¶???ì°Œê²Œ%';

SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=8 AND (title LIKE '%ë¶???ì°Œê²Œ%' OR content LIKE '%ë¶???ì°Œê²Œ%' OR word LIKE '%ë¶???ì°Œê²Œ%');

-- SUBSTR(ì»¬ëŸ¼ëª?, ?‹œ?‘ index(1ë¶??„° ?‹œ?‘), ê¸¸ì´), ë¶?ë¶? ë¬¸ì?—´ ì¶”ì¶œ
SELECT contentsno, SUBSTR(title, 1, 4) as title
FROM contents
WHERE cateno=8 AND (content LIKE '%ë¶???%');

-- SQL?? ???†Œë¬¸ìë¥? êµ¬ë¶„?•˜ì§? ?•Š?œ¼?‚˜ WHEREë¬¸ì— ëª…ì‹œ?•˜?Š” ê°’ì? ???†Œë¬¸ìë¥? êµ¬ë¶„?•˜?—¬ ê²??ƒ‰
SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (word LIKE '%FOOD%');

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (word LIKE '%food%'); 

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (LOWER(word) LIKE '%food%'); -- ???†Œë¬¸ìë¥? ?¼ì¹? ?‹œì¼œì„œ ê²??ƒ‰

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (UPPER(word) LIKE '%' || UPPER('FOOD') || '%'); -- ???†Œë¬¸ìë¥? ?¼ì¹? ?‹œì¼œì„œ ê²??ƒ‰ ?˜…

SELECT contentsno, title, word
FROM contents
WHERE cateno=8 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- ???†Œë¬¸ìë¥? ?¼ì¹? ?‹œì¼œì„œ ê²??ƒ‰

SELECT contentsno || '. ' || title || ' ?ƒœê·?: ' || word as title -- ì»¬ëŸ¼?˜ ê²°í•©, ||
FROM contents
WHERE cateno=8 AND (LOWER(word) LIKE '%' || LOWER('Food') || '%'); -- ???†Œë¬¸ìë¥? ?¼ì¹? ?‹œì¼œì„œ ê²??ƒ‰


SELECT UPPER('?•œê¸?') FROM dual; -- dual: ?˜¤?¼?´?—?„œ SQL ?˜•?‹?„ ë§ì¶”ê¸°ìœ„?•œ ?‹œ?Š¤?…œ ?…Œ?´ë¸?

-- ----------------------------------------------------------------------------------------------------
-- ê²??ƒ‰ + ?˜?´ì§? + ë©”ì¸ ?´ë¯¸ì?
-- ----------------------------------------------------------------------------------------------------
-- step 1
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE cateno=1 AND (title LIKE '%?‹¨?’%' OR content LIKE '%?‹¨?’%' OR word LIKE '%?‹¨?’%')
ORDER BY contentsno DESC;

-- step 2
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, rownum as r
FROM (
          SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                     file1, file1saved, thumb1, size1, map, youtube
          FROM contents
          WHERE cateno=1 AND (title LIKE '%?‹¨?’%' OR content LIKE '%?‹¨?’%' OR word LIKE '%?‹¨?’%')
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
                     WHERE cateno=1 AND (title LIKE '%?‹¨?’%' OR content LIKE '%?‹¨?’%' OR word LIKE '%?‹¨?’%')
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
                     WHERE cateno=1 AND (title LIKE '%?‹¨?’%' OR content LIKE '%?‹¨?’%' OR word LIKE '%?‹¨?’%')
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 4 AND r <= 6;

-- ???†Œë¬¸ìë¥? ì²˜ë¦¬?•˜?Š” ?˜?´ì§? ì¿¼ë¦¬
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
           file1, file1saved, thumb1, size1, map, youtube, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                      file1, file1saved, thumb1, size1, map, youtube, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
                                file1, file1saved, thumb1, size1, map, youtube
                     FROM contents
                     WHERE cateno=1 AND (UPPER(title) LIKE '%' || UPPER('?‹¨?’') || '%' 
                                         OR UPPER(content) LIKE '%' || UPPER('?‹¨?’') || '%' 
                                         OR UPPER(word) LIKE '%' || UPPER('?‹¨?’') || '%')
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 1 AND r <= 3;

-- ----------------------------------------------------------------------------
-- ì¡°íšŒ
-- ----------------------------------------------------------------------------
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, passwd, word, rdate,
           file1, file1saved, thumb1, size1, map, youtube
FROM contents
WHERE contentsno = 1;

-- ----------------------------------------------------------------------------
-- ?‹¤?Œ ì§??„, MAP, ë¨¼ì? ? ˆì½”ë“œê°? ?“±ë¡ë˜?–´ ?ˆ?–´?•¼?•¨.
-- map                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- MAP ?“±ë¡?/?ˆ˜? •
UPDATE contents SET map='ì¹´í˜?‚° ì§??„ ?Š¤?¬ë¦½íŠ¸' WHERE contentsno=1;

-- MAP ?‚­? œ
UPDATE contents SET map='' WHERE contentsno=1;

commit;

-- ----------------------------------------------------------------------------
-- Youtube, ë¨¼ì? ? ˆì½”ë“œê°? ?“±ë¡ë˜?–´ ?ˆ?–´?•¼?•¨.
-- youtube                                   VARCHAR2(1000)         NULL ,
-- ----------------------------------------------------------------------------
-- youtube ?“±ë¡?/?ˆ˜? •
UPDATE contents SET youtube='Youtube ?Š¤?¬ë¦½íŠ¸' WHERE contentsno=1;

-- youtube ?‚­? œ
UPDATE contents SET youtube='' WHERE contentsno=1;

commit;

-- ?Œ¨?Š¤?›Œ?“œ ê²??‚¬, id="password_check"
SELECT COUNT(*) as cnt 
FROM contents
WHERE contentsno=1 AND passwd='123';

-- ?…?Š¤?Š¸ ?ˆ˜? •: ?˜ˆ?™¸ ì»¬ëŸ¼: ì¶”ì²œ?ˆ˜, ì¡°íšŒ?ˆ˜, ?Œ“ê¸? ?ˆ˜
UPDATE contents
SET title='ê¸°ì°¨ë¥? ??ê³?', content='ê³„íš?—†?´ ?—¬?–‰ ì¶œë°œ',  word='?‚˜,ê¸°ì°¨,?ƒê°?' 
WHERE contentsno = 2;

-- ERROR, " ?‚¬?š© ?—?Ÿ¬
UPDATE contents
SET title='ê¸°ì°¨ë¥? ??ê³?', content="ê³„íš?—†?´ '?—¬?–‰' ì¶œë°œ",  word='?‚˜,ê¸°ì°¨,?ƒê°?'
WHERE contentsno = 1;

-- ERROR, \' ?—?Ÿ¬
UPDATE contents
SET title='ê¸°ì°¨ë¥? ??ê³?', content='ê³„íš?—†?´ \'?—¬?–‰\' ì¶œë°œ',  word='?‚˜,ê¸°ì°¨,?ƒê°?'
WHERE contentsno = 1;

-- SUCCESS, '' ?•œë²? ' ì¶œë ¥?¨.
UPDATE contents
SET title='ê¸°ì°¨ë¥? ??ê³?', content='ê³„íš?—†?´ ''?—¬?–‰'' ì¶œë°œ',  word='?‚˜,ê¸°ì°¨,?ƒê°?'
WHERE contentsno = 1;

-- SUCCESS
UPDATE contents
SET title='ê¸°ì°¨ë¥? ??ê³?', content='ê³„íš?—†?´ "?—¬?–‰" ì¶œë°œ',  word='?‚˜,ê¸°ì°¨,?ƒê°?'
WHERE contentsno = 1;

commit;

-- ?ŒŒ?¼ ?ˆ˜? •
UPDATE contents
SET file1='train.jpg', file1saved='train.jpg', thumb1='train_t.jpg', size1=5000
WHERE contentsno = 1;

-- ?‚­? œ
DELETE FROM contents
WHERE contentsno = 42;

commit;

DELETE FROM contents
WHERE contentsno >= 7;

commit;

-- ì¶”ì²œ
UPDATE contents
SET recom = recom + 1
WHERE contentsno = 1;

-- cateno FK ?Š¹? • ê·¸ë£¹?— ?†?•œ ? ˆì½”ë“œ ê°??ˆ˜ ?‚°ì¶?
SELECT COUNT(*) as cnt 
FROM contents 
WHERE cateno=1;

-- memberno FK ?Š¹? • ê´?ë¦¬ì?— ?†?•œ ? ˆì½”ë“œ ê°??ˆ˜ ?‚°ì¶?
SELECT COUNT(*) as cnt 
FROM contents 
WHERE memberno=1;

-- cateno FK ?Š¹? • ê·¸ë£¹?— ?†?•œ ? ˆì½”ë“œ ëª¨ë‘ ?‚­? œ
DELETE FROM contents
WHERE cateno=1;

-- memberno FK ?Š¹? • ê´?ë¦¬ì?— ?†?•œ ? ˆì½”ë“œ ëª¨ë‘ ?‚­? œ
DELETE FROM contents
WHERE memberno=1;

commit;

-- ?‹¤?ˆ˜?˜ ì¹´í…Œê³ ë¦¬?— ?†?•œ ? ˆì½”ë“œ ê°??ˆ˜ ?‚°ì¶?: IN
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno IN(1,2,3);

-- ?‹¤?ˆ˜?˜ ì¹´í…Œê³ ë¦¬?— ?†?•œ ? ˆì½”ë“œ ëª¨ë‘ ?‚­? œ: IN
SELECT contentsno, memberno, cateno, title
FROM contents
WHERE cateno IN(1,2,3);

CONTENTSNO    ADMINNO     CATENO TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           ?¸?„°?Š¤?…”?¼                                                                                                                                                                                                                                                                                                  
         4             1                   2           ?“œ?¼ë§?                                                                                                                                                                                                                                                                                                      
         5             1                   3           ì»¨ì?ë§?                                                                                                                                                                                                                                                                                                      
         6             1                   1           ë§ˆì…˜       
         
SELECT contentsno, memberno, cateno, title
FROM contents
WHERE cateno IN('1','2','3');

CONTENTSNO    ADMINNO     CATENO TITLE                                                                                                                                                                                                                                                                                                       
---------- ---------- ---------- ------------------------
         3             1                   1           ?¸?„°?Š¤?…”?¼                                                                                                                                                                                                                                                                                                  
         4             1                   2           ?“œ?¼ë§?                                                                                                                                                                                                                                                                                                      
         5             1                   3           ì»¨ì?ë§?                                                                                                                                                                                                                                                                                                      
         6             1                   1           ë§ˆì…˜       

-- ----------------------------------------------------------------------------------------------------
-- cate + contents INNER JOIN
-- ----------------------------------------------------------------------------------------------------
-- ëª¨ë“ ê¸?
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
     WHERE cateno=14 AND (title LIKE '%?•¼ê²?%' OR content LIKE '%?•¼ê²?%' OR word LIKE '%?•¼ê²?%')
)
WHERE r >= 1 AND r <= 3;

-- 2 page
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
       file1, file1saved, thumb1, size1, map, youtube, r
FROM (
     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate,
            file1, file1saved, thumb1, size1, map, youtube, rownum as r
     FROM vcontents -- View
     WHERE cateno=14 AND (title LIKE '%?•¼ê²?%' OR content LIKE '%?•¼ê²?%' OR word LIKE '%?•¼ê²?%')
)
WHERE r >= 4 AND r <= 6;


-- ----------------------------------------------------------------------------------------------------
-- ê´??‹¬ ì¹´í…Œê³ ë¦¬?˜ ì¢‹ì•„?š”(recom) ê¸°ì?, 1ë²? ?šŒ?›?´ 1ë²? ì¹´í…Œê³ ë¦¬ë¥? ì¶”ì²œ ë°›ëŠ” ê²½ìš°, ì¶”ì²œ ?ƒ?’ˆ?´ 7ê±´ì¼ ê²½ìš°
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
-- ê´??‹¬ ì¹´í…Œê³ ë¦¬?˜ ?‰? (score) ê¸°ì?, 1ë²? ?šŒ?›?´ 1ë²? ì¹´í…Œê³ ë¦¬ë¥? ì¶”ì²œ ë°›ëŠ” ê²½ìš°, ì¶”ì²œ ?ƒ?’ˆ?´ 7ê±´ì¼ ê²½ìš°
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
-- ê´??‹¬ ì¹´í…Œê³ ë¦¬?˜ ìµœì‹  ?ƒ?’ˆ ê¸°ì?, 1ë²? ?šŒ?›?´ 1ë²? ì¹´í…Œê³ ë¦¬ë¥? ì¶”ì²œ ë°›ëŠ” ê²½ìš°, ì¶”ì²œ ?ƒ?’ˆ?´ 7ê±´ì¼ ê²½ìš°
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
-- ê´??‹¬ ì¹´í…Œê³ ë¦¬?˜ ì¡°íšŒ?ˆ˜ ?†’?? ?ƒ?’ˆê¸°ì?, 1ë²? ?šŒ?›?´ 1ë²? ì¹´í…Œê³ ë¦¬ë¥? ì¶”ì²œ ë°›ëŠ” ê²½ìš°, ì¶”ì²œ ?ƒ?’ˆ?´ 7ê±´ì¼ ê²½ìš°
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
-- ê´??‹¬ ì¹´í…Œê³ ë¦¬?˜ ?‚®?? ê°?ê²? ?ƒ?’ˆ ì¶”ì²œ, 1ë²? ?šŒ?›?´ 1ë²? ì¹´í…Œê³ ë¦¬ë¥? ì¶”ì²œ ë°›ëŠ” ê²½ìš°, ì¶”ì²œ ?ƒ?’ˆ?´ 7ê±´ì¼ ê²½ìš°
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
-- ê´??‹¬ ì¹´í…Œê³ ë¦¬?˜ ?†’?? ê°?ê²? ?ƒ?’ˆ ì¶”ì²œ, 1ë²? ?šŒ?›?´ 1ë²? ì¹´í…Œê³ ë¦¬ë¥? ì¶”ì²œ ë°›ëŠ” ê²½ìš°, ì¶”ì²œ ?ƒ?’ˆ?´ 7ê±´ì¼ ê²½ìš°
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
-- FK cateno ì»¬ëŸ¼?— ???‘?•˜?Š” ?•„?ˆ˜ SQL
-----------------------------------------------------------
-- ?Š¹? • ì¹´í…Œê³ ë¦¬?— ?†?•œ ? ˆì½”ë“œ ê°??ˆ˜ë¥? ë¦¬í„´
SELECT COUNT(*) as cnt 
FROM contents 
WHERE cateno=1;
  
-- ?Š¹? • ì¹´í…Œê³ ë¦¬?— ?†?•œ ëª¨ë“  ? ˆì½”ë“œ ?‚­? œ
DELETE FROM contents
WHERE cateno=1;

-----------------------------------------------------------
-- FK memberno ì»¬ëŸ¼?— ???‘?•˜?Š” ?•„?ˆ˜ SQL
-----------------------------------------------------------
-- ?Š¹? • ?šŒ?›?— ?†?•œ ? ˆì½”ë“œ ê°??ˆ˜ë¥? ë¦¬í„´
SELECT COUNT(*) as cnt 
FROM contents 
WHERE memberno=1;
  
-- ?Š¹? • ?šŒ?›?— ?†?•œ ëª¨ë“  ? ˆì½”ë“œ ?‚­? œ
DELETE FROM contents
WHERE memberno=1;
