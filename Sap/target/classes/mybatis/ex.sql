CREATE TABLE member (
  mno     INT  NOT NULL, -- ȸ�� ��ȣ, ���ڵ带 �����ϴ� �÷� 
  id           VARCHAR(20)   NOT NULL UNIQUE, -- ���̵�, �ߺ� �ȵ�, ���ڵ带 ���� 
  passwd    VARCHAR(20)   NOT NULL, -- �н�����, ������ ����
  mname    VARCHAR(20)   NOT NULL, -- ����, �ѱ� 10�� ���� ����
  memail VARCHAR(20) NOT NULL,
  qadmin VARCHAR(45) NOT NULL DEFAULT 'y',
  PRIMARY KEY (mno)             -- �ѹ� ��ϵ� ���� �ߺ� �ȵ�
);

DROP TABLE member;