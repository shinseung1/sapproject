�� /webapp/WEB-INF/doc/dbms/blog_c.sql
-----------------------------------------------------------------------------------
DROP TABLE member;

CREATE TABLE member (
  mno       NUMBER(6) NOT NULL, -- ȸ�� ��ȣ, ���ڵ带 �����ϴ� �÷� 
  PRIMARY KEY (mno)             -- �ѹ� ��ϵ� ���� �ߺ� �ȵ�
);


DROP TABLE blog;

/**********************************/
/* Table Name: ��α� ���� */
/**********************************/
CREATE TABLE blog(
        blogno               NUMBER(7)        NOT NULL        PRIMARY KEY,
        categoryno         NUMBER(7)        NULL ,
        mno                  NUMBER(6)        NULL ,
        title                   VARCHAR2(300)        NOT NULL,
        content              VARCHAR2(4000)       NOT NULL,
        good                 NUMBER(7)        DEFAULT 0       NOT NULL,
        thumb               VARCHAR2(100)        NULL ,
        file1                   VARCHAR2(50)         NULL ,
        size1                  NUMBER(9)        DEFAULT 0       NULL ,
        cnt                    NUMBER(7)        DEFAULT 0       NOT NULL,
        replycnt              NUMBER(7)        DEFAULT 0       NOT NULL,
        rdate                  DATE         NOT NULL,
        grpno                 NUMBER(7)        NOT NULL,
        indent                NUMBER(2)        DEFAULT 0       NOT NULL,
        ansnum              NUMBER(5)        DEFAULT 0       NOT NULL,
        word                  VARCHAR2(100)  NULL, 
  FOREIGN KEY (categoryno) REFERENCES category (categoryno),
  FOREIGN KEY (mno) REFERENCES MEMBER (mno)
);

COMMENT ON TABLE blog is '��α� ����';
COMMENT ON COLUMN blog.blogno is '��α׹�ȣ';
COMMENT ON COLUMN blog.categoryno is 'ī�װ���ȣ';
COMMENT ON COLUMN blog.mno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN blog.title is '����';
COMMENT ON COLUMN blog.content is '����';
COMMENT ON COLUMN blog.good is '��õ��';
COMMENT ON COLUMN blog.thumb is 'Thumb ����';
COMMENT ON COLUMN blog.file1 is '���� 1';
COMMENT ON COLUMN blog.size1 is '���� 1 ũ��';
COMMENT ON COLUMN blog.cnt is '��ȸ��';
COMMENT ON COLUMN blog.replycnt is '��ۼ�';
COMMENT ON COLUMN blog.rdate is '�����';
COMMENT ON COLUMN blog.grpno is '�׷��ȣ';
COMMENT ON COLUMN blog.indent is '�亯����';
COMMENT ON COLUMN blog.ansnum is '�亯 ����';
COMMENT ON COLUMN blog.word is '�˻���';

-- DDL(Data Definition Language)
-- �÷� �߰�
ALTER TABLE blog
ADD (title VARCHAR2(256));

-- �÷� ���� ����
ALTER TABLE blog
MODIFY (title VARCHAR2(300));
-- ORA-01441: cannot decrease column length because some value is too big

-- ORA-00910: specified length too long for its datatype
ALTER TABLE blog
MODIFY (content VARCHAR2(65000));

-- �÷� �̸� ����
ALTER TABLE blog
RENAME COLUMN old_title TO new_title;

-- �÷� ����
ALTER TABLE blog
DROP COLUMN title;

  
1) ȸ��(member) ���� ���̺� ����
-- ȸ�� ���̺��� FK �÷����� ���������� �ӽ÷� �����մϴ�.
-- ���̺��, PK �÷����� ����� ������ ���� ����մϴ�. 
INSERT INTO member(mno) VALUES(1);
INSERT INTO member(mno) VALUES(2);
INSERT INTO member(mno) VALUES(3);

-- member ȸ�� ���(���� 1)
SELECT mno
FROM member;

 MNO
 ------
   1
   2
   3
  
2) ī�װ� �׷�(categrp) ���� ���̺� ����
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '��ȭ', 1, 'Y', sysdate);
  
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '����', 2, 'Y', sysdate);  
  
SELECT categrpno, name, seqno, visible, rdate
FROM categrp
ORDER BY categrpno ASC;

 CATEGRPNO NAME SEQNO VISIBLE RDATE
 --------- ---- ----- ------- ---------------------
         1 ��ȭ       1 Y       2017-11-15 12:39:29.0
         2 ����       2 Y       2017-11-15 12:39:30.0
         
3) ī�װ�(category) ���� ���̺� ����

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '��', 1 , 'Y', 'admin', sysdate);

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '�θǽ�', 2 ,'Y' , 'admin', sysdate);

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, 'SF' , 3 , 'Y' , 'admin', sysdate);
             
SELECT * FROM category;

4) blog ���             
-- blog ���� ���(���� 3)
- ���ο� ��, �亯 �ۿ����� ��� SQL���̰� �ֽ��ϴ�.
- ���ο� �� ����� ���ο� �׷��� ��������� ����� �ֽ��ϴ�. MAX + 1
- categoryno �÷� 1�� ����
- mno �÷� 1�� ����
INSERT INTO blog(blogno,
                         categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
                         grpno, indent, ansnum, word)  
VALUES((SELECT NVL(MAX(blogno), 0) + 1 as blogno FROM blog),
            1, 1, '����', '����', 0, 'fall_m.jpg', 'fall.jpg', 0, 0, 0, sysdate,
            (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM blog), 0, 0, '������,spring,��,��,����,����,������');

-- ERROR: FK �÷��� ����� ���� �ٸ� ���̺� ����� �ȵǾ� �ִ� ���
    ORA-02291: integrity constraint (SOLDESK.SYS_C007131) violated - parent key not found
    ORA-02291: integrity constraint (SOLDESK.SYS_C007132) violated - parent key not found

5) ��ü ���(��� ����)
SELECT blogno,
           categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
           grpno, indent, ansnum, word
FROM blog
ORDER BY grpno DESC, ansnum ASC;

 BLOGNO CATEGORYNO MNO TITLE CONTENT GOOD THUMB      FILE1    SIZE1 CNT REPLYCNT RDATE                 GRPNO INDENT ANSNUM WORD
 ------ ---------- --- ----- ------- ---- ---------- -------- ----- --- -------- --------------------- ----- ------ ------ ------------------------
      1          1   1 ����    ����         0 fall_m.jpg fall.jpg     0   0        0 2017-04-20 13:20:20.0     1      0      0 ������,spring,��,��,����,����,������

6) category �� ���(��� ����)
SELECT blogno,
           categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
           grpno, indent, ansnum, word
FROM blog
WHERE categoryno=1
ORDER BY grpno DESC, ansnum ASC;

 BLOGNO CATEGORYNO MNO TITLE CONTENT GOOD THUMB      FILE1    SIZE1 CNT REPLYCNT RDATE                 GRPNO INDENT ANSNUM WORD
 ------ ---------- --- ----- ------- ---- ---------- -------- ----- --- -------- --------------------- ----- ------ ------ ------------------------
      1          1   1 ����    ����         0 fall_m.jpg fall.jpg     0   0        0 2017-04-20 13:20:20.0     1      0      0 ������,spring,��,��,����,����,������

      
7) ��ü ī��Ʈ
SELECT COUNT(*) as count
FROM blog;

 COUNT
 -----
     1

8) ��ȸ
SELECT blogno,
           categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
           grpno, indent, ansnum, word
FROM blog
WHERE blogno=1; 

9) ����
UPDATE blog
SET title='�ܿ�', content='���̽÷���...', 
      thumb='snow_t.jpg', file1='snow.jpg', size1=1500, word='�ް�'
WHERE blogno=1;

10) ����
DELETE FROM blog
WHERE blogno=9

DELETE FROM blog
WHERE blogno=1 OR blogno=2;

11) �˻�(%: ���ų� �ϳ� �̻��� ��� ����)
-- word LIKE '������' �� word = '������'
   ^������$
-- word LIKE '%������' �� word = '���� ���� ������'
   .*������$
-- word LIKE '������%' �� word = '����������~'
   ^������.*
-- word LIKE '%������%' �� word = '���� ������ ������ �� �湮�ؾ�~'
   .*������.*

-- '������' �÷����� �˻�
SELECT blogno,
          categoryno, mno, title, good, thumb, file1, size1, cnt, replycnt, rdate, 
          grpno, indent, ansnum, word
FROM blog
WHERE categoryno=1 AND word LIKE '%������%'
ORDER BY blogno DESC;

-- '���ǽ�' �÷����� �˻�
SELECT blogno,
          categoryno, mno, title, good, thumb, file1, size1, cnt, replycnt, rdate, 
          grpno, indent, ansnum, word
FROM blog
WHERE categoryno=1 AND word LIKE '%���ǽ�%'
ORDER BY blogno DESC;

-- '���ǽ�' �÷����� �˻�
SELECT blogno,
          categoryno, mno, title, good, thumb, file1, size1, cnt, replycnt, rdate, 
          grpno, indent, ansnum, word
FROM blog
WHERE categoryno=1 AND word LIKE '%���ǽ�%'
ORDER BY blogno DESC;

-- 'swiss' �÷����� �˻�
SELECT blogno,
          categoryno, mno, title, good, thumb, file1, size1, cnt, replycnt, rdate, 
          grpno, indent, ansnum, word
FROM blog
WHERE categoryno=1 AND word LIKE '%swiss%'
ORDER BY blogno DESC;


12) �˻� �� ��ü ���ڵ� ����
-- �˻����� �ʴ� ��� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM blog
WHERE categoryno=1;

-- '������' �˻� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM blog
WHERE categoryno=1 AND word LIKE '%������%';

13) ����¡

DROP TABLE PG;

CREATE TABLE PG(
  num NUMBER(5) NOT NULL,
  title  VARCHAR(20) NOT NULL,
  PRIMARY KEY(num)
);

INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '01��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '02��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '03��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '04��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '05��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '06��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '07��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '08��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '09��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '10��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '11��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '12��');

SELECT num, title FROM pg;

 NUM TITLE
 --- -----
   1 01��
   2 02��
   3 03��
   4 04��
   5 05��
   6 06��
   7 07��
   8 08��
   9 09��
  10 10��
  11 11��
  12 12��

-- �б⺰�� �����Ͽ� ���ڵ带 �����ϴ� ���(����¡)
SELECT num, title FROM pg;

-- rownum: oralce system���� select�ÿ� �ڵ����� �ٿ��ִ� �Ϸù�ȣ
SELECT num, title, rownum FROM pg;

 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
   2 02��        2
   3 03��        3
   4 04��        4
   5 05��        5
   6 06��        6
   7 07��        7
   8 08��        8
   9 09��        9
  10 10��       10
  11 11��       11
  12 12��       12

-- 2,3�� ����
DELETE FROM pg WHERE num=2 or num=3;

SELECT num, title, rownum FROM pg;

 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
   4 04��        2
   5 05��        3
   6 06��        4
   7 07��        5
   8 08��        6
   9 09��        7
  10 10��        8
  11 11��        9
  12 12��       10


-- ����¡�ô� ������ �������� �����Ǵ� rownum ���� ����մϴ�.
-- rownum����: rownum�� ����(ORDER BY ~)���� ���� ����������
   ������ �� �� rownum �÷��� ����մϴ�.

INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '����');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '����');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '�ܿ�');

-- Paging Step 1
-- SELECT �� ROWNUM �� ORDER BY ~
SELECT num, title, rownum 
FROM pg
ORDER BY title ASC;

 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
   4 04��        4
   5 05��        5
   6 06��        6
   7 07��        7
   8 08��        8
   9 09��        9
  10 10��       10
  11 11��       11
  12 12��       12
  15 ����         2
  16 �ܿ�         3
  13 ��         13
  14 ����        14
  
  
-- Paging Step 2, subquery
SELECT num, title, rownum
FROM (
           SELECT num, title 
           FROM pg
           ORDER BY num ASC
);

  NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
   4 04��        2
   5 05��        3
   6 06��        4
   7 07��        5
   8 08��        6
   9 09��        7
  10 10��        8
  11 11��        9
  12 12��       10
  13 ��         11
  14 ����        12
  15 ����        13
  16 �ܿ�        14
  
-- 2,3 ���� �߰��ϼ���.
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '02��');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '03��');

-- ��� �ٽ� ���, �� rownum�� �����ǰ� ���� ����� �۵���
SELECT num, title, rownum
FROM pg
ORDER BY title ASC;
  
 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
  17 02��       15
  18 03��       16
   4 04��        4
   5 05��        5
   6 06��        6
   7 07��        7
   8 08��        8
   9 09��        9
  10 10��       10
  11 11��       11
  12 12��       12
  15 ����         2
  16 �ܿ�         3
  13 ��         13
  14 ����        14
  
-- Subquery���� ������ rownum�� ���
SELECT num, title, rownum
FROM (
           SELECT num, title
           FROM pg
           ORDER BY title ASC
);

 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
  17 02��        2
  18 03��        3
   4 04��        4
   5 05��        5
   6 06��        6
   7 07��        7
   8 08��        8
   9 09��        9
  10 10��       10
  11 11��       11
  12 12��       12
  15 ����        13
  16 �ܿ�        14
  13 ��         15
  14 ����        16

-- Paging Step 3, subquery
-- 1 �б�
SELECT num, title, r
FROM(
         SELECT num, title, rownum as r
         FROM (
                   SELECT num, title 
                   FROM pg
                   ORDER BY title ASC
         )  
)
WHERE r>=1 AND r <=3;

 NUM TITLE R
 --- ----- -
   1 01��   1
  17 02��   2
  18 03��   3
   
-- 2 �б�
SELECT num, title, r
FROM(
         SELECT num, title, rownum as r
         FROM (
                   SELECT num, title 
                   FROM pg
                   ORDER BY title ASC
         )  
)
WHERE r>=4 AND r <=6;
   
 NUM TITLE R
 --- ----- -
   4 04��   4
   5 05��   5
   6 06��   6


   
* rownum�� ���� 1�������� ���� ó���ǰ� 2���̺��ʹ� WHERE������ 
  �ν��̾ȵ˴ϴ�. ���� 3�� ������ ����ؾ��մϴ�.   
SELECT num, title, rownum
FROM (
          SELECT num, title 
          FROM pg
          ORDER BY title ASC
)  
WHERE rownum>=1 AND rownum <=3;

 NUM TITLE ROWNUM
 --- ----- ------
   1 01��        1
  17 02��        2
  18 03��        3

SELECT num, title, rownum
FROM (
          SELECT num, title 
          FROM pg
          ORDER BY title ASC
)  
WHERE rownum>=4 AND rownum <=6;

 NUM TITLE ROWNUM
 --- ----- ------


14) ����¡ ����
-- step 1
SELECT blogno, categoryno, title, content, good, thumb, file1, size1,
          cnt, replycnt, rdate, word
FROM blog
WHERE categoryno=1
ORDER BY blogno DESC;

-- step 2         
SELECT blogno, categoryno, title, content, good, thumb, file1, size1,
          cnt, replycnt, rdate, word, rownum as r
FROM(
         SELECT blogno, categoryno, title, content, good, thumb, file1, size1,
                   cnt, replycnt, rdate, word
         FROM blog
         WHERE categoryno=1
         ORDER BY blogno DESC
);

-- step 3         
SELECT blogno, categoryno, title, content, good, thumb, file1, size1, cnt,
          replycnt, rdate, word, r
FROM(
         SELECT blogno, categoryno, title, content, good, thumb, file1, size1, cnt,
                   replycnt, rdate, word, rownum as r
         FROM(
                  SELECT blogno, categoryno, title, content, good, thumb, file1, size1, cnt,
                            replycnt, rdate, word
                  FROM blog
                  WHERE categoryno=1
                  ORDER BY blogno DESC
         )
)
WHERE r >=1 AND r <= 3;

 BLOGNO CATEGORYNO TITLE CONTENT    GOOD THUMB        FILE1      SIZE1  CNT REPLYCNT RDATE                 WORD               R
 ------ ---------- ----- ---------- ---- ------------ ---------- ------ --- -------- --------------------- ------------------ -
      2          1 �ν�Ʈ   �ν�Ʈ           0 Lost04_t.jpg Lost04.jpg 148940   0        0 2017-05-01 13:01:13.0 �ν�Ʈ                1
      1          1 �ٴٰǳ�  ũ���������� ������    0 sw02_t.jpg   sw02.jpg   210262   0        0 2017-05-01 12:59:02.0 ������ swiss �ؿ� �ȱ� ���� 2

      
15) �亯
[�亯 ����]
-- 1���� ���� �亯 ��Ͽ�: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM categrp;
SELECT * FROM category;

�� ���ο� �亯�� �ֽ����� ����ϱ����� ���� �亯�� �ڷ� �̷�ϴ�.
-- ��� ���� �켱 ������ 1�� ������, 1�� -> 2��
UPDATE blog
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 0;

-- 2����� �켱 ������ 1�� ������, 2�� -> 3��
UPDATE blog
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 1;

-- 3����� �켱 ������ 1�� ������, 3�� -> 4��
UPDATE blog
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 2;

-- 6����� �켱 ������ 1�� ������, 6�� -> 7��
UPDATE blog
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 5;


�� �亯 ���
INSERT INTO blog(blogno,
                          categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
                          grpno, indent, ansnum, word)  
VALUES((SELECT NVL(MAX(blogno), 0) + 1 as blogno FROM blog),
            1, 1, '����', '����',0, 'summer_m.jpg', 'summer.jpg', 0, 0, 0, sysdate,
            1, 1, 1,'');


�� �亯�� ���� ���� ���� ����    
SELECT blogno, categoryno, mno, title, content, good, 
           thumb, file1, size1, cnt, replycnt, rdate, grpno, indent, ansnum, word, r
FROM(
         SELECT blogno, categoryno, mno, title, content, good,
                    thumb, file1, size1, cnt, replycnt, rdate, grpno, indent, ansnum, word, rownum as r
         FROM(
                  SELECT blogno, categoryno, mno, title, content, good,
                             thumb, file1, size1, cnt, replycnt, rdate, grpno, indent, ansnum, word
                  FROM blog
                  WHERE categoryno=1
                  ORDER BY grpno DESC, ansnum ASC
         )
)
WHERE r >=1 AND r <= 3;
 
   
     
-----------------------------------------------------------------------------------



 