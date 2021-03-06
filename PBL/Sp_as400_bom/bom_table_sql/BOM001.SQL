--  Generate SQL
--  Version:                    V5R3M0 040528
--  Generated on:               10/11/16 10:17:29
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries
--  Description : BOM �⺻����

CREATE TABLE PBPDM.BOM001 (
  PCMCD CHAR(2) CCSID 833 NOT NULL ,
  PLANT CHAR(1) CCSID 833 NOT NULL ,
  PDVSN CHAR(1) CCSID 833 NOT NULL ,
  PPITN CHAR(15) CCSID 933 NOT NULL ,
  PROUT CHAR(4) CCSID 933 NOT NULL ,
  PCITN CHAR(15) CCSID 933 NOT NULL ,
  PCHDT CHAR(8) CCSID 933 NOT NULL ,
  PQTYM NUMERIC(8, 3) NOT NULL ,
  PQTYE NUMERIC(8, 3) NOT NULL ,
  PWKCT CHAR(4) CCSID 933 NOT NULL ,
  PEDTM CHAR(8) CCSID 933 NOT NULL ,
  PEDTE CHAR(8) CCSID 933 NOT NULL ,
  POPCD CHAR(1) CCSID 833 NOT NULL ,
  PEXPLANT CHAR(1) CCSID 833 NOT NULL ,
  PEXDV CHAR(1) CCSID 833 NOT NULL ,
  PCHCD CHAR(1) CCSID 833 NOT NULL ,
  POSCD CHAR(1) CCSID 833 NOT NULL ,
  PEBST CHAR(1) CCSID 833 NOT NULL ,
  PMACADDR CHAR(30) CCSID 933 NOT NULL ,
  PIPADDR CHAR(30) CCSID 933 NOT NULL ,
  PINDT CHAR(8) CCSID 933 NOT NULL ,
  PEMNO CHAR(6) CCSID 933 NOT NULL ,
  PREMK CHAR(20) CCSID 933 NOT NULL ,
  PRIMARY KEY( PCMCD , PLANT , PDVSN , PPITN , PROUT , PCITN , PCHDT ) ) ;
  
CREATE INDEX PBPDM.BOM001L01
  ON PBPDM.BOM001 ( PLANT ASC , PDVSN ASC , PCITN ASC , PPITN ASC ) ;
CREATE INDEX PBPDM.BOM001L02
  ON PBPDM.BOM001 ( PLANT ASC , PDVSN ASC , PCITN ASC ) ;
CREATE UNIQUE INDEX PBPDM.BOM001L03
  ON PBPDM.BOM001 ( PLANT ASC , PDVSN ASC , PPITN ASC , PCITN ASC , PROUT ASC , PCHDT ASC ) ;
CREATE INDEX PBPDM.BOM001L04
  ON PBPDM.BOM001 ( PCITN ASC , PPITN ASC ) ;
CREATE INDEX PBPDM.BOM001L05
  ON PBPDM.BOM001 ( PPITN ASC , PCITN ASC ) ;