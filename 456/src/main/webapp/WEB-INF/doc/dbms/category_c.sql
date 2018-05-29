�� /WEB-INF/doc/category_c.sql

1. DDL(Data Definition Language): ���̺� ����
-------------------------------------------------------------------------------------
-- FOREIGN KEY (categrpno) REFERENCES categrp (categrpno):
-- categrpno �÷��� ���� categrp ���̺��� categrpno �÷��� ��ϵ� ����
-- ����� �� �ֽ��ϴ�.  
-- PK ������ FK ���ڵ� �ڵ� ����(���� �ƴ�)
-- FOREIGN KEY (categrpno) REFERENCES categrp (categrpno) ON DELETE CASCADE
/**********************************/
/* Table Name: ī�װ� */
/**********************************/
DROP TABLE blog;
DROP TABLE category;
DROP TABLE categrp;

DROP TABLE MEMBER;

CREATE TABLE category(
  categoryno      NUMBER(7)                                NOT NULL,
  categrpno       NUMBER(10)                               NOT NULL ,
  title                VARCHAR2(50)                            NOT NULL,
  seqno             NUMBER(3)        DEFAULT 1         NOT NULL,
  visible             CHAR(1)            DEFAULT 'Y'        NOT NULL,
  ids                  VARCHAR2(100)                                NULL,
  cnt                  NUMBER(6)       DEFAULT 0          NOT NULL,
  rdate               DATE                 NOT NULL,
  PRIMARY KEY(categoryno),
  FOREIGN KEY (categrpno) REFERENCES categrp (categrpno)
);

COMMENT ON TABLE category is 'ī�װ�';
COMMENT ON COLUMN category.categoryno is 'ī�װ� ��ȣ';
COMMENT ON COLUMN category.categrpno is 'ī�װ� �׷� ��ȣ';
COMMENT ON COLUMN category.title is '�Խ��� �̸�';
COMMENT ON COLUMN category.seqno is '��� ����';
COMMENT ON COLUMN category.visible is '��� ���';
COMMENT ON COLUMN category.ids is '���� ����';
COMMENT ON COLUMN category.cnt is '��ϵ� �� ��';
COMMENT ON COLUMN category.rdate is '�����';


2. ���̺� ����: �ڽ� -> �θ�
�� DROP TABLE categrp; : ORA-02449: unique/primary keys in table referenced by foreign keys
�� �ڽ� ���̺� ����: DROP TABLE category;
�� �θ� ���̺� ����: DROP TABLE categrp;


3. ���̺� ����: �θ� -> �ڽ�
�� FK category ������ ���� �߻�: ORA-00942: table or view does not exist
�� �θ� ���̺� ���� ����: categrp
�� �ڽ� ���̺� ����: category


4. �θ� ���̺��� ���� ����(���� ���� ����), ���� ���ǵ� �Բ� ������.
DROP TABLE categrp CASCADE CONSTRAINTS;


5. ���ڵ� �߰�, ERROR, �θ� ���̺� PK �÷��� ���� ���� ���
SELECT * FROM categrp ORDER BY seqno ASC;
 CATEGRPNO   SORT     SEQNO
 ----------  ---------   ---------
 PK ���̺� ���ڵ� ����.

-- ���� �ڷ� ���� ���ڵ� �߰�
-- ERROR �޽���: FK categrpno �÷��� �� '1'�� PK ���̺� ���� ��� �߻�
-- ORA-02291: integrity constraint (SOLDESK.SYS_C007052) violated - parent key not found
INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1000, 'JAVA', 1, 'Y', 'admin', sysdate);

             
6. ���ڵ� �߰�, �θ� ���̺� PK �÷��� ���� �ִ� ���
   - ���ڵ� �߰� ����: �θ� categrp -> �ڽ� category

1) categrp ���̺� INSERT SQL ���� 

SELECT * FROM categrp ORDER BY seqno ASC;

 CATEGRPNO NAME  SEQNO VISIBLE RDATE
 --------- ----- ----- ------- ---------------------
         1 ��ȭ        1 Y       2017-04-18 12:03:16.0
         2 ���� ����     2 Y       2017-04-18 12:03:29.0
         3 �ؿ� ����     3 Y       2017-04-18 12:03:58.0
     
INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '��', 1 , 'Y', 'admin', sysdate);

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '�θǽ�', 2 ,'Y' , 'admin', sysdate);

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '�ڹ�' , 3 , 'Y' , 'admin', sysdate);

             
7. ���
-- DELETE FROM category;

SELECT categoryno, categrpno, title, seqno, visible, ids, rdate
FROM category 
ORDER BY seqno ASC;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   RDATE
 ---------- --------- ----- ----- ------- ----- ---------------------
          1         1 ��        1 Y       admin 2017-04-18 12:16:52.0
          2         1 �θǽ�       2 Y       admin 2017-04-18 12:16:53.0
          3         1 �ڹ�        3 Y       admin 2017-04-18 12:16:54.0


8. �ٸ� ī�װ� �׷��� ���
INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             2, '������' , 1 , 'Y' , 'admin', sysdate);
             
INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             2, '��û��' , 2 , 'Y' , 'admin', sysdate);

             
9. �׷�ȭ�Ͽ� �����Ͽ� ���
1) categoryno �÷� �������� ����
SELECT categoryno, categrpno, title, seqno, visible, ids, rdate
FROM category 
ORDER BY categoryno ASC;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   RDATE
 ---------- --------- ----- ----- ------- ----- ---------------------
          1         1 ��        1 Y       admin 2017-04-18 12:16:52.0
          2         1 �θǽ�       2 Y       admin 2017-04-18 12:16:53.0
          3         1 �ڹ�        3 Y       admin 2017-04-18 12:16:54.0
          4         2 ������       1 Y       admin 2017-04-18 12:18:44.0
          5         2 ��û��       2 Y       admin 2017-04-18 12:19:02.0

         
2) ��� ������ ����ϴ� ������ �ȵ�.
SELECT categoryno, categrpno, title, seqno, visible, ids, rdate
FROM category 
ORDER BY seqno ASC;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   RDATE
 ---------- --------- ----- ----- ------- ----- ---------------------
          1         1 ��        1 Y       admin 2017-04-18 12:16:52.0
          4         2 ������       1 Y       admin 2017-04-18 12:18:44.0
          2         1 �θǽ�       2 Y       admin 2017-04-18 12:16:53.0
          5         2 ��û��       2 Y       admin 2017-04-18 12:19:02.0
          3         1 �ڹ�        3 Y       admin 2017-04-18 12:16:54.0

          
3) �׷캰�� �����Ͽ� ���          
SELECT categoryno, categrpno, title, seqno, visible, ids, rdate
FROM category 
ORDER BY categrpno ASC, seqno ASC;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   RDATE
 ---------- --------- ----- ----- ------- ----- ---------------------
          1         1 ��        1 Y       admin 2017-04-18 12:16:52.0
          2         1 �θǽ�       2 Y       admin 2017-04-18 12:16:53.0
          3         1 �ڹ�        3 Y       admin 2017-04-18 12:16:54.0
          4         2 ������       1 Y       admin 2017-04-18 12:18:44.0
          5         2 ��û��       2 Y       admin 2017-04-18 12:19:02.0
          
SELECT categoryno, categrpno, title, seqno, visible, ids, rdate
FROM category 
ORDER BY categrpno ASC, seqno DESC;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   RDATE
 ---------- --------- ----- ----- ------- ----- ---------------------
          3         1 �ڹ�          3 Y       admin 2017-04-18 12:16:54.0
          2         1 �θǽ�       2 Y       admin 2017-04-18 12:16:53.0
          1         1 ��          1 Y       admin 2017-04-18 12:16:52.0
          5         2 ��û��       2 Y       admin 2017-04-18 12:19:02.0
          4         2 ������       1 Y       admin 2017-04-18 12:18:44.0
          
SELECT categoryno, categrpno, title, seqno, visible, ids, rdate
FROM category 
ORDER BY categrpno DESC, seqno ASC;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   RDATE
 ---------- --------- ----- ----- ------- ----- ---------------------
          4         2 ������       1 Y       admin 2017-04-18 12:18:44.0     
          5         2 ��û��       2 Y       admin 2017-04-18 12:19:02.0
          3         1 �ڹ�          3 Y       admin 2017-04-18 12:16:54.0
          1         1 ��          1 Y       admin 2017-04-18 12:16:52.0
          2         1 �θǽ�       2 Y       admin 2017-04-18 12:16:53.0
    
           
10. ��ȸ
SELECT categoryno, categrpno, title, seqno, visible, ids
FROM category 
WHERE categoryno=1;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 ---------- --------- ----- ----- ------- -----
          1         1 ��        1 Y       admin


11. ����: title, seqno, visible, ids
UPDATE category
SET title='����', seqno=1, visible='N', ids='admin1/user1/user2'
WHERE categoryno=1;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 ---------- --------- ----- ----- ------- ------------------
          1         1 ����        1 N       admin1/user1/user2


12. categrp(��з�) ���� ���� ���� ����
SELECT COUNT(*) as cnt
FROM category
WHERE categrpno = 2;
 CNT
 -----
   2

   
13. ����
- ���ڵ� ���� ����: �ڽ� category -> �θ� categrp 

1) �ϳ��� ���ڵ� ����
DELETE FROM category WHERE categoryno = 1;

2) categrp(��з�) ���� ��ġ�ϴ� �ټ��� ���ڵ� ����(���� ���ڵ尡 ���� �� �� ����)
DELETE FROM category WHERE categrpno = 1;
   
   
14. ��� �켱 ���� ����, 10 -> 1
UPDATE category 
SET seqno = seqno - 1 
WHERE categoryno=1;


15. ��� �켱 ���� ����, 1 -> 10
UPDATE category 
SET seqno = seqno + 1 
WHERE categoryno=1;


16. categrp(��з�) ���� ���� ���� ����
SELECT COUNT(*) as cnt
FROM category
WHERE categrpno = 1;

 CNT
 -----
   3
 
    
17. categrp(��з�) ���� ��ġ�ϴ� �ټ��� ���ڵ� ����(���� ���ڵ尡 ���� �� �� ����)
DELETE FROM category
WHERE categrpno = 1;


18. blog �� �߰������� ��ϵ� �ۼ��� ����
UPDATE category 
SET cnt = cnt + 1 
WHERE categoryno=1;


19. blog �� ���������� ��ϵ� �ۼ��� ����
UPDATE category 
SET cnt = cnt - 1 
WHERE categoryno=1;


20. �ۼ��� �ʱ�ȭ
UPDATE category 
SET cnt = 0;


-------------------------------------------------------------------------------------
 
 