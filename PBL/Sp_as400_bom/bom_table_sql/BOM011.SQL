--  Generate SQL
--  Version:                    V5R3M0 040528
--  Generated on:               10/11/16 10:52:12
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries
--  Description : BOM 공장지역 담당간 변환정보

CREATE TABLE PBPDM.BOM011 (
  CMCD CHAR(2) CCSID 833 NOT NULL ,
  GUBUN CHAR(1) CCSID 833 NOT NULL ,
  BPLANT CHAR(1) CCSID 833 NOT NULL ,
  BDIV CHAR(1) CCSID 833 NOT NULL ,
  ADIV CHAR(1) CCSID 833 NOT NULL ,
  AREA CHAR(1) CCSID 833 NOT NULL ,
  INPTID CHAR(6) CCSID 933 NOT NULL ,
  INPTDT CHAR(8) CCSID 933 NOT NULL ,
  PRIMARY KEY( CMCD , GUBUN , BPLANT , BDIV , ADIV ) ) ;