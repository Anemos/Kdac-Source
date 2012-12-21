--  Author                      ��⼷
--  Description                 ��ü���θ���Ÿ
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE TABLE PBRTN.RTN012 (
  RBCMCD      CHAR(2)       NOT NULL ,  -- ȸ��
  RBPLANT     CHAR(1)       NOT NULL ,  -- ����
  RBDVSN      CHAR(1)       NOT NULL ,  -- ����
  RBLINE1     VARCHAR(7)    NOT NULL ,  -- ��ü�����ڵ�
  RBLINE2     CHAR(1)       NOT NULL ,  -- ��ü���γѹ�
  RBLNMN      VARCHAR(50)   NOT NULL ,  -- ��ü���θ�
  RBLCTN      CHAR(1)       NOT NULL ,  -- ���� A, ���� M
  RBVEND      CHAR(1)       NOT NULL ,  -- ���ֱ��� �系 I, ��� O
  RBFLAG      CHAR(1)       NOT NULL ,  -- �Է±��� �Է� A, ���� R
  RBEPNO      CHAR(6)       NOT NULL ,  -- �Է���
  RBIPAD      VARCHAR(15)   NOT NULL ,  -- IP ADDRESS
  RBUPDT      CHAR(8)       NOT NULL ,  -- ��������
  RBSYDT      CHAR(8)       NOT NULL ,  -- �Է�����
  RBOPTION    INT           NOT NULL DEFAULT 0 ,  -- ������(%)
  RBSUBCHK    CHAR(1)       NOT NULL DEFAULT 'N' , -- SUB����ǰ
  PRIMARY KEY( RBCMCD, RBPLANT, RBDVSN, RBLINE1, RBLINE2 ) ) ;
