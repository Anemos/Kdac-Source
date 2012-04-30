--  Generate SQL
--  Version:                    V5R3M0 040528
--  Generated on:               10/11/16 10:35:29
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSerie
--  Description : BOM royalty대상소재（내자)

CREATE TABLE PBPDM.BOM007 (
  KRYCMCD CHAR(2) CCSID 833 NOT NULL DEFAULT '' ,   -- 회사
  KRYPLANT CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,  -- 지역
  KRYDVSN CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,   -- 공장
  KRYITNO CHAR(15) CCSID 833 NOT NULL DEFAULT '' ,  -- 공제대상자재
  KRYPDCD CHAR(4) CCSID 833 NOT NULL DEFAULT '' ,   -- 제품군
  KRYFROMDT CHAR(8) CCSID 833 NOT NULL DEFAULT '' , -- 적용일
  KRYTODT CHAR(8) CCSID 833 NOT NULL DEFAULT '' ,   -- 완료일
  KRYCUST CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,   -- 공제대상업체
  KRYUPID CHAR(6) CCSID 833 NOT NULL DEFAULT '' ,   -- 사번
  KRYIPAD CHAR(15) CCSID 833 NOT NULL DEFAULT '' ,  -- ip address
  KRYUPDT CHAR(8) CCSID 833 NOT NULL DEFAULT '' ,   -- 등록일
  PRIMARY KEY( KRYCMCD , KRYPLANT , KRYDVSN , KRYITNO ) ) ;
  
