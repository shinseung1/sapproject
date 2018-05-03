CREATE TABLE member (
  mno     INT  NOT NULL, -- 회원 번호, 레코드를 구분하는 컬럼 
  id           VARCHAR(20)   NOT NULL UNIQUE, -- 아이디, 중복 안됨, 레코드를 구분 
  passwd    VARCHAR(20)   NOT NULL, -- 패스워드, 영숫자 조합
  mname    VARCHAR(20)   NOT NULL, -- 성명, 한글 10자 저장 가능
  memail VARCHAR(20) NOT NULL,
  qadmin VARCHAR(45) NOT NULL DEFAULT 'y',
  PRIMARY KEY (mno)             -- 한번 등록된 값은 중복 안됨
);

DROP TABLE member;