▷ /WEB-INF/doc/category_c.sql

1. DDL(Data Definition Language): 테이블 구조
-------------------------------------------------------------------------------------
-- FOREIGN KEY (categrpno) REFERENCES categrp (categrpno):
-- categrpno 컬럼의 값은 categrp 테이블의 categrpno 컬럼에 등록된 값만
-- 사용할 수 있습니다.  
-- PK 삭제시 FK 레코드 자동 삭제(권장 아님)
-- FOREIGN KEY (categrpno) REFERENCES categrp (categrpno) ON DELETE CASCADE
/**********************************/
/* Table Name: 카테고리 */
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

COMMENT ON TABLE category is '카테고리';
COMMENT ON COLUMN category.categoryno is '카테고리 번호';
COMMENT ON COLUMN category.categrpno is '카테고리 그룹 번호';
COMMENT ON COLUMN category.title is '게시판 이름';
COMMENT ON COLUMN category.seqno is '출력 순서';
COMMENT ON COLUMN category.visible is '출력 모드';
COMMENT ON COLUMN category.ids is '접근 계정';
COMMENT ON COLUMN category.cnt is '등록된 글 수';
COMMENT ON COLUMN category.rdate is '등록일';


2. 테이블 삭제: 자식 -> 부모
① DROP TABLE categrp; : ORA-02449: unique/primary keys in table referenced by foreign keys
② 자식 테이블 삭제: DROP TABLE category;
③ 부모 테이블 삭제: DROP TABLE categrp;


3. 테이블 생성: 부모 -> 자식
① FK category 생성시 에러 발생: ORA-00942: table or view does not exist
② 부모 테이블 먼저 생성: categrp
③ 자식 테이블 생성: category


4. 부모 테이블의 강제 삭제(권장 하지 않음), 제약 조건도 함께 삭제됨.
DROP TABLE categrp CASCADE CONSTRAINTS;


5. 레코드 추가, ERROR, 부모 테이블 PK 컬럼에 값이 없는 경우
SELECT * FROM categrp ORDER BY seqno ASC;
 CATEGRPNO   SORT     SEQNO
 ----------  ---------   ---------
 PK 테이블에 레코드 없음.

-- 개발 자료 관련 레코드 추가
-- ERROR 메시지: FK categrpno 컬럼의 값 '1'이 PK 테이블에 없는 경우 발생
-- ORA-02291: integrity constraint (SOLDESK.SYS_C007052) violated - parent key not found
INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1000, 'JAVA', 1, 'Y', 'admin', sysdate);

             
6. 레코드 추가, 부모 테이블 PK 컬럼에 값이 있는 경우
   - 레코드 추가 순서: 부모 categrp -> 자식 category

1) categrp 테이블에 INSERT SQL 실행 

SELECT * FROM categrp ORDER BY seqno ASC;

 CATEGRPNO NAME  SEQNO VISIBLE RDATE
 --------- ----- ----- ------- ---------------------
         1 영화        1 Y       2017-04-18 12:03:16.0
         2 국내 여행     2 Y       2017-04-18 12:03:29.0
         3 해외 여행     3 Y       2017-04-18 12:03:58.0
     
INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '퇴마', 1 , 'Y', 'admin', sysdate);

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '로맨스', 2 ,'Y' , 'admin', sysdate);

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '코믹' , 3 , 'Y' , 'admin', sysdate);

             
7. 목록
-- DELETE FROM category;

SELECT categoryno, categrpno, title, seqno, visible, ids, rdate
FROM category 
ORDER BY seqno ASC;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   RDATE
 ---------- --------- ----- ----- ------- ----- ---------------------
          1         1 퇴마        1 Y       admin 2017-04-18 12:16:52.0
          2         1 로맨스       2 Y       admin 2017-04-18 12:16:53.0
          3         1 코믹        3 Y       admin 2017-04-18 12:16:54.0


8. 다른 카테고리 그룹의 등록
INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             2, '강원도' , 1 , 'Y' , 'admin', sysdate);
             
INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             2, '충청도' , 2 , 'Y' , 'admin', sysdate);

             
9. 그룹화하여 정렬하여 출력
1) categoryno 컬럼 오름차순 정렬
SELECT categoryno, categrpno, title, seqno, visible, ids, rdate
FROM category 
ORDER BY categoryno ASC;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   RDATE
 ---------- --------- ----- ----- ------- ----- ---------------------
          1         1 퇴마        1 Y       admin 2017-04-18 12:16:52.0
          2         1 로맨스       2 Y       admin 2017-04-18 12:16:53.0
          3         1 코믹        3 Y       admin 2017-04-18 12:16:54.0
          4         2 강원도       1 Y       admin 2017-04-18 12:18:44.0
          5         2 충청도       2 Y       admin 2017-04-18 12:19:02.0

         
2) 출력 순서로 출력하니 정렬이 안됨.
SELECT categoryno, categrpno, title, seqno, visible, ids, rdate
FROM category 
ORDER BY seqno ASC;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   RDATE
 ---------- --------- ----- ----- ------- ----- ---------------------
          1         1 퇴마        1 Y       admin 2017-04-18 12:16:52.0
          4         2 강원도       1 Y       admin 2017-04-18 12:18:44.0
          2         1 로맨스       2 Y       admin 2017-04-18 12:16:53.0
          5         2 충청도       2 Y       admin 2017-04-18 12:19:02.0
          3         1 코믹        3 Y       admin 2017-04-18 12:16:54.0

          
3) 그룹별로 정렬하여 출력          
SELECT categoryno, categrpno, title, seqno, visible, ids, rdate
FROM category 
ORDER BY categrpno ASC, seqno ASC;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   RDATE
 ---------- --------- ----- ----- ------- ----- ---------------------
          1         1 퇴마        1 Y       admin 2017-04-18 12:16:52.0
          2         1 로맨스       2 Y       admin 2017-04-18 12:16:53.0
          3         1 코믹        3 Y       admin 2017-04-18 12:16:54.0
          4         2 강원도       1 Y       admin 2017-04-18 12:18:44.0
          5         2 충청도       2 Y       admin 2017-04-18 12:19:02.0
          
SELECT categoryno, categrpno, title, seqno, visible, ids, rdate
FROM category 
ORDER BY categrpno ASC, seqno DESC;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   RDATE
 ---------- --------- ----- ----- ------- ----- ---------------------
          3         1 코믹          3 Y       admin 2017-04-18 12:16:54.0
          2         1 로맨스       2 Y       admin 2017-04-18 12:16:53.0
          1         1 퇴마          1 Y       admin 2017-04-18 12:16:52.0
          5         2 충청도       2 Y       admin 2017-04-18 12:19:02.0
          4         2 강원도       1 Y       admin 2017-04-18 12:18:44.0
          
SELECT categoryno, categrpno, title, seqno, visible, ids, rdate
FROM category 
ORDER BY categrpno DESC, seqno ASC;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS   RDATE
 ---------- --------- ----- ----- ------- ----- ---------------------
          4         2 강원도       1 Y       admin 2017-04-18 12:18:44.0     
          5         2 충청도       2 Y       admin 2017-04-18 12:19:02.0
          3         1 코믹          3 Y       admin 2017-04-18 12:16:54.0
          1         1 퇴마          1 Y       admin 2017-04-18 12:16:52.0
          2         1 로맨스       2 Y       admin 2017-04-18 12:16:53.0
    
           
10. 조회
SELECT categoryno, categrpno, title, seqno, visible, ids
FROM category 
WHERE categoryno=1;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 ---------- --------- ----- ----- ------- -----
          1         1 퇴마        1 Y       admin


11. 수정: title, seqno, visible, ids
UPDATE category
SET title='변경', seqno=1, visible='N', ids='admin1/user1/user2'
WHERE categoryno=1;

 CATEGORYNO CATEGRPNO TITLE SEQNO VISIBLE IDS
 ---------- --------- ----- ----- ------- ------------------
          1         1 변경        1 N       admin1/user1/user2


12. categrp(대분류) 값에 따른 갯수 산출
SELECT COUNT(*) as cnt
FROM category
WHERE categrpno = 2;
 CNT
 -----
   2

   
13. 삭제
- 레코드 삭제 순서: 자식 category -> 부모 categrp 

1) 하나의 레코드 삭제
DELETE FROM category WHERE categoryno = 1;

2) categrp(대분류) 값과 일치하는 다수의 레코드 삭제(많은 레코드가 삭제 될 수 있음)
DELETE FROM category WHERE categrpno = 1;
   
   
14. 출력 우선 순위 높임, 10 -> 1
UPDATE category 
SET seqno = seqno - 1 
WHERE categoryno=1;


15. 출력 우선 순서 낮춤, 1 -> 10
UPDATE category 
SET seqno = seqno + 1 
WHERE categoryno=1;


16. categrp(대분류) 값에 따른 갯수 산출
SELECT COUNT(*) as cnt
FROM category
WHERE categrpno = 1;

 CNT
 -----
   3
 
    
17. categrp(대분류) 값과 일치하는 다수의 레코드 삭제(많은 레코드가 삭제 될 수 있음)
DELETE FROM category
WHERE categrpno = 1;


18. blog 글 추가에따른 등록된 글수의 증가
UPDATE category 
SET cnt = cnt + 1 
WHERE categoryno=1;


19. blog 글 삭제에따른 등록된 글수의 감소
UPDATE category 
SET cnt = cnt - 1 
WHERE categoryno=1;


20. 글수의 초기화
UPDATE category 
SET cnt = 0;


-------------------------------------------------------------------------------------
 
 