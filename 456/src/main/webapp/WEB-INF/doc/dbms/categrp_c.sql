1) Oracle
�� /doc/dbms/categrp_c.sql(ddl)
-----------------------------------------------------------------------------------
DROP TABLE blog CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE category CASCADE CONSTRAINTS;
DROP TABLE categrp CASCADE CONSTRAINTS;

DROP TABLE MEMBER;

/**********************************/
/* Table Name: ī�װ� �׷� */
/**********************************/
CREATE TABLE categrp(
    categrpno     NUMBER(7)        NOT NULL    PRIMARY KEY,
    name           VARCHAR2(50)    NOT NULL,
    seqno          NUMBER(7)         DEFAULT 0     NOT NULL,
    visible          CHAR(1)             DEFAULT 'Y'     NOT NULL,
    rdate             DATE                 NOT NULL
);

COMMENT ON TABLE categrp is 'ī�װ� �׷�';
COMMENT ON COLUMN categrp.categrpno is 'ī�װ� �׷� ��ȣ';
COMMENT ON COLUMN categrp.name is 'ī�װ� �̸�';
COMMENT ON COLUMN categrp.seqno is '��� ����';
COMMENT ON COLUMN categrp.visible is '��� ���';
COMMENT ON COLUMN categrp.rdate is 'ī�װ� �׷� ������';


2. INSERT
1) �Ϸù�ȣ�� ����
SELECT categrpno as categrpno FROM categrp;
 CATEGRPNO
 ---------------

SELECT MAX(categrpno) as categrpno FROM categrp;
 CATEGRPNO
 ---------------
      NULL   �� ���ڵ尡 ������ 0�̾ƴ϶� 'null'�� ��µ�.

SELECT MAX(categrpno)+1 as categrpno FROM categrp;
 CATEGRPNO
 ---------------
      NULL   �� ���ڵ尡 ������ + �������ص� 1�̾ƴ϶� 'null'�� ��µ�.
      
-- null�� ��� 0���� ����      
SELECT NVL(MAX(categrpno), 0) as categrpno FROM categrp
 CATEGRPNO
 ---------------
         0

-- �������� �Ϸù�ȣ ����
SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp
 CATEGRPNO
 ---------------
         1
         
-- SubQuery�� ����, ()�� �̿��Ͽ� ����
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '��ȭ', 1, 'Y', sysdate);

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '����', 2, 'Y', sysdate);

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  'ķ��', 3, 'Y', sysdate);

  
3. ��ü ���
SELECT categrpno, name, seqno, visible, rdate
FROM categrp
ORDER BY categrpno ASC;

 CATEGRPNO NAME SEQNO VISIBLE RDATE
 --------- ---- ----- ------- ---------------------
         1 ��ȭ       1 Y       2017-04-14 10:43:18.0
         2 ����       2 Y       2017-04-14 10:43:19.0
         3 ķ��       3 Y       2017-04-14 10:43:20.0


-- ��� ���������� ��ü ���
SELECT categrpno, name, seqno, visible, rdate
FROM categrp
ORDER BY seqno ASC;

 CATEGRPNO NAME SEQNO VISIBLE RDATE
 --------- ---- ----- ------- ---------------------
         1 ��ȭ       1 Y       2017-04-14 10:43:18.0
         2 ����       2 Y       2017-04-14 10:43:19.0
         3 ķ��       3 Y       2017-04-14 10:43:20.0

         
4. ��ȸ
SELECT categrpno, name, seqno
FROM categrp
WHERE categrpno=1;


5. ����
UPDATE categrp
SET name='', seqno='', visivle=''
WHERE categrpno=1;

6. ����         
DELETE FROM categrp
WHERE categrpno = 1

7. ��� ���� ����
-- ��� ���� ����, 10 -> 1
UPDATE categrp SET seqno = seqno - 1 WHERE categrpno=1;

-- ��¼��� ����, 1 -> 10
UPDATE categrp SET seqno = seqno + 1 WHERE categrpno=1;
         
  
-----------------------------------------------------------------------------------
 
 
