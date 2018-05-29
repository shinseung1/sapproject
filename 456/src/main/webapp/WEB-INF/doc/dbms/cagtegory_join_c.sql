1. SQL:  /webapp/WEB-INF/doc/dbms/cagtegory_join_c.sql
-------------------------------------------------------------------------------------
1. 2개 이상의 테이블 연결 JOIN 
      - PK, FK 컬럼을 대상으로 합니다.

1) FK 테이블 데이터 삭제
DELETE FROM category;

2) PK 테이블 데이터 삭제
DELETE FROM categrp;
    
3) PK 테이블 데이터 추가
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '영화', 1, 'Y', sysdate);

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '여행', 2, 'Y', sysdate);

INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '캠핑', 3, 'Y', sysdate);
  
4) FK 테이블 데이터 추가
INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '퇴마', 1 , 'Y', 'admin', sysdate);

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '로맨스', 2 ,'Y' , 'admin', sysdate);

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '코믹' , 3 , 'Y' , 'admin', sysdate);

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             2, '국내 여행' , 1 , 'Y' , 'admin', sysdate);

-- ORA-02291: integrity constraint (SOLDESK.SYS_C007045) violated - parent key not found
INSERT INTO category(categoryno, 
                              categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             2, '해외 여행' , 2 , 'Y' , 'admin', sysdate);
             
5) PK 테이블 데이터 확인
SELECT categrpno, name, seqno, visible, rdate 
FROM categrp 
ORDER BY seqno ASC;

 PK
 CATEGRPNO NAME SEQNO VISIBLE RDATE
 --------- ---- ----- ------- ---------------------
         1 영화       1 Y       2017-04-18 15:54:39.0
         2 여행       2 Y       2017-04-18 15:54:40.0
         3 캠핑       3 Y       2017-04-18 15:54:41.0
         
6) FK 테이블 데이터 확인
SELECT categoryno, categrpno, title, seqno, visible, ids, rdate, cnt
FROM category 
ORDER BY categrpno ASC, seqno ASC;

 PK                FK
 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   RDATE
 ---------- --------- ----- ----- ------- ----- ---------------------
          1         1 퇴마        1 Y       admin 2017-04-18 15:56:30.0
          2         1 로맨스       2 Y       admin 2017-04-18 15:56:31.0
          3         1 코믹        3 Y       admin 2017-04-18 15:56:32.0
          4         2 국내 여행     1 Y       admin 2017-04-18 15:56:33.0
          5         2 해외 여행     2 Y       admin 2017-04-18 15:56:34.0


2. Cross join
- 정보로서의 가치가 매우 부족함.
- 권장하지 않음.

SELECT categrp.categrpno, categrp.name,
           category.categoryno, category.categrpno, category.title,
           category.seqno, category.visible, category.ids, category.cnt
FROM categrp, category
ORDER BY categrp.categrpno ASC, category.seqno ASC;

-- 테이블 별명의 사용
-- categrp c: 테이블명이 너무 길어 categrp 테이블의 별명을 'c'로 붙임.
SELECT c.categrpno, c.name,
           t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c, category t  
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 --------- ---- ---------- --------- ----- ----- ------- -----
         3 캠핑            1         1 퇴마        1 Y       admin
         1 영화            1         1 퇴마        1 Y       admin
         2 여행            1         1 퇴마        1 Y       admin
         2 여행            2         1 로맨스       2 Y       admin
         1 영화            2         1 로맨스       2 Y       admin
         3 캠핑            2         1 로맨스       2 Y       admin
         2 여행            3         1 코믹        3 Y       admin
         3 캠핑            3         1 코믹        3 Y       admin
         1 영화            3         1 코믹        3 Y       admin
         2 여행            4         2 국내 여행     1 Y       admin
         1 영화            4         2 국내 여행     1 Y       admin
         3 캠핑            4         2 국내 여행     1 Y       admin
         1 영화            5         2 해외 여행     2 Y       admin
         3 캠핑            5         2 해외 여행     2 Y       admin
         2 여행            5         2 해외 여행     2 Y       admin
         
          
3. Equal JOIN시 FK 테이블을 기준으로 합니다.
- WHERE c.categrpno = t.categrpno: 2개의 테이블에서 categrpno 컬럼이 같은
  레코드를 읽어 메모리상에서 하나의 레코드로 결합하여 메모리 테이블을
  생성합니다. (DBMS는 많은 메모리 사용)

SELECT c.categrpno, c.name,
          t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c, category t  
WHERE c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 --------- ---- ---------- --------- ----- ----- ------- -----
         1 영화            1         1 퇴마        1 Y       admin
         1 영화            2         1 로맨스       2 Y       admin
         1 영화            3         1 코믹        3 Y       admin
         2 여행            4         2 국내 여행     1 Y       admin
         2 여행            5         2 해외 여행     2 Y       admin

-- seqno 컬럼의 중복
    SELECT c.categrpno, c.name, c.seqno,
               t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
    FROM categrp c, category t  
    WHERE c.categrpno = t.categrpno
    ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME SEQNO CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   CNT
 --------- ---- ----- ---------- --------- ----- ----- ------- ----- ---
         1 영화       1          1         1 퇴마        1 Y       admin   0
         1 영화       1          2         1 로맨스       2 Y       admin   0
         1 영화       1          3         1 코믹        3 Y       admin   0
         2 여행       2          4         2 국내 여행     1 Y       admin   0
          
-- seqno 컬럼의 중복
    SELECT c.categrpno, c.name, c.seqno,
               t.categoryno, t.categrpno, t.title, t.seqno as category_seqno, t.visible, t.ids, t.cnt
    FROM categrp c, category t  
    WHERE c.categrpno = t.categrpno
    ORDER BY c.categrpno ASC, t.seqno ASC;

     CATEGRPNO NAME SEQNO CATEGORYNO CATEGRPNO TITLE CATEGORY_SEQNO VISIBLE IDS   CNT
 --------- ---- ----- ---------- --------- ----- ---------------- ------- ----- ---
         1 영화       1          1         1 퇴마                   1 Y       admin   0
         1 영화       1          2         1 로맨스                  2 Y       admin   0
         1 영화       1          3         1 코믹                   3 Y       admin   0
         2 여행       2          4         2 국내 여행                1 Y       admin   0
         
         

4. LEFT Outer JOIN
- 값이 FK에 없는 부모 테이블의 값이 출력이안되어 조회에 문제가 발생함으로
  Outer JOIN을 사용함.
- category FK 테이블에 '+' 선언을하면 레코드 대응이 없어도 
  NULL 값으로 대응하여 출력
  
SELECT c.categrpno, c.name,  
          t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c, category t  
WHERE c.categrpno = t.categrpno(+)
ORDER BY c.categrpno ASC, t.seqno ASC;

 <----- categrp ----->       <---------------------category ---------------------------->   
 CATEGRPNO NAME        CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 --------- ---- ----------       --------- ----- ----- ------- -----
         1 영화                   1         1 퇴마        1 Y       admin
         1 영화                   2         1 로맨스       2 Y       admin
         1 영화                   3         1 코믹        3 Y       admin
         2 여행                   4         2 국내 여행     1 Y       admin
         2 여행                   5         2 해외 여행     2 Y       admin
         3 캠핑                 NULL      NULL NULL   NULL NULL    NULL

-- ANSI Left Outer Join: 왼쪽 테이블 모두 출력
SELECT c.categrpno, c.name,  
          t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c LEFT OUTER JOIN category t
ON c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 --------- ---- ---------- --------- ----- ----- ------- -----
         1 영화            1         1 퇴마        1 Y       admin
         1 영화            2         1 로맨스       2 Y       admin
         1 영화            3         1 코믹        3 Y       admin
         2 여행            4         2 국내 여행     1 Y       admin
         2 여행            5         2 해외 여행     2 Y       admin
         3 캠핑         NULL      NULL NULL   NULL NULL    NULL

-- ANSI Right Outer Join, 
-- 무결성 제약조건의 손상으로 PK 없는 FK는 등록 불가하여 Equal(동등)과 같은 결과를
-- 출력함. 
SELECT c.categrpno, c.name,  
          t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c RIGHT OUTER JOIN category t
ON c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 --------- ---- ---------- --------- ----- ----- ------- -----
         1 영화            1         1 퇴마        1 Y       admin
         1 영화            2         1 로맨스       2 Y       admin
         1 영화            3         1 코믹        3 Y       admin
         2 여행            4         2 국내 여행     1 Y       admin
         2 여행            5         2 해외 여행     2 Y       admin

-- from절의 테이블의 위치를 변경함.
SELECT c.categrpno, c.name,  
          t.categoryno, t.categrpno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM category t RIGHT OUTER JOIN categrp c 
ON c.categrpno = t.categrpno
ORDER BY c.categrpno ASC, t.seqno ASC;

CATEGRPNO NAME CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 --------- ---- ---------- --------- ----- ----- ------- -----
         1 영화            1         1 퇴마        1 Y       admin
         1 영화            2         1 로맨스       2 Y       admin
         1 영화            3         1 코믹        3 Y       admin
         2 여행            4         2 국내 여행     1 Y       admin
         2 여행            5         2 해외 여행     2 Y       admin
         3 캠핑         NULL      NULL NULL   NULL NULL    NULL


-- PK, FK는 모두 출력하고 중복 컬럼은 하나만 선택하여 출력합니다.
-- seqno가 중복되는 경우의 SQL
SELECT c.categrpno, c.name, c.seqno,
          t.categoryno, t.title, t.seqno, t.visible, t.ids, t.cnt
FROM categrp c, category t  
WHERE c.categrpno = t.categrpno(+)
ORDER BY c.categrpno ASC, t.seqno ASC;

 CATEGRPNO NAME SEQNO       CATEGORYNO TITLE SEQNO VISIBLE IDS
 --------- ----       -----               ---------- ----- ----- ------- -----
         1 영화       1                   1 퇴마        1 Y       admin
         1 영화       1                   2 로맨스       2 Y       admin
         1 영화       1                   3 코믹        3 Y       admin
         2 여행       2                   4 국내 여행     1 Y       admin
         2 여행       2                   5 해외 여행     2 Y       admin
         3 캠핑       3                   NULL NULL   NULL NULL    NULL


-------------------------------------------------------------------------------------
         
         
         