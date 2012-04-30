--  Generate SQL
--  Version:                    V5R3M0 040528
--  Generated on:               10/11/16 11:03:00
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries
--  Description : 

CREATE TABLE PBPDM.BOM014 (
  COMLTD CHAR(2) CCSID 833 NOT NULL ,
  EMPNO CHAR(6) CCSID 933 NOT NULL ,
  WORKCENTER CHAR(4) CCSID 933 NOT NULL ,
  INPTID CHAR(6) CCSID 933 NOT NULL ,
  INPTDT CHAR(8) CCSID 933 NOT NULL ,
  PRIMARY KEY( COMLTD , EMPNO , WORKCENTER ) ) ;