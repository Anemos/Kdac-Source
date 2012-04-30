--  Generate SQL
--  Version:                    V5R3M0 040528
--  Generated on:               10/11/16 11:13:04
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries
--  Description : BOM 승인/결재자 정보

CREATE TABLE PBPDM.BOM018 (
  XCMCD CHAR(2) CCSID 833 NOT NULL DEFAULT '' ,
  XINEMP CHAR(6) CCSID 933 NOT NULL DEFAULT '' ,
  XPLEMP CHAR(6) CCSID 933 NOT NULL DEFAULT '' ,
  XMACADDR CHAR(30) CCSID 933 NOT NULL DEFAULT '' ,
  XIPADDR CHAR(30) CCSID 933 NOT NULL DEFAULT '' ,
  XINDT CHAR(8) CCSID 933 NOT NULL DEFAULT '' ,
  PRIMARY KEY( XCMCD , XINEMP ) ) ;