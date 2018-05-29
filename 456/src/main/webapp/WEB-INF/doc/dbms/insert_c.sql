1. �ǽ� ���̺� ����
DROP TABLE notice;
CREATE TABLE notice(
  noticeno NUMBER(7)     NOT NULL,
  title       VARCHAR(100) NOT NULL,
  rname    VARCHAR(15)  NOT NULL,
  rdate     DATE                     NULL,
  PRIMARY KEY(noticeno)
);
 

2. INSERT
INSERT INTO notice
VALUES((SELECT NVL(MAX(noticeno), 0)+1 as noticeno FROM notice),
            '�˸�1', '������', sysdate);
INSERT INTO notice
VALUES((SELECT NVL(MAX(noticeno), 0)+1 as noticeno FROM notice),
            '�˸�2', '������', sysdate);
INSERT INTO notice
VALUES((SELECT NVL(MAX(noticeno), 0)+1 as noticeno FROM notice),
            '�˸�3', '������', sysdate);    

SELECT noticeno, title, rname, rdate 
FROM notice
ORDER BY noticeno ASC;

 NOTICENO TITLE RNAME RDATE
 -------- ----- ----- ---------------------
        1 �˸�1   ������   2018-02-23 13:40:12.0
        2 �˸�2   ������   2018-02-23 13:40:37.0
        3 �˸�3   ������   2018-02-23 13:40:38.0

        
3. ���̺� ������ ��� �÷��� ������ �Է�ó��
DROP TABLE notice_bak1;

CREATE TABLE notice_bak1 
AS
SELECT *
FROM notice;

SELECT noticeno, title, rname, rdate 
FROM notice_bak1
ORDER BY noticeno ASC;

 NOTICENO TITLE RNAME RDATE
 -------- ----- ----- ---------------------
        1 �˸�1   ������   2018-02-23 13:40:12.0
        2 �˸�2   ������   2018-02-23 13:40:37.0
        3 �˸�3   ������   2018-02-23 13:40:38.0
        
        
4. ���̺� ������ �ʿ��� �÷��� ������ �Է�ó��
CREATE TABLE notice_bak2 
AS
SELECT noticeno, title, rname 
FROM notice;

-- ���� �߻�
SELECT noticeno, title, rname, rdate 
FROM notice_bak2
ORDER BY noticeno ASC;        

SELECT noticeno, title, rname
FROM notice_bak2
ORDER BY noticeno ASC;   

 NOTICENO TITLE RNAME
 -------- ----- -----
        1 �˸�1   ������
        2 �˸�2   ������
        3 �˸�3   ������
        
        
5. SELECT ����� INSERT �ϱ�

DROP TABLE notice2;
CREATE TABLE notice2(
  noticeno NUMBER(7)     NOT NULL,
  title       VARCHAR(100) NOT NULL,
  rname    VARCHAR(15)  NOT NULL,
  rdate     DATE                     NULL,
  PRIMARY KEY(noticeno)
);
 
INSERT INTO notice2
SELECT *
FROM notice;

SELECT noticeno, title, rname, rdate 
FROM notice2
ORDER BY noticeno ASC;        

 NOTICENO TITLE RNAME RDATE
 -------- ----- ----- ---------------------
        1 �˸�1   ������   2018-02-23 13:47:06.0
        2 �˸�2   ������   2018-02-23 13:47:07.0
        3 �˸�3   ������   2018-02-23 13:47:08.0

        
6. �ʿ��� �÷��� SELECT�� ����� INSERT �ϱ�
DROP TABLE notice3;
CREATE TABLE notice3(
  noticeno NUMBER(7)     NOT NULL,
  title       VARCHAR(100) NOT NULL,
  rname    VARCHAR(15)  NOT NULL,
  PRIMARY KEY(noticeno)
);
 
INSERT INTO notice3
SELECT noticeno, title, rname
FROM notice;

�Ǵ�

INSERT INTO notice3(noticeno, title, rname)
SELECT noticeno, title, rname
FROM notice;

SELECT noticeno, title, rname
FROM notice3
ORDER BY noticeno ASC;  


 NOTICENO TITLE RNAME
 -------- ----- -----
        1 �˸�1   ������
        2 �˸�2   ������
        3 �˸�3   ������


7. ���� ���̺��� ���� INSERT
DROP TABLE notice4_1;
CREATE TABLE notice4_1(
  noticeno NUMBER(7)     NOT NULL,
  title       VARCHAR(100) NOT NULL,
  rname    VARCHAR(15)  NOT NULL,
  PRIMARY KEY(noticeno)
);

DROP TABLE notice4_2;
CREATE TABLE notice4_2(
  noticeno NUMBER(7)     NOT NULL,
  title       VARCHAR(100) NOT NULL,
  rname    VARCHAR(15)  NOT NULL,
  PRIMARY KEY(noticeno)
);

INSERT ALL
  INTO notice4_1(noticeno, title, rname)
  INTO notice4_2(noticeno, title, rname)  
SELECT noticeno, title, rname
FROM notice;

SELECT noticeno, title, rname
FROM notice4_1
ORDER BY noticeno ASC;  

 NOTICENO TITLE RNAME
 -------- ----- -----
        1 �˸�1   ������
        2 �˸�2   ������
        3 �˸�3   ������
        
SELECT noticeno, title, rname
FROM notice4_2
ORDER BY noticeno ASC;  

 NOTICENO TITLE RNAME
 -------- ----- -----
        1 �˸�1   ������
        2 �˸�2   ������
        3 �˸�3   ������
        

