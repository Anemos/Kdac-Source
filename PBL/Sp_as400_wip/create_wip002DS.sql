--  Generate SQL
--  Version:                    V5R3M0 040528
--  Generated on:               08/08/14 12:06:59
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

--  Generate SQL
--  Version:                    V5R3M0 040528
--  Generated on:               08/08/14 12:05:29
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

DROP TABLE PBWIP.WIP002DS;
CREATE TABLE PBWIP.WIP002DS (
  WBCMCD CHAR(2) CCSID 833 NOT NULL ,
  WBYYMMDD CHAR(8) CCSID 833 NOT NULL ,
  WBPLANT CHAR(1) CCSID 833 NOT NULL ,
  WBDVSN CHAR(1) CCSID 833 NOT NULL ,
  WBORCT CHAR(5) CCSID 933 NOT NULL ,
  WBITNO CHAR(15) CCSID 933 NOT NULL ,
  WBIOCD CHAR(1) CCSID 833 NOT NULL ,
  WBPDCD CHAR(2) CCSID 833 NOT NULL ,
  WBOHQT DECIMAL(15, 4) NOT NULL ,
  WBOHAT1 DECIMAL(15, 0) NOT NULL ,     -- ������
  WBOHAT2 DECIMAL(15, 0) NOT NULL ,     -- ������
  WBOHAT3 DECIMAL(15, 0) NOT NULL ,     -- ������
  WBOHAT4 DECIMAL(15, 0) NOT NULL ,     -- ��ü������
  WBOHAT5 DECIMAL(15, 0) NOT NULL ,     -- ��ü������
  WBOHAT6 DECIMAL(15, 0) NOT NULL ,     -- ��ü������
  WBINPTDT CHAR(8) CCSID 933 NOT NULL ,
  WBUPDTDT CHAR(19) CCSID 933 NOT NULL ,
  PRIMARY KEY( WBCMCD , WBYYMMDD , WBPLANT , WBDVSN , WBORCT , WBITNO , WBIOCD ) ) ;