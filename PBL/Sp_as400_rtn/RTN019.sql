--  Author                      ��⼷
--  Description                 ���� ����� ����
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE TABLE PBRTN.RTN019 (
  XCMCD      CHAR(2)       CCSID 833 NOT NULL , -- ȸ��
  XINEMP     CHAR(6)       CCSID 833 NOT NULL , -- ����ڻ��
  XPLEMP     CHAR(6)       CCSID 833 NOT NULL , -- ���PL���
  XMACADDR   VARCHAR(30)   CCSID 933 NOT NULL , -- MACHINE NO.
  XIPADDR    VARCHAR(30)   CCSID 933 NOT NULL , -- IP ADDRESS
  XINDT      CHAR(8)       CCSID 933 NOT NULL , -- �Է�����
  PRIMARY KEY( XCMCD, XINEMP )
  ) ;