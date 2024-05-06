/**********************************/
/* Table Name: 오버 렌딩 카테고리 */
/**********************************/
CREATE TABLE CATE(
		CATENO                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		NAME                          		VARCHAR2(30)		 NOT NULL,
		NAMESUB                       		VARCHAR2(30)		 DEFAULT '-'		 NOT NULL,
		CNT                           		NUMBER(7)		 DEFAULT 0		 NOT NULL,
		RDATE                         		DATE		 NOT NULL,
		SEQNO                         		NUMBER(5)		 DEFAULT 0		 NOT NULL,
		VISIBLE                       		CHAR(1)		 DEFAULT 'N'		 NOT NULL
);

COMMENT ON TABLE CATE is '오버 렌딩 카테고리';
COMMENT ON COLUMN CATE.CATENO is '카테고리번호';
COMMENT ON COLUMN CATE.NAME is '중분류명';
COMMENT ON COLUMN CATE.NAMESUB is '소분류명';
COMMENT ON COLUMN CATE.CNT is '관련 자료수';
COMMENT ON COLUMN CATE.RDATE is '등록일';
COMMENT ON COLUMN CATE.SEQNO is '출력 순서';
COMMENT ON COLUMN CATE.VISIBLE is '출력 모드';


/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE MEMBER(
		MEMBERNO                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE MEMBER is '회원';
COMMENT ON COLUMN MEMBER.MEMBERNO is '회원번호';


/**********************************/
/* Table Name: 컨텐츠 */
/**********************************/
CREATE TABLE CONTENTS(
		CONTENTSNO                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		CATENO                        		NUMBER(10)		 NULL ,
		MEMBERNO                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (CATENO) REFERENCES CATE (CATENO),
  FOREIGN KEY (MEMBERNO) REFERENCES MEMBER (MEMBERNO)
);

COMMENT ON TABLE CONTENTS is '컨텐츠';
COMMENT ON COLUMN CONTENTS.CONTENTSNO is '컨텐츠번호';
COMMENT ON COLUMN CONTENTS.CATENO is '카테고리번호';
COMMENT ON COLUMN CONTENTS.MEMBERNO is '회원번호';


/**********************************/
/* Table Name: 댓글 */
/**********************************/
CREATE TABLE reply(
		replyno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		CONTENTSNO                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (CONTENTSNO) REFERENCES CONTENTS (CONTENTSNO)
);

COMMENT ON TABLE reply is '댓글';
COMMENT ON COLUMN reply.replyno is '댓글번호';
COMMENT ON COLUMN reply.CONTENTSNO is '컨텐츠번호';


