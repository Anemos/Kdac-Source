--  Author                      ��⼷
--  Description                 ������ �����Ȳ����
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE TABLE PBRTN.RTN017 (
  RGCMCD      CHAR(2)       CCSID 833 NOT NULL , -- ȸ��
  RGPLANT     CHAR(1)       CCSID 833 NOT NULL , -- ����
  RGDVSN      CHAR(1)       CCSID 833 NOT NULL , -- ����
  RGITNO      VARCHAR(12)   CCSID 933 NOT NULL , -- ǰ��
  RGLINE1     VARCHAR(7)    CCSID 933 NOT NULL , -- ��ü�����ڵ�
  RGLINE2     CHAR(1)       CCSID 833 NOT NULL , -- ��ü���γѹ�
  RGOPNO      VARCHAR(7)    CCSID 933 NOT NULL , -- ������ȣ
  RGMCNO      VARCHAR(10)   CCSID 933 NOT NULL , -- ����ȣ
  RGEDFM      VARCHAR(8)    CCSID 933 NOT NULL , -- ������
  RGFLAG      CHAR(1)       CCSID 833 NOT NULL , -- �Է±���
  RGEPNO      VARCHAR(6)    CCSID 933 NOT NULL , -- �����
  RGIPAD      VARCHAR(15)   CCSID 933 NOT NULL , -- IP ADDRESS
  RGUPDT      CHAR(8)       CCSID 933 NOT NULL , -- ������
  RGSYDT      CHAR(8)       CCSID 933 NOT NULL , -- �����
  PRIMARY KEY( RGCMCD , RGPLANT , RGDVSN , RGITNO , RGLINE1 , RGLINE2 , RGOPNO , RGMCNO )
  ) ;