--  Generate SQL 
--  Version:                   	V5R3M0 040528 
--  Generated on:              	08/08/14 12:12:49 
--  Relational Database:       	I520 
--  Standards Option:          	DB2 UDB iSeries 
  
CREATE TABLE PBWIP.WIP013 ( 
	WBYEAR CHAR(4) CCSID 933 NOT NULL , 
	WBMONTH CHAR(2) CCSID 833 NOT NULL , 
	WBCMCD CHAR(2) CCSID 833 NOT NULL , 
	WBPLANT CHAR(1) CCSID 833 NOT NULL , 
	WBDVSN CHAR(1) CCSID 833 NOT NULL , 
	WBORCT CHAR(5) CCSID 933 NOT NULL , 
	WBITNO CHAR(15) CCSID 933 NOT NULL , 
	WBBGQT DECIMAL(15, 4) NOT NULL , 
	WBINQT DECIMAL(15, 4) NOT NULL , 
	WBUSQT1 DECIMAL(15, 4) NOT NULL , 
	WBUSQT2 DECIMAL(15, 4) NOT NULL , 
	WBUSQT3 DECIMAL(15, 4) NOT NULL , 
	WBUSQT4 DECIMAL(15, 4) NOT NULL , 
	WBUSQT5 DECIMAL(15, 4) NOT NULL , 
	WBUSQT6 DECIMAL(15, 4) NOT NULL , 
	WBUSQT7 DECIMAL(15, 4) NOT NULL , 
	WBUSQT8 DECIMAL(15, 4) NOT NULL , 
	WBOHQT DECIMAL(15, 4) NOT NULL , 
	CONSTRAINT PBWIP.Q_PBWIP_WIP013_WBYEAR_00001 PRIMARY KEY( WBYEAR , WBMONTH , WBCMCD , WBPLANT , WBDVSN , WBITNO , WBORCT ) ) ;