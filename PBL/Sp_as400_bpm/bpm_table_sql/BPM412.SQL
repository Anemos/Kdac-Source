--  Generate SQL 
--  Version:                   	V5R3M0 040528 
--  Generated on:              	09/06/02 15:07:34 
--  Relational Database:       	I520 
--  Standards Option:          	DB2 UDB iSeries 
--  재료비 통화단위 정보

DROP TABLE PBBPM.BPM412;

CREATE TABLE PBBPM.BPM412 ( 
	COMLTD CHAR(2) CCSID 833 NOT NULL ,           --회사
	SEQNO CHAR(2) CCSID 833 NOT NULL ,            --필드순번
	CURUNIT CHAR(3) CCSID 833 NOT NULL ,          --통화단위
	LASTEMP CHAR(6) CCSID 833 NOT NULL ,          --최종수정자
	LASTDATE VARCHAR(19) CCSID 833 NOT NULL ,     --최종수정일시
	PRIMARY KEY( COMLTD , CURUNIT ) ) ;