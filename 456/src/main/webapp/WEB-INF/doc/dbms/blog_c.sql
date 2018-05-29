▷ /webapp/WEB-INF/doc/dbms/blog_c.sql
-----------------------------------------------------------------------------------
DROP TABLE member;

CREATE TABLE member (
  mno       NUMBER(6) NOT NULL, -- 회원 번호, 레코드를 구분하는 컬럼 
  PRIMARY KEY (mno)             -- 한번 등록된 값은 중복 안됨
);


DROP TABLE blog;

/**********************************/
/* Table Name: 블로그 내용 */
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

COMMENT ON TABLE blog is '블로그 내용';
COMMENT ON COLUMN blog.blogno is '블로그번호';
COMMENT ON COLUMN blog.categoryno is '카테고리번호';
COMMENT ON COLUMN blog.mno is '회원 번호';
COMMENT ON COLUMN blog.title is '제목';
COMMENT ON COLUMN blog.content is '내용';
COMMENT ON COLUMN blog.good is '추천수';
COMMENT ON COLUMN blog.thumb is 'Thumb 파일';
COMMENT ON COLUMN blog.file1 is '파일 1';
COMMENT ON COLUMN blog.size1 is '파일 1 크기';
COMMENT ON COLUMN blog.cnt is '조회수';
COMMENT ON COLUMN blog.replycnt is '댓글수';
COMMENT ON COLUMN blog.rdate is '등록일';
COMMENT ON COLUMN blog.grpno is '그룹번호';
COMMENT ON COLUMN blog.indent is '답변차수';
COMMENT ON COLUMN blog.ansnum is '답변 순서';
COMMENT ON COLUMN blog.word is '검색어';

-- DDL(Data Definition Language)
-- 컬럼 추가
ALTER TABLE blog
ADD (title VARCHAR2(256));

-- 컬럼 구조 변경
ALTER TABLE blog
MODIFY (title VARCHAR2(300));
-- ORA-01441: cannot decrease column length because some value is too big

-- ORA-00910: specified length too long for its datatype
ALTER TABLE blog
MODIFY (content VARCHAR2(65000));

-- 컬럼 이름 변경
ALTER TABLE blog
RENAME COLUMN old_title TO new_title;

-- 컬럼 삭제
ALTER TABLE blog
DROP COLUMN title;

  
1) 회원(member) 참조 테이블 설정
-- 회원 테이블을 FK 컬럼으로 참조함으로 임시로 제작합니다.
-- 테이블명, PK 컬럼명은 설계시 지정된 것을 사용합니다. 
INSERT INTO member(mno) VALUES(1);
INSERT INTO member(mno) VALUES(2);
INSERT INTO member(mno) VALUES(3);

-- member 회원 목록(팀원 1)
SELECT mno
FROM member;

 MNO
 ------
   1
   2
   3
  
2) 카테고리 그룹(categrp) 참조 테이블 설정
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '영화', 1, 'Y', sysdate);
  
INSERT INTO categrp(categrpno, name, seqno, visible, rdate)
VALUES((SELECT NVL(MAX(categrpno), 0)+1 as categrpno FROM categrp),
  '여행', 2, 'Y', sysdate);  
  
SELECT categrpno, name, seqno, visible, rdate
FROM categrp
ORDER BY categrpno ASC;

 CATEGRPNO NAME SEQNO VISIBLE RDATE
 --------- ---- ----- ------- ---------------------
         1 영화       1 Y       2017-11-15 12:39:29.0
         2 여행       2 Y       2017-11-15 12:39:30.0
         
3) 카테고리(category) 참조 테이블 설정

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '퇴마', 1 , 'Y', 'admin', sysdate);

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, '로맨스', 2 ,'Y' , 'admin', sysdate);

INSERT INTO category(categoryno, categrpno, title, seqno, visible, ids, rdate)
VALUES((SELECT NVL(MAX(categoryno), 0)+1 as categoryno FROM category),
             1, 'SF' , 3 , 'Y' , 'admin', sysdate);
             
SELECT * FROM category;

4) blog 등록             
-- blog 새글 등록(팀원 3)
- 새로운 글, 답변 글에따라 등록 SQL차이가 있습니다.
- 새로운 글 등록은 새로운 그룹이 만들어지는 기능이 있습니다. MAX + 1
- categoryno 컬럼 1번 기준
- mno 컬럼 1번 기준
INSERT INTO blog(blogno,
                         categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
                         grpno, indent, ansnum, word)  
VALUES((SELECT NVL(MAX(blogno), 0) + 1 as blogno FROM blog),
            1, 1, '제목', '내용', 0, 'fall_m.jpg', 'fall.jpg', 0, 0, 0, sysdate,
            (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM blog), 0, 0, '스프링,spring,봄,春,계절,냉이,개나리');

-- ERROR: FK 컬럼에 사용할 값이 다른 테이블에 등록이 안되어 있는 경우
    ORA-02291: integrity constraint (SOLDESK.SYS_C007131) violated - parent key not found
    ORA-02291: integrity constraint (SOLDESK.SYS_C007132) violated - parent key not found

5) 전체 목록(댓글 구현)
SELECT blogno,
           categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
           grpno, indent, ansnum, word
FROM blog
ORDER BY grpno DESC, ansnum ASC;

 BLOGNO CATEGORYNO MNO TITLE CONTENT GOOD THUMB      FILE1    SIZE1 CNT REPLYCNT RDATE                 GRPNO INDENT ANSNUM WORD
 ------ ---------- --- ----- ------- ---- ---------- -------- ----- --- -------- --------------------- ----- ------ ------ ------------------------
      1          1   1 제목    내용         0 fall_m.jpg fall.jpg     0   0        0 2017-04-20 13:20:20.0     1      0      0 스프링,spring,봄,春,계절,냉이,개나리

6) category 별 목록(댓글 구현)
SELECT blogno,
           categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
           grpno, indent, ansnum, word
FROM blog
WHERE categoryno=1
ORDER BY grpno DESC, ansnum ASC;

 BLOGNO CATEGORYNO MNO TITLE CONTENT GOOD THUMB      FILE1    SIZE1 CNT REPLYCNT RDATE                 GRPNO INDENT ANSNUM WORD
 ------ ---------- --- ----- ------- ---- ---------- -------- ----- --- -------- --------------------- ----- ------ ------ ------------------------
      1          1   1 제목    내용         0 fall_m.jpg fall.jpg     0   0        0 2017-04-20 13:20:20.0     1      0      0 스프링,spring,봄,春,계절,냉이,개나리

      
7) 전체 카운트
SELECT COUNT(*) as count
FROM blog;

 COUNT
 -----
     1

8) 조회
SELECT blogno,
           categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
           grpno, indent, ansnum, word
FROM blog
WHERE blogno=1; 

9) 수정
UPDATE blog
SET title='겨울', content='손이시려워...', 
      thumb='snow_t.jpg', file1='snow.jpg', size1=1500, word='휴가'
WHERE blogno=1;

10) 삭제
DELETE FROM blog
WHERE blogno=9

DELETE FROM blog
WHERE blogno=1 OR blogno=2;

11) 검색(%: 없거나 하나 이상의 모든 문자)
-- word LIKE '스위스' → word = '스위스'
   ^스위스$
-- word LIKE '%스위스' → word = '잊지 못할 스위스'
   .*스위스$
-- word LIKE '스위스%' → word = '스위스에서~'
   ^스위스.*
-- word LIKE '%스위스%' → word = '유럽 여행은 스위스 꼭 방문해야~'
   .*스위스.*

-- '스위스' 컬럼으로 검색
SELECT blogno,
          categoryno, mno, title, good, thumb, file1, size1, cnt, replycnt, rdate, 
          grpno, indent, ansnum, word
FROM blog
WHERE categoryno=1 AND word LIKE '%스위스%'
ORDER BY blogno DESC;

-- '스의스' 컬럼으로 검색
SELECT blogno,
          categoryno, mno, title, good, thumb, file1, size1, cnt, replycnt, rdate, 
          grpno, indent, ansnum, word
FROM blog
WHERE categoryno=1 AND word LIKE '%스의스%'
ORDER BY blogno DESC;

-- '수의스' 컬럼으로 검색
SELECT blogno,
          categoryno, mno, title, good, thumb, file1, size1, cnt, replycnt, rdate, 
          grpno, indent, ansnum, word
FROM blog
WHERE categoryno=1 AND word LIKE '%수의스%'
ORDER BY blogno DESC;

-- 'swiss' 컬럼으로 검색
SELECT blogno,
          categoryno, mno, title, good, thumb, file1, size1, cnt, replycnt, rdate, 
          grpno, indent, ansnum, word
FROM blog
WHERE categoryno=1 AND word LIKE '%swiss%'
ORDER BY blogno DESC;


12) 검색 및 전체 레코드 갯수
-- 검색하지 않는 경우 레코드 갯수
SELECT COUNT(*) as cnt
FROM blog
WHERE categoryno=1;

-- '스위스' 검색 레코드 갯수
SELECT COUNT(*) as cnt
FROM blog
WHERE categoryno=1 AND word LIKE '%스위스%';

13) 페이징

DROP TABLE PG;

CREATE TABLE PG(
  num NUMBER(5) NOT NULL,
  title  VARCHAR(20) NOT NULL,
  PRIMARY KEY(num)
);

INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '01월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '02월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '03월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '04월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '05월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '06월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '07월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '08월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '09월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '10월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '11월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '12월');

SELECT num, title FROM pg;

 NUM TITLE
 --- -----
   1 01월
   2 02월
   3 03월
   4 04월
   5 05월
   6 06월
   7 07월
   8 08월
   9 09월
  10 10월
  11 11월
  12 12월

-- 분기별로 분할하여 레코드를 추출하는 경우(페이징)
SELECT num, title FROM pg;

-- rownum: oralce system에서 select시에 자동으로 붙여주는 일련번호
SELECT num, title, rownum FROM pg;

 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
   2 02월        2
   3 03월        3
   4 04월        4
   5 05월        5
   6 06월        6
   7 07월        7
   8 08월        8
   9 09월        9
  10 10월       10
  11 11월       11
  12 12월       12

-- 2,3월 삭제
DELETE FROM pg WHERE num=2 or num=3;

SELECT num, title, rownum FROM pg;

 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
   4 04월        2
   5 05월        3
   6 06월        4
   7 07월        5
   8 08월        6
   9 09월        7
  10 10월        8
  11 11월        9
  12 12월       10


-- 페이징시는 일정한 순차값이 생성되는 rownum 값을 사용합니다.
-- rownum주의: rownum은 정렬(ORDER BY ~)보다 먼저 생성됨으로
   정렬을 한 후 rownum 컬럼을 사용합니다.

INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '봄');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '여름');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '가을');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '겨울');

-- Paging Step 1
-- SELECT → ROWNUM → ORDER BY ~
SELECT num, title, rownum 
FROM pg
ORDER BY title ASC;

 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
   4 04월        4
   5 05월        5
   6 06월        6
   7 07월        7
   8 08월        8
   9 09월        9
  10 10월       10
  11 11월       11
  12 12월       12
  15 가을         2
  16 겨울         3
  13 봄         13
  14 여름        14
  
  
-- Paging Step 2, subquery
SELECT num, title, rownum
FROM (
           SELECT num, title 
           FROM pg
           ORDER BY num ASC
);

  NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
   4 04월        2
   5 05월        3
   6 06월        4
   7 07월        5
   8 08월        6
   9 09월        7
  10 10월        8
  11 11월        9
  12 12월       10
  13 봄         11
  14 여름        12
  15 가을        13
  16 겨울        14
  
-- 2,3 월을 추가하세요.
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '02월');
INSERT INTO pg(num, title)
VALUES((SELECT NVL(MAX(num), 0) +1 as num FROM pg), '03월');

-- 목록 다시 출력, ☆ rownum이 생성되고 정렬 기능이 작동함
SELECT num, title, rownum
FROM pg
ORDER BY title ASC;
  
 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
  17 02월       15
  18 03월       16
   4 04월        4
   5 05월        5
   6 06월        6
   7 07월        7
   8 08월        8
   9 09월        9
  10 10월       10
  11 11월       11
  12 12월       12
  15 가을         2
  16 겨울         3
  13 봄         13
  14 여름        14
  
-- Subquery에서 정렬후 rownum을 사용
SELECT num, title, rownum
FROM (
           SELECT num, title
           FROM pg
           ORDER BY title ASC
);

 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
  17 02월        2
  18 03월        3
   4 04월        4
   5 05월        5
   6 06월        6
   7 07월        7
   8 08월        8
   9 09월        9
  10 10월       10
  11 11월       11
  12 12월       12
  15 가을        13
  16 겨울        14
  13 봄         15
  14 여름        16

-- Paging Step 3, subquery
-- 1 분기
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
   1 01월   1
  17 02월   2
  18 03월   3
   
-- 2 분기
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
   4 04월   4
   5 05월   5
   6 06월   6


   
* rownum은 최초 1페이지만 정상 처리되고 2페이부터는 WHERE문에서 
  인식이안됩니다. 따라서 3단 쿼리를 사용해야합니다.   
SELECT num, title, rownum
FROM (
          SELECT num, title 
          FROM pg
          ORDER BY title ASC
)  
WHERE rownum>=1 AND rownum <=3;

 NUM TITLE ROWNUM
 --- ----- ------
   1 01월        1
  17 02월        2
  18 03월        3

SELECT num, title, rownum
FROM (
          SELECT num, title 
          FROM pg
          ORDER BY title ASC
)  
WHERE rownum>=4 AND rownum <=6;

 NUM TITLE ROWNUM
 --- ----- ------


14) 페이징 구현
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
      2          1 로스트   로스트           0 Lost04_t.jpg Lost04.jpg 148940   0        0 2017-05-01 13:01:13.0 로스트                1
      1          1 바다건너  크리스마스에 갔던곳    0 sw02_t.jpg   sw02.jpg   210262   0        0 2017-05-01 12:59:02.0 스위스 swiss 해외 걷기 여행 2

      
15) 답변
[답변 쓰기]
-- 1번글 기준 답변 등록예: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM categrp;
SELECT * FROM category;

① 새로운 답변을 최신으로 등록하기위해 기존 답변을 뒤로 미룹니다.
-- 모든 글의 우선 순위가 1씩 증가됨, 1등 -> 2등
UPDATE blog
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 0;

-- 2등부터 우선 순위가 1씩 증가됨, 2등 -> 3등
UPDATE blog
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 1;

-- 3등부터 우선 순위가 1씩 증가됨, 3등 -> 4등
UPDATE blog
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 2;

-- 6등부터 우선 순위가 1씩 증가됨, 6등 -> 7등
UPDATE blog
SET ansnum = ansnum + 1
WHERE categoryno=1 AND grpno = 1 AND ansnum > 5;


② 답변 등록
INSERT INTO blog(blogno,
                          categoryno, mno, title, content, good, thumb, file1, size1, cnt, replycnt, rdate, 
                          grpno, indent, ansnum, word)  
VALUES((SELECT NVL(MAX(blogno), 0) + 1 as blogno FROM blog),
            1, 1, '제목', '내용',0, 'summer_m.jpg', 'summer.jpg', 0, 0, 0, sysdate,
            1, 1, 1,'');


③ 답변에 따른 정렬 순서 변경    
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



 