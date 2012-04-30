--  Author                      ��⼷
--  Description                 ������ �δ��۾� �̷�
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries
DROP TABLE PBRTN.RTN016;
CREATE TABLE PBRTN.RTN016 (
  RFLOGID     INTEGER                 NOT NULL ,
  RFCMCD      CHAR(2)       CCSID 833 NOT NULL , -- ȸ��
  RFPLANT     CHAR(1)       CCSID 833 NOT NULL , -- ����
  RFDVSN      CHAR(1)       CCSID 833 NOT NULL , -- ����
  RFITNO      VARCHAR(12)   CCSID 933 NOT NULL , -- ǰ��
  RFLINE1     VARCHAR(7)    CCSID 933 NOT NULL , -- ��ü�����ڵ�
  RFLINE2     CHAR(1)       CCSID 833 NOT NULL , -- ��ü���γѹ�
  RFOPNO      VARCHAR(7)    CCSID 933 NOT NULL , -- ������ȣ
  RFNVMO      CHAR(2)       CCSID 833 NOT NULL , -- ����
  RFMCNO      CHAR(1)       CCSID 833 NOT NULL , -- ����
  RFTERM      CHAR(1)       CCSID 833 NOT NULL , -- ��
  RFEDFM      VARCHAR(8)    CCSID 933 NOT NULL , -- ������
  RFMCTM      DECIMAL(7, 4)           NOT NULL , -- ����۾�(��)
  RFLBTM      DECIMAL(7, 4)           NOT NULL , -- ���۾�(��)
  RFREMK      VARCHAR(240)  CCSID 933 NOT NULL , -- ���
  RFFLAG      CHAR(1)       CCSID 833 NOT NULL , -- �Է±���
  RFEPNO      VARCHAR(6)    CCSID 933 NOT NULL , -- �����
  RFEDTO      VARCHAR(8)    CCSID 933 NOT NULL , -- �Ϸ���
  RFIPAD      VARCHAR(15)   CCSID 933 NOT NULL , -- IP ADDRESS
  RFUPDT      CHAR(8)       CCSID 933 NOT NULL , -- ������
  RFSYDT      CHAR(8)       CCSID 933 NOT NULL , -- �����
  PRIMARY KEY( RFLOGID , RFEDFM )
  ) ;