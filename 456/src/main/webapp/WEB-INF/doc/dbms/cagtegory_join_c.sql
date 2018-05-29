1. SQL:  /webapp/WEB-INF/doc/dbms/cagtegory_join_c.sql
-------------------------------------------------------------------------------------
1. 2�� �̻��� ���̺� ���� JOIN 
      - PK, FK �÷��� ������� �մϴ�.

1) FK ���̺� ������ ����
DELETE FROM category;

2) PK ���̺� ������ ����
DELETE FROM categrp;
    
3) PK ���̺� ������ �߰�
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '��ȭ', 1, 'Y', sysdate);

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '����', 2, 'Y', sysdate);

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  'ķ��', 3, 'Y', sysdate);
  
4) FK ���̺� ������ �߰�
INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '��', 1 , 'Y', 'admin', sysdate);

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '�θǽ�', 2 ,'Y' , 'admin', sysdate);

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '�ڹ�' , 3 , 'Y' , 'admin', sysdate);

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             2, '���� ����' , 1 , 'Y' , 'admin', sysdate);

-- ORA-02291: integrity constraint (SOLDESK.SYS_C007045) violated - parent key not found
INSERT INTO category(categoryno, 
                              categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             2, '�ؿ� ����' , 2 , 'Y' , 'admin', sysdate);
             
5) PK ���̺� ������ Ȯ��
SELECT categrpno, name, seqno, visible, rdate 
FROM categrp 
ORDER BY seqno ASC;

 PK
 CATEGRPNO NAME SEQNO VISIBLE RDATE
 --------- ---- ----- ------- ---------------------
         1 ��ȭ       1 Y       2017-04-18 15:54:39.0
         2 ����       2 Y       2017-04-18 15:54:40.0
         3 ķ��       3 Y       2017-04-18 15:54:41.0
         
6) FK ���̺� ������ Ȯ��
SELECT categoryno, categrpno, title, seqno, visible, ids, rdate, cnt
FROM category 
ORDER BY categrpno ASC, seqno ASC;

 PK                FK
 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   RDATE
 ---------- --------- ----- ----- ------- ----- ---------------------
          1         1 ��        1 Y       admin 2017-04-18 15:56:30.0
          2         1 �θǽ�       2 Y       admin 2017-04-18 15:56:31.0
          3         1 �ڹ�        3 Y       admin 2017-04-18 15:56:32.0
          4         2 ���� ����     1 Y       admin 2017-04-18 15:56:33.0
          5         2 �ؿ� ����     2 Y       admin 2017-04-18 15:56:34.0


2. Cross join
- �����μ��� ��ġ�� �ſ� ������.
- �������� ����.

SELECT categrp.categrpno, categrp.name,
           category.categoryno, category.categrpno, category.title,
           category.seqno, category.visible, category.ids, category.cnt
FROM categrp, category
ORDER BY categrp.categrpno ASC, category.seqno ASC;

-- ���̺� ������ ���
-- categrp c: ���̺����� �ʹ� ��� categrp ���̺��� ������ 'c'�� ����.
SELECT c.categrpno, c.name,
           t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c, category t  
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 --------- ---- ---------- --------- ----- ----- ------- -----
         3 ķ��            1         1 ��        1 Y       admin
         1 ��ȭ            1         1 ��        1 Y       admin
         2 ����            1         1 ��        1 Y       admin
         2 ����            2         1 �θǽ�       2 Y       admin
         1 ��ȭ            2         1 �θǽ�       2 Y       admin
         3 ķ��            2         1 �θǽ�       2 Y       admin
         2 ����            3         1 �ڹ�        3 Y       admin
         3 ķ��            3         1 �ڹ�        3 Y       admin
         1 ��ȭ            3         1 �ڹ�        3 Y       admin
         2 ����            4         2 ���� ����     1 Y       admin
         1 ��ȭ            4         2 ���� ����     1 Y       admin
         3 ķ��            4         2 ���� ����     1 Y       admin
         1 ��ȭ            5         2 �ؿ� ����     2 Y       admin
         3 ķ��            5         2 �ؿ� ����     2 Y       admin
         2 ����            5         2 �ؿ� ����     2 Y       admin
         
          
3. Equal JOIN�� FK ���̺��� �������� �մϴ�.
- WHERE c.categrpno = t.categrpno: 2���� ���̺����� categrpno �÷��� ����
  ���ڵ带 �о� �޸𸮻󿡼� �ϳ��� ���ڵ�� �����Ͽ� �޸� ���̺���
  �����մϴ�. (DBMS�� ���� �޸� ���)

SELECT c.categrpno, c.name,
          t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c, category t  
WHERE c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 --------- ---- ---------- --------- ----- ----- ------- -----
         1 ��ȭ            1         1 ��        1 Y       admin
         1 ��ȭ            2         1 �θǽ�       2 Y       admin
         1 ��ȭ            3         1 �ڹ�        3 Y       admin
         2 ����            4         2 ���� ����     1 Y       admin
         2 ����            5         2 �ؿ� ����     2 Y       admin

-- seqno �÷��� �ߺ�
    SELECT c.categrpno, c.name, c.seqno,
               t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
    FROM categrp c, category t  
    WHERE c.categrpno = t.categrpno
    ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME SEQNO CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   CNT
 --------- ---- ----- ---------- --------- ----- ----- ------- ----- ---
         1 ��ȭ       1          1         1 ��        1 Y       admin   0
         1 ��ȭ       1          2         1 �θǽ�       2 Y       admin   0
         1 ��ȭ       1          3         1 �ڹ�        3 Y       admin   0
         2 ����       2          4         2 ���� ����     1 Y       admin   0
          
-- seqno �÷��� �ߺ�
    SELECT c.categrpno, c.name, c.seqno,
               t.categoryno, t.categrpno, t.title, t.seqno as category_seqno, t.visible, t.ids, t.cnt
    FROM categrp c, category t  
    WHERE c.categrpno = t.categrpno
    ORDER BY c.categrpno ASC, t.seqno ASC;

     CATEGRPNO NAME SEQNO CATEGORYNO CATEGRPNO TITLE CATEGORY_SEQNO VISIBLE IDS   CNT
 --------- ---- ----- ---------- --------- ----- ---------------- ------- ----- ---
         1 ��ȭ       1          1         1 ��                   1 Y       admin   0
         1 ��ȭ       1          2         1 �θǽ�                  2 Y       admin   0
         1 ��ȭ       1          3         1 �ڹ�                   3 Y       admin   0
         2 ����       2          4         2 ���� ����                1 Y       admin   0
         
         

4. LEFT Outer JOIN
- ���� FK�� ���� �θ� ���̺��� ���� ����̾ȵǾ� ��ȸ�� ������ �߻�������
  Outer JOIN�� �����.
- category FK ���̺��� '+' �������ϸ� ���ڵ� ������ ��� 
  NULL ������ �����Ͽ� ���
  
SELECT c.categrpno, c.name,  
          t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c, category t  
WHERE c.categrpno = t.categrpno(+)
ORDER BY c.categrpno ASC, t.seqno ASC;

 <----- categrp ----->       <---------------------category ---------------------------->   
 CATEGRPNO NAME        CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 --------- ---- ----------       --------- ----- ----- ------- -----
         1 ��ȭ                   1         1 ��        1 Y       admin
         1 ��ȭ                   2         1 �θǽ�       2 Y       admin
         1 ��ȭ                   3         1 �ڹ�        3 Y       admin
         2 ����                   4         2 ���� ����     1 Y       admin
         2 ����                   5         2 �ؿ� ����     2 Y       admin
         3 ķ��                 NULL      NULL NULL   NULL NULL    NULL

-- ANSI Left Outer Join: ���� ���̺� ��� ���
SELECT c.categrpno, c.name,  
          t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c LEFT OUTER JOIN category t
ON c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 --------- ---- ---------- --------- ----- ----- ------- -----
         1 ��ȭ            1         1 ��        1 Y       admin
         1 ��ȭ            2         1 �θǽ�       2 Y       admin
         1 ��ȭ            3         1 �ڹ�        3 Y       admin
         2 ����            4         2 ���� ����     1 Y       admin
         2 ����            5         2 �ؿ� ����     2 Y       admin
         3 ķ��         NULL      NULL NULL   NULL NULL    NULL

-- ANSI Right Outer Join, 
-- ���Ἲ ���������� �ջ����� PK ���� FK�� ��� �Ұ��Ͽ� Equal(����)�� ���� �����
-- �����. 
SELECT c.categrpno, c.name,  
          t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c RIGHT OUTER JOIN category t
ON c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 --------- ---- ---------- --------- ----- ----- ------- -----
         1 ��ȭ            1         1 ��        1 Y       admin
         1 ��ȭ            2         1 �θǽ�       2 Y       admin
         1 ��ȭ            3         1 �ڹ�        3 Y       admin
         2 ����            4         2 ���� ����     1 Y       admin
         2 ����            5         2 �ؿ� ����     2 Y       admin

-- from���� ���̺��� ��ġ�� ������.
SELECT c.categrpno, c.name,  
          t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM category t RIGHT OUTER JOIN categrp c 
ON c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;

CATEGRPNO NAME CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 --------- ---- ---------- --------- ----- ----- ------- -----
         1 ��ȭ            1         1 ��        1 Y       admin
         1 ��ȭ            2         1 �θǽ�       2 Y       admin
         1 ��ȭ            3         1 �ڹ�        3 Y       admin
         2 ����            4         2 ���� ����     1 Y       admin
         2 ����            5         2 �ؿ� ����     2 Y       admin
         3 ķ��         NULL      NULL NULL   NULL NULL    NULL


-- PK, FK�� ��� ����ϰ� �ߺ� �÷��� �ϳ��� �����Ͽ� ����մϴ�.
-- seqno�� �ߺ��Ǵ� ����� SQL
SELECT c.categrpno, c.name, c.seqno,
          t.categoryno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c, category t  
WHERE c.categrpno = t.categrpno(+)
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME SEQNO       CATEGORYNO TITLE SEQNO VISIBLE IDS
 --------- ----       -----               ---------- ----- ----- ------- -----
         1 ��ȭ       1                   1 ��        1 Y       admin
         1 ��ȭ       1                   2 �θǽ�       2 Y       admin
         1 ��ȭ       1                   3 �ڹ�        3 Y       admin
         2 ����       2                   4 ���� ����     1 Y       admin
         2 ����       2                   5 �ؿ� ����     2 Y       admin
         3 ķ��       3                   NULL NULL   NULL NULL    NULL


-------------------------------------------------------------------------------------
         
         
         