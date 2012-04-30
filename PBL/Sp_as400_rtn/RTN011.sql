--  Author                      김기섭
--  Description                 대표/대체품번 정보이력
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE TABLE PBRTN.RTN011 (
  RACMCD      CHAR(2)       CCSID 833 NOT NULL ,  -- 회사
  RAPLANT     CHAR(1)       CCSID 833 NOT NULL ,  -- 지역
  RADVSN      CHAR(1)       CCSID 833 NOT NULL ,  -- 공장
  RAITNO      VARCHAR(12)   CCSID 933 NOT NULL ,  -- 대표품번
  RAITNO1     VARCHAR(12)   CCSID 933 NOT NULL ,  -- 대체품번
  RACHTIME    VARCHAR(19)   CCSID 933 NOT NULL ,  -- 변경시간
  RAEDFM      CHAR(8)       CCSID 833 NOT NULL ,  -- 적용일자
  RAEPNO      CHAR(6)       CCSID 833 NOT NULL ,  -- 입력자
  RAIPAD      VARCHAR(15)   CCSID 933 NOT NULL ,  -- IP ADDRESS
  RASYDT      CHAR(8)       CCSID 833 NOT NULL ,  -- 입력일자
  RAINEMP     VARCHAR(6)    CCSID 933 NOT NULL ,  -- 담당자
  RAINCHK     CHAR(1)       CCSID 833 NOT NULL ,  -- 담당자승인여부
  RAINTIME    VARCHAR(19)   CCSID 933 NOT NULL ,  -- 담당자승인시간
  RAPLEMP     VARCHAR(6)    CCSID 933 NOT NULL ,  -- P/L
  RAPLCHK     CHAR(1)       CCSID 833 NOT NULL ,  -- P/L 승인여부
  RAPLTIME    VARCHAR(19)   CCSID 933 NOT NULL ,  -- P/L 승인시간
  RADLEMP     VARCHAR(6)    CCSID 933 NOT NULL ,  -- 팀장
  RADLCHK     CHAR(1)       CCSID 833 NOT NULL ,  -- 팀장승인여부
  RADLTIME    VARCHAR(19)   CCSID 933 NOT NULL ,  -- 팀장승인시간
  RAFLAG      CHAR(1)       CCSID 833 NOT NULL ,  -- 입력구분 A, R
  PRIMARY KEY( RACMCD, RAPLANT, RADVSN, RAITNO, RAITNO1) ) ;
