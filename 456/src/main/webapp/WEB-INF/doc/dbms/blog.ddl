/**********************************/
/* Table Name: ī�װ� �׷� */
/**********************************/
CREATE TABLE categrp(
		categrpno                     		NUMBER(7)		 NOT NULL,
		name                          		VARCHAR2(50)		 NOT NULL,
		seqno                         		NUMBER(7)		 DEFAULT 0		 NOT NULL,
		visible                       		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		rdate                         		DATE		 NOT NULL
);

COMMENT ON TABLE categrp is 'ī�װ� �׷�';
COMMENT ON COLUMN categrp.categrpno is 'ī�װ� �׷�';
COMMENT ON COLUMN categrp.name is 'ī�װ� �̸�';
COMMENT ON COLUMN categrp.seqno is '��� ����';
COMMENT ON COLUMN categrp.visible is '��� ���';
COMMENT ON COLUMN categrp.rdate is 'ī�װ� �׷� ������';


/**********************************/
/* Table Name: ī�װ� */
/**********************************/
CREATE TABLE category(
		categoryno                    		NUMBER(7)		 NOT NULL,
		categrpno                     		NUMBER(7)		 NULL 
);

COMMENT ON TABLE category is 'ī�װ�';
COMMENT ON COLUMN category.categoryno is 'ī�װ���ȣ';
COMMENT ON COLUMN category.categrpno is 'ī�װ� �׷�';


/**********************************/
/* Table Name: ȸ�� */
/**********************************/
CREATE TABLE member(
		mno                           		NUMBER(8)		 NOT NULL
);

COMMENT ON TABLE member is 'ȸ��';
COMMENT ON COLUMN member.mno is 'ȸ�� ��ȣ';


/**********************************/
/* Table Name: ��α� ���� */
/**********************************/
CREATE TABLE blog(
		blogno                        		NUMBER(8)		 NOT NULL,
		categoryno                    		NUMBER(7)		 NULL ,
		mno                           		NUMBER(8)		 NULL 
);

COMMENT ON TABLE blog is '��α� ����';
COMMENT ON COLUMN blog.blogno is '��α� ���� ��ȣ';
COMMENT ON COLUMN blog.categoryno is 'ī�װ���ȣ';
COMMENT ON COLUMN blog.mno is 'ȸ�� ��ȣ';



ALTER TABLE categrp ADD CONSTRAINT IDX_categrp_PK PRIMARY KEY (categrpno);

ALTER TABLE category ADD CONSTRAINT IDX_category_PK PRIMARY KEY (categoryno);
ALTER TABLE category ADD CONSTRAINT IDX_category_FK0 FOREIGN KEY (categrpno) REFERENCES categrp (categrpno);

ALTER TABLE member ADD CONSTRAINT IDX_member_PK PRIMARY KEY (mno);

ALTER TABLE blog ADD CONSTRAINT IDX_blog_PK PRIMARY KEY (blogno);
ALTER TABLE blog ADD CONSTRAINT IDX_blog_FK0 FOREIGN KEY (categoryno) REFERENCES category (categoryno);
ALTER TABLE blog ADD CONSTRAINT IDX_blog_FK1 FOREIGN KEY (mno) REFERENCES member (mno);

