1) Oracle
▷ /doc/dbms/categrp_c.sql(ddl)
-----------------------------------------------------------------------------------
DROP TABLE blog CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE category CASCADE CONSTRAINTS;
DROP TABLE categrp CASCADE CONSTRAINTS;

DROP TABLE MEMBER;

/**********************************/
/* Table Name: 카테고리 그룹 */
/**********************************/
CREATE TABLE categrp(
    categrpno     NUMBER(7)        NOT NULL    PRIMARY KEY,
    name           VARCHAR2(50)    NOT NULL,
    seqno          NUMBER(7)         DEFAULT 0     NOT NULL,
    visible          CHAR(1)             DEFAULT 'Y'     NOT NULL,
    rdate             DATE                 NOT NULL
);

COMMENT ON TABLE categrp is '카테고리 그룹';
COMMENT ON COLUMN categrp.categrpno is '카테고리 그룹 번호';
COMMENT ON COLUMN categrp.name is '카테고리 이름';
COMMENT ON COLUMN categrp.seqno is '출력 순서';
COMMENT ON COLUMN categrp.visible is '출력 모드';
COMMENT ON COLUMN categrp.rdate is '카테고리 그룹 생성일';


2. INSERT
1) 일련번호의 생성
SELECT categrpno as categrpno FROM categrp;
 CATEGRPNO
 ---------------

SELECT MAX(categrpno) as categrpno FROM categrp;
 CATEGRPNO
 ---------------
      NULL   ← 레코드가 없으면 0이아니라 'null'이 출력됨.

SELECT MAX(categrpno)+1 as categrpno FROM categrp;
 CATEGRPNO
 ---------------
      NULL   ← 레코드가 없으면 + 연산을해도 1이아니라 'null'이 출력됨.
      
-- null일 경우 0으로 변경      
SELECT NVL(MAX(categrpno), 0) as categrpno FROM categrp
 CATEGRPNO
 ---------------
         0

-- 정상적인 일련번호 산출
SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp
 CATEGRPNO
 ---------------
         1
         
-- SubQuery에 적용, ()를 이용하여 선언
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '영화', 1, 'Y', sysdate);

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '여행', 2, 'Y', sysdate);

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '캠핑', 3, 'Y', sysdate);

  
3. 전체 목록
SELECT categrpno, name, seqno, visible, rdate
FROM categrp
ORDER BY categrpno ASC;

 CATEGRPNO NAME SEQNO VISIBLE RDATE
 --------- ---- ----- ------- ---------------------
         1 영화       1 Y       2017-04-14 10:43:18.0
         2 여행       2 Y       2017-04-14 10:43:19.0
         3 캠핑       3 Y       2017-04-14 10:43:20.0


-- 출력 순서에따른 전체 목록
SELECT categrpno, name, seqno, visible, rdate
FROM categrp
ORDER BY seqno ASC;

 CATEGRPNO NAME SEQNO VISIBLE RDATE
 --------- ---- ----- ------- ---------------------
         1 영화       1 Y       2017-04-14 10:43:18.0
         2 여행       2 Y       2017-04-14 10:43:19.0
         3 캠핑       3 Y       2017-04-14 10:43:20.0

         
4. 조회
SELECT categrpno, name, seqno
FROM categrp
WHERE categrpno=1;


5. 수정
UPDATE categrp
SET name='', seqno='', visivle=''
WHERE categrpno=1;

6. 삭제         
DELETE FROM categrp
WHERE categrpno = 1

7. 출력 순서 변경
-- 출력 순서 상향, 10 -> 1
UPDATE categrp SET seqno = seqno - 1 WHERE categrpno=1;

-- 출력순서 하향, 1 -> 10
UPDATE categrp SET seqno = seqno + 1 WHERE categrpno=1;
         
  
-----------------------------------------------------------------------------------
 
 
