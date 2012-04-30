--  Author                      ��⼷
--  Description                 ��ǥ/��üǰ�� �����̷�
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE TABLE PBRTN.RTN011 (
  RACMCD      CHAR(2)       CCSID 833 NOT NULL ,  -- ȸ��
  RAPLANT     CHAR(1)       CCSID 833 NOT NULL ,  -- ����
  RADVSN      CHAR(1)       CCSID 833 NOT NULL ,  -- ����
  RAITNO      VARCHAR(12)   CCSID 933 NOT NULL ,  -- ��ǥǰ��
  RAITNO1     VARCHAR(12)   CCSID 933 NOT NULL ,  -- ��üǰ��
  RACHTIME    VARCHAR(19)   CCSID 933 NOT NULL ,  -- ����ð�
  RAEDFM      CHAR(8)       CCSID 833 NOT NULL ,  -- ��������
  RAEPNO      CHAR(6)       CCSID 833 NOT NULL ,  -- �Է���
  RAIPAD      VARCHAR(15)   CCSID 933 NOT NULL ,  -- IP ADDRESS
  RASYDT      CHAR(8)       CCSID 833 NOT NULL ,  -- �Է�����
  RAINEMP     VARCHAR(6)    CCSID 933 NOT NULL ,  -- �����
  RAINCHK     CHAR(1)       CCSID 833 NOT NULL ,  -- ����ڽ��ο���
  RAINTIME    VARCHAR(19)   CCSID 933 NOT NULL ,  -- ����ڽ��νð�
  RAPLEMP     VARCHAR(6)    CCSID 933 NOT NULL ,  -- P/L
  RAPLCHK     CHAR(1)       CCSID 833 NOT NULL ,  -- P/L ���ο���
  RAPLTIME    VARCHAR(19)   CCSID 933 NOT NULL ,  -- P/L ���νð�
  RADLEMP     VARCHAR(6)    CCSID 933 NOT NULL ,  -- ����
  RADLCHK     CHAR(1)       CCSID 833 NOT NULL ,  -- ������ο���
  RADLTIME    VARCHAR(19)   CCSID 933 NOT NULL ,  -- ������νð�
  RAFLAG      CHAR(1)       CCSID 833 NOT NULL ,  -- �Է±��� A, R
  PRIMARY KEY( RACMCD, RAPLANT, RADVSN, RAITNO, RAITNO1) ) ;
