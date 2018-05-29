/**********************************/
/* Table Name: 카테고리 그룹 */
/**********************************/
CREATE TABLE categrp(
		categrpno                     		NUMBER(7)		 NOT NULL,
		name                          		VARCHAR2(50)		 NOT NULL,
		seqno                         		NUMBER(7)		 DEFAULT 0		 NOT NULL,
		visible                       		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		rdate                         		DATE		 NOT NULL
);

COMMENT ON TABLE categrp is '카테고리 그룹';
COMMENT ON COLUMN categrp.categrpno is '카테고리 그룹';
COMMENT ON COLUMN categrp.name is '카테고리 이름';
COMMENT ON COLUMN categrp.seqno is '출력 순서';
COMMENT ON COLUMN categrp.visible is '출력 모드';
COMMENT ON COLUMN categrp.rdate is '카테고리 그룹 생성일';


/**********************************/
/* Table Name: 카테고리 */
/**********************************/
CREATE TABLE category(
		categoryno                    		NUMBER(7)		 NOT NULL,
		categrpno                     		NUMBER(7)		 NULL 
);

COMMENT ON TABLE category is '카테고리';
COMMENT ON COLUMN category.categoryno is '카테고리번호';
COMMENT ON COLUMN category.categrpno is '카테고리 그룹';


/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		mno                           		NUMBER(8)		 NOT NULL
);

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.mno is '회원 번호';


/**********************************/
/* Table Name: 블로그 내용 */
/**********************************/
CREATE TABLE blog(
		blogno                        		NUMBER(8)		 NOT NULL,
		categoryno                    		NUMBER(7)		 NULL ,
		mno                           		NUMBER(8)		 NULL 
);

COMMENT ON TABLE blog is '블로그 내용';
COMMENT ON COLUMN blog.blogno is '블로그 내용 번호';
COMMENT ON COLUMN blog.categoryno is '카테고리번호';
COMMENT ON COLUMN blog.mno is '회원 번호';



ALTER TABLE categrp ADD CONSTRAINT IDX_categrp_PK PRIMARY KEY (categrpno);

ALTER TABLE category ADD CONSTRAINT IDX_category_PK PRIMARY KEY (categoryno);
ALTER TABLE category ADD CONSTRAINT IDX_category_FK0 FOREIGN KEY (categrpno) REFERENCES categrp (categrpno);

ALTER TABLE member ADD CONSTRAINT IDX_member_PK PRIMARY KEY (mno);

ALTER TABLE blog ADD CONSTRAINT IDX_blog_PK PRIMARY KEY (blogno);
ALTER TABLE blog ADD CONSTRAINT IDX_blog_FK0 FOREIGN KEY (categoryno) REFERENCES category (categoryno);
ALTER TABLE blog ADD CONSTRAINT IDX_blog_FK1 FOREIGN KEY (mno) REFERENCES member (mno);

