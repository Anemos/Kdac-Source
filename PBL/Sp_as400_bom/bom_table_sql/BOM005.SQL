--  Generate SQL
--  Version:                    V5R3M0 040528
--  Generated on:               10/11/16 10:27:56
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries
--  Description : BOM 로얄티 계산정보

CREATE TABLE PBPDM.BOM005 (
  RECMCD CHAR(2) CCSID 833 NOT NULL DEFAULT '' ,  -- 회사
  REYYMM CHAR(6) CCSID 833 NOT NULL DEFAULT '' ,  -- 년월
  RECUST CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,  -- 공제대상업체
  REPLANT CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,  -- 지역
  REDVSN CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,   -- 공장
  REPITN CHAR(15) CCSID 833 NOT NULL DEFAULT '' ,   -- Model No
  RECITN CHAR(15) CCSID 833 NOT NULL DEFAULT '' ,   -- 자재품번
  REPQTY DECIMAL(9, 3) NOT NULL DEFAULT 0 ,         -- 원단위량
  RELEVL DECIMAL(3, 0) NOT NULL DEFAULT 0 ,         -- Level No
  REEXPLANT CHAR(1) CCSID 833 NOT NULL DEFAULT '' , -- 이체지역
  REEXDV CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,    -- 이체공장
  PRIMARY KEY( RECMCD , REYYMM , RECUST , REPLANT , REDVSN , REPITN , RECITN ) ) ;

