--  Generate SQL
--  Version:                    V5R3M0 040528
--  Generated on:               10/11/16 10:37:59
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries
--  Description : BOM 월별Royalty공제　단위당재료비

CREATE TABLE PBPDM.BOM008 (
  RCMCD CHAR(2) CCSID 833 NOT NULL DEFAULT '' ,   -- 회사
  RYEAR CHAR(4) CCSID 833 NOT NULL DEFAULT '' ,   -- 년도
  RMONTH CHAR(2) CCSID 833 NOT NULL DEFAULT '' ,  -- 월
  RCUST CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,   -- 고객사
  RDIV CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,    -- 공장
  RMDNO CHAR(12) CCSID 833 NOT NULL DEFAULT '' ,  -- 제품번호
  RCOST DECIMAL(9, 1) NOT NULL DEFAULT 0 ,        -- 단가
  PRIMARY KEY( RCMCD , RYEAR , RMONTH , RCUST , RDIV , RMDNO ) ) ;
