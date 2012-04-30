--  Author                      김기섭
--  Description                 대표/대체품번 정보[확정]
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE TABLE PBRTN.RTN018 (
  RHCMCD      CHAR(2)       CCSID 833 NOT NULL , -- 회사
  RHPLANT     CHAR(1)       CCSID 833 NOT NULL , -- 지역
  RHDVSN      CHAR(1)       CCSID 833 NOT NULL , -- 공장
  RHITNO      VARCHAR(12)   CCSID 933 NOT NULL , -- 대표품번
  RHITNO1     VARCHAR(12)   CCSID 933 NOT NULL , -- 대체품번
  RHEDFM      CHAR(8)       CCSID 933 NOT NULL , -- 적용일자
  RHEDTO      CHAR(8)       CCSID 933 NOT NULL , -- 완료일자
  RHEPNO      CHAR(6)       CCSID 933 NOT NULL , -- 입력자
  RHIPAD      VARCHAR(15)   CCSID 933 NOT NULL , -- IP ADDRESS
  RHSYDT      CHAR(8)       CCSID 933 NOT NULL , -- 입력일자
  PRIMARY KEY( RHCMCD , RHPLANT , RHDVSN , RHITNO , RHITNO1 , RHEDFM )
  ) ;