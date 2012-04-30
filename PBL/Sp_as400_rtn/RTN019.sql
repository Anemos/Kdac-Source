--  Author                      김기섭
--  Description                 결재 담당자 관리
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE TABLE PBRTN.RTN019 (
  XCMCD      CHAR(2)       CCSID 833 NOT NULL , -- 회사
  XINEMP     CHAR(6)       CCSID 833 NOT NULL , -- 담당자사번
  XPLEMP     CHAR(6)       CCSID 833 NOT NULL , -- 담당PL사번
  XMACADDR   VARCHAR(30)   CCSID 933 NOT NULL , -- MACHINE NO.
  XIPADDR    VARCHAR(30)   CCSID 933 NOT NULL , -- IP ADDRESS
  XINDT      CHAR(8)       CCSID 933 NOT NULL , -- 입력일자
  PRIMARY KEY( XCMCD, XINEMP )
  ) ;