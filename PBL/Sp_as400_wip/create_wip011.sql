--  Generate SQL 
--  Version:                   	V5R3M0 040528 
--  Generated on:              	08/08/14 12:12:07 
--  Relational Database:       	I520 
--  Standards Option:          	DB2 UDB iSeries 
  
CREATE TABLE PBWIP.WIP011 ( 
	WJYEAR CHAR(4) CCSID 933 NOT NULL , 
	WJMONTH CHAR(2) CCSID 833 NOT NULL , 
	WJCMCD CHAR(2) CCSID 833 NOT NULL , 
	WJPLANT CHAR(1) CCSID 833 NOT NULL , 
	WJDVSN CHAR(1) CCSID 833 NOT NULL , 
	WJDEPT CHAR(4) CCSID 933 NOT NULL , 
	WJITNO CHAR(15) CCSID 933 NOT NULL , 
	PRIMARY KEY( WJYEAR , WJMONTH , WJCMCD , WJPLANT , WJDVSN , WJDEPT , WJITNO ) ) ;