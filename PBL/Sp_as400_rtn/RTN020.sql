--  Author                      ��⼷
--  Description                 ��������ǰ ���
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE TABLE PBRTN.RTN020 (
  RCMCD      CHAR(2)       NOT NULL , -- ȸ��
  RPLANT     CHAR(1)       NOT NULL , -- ����
  RDVSN      CHAR(1)       NOT NULL , -- ����
  RITNO      VARCHAR(15)   NOT NULL , -- Sub����ǰ
  REPNO      CHAR(6)       NOT NULL , -- �Է���
  RIPAD      VARCHAR(15)   NOT NULL , -- IP ADDRESS
  RSYDT      CHAR(8)       NOT NULL , -- �Է�����
  PRIMARY KEY( RCMCD , RPLANT , RDVSN , RITNO )
  ) ;