--  Author                      ��⼷
--  Description                 ��ǥ/��üǰ�� ����[Ȯ��]
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE TABLE PBRTN.RTN018 (
  RHCMCD      CHAR(2)       CCSID 833 NOT NULL , -- ȸ��
  RHPLANT     CHAR(1)       CCSID 833 NOT NULL , -- ����
  RHDVSN      CHAR(1)       CCSID 833 NOT NULL , -- ����
  RHITNO      VARCHAR(12)   CCSID 933 NOT NULL , -- ��ǥǰ��
  RHITNO1     VARCHAR(12)   CCSID 933 NOT NULL , -- ��üǰ��
  RHEDFM      CHAR(8)       CCSID 933 NOT NULL , -- ��������
  RHEDTO      CHAR(8)       CCSID 933 NOT NULL , -- �Ϸ�����
  RHEPNO      CHAR(6)       CCSID 833 NOT NULL ,  -- �Է���
  RHIPAD      VARCHAR(15)   CCSID 933 NOT NULL ,  -- IP ADDRESS
  RHSYDT      CHAR(8)       CCSID 833 NOT NULL ,  -- �Է�����
  RHINEMP     VARCHAR(6)    CCSID 933 NOT NULL ,  -- �����
  RHINCHK     CHAR(1)       CCSID 833 NOT NULL ,  -- ����ڽ��ο���
  RHINTIME    VARCHAR(19)   CCSID 933 NOT NULL ,  -- ����ڽ��νð�
  RHPLEMP     VARCHAR(6)    CCSID 933 NOT NULL ,  -- P/L
  RHPLCHK     CHAR(1)       CCSID 833 NOT NULL ,  -- P/L ���ο���
  RHPLTIME    VARCHAR(19)   CCSID 933 NOT NULL ,  -- P/L ���νð�
  RHDLEMP     VARCHAR(6)    CCSID 933 NOT NULL ,  -- ����
  RHDLCHK     CHAR(1)       CCSID 833 NOT NULL ,  -- ������ο���
  RHDLTIME    VARCHAR(19)   CCSID 933 NOT NULL ,  -- ������νð�
  RHFLAG      CHAR(1)       CCSID 833 NOT NULL ,  -- �Է±��� A, R
  PRIMARY KEY( RHCMCD , RHPLANT , RHDVSN , RHITNO , RHITNO1 , RHEDFM )
  ) ;