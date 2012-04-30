--  Generate SQL
--  Version:                    V5R3M0 040528
--  Generated on:               09/06/02 15:07:34
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries
--  작업이력관리

DROP TABLE PBBPM.BPM521;

CREATE TABLE PBBPM.BPM521 (
  CHGDATE VARCHAR(30) CCSID 833 NOT NULL DEFAULT '' ,   -- 생성일시
  XYEAR CHAR(4) CCSID 833 NOT NULL DEFAULT '' ,         -- 년도
  SEQNO CHAR(3) CCSID 833 NOT NULL DEFAULT '' ,            --작업순서
  WINDOWID VARCHAR(20) CCSID 833 NOT NULL ,    --윈도우ID
  TASKNAME VARCHAR(100) CCSID 933 NOT NULL DEFAULT '' ,    --작업명
  JOBEMPNO CHAR(6) CCSID 833 NOT NULL DEFAULT '' ,         --작업자사번
  JOBCODE CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,     --작업구분(C,S,D)
  MEMO VARCHAR(250) CCSID 933 NOT NULL DEFAULT '' ,       -- 비고
  LASTEMP CHAR(6) CCSID 833 NOT NULL DEFAULT '' ,          --최종수정자
  LASTDATE VARCHAR(19) CCSID 833 NOT NULL DEFAULT '' ,     --최종수정일시
  PRIMARY KEY( CHGDATE ) ) ;