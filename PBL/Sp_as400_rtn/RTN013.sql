--  Author                      ��⼷
--  Description                 ����� �������� �̷�
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE TABLE PBRTN.RTN013 (
  RCCMCD      CHAR(2)       CCSID 833 NOT NULL , -- ȸ��
  RCPLANT     CHAR(1)       CCSID 833 NOT NULL , -- ����
  RCDVSN      CHAR(1)       CCSID 833 NOT NULL , -- ����
  RCITNO      VARCHAR(12)   CCSID 933 NOT NULL , -- ǰ��
  RCLINE1     VARCHAR(7)    CCSID 933 NOT NULL , -- ��ü�����ڵ�
  RCLINE2     CHAR(1)       CCSID 833 NOT NULL , -- ��ü���γѹ�
  RCOPNO      VARCHAR(7)    CCSID 933 NOT NULL , -- ������ȣ
  RCCHTIME    VARCHAR(19)   CCSID 933 NOT NULL , -- ����ð�
  RCEDFM      CHAR(8)       CCSID 833 NOT NULL , -- ������
  RCOPNM      VARCHAR(50)   CCSID 933 NOT NULL , -- ������
  RCOPSQ      NUMERIC(3, 0)           NOT NULL , -- ��������
  RCLINE3     VARCHAR(5)    CCSID 933 NOT NULL , -- ��
  RCGRDE      CHAR(1)       CCSID 833 NOT NULL , -- ��� ��A,��B
  RCMCYN      CHAR(1)       CCSID 833 NOT NULL , -- ������� ��Y, ��N
  RCBMTM      DECIMAL(7, 4)           NOT NULL , -- �⺻����۾��ð�
  RCBLTM      DECIMAL(7, 4)           NOT NULL , -- �⺻���۾��ð�
  RCBSTM      DECIMAL(7, 4)           NOT NULL , -- �⺻�۾��ð�
  RCNVCD      CHAR(1)       CCSID 833 NOT NULL , -- �δ��۾����� ��Y,��N
  RCNVMC      DECIMAL(7, 4)           NOT NULL , -- �δ����۾�
  RCNVLB      DECIMAL(7, 4)           NOT NULL , -- �δ���۾�
  RCLBCNT     NUMERIC(3, 0)           NOT NULL , -- �ο�
  RCFLAG      CHAR(1)       CCSID 833 NOT NULL , -- �Է±���
  RCEPNO      VARCHAR(6)    CCSID 933 NOT NULL , -- �����
  RCIPAD      VARCHAR(15)   CCSID 933 NOT NULL , -- IP ADDRESS
  RCUPDT      CHAR(8)       CCSID 833 NOT NULL , -- ������
  RCSYDT      CHAR(8)       CCSID 833 NOT NULL , -- �����
  RCINEMP     VARCHAR(6)    CCSID 933 NOT NULL , -- �����
  RCINCHK     CHAR(1)       CCSID 833 NOT NULL , -- ����ڽ��ο���
  RCINTIME    VARCHAR(19)   CCSID 933 NOT NULL , -- ����ڽ��νð�
  RCPLEMP     VARCHAR(6)    CCSID 933 NOT NULL , -- P/L
  RCPLCHK     CHAR(1)       CCSID 833 NOT NULL , -- P/L ���ο���
  RCPLTIME    VARCHAR(19)   CCSID 933 NOT NULL , -- P/L ���νð�
  RCDLEMP     VARCHAR(6)    CCSID 933 NOT NULL , -- ����
  RCDLCHK     CHAR(1)       CCSID 833 NOT NULL , -- ������ο���
  RCDLTIME    VARCHAR(19)   CCSID 933 NOT NULL , -- ������νð�
  RCPOWER     NUMERIC(10,5) CCSID 833 NOT NULL DEFAULT 0, -- ���º�(KW/EA)
  PRIMARY KEY( RCCMCD , RCPLANT , RCDVSN , RCITNO , RCLINE1 , RCLINE2 , RCOPNO ) ) ;
  
ALTER TABLE PBRTN.RTN013
ADD COLUMN RCPOWER DECIMAL(10, 5) NOT NULL DEFAULT 0.00000;