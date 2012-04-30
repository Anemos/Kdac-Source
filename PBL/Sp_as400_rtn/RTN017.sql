--  Author                      김기섭
--  Description                 공정별 장비현황정보
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE TABLE PBRTN.RTN017 (
  RGCMCD      CHAR(2)       CCSID 833 NOT NULL , -- 회사
  RGPLANT     CHAR(1)       CCSID 833 NOT NULL , -- 지역
  RGDVSN      CHAR(1)       CCSID 833 NOT NULL , -- 공장
  RGITNO      VARCHAR(12)   CCSID 933 NOT NULL , -- 품번
  RGLINE1     VARCHAR(7)    CCSID 933 NOT NULL , -- 대체라인코드
  RGLINE2     CHAR(1)       CCSID 833 NOT NULL , -- 대체라인넘버
  RGOPNO      VARCHAR(7)    CCSID 933 NOT NULL , -- 공정번호
  RGMCNO      VARCHAR(10)   CCSID 933 NOT NULL , -- 장비번호
  RGEDFM      VARCHAR(8)    CCSID 933 NOT NULL , -- 적용일
  RGFLAG      CHAR(1)       CCSID 833 NOT NULL , -- 입력구분
  RGEPNO      VARCHAR(6)    CCSID 933 NOT NULL , -- 등록자
  RGIPAD      VARCHAR(15)   CCSID 933 NOT NULL , -- IP ADDRESS
  RGUPDT      CHAR(8)       CCSID 933 NOT NULL , -- 수정일
  RGSYDT      CHAR(8)       CCSID 933 NOT NULL , -- 등록일
  PRIMARY KEY( RGCMCD , RGPLANT , RGDVSN , RGITNO , RGLINE1 , RGLINE2 , RGOPNO , RGMCNO )
  ) ;