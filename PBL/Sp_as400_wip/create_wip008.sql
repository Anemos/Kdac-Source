--  Generate SQL 
--  Version:                   	V5R3M0 040528 
--  Generated on:              	08/08/14 12:10:04 
--  Relational Database:       	I520 
--  Standards Option:          	DB2 UDB iSeries 
  
CREATE TABLE PBWIP.WIP008 ( 
	WFCMCD CHAR(2) CCSID 833 NOT NULL , 
	WFYEAR CHAR(4) CCSID 933 NOT NULL , 
	WFPART CHAR(1) CCSID 833 NOT NULL , 
	WFSERL CHAR(5) CCSID 933 NOT NULL , 
	WFPAGE CHAR(1) CCSID 833 NOT NULL , 
	WFPLANT CHAR(1) CCSID 833 NOT NULL , 
	WFDVSN CHAR(1) CCSID 833 NOT NULL , 
	WFVSRNO CHAR(5) CCSID 933 NOT NULL , 
	WFVNDR CHAR(10) CCSID 933 NOT NULL , 
	WFVNDNM CHAR(30) CCSID 933 NOT NULL , 
	WFADDR CHAR(100) CCSID 933 NOT NULL , 
	WFPRNM CHAR(20) CCSID 933 NOT NULL , 
	WFITNO CHAR(15) CCSID 933 NOT NULL , 
	WFITNM CHAR(50) CCSID 933 NOT NULL , 
	WFUNIT CHAR(2) CCSID 833 NOT NULL , 
	WFSCRP DECIMAL(5, 2) NOT NULL , 
	WFRETN DECIMAL(5, 2) NOT NULL , 
	WFBGQT DECIMAL(15, 4) NOT NULL , 
	WFINQT DECIMAL(15, 4) NOT NULL , 
	WFUSQT2 DECIMAL(15, 4) NOT NULL , 
	WFUSQT7 DECIMAL(15, 4) NOT NULL , 
	WFOHQT DECIMAL(15, 4) NOT NULL , 
	WFINPTID CHAR(6) CCSID 933 NOT NULL , 
	WFINPTDT CHAR(8) CCSID 933 NOT NULL , 
	CONSTRAINT PBWIP.Q_PBWIP_WIP008_WFCMCD_00001 PRIMARY KEY( WFCMCD , WFYEAR , WFPART , WFPLANT , WFDVSN , WFVSRNO , WFITNO ) ) ;