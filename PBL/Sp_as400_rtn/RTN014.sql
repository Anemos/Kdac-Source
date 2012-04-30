--  Author                      ��⼷
--  Description                 ������ �δ��۾�����
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries
DROP TABLE PBRTN.RTN014;
CREATE TABLE PBRTN.RTN014 (
  RDLOGID     INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1, NO CACHE),
  RDCMCD      CHAR(2)       CCSID 833 NOT NULL , -- ȸ��
  RDPLANT     CHAR(1)       CCSID 833 NOT NULL , -- ����
  RDDVSN      CHAR(1)       CCSID 833 NOT NULL , -- ����
  RDITNO      VARCHAR(12)   CCSID 933 NOT NULL , -- ǰ��
  RDLINE1     VARCHAR(7)    CCSID 933 NOT NULL , -- ��ü�����ڵ�
  RDLINE2     CHAR(1)       CCSID 833 NOT NULL , -- ��ü���γѹ�
  RDOPNO      VARCHAR(7)    CCSID 933 NOT NULL , -- ������ȣ
  RDNVMO      CHAR(2)       CCSID 833 NOT NULL , -- ����
  RDMCNO      CHAR(1)       CCSID 833 NOT NULL , -- ����
  RDTERM      CHAR(1)       CCSID 833 NOT NULL , -- ��
  RDMCTM      DECIMAL(7, 4)           NOT NULL , -- ����۾�(��)
  RDLBTM      DECIMAL(7, 4)           NOT NULL , -- ���۾�(��)
  RDREMK      VARCHAR(240)  CCSID 933 NOT NULL , -- ���
  RDFLAG      CHAR(1)       CCSID 833 NOT NULL , -- �Է±���
  RDEPNO      CHAR(6)       CCSID 933 NOT NULL , -- �����
  RDEDFM      CHAR(8)       CCSID 933 NOT NULL , -- ������
  RDIPAD      VARCHAR(15)   CCSID 933 NOT NULL , -- IP ADDRESS
  RDUPDT      CHAR(8)       CCSID 933 NOT NULL , -- ������
  RDSYDT      CHAR(8)       CCSID 933 NOT NULL ,  -- �����
  PRIMARY KEY( RDLOGID )
  ) ;