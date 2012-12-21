--  Author                      ��⼷
--  Description                 ������ ��������[Ȯ��]
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries
--  Desc : ���º��߰� (2012.10.15)

CREATE TABLE PBRTN.RTN015 (
  RECMCD      CHAR(2)       CCSID 833 NOT NULL , -- ȸ��
  REPLANT     CHAR(1)       CCSID 833 NOT NULL , -- ����
  REDVSN      CHAR(1)       CCSID 833 NOT NULL , -- ����
  REITNO      VARCHAR(12)   CCSID 933 NOT NULL , -- ǰ��
  RELINE1     VARCHAR(7)    CCSID 933 NOT NULL , -- ��ü�����ڵ�
  RELINE2     CHAR(1)       CCSID 833 NOT NULL , -- ��ü���γѹ�
  REOPNO      VARCHAR(7)    CCSID 933 NOT NULL , -- ������ȣ
  REEDFM      CHAR(8)       CCSID 933 NOT NULL , -- ������
  REEDTO      CHAR(8)       CCSID 933 NOT NULL , -- �Ϸ���
  REOPNM      VARCHAR(50)   CCSID 933 NOT NULL , -- ������
  REOPSQ      NUMERIC(3, 0)           NOT NULL , -- ��������
  RELINE3     VARCHAR(5)    CCSID 933 NOT NULL , -- ��
  REGRDE      CHAR(1)       CCSID 833 NOT NULL , -- GRADE
  REMCYN      CHAR(1)       CCSID 833 NOT NULL , -- �������
  REBMTM      DECIMAL(7, 4)           NOT NULL , -- �⺻ ����۾�
  REBLTM      DECIMAL(7, 4)           NOT NULL , -- �⺻ ���۾�
  REBSTM      DECIMAL(7, 4)           NOT NULL , -- �⺻ �⺻�۾�
  RENVCD      CHAR(1)       CCSID 833 NOT NULL , -- �δ��۾� ����
  RENVMC      DECIMAL(7, 4)           NOT NULL , -- �δ� ����۾�
  RENVLB      DECIMAL(7, 4)           NOT NULL , -- �δ� ���۾�
  RELBCNT     NUMERIC(3, 0)           NOT NULL , -- �ο�
  REFLAG      CHAR(1)       CCSID 833 NOT NULL , -- �Է±���
  REEPNO      VARCHAR(6)    CCSID 933 NOT NULL , -- �����
  REIPAD      VARCHAR(15)   CCSID 933 NOT NULL , -- IP ADDRESS
  REUPDT      CHAR(8)       CCSID 833 NOT NULL , -- ������
  RESYDT      CHAR(8)       CCSID 833 NOT NULL , -- �����
  REINEMP     VARCHAR(6)    CCSID 933 NOT NULL , -- �����
  REINCHK     CHAR(1)       CCSID 833 NOT NULL , -- ����ڽ��ο���
  REINTIME    VARCHAR(19)   CCSID 933 NOT NULL , -- ����ڽ��νð�
  REPLEMP     VARCHAR(6)    CCSID 933 NOT NULL , -- P/L
  REPLCHK     CHAR(1)       CCSID 833 NOT NULL , -- P/L ���ο���
  REPLTIME    VARCHAR(19)   CCSID 933 NOT NULL , -- P/L ���νð�
  REDLEMP     VARCHAR(6)    CCSID 933 NOT NULL , -- ����
  REDLCHK     CHAR(1)       CCSID 833 NOT NULL , -- ������ο���
  REDLTIME    VARCHAR(19)   CCSID 933 NOT NULL , -- ������νð�
  REPOWER     NUMERIC(10,5) CCSID 833 NOT NULL DEFAULT 0, -- ���º�(KW/EA)
  PRIMARY KEY( RECMCD , REPLANT , REDVSN , REITNO , RELINE1 , RELINE2 , REOPNO , REEDFM )
  ) ;
  
ALTER TABLE PBRTN.RTN015
ADD COLUMN REPOWER DECIMAL(10, 5) NOT NULL DEFAULT 0.00000;