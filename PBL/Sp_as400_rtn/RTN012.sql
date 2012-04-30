--  Author                      ��⼷
--  Description                 ��ü���θ���Ÿ
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE TABLE PBRTN.RTN012 (
  RBCMCD      CHAR(2)       CCSID 833 NOT NULL ,  -- ȸ��
  RBPLANT     CHAR(1)       CCSID 833 NOT NULL ,  -- ����
  RBDVSN      CHAR(1)       CCSID 833 NOT NULL ,  -- ����
  RBLINE1     VARCHAR(7)    CCSID 933 NOT NULL ,  -- ��ü�����ڵ�
  RBLINE2     CHAR(1)       CCSID 833 NOT NULL ,  -- ��ü���γѹ�
  RBLNMN      VARCHAR(50)   CCSID 933 NOT NULL ,  -- ��ü���θ�
  RBLCTN      CHAR(1)       CCSID 833 NOT NULL ,  -- ���� A, ���� M
  RBVEND      CHAR(1)       CCSID 833 NOT NULL ,  -- ���ֱ��� �系 I, ��� O
  RBFLAG      CHAR(1)       CCSID 833 NOT NULL ,  -- �Է±��� �Է� A, ���� R
  RBEPNO      CHAR(6)       CCSID 833 NOT NULL ,  -- �Է���
  RBIPAD      VARCHAR(15)   CCSID 933 NOT NULL ,  -- IP ADDRESS
  RBUPDT      CHAR(8)       CCSID 833 NOT NULL ,  -- ��������
  RBSYDT      CHAR(8)       CCSID 833 NOT NULL ,  -- �Է�����
  PRIMARY KEY( RBCMCD, RBPLANT, RBDVSN, RBLINE1, RBLINE2 ) ) ;
