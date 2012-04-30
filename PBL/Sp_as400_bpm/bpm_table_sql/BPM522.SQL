--  Generate SQL 
--  Version:                   	V5R3M0 040528 
--  Generated on:              	09/06/02 15:07:34 
--  Relational Database:       	I520 
--  Standards Option:          	DB2 UDB iSeries 
--  사업계획 버전별 이력정보

DROP TABLE PBBPM.BPM522;

CREATE TABLE PBBPM.BPM522 ( 
	COMLTD CHAR(2) CCSID 833 NOT NULL ,           --회사
	XYEAR CHAR(4) CCSID 833 NOT NULL ,            --년도
	REVNO CHAR(2) CCSID 833 NOT NULL ,            --버전
	TASKNAME VARCHAR(250) CCSID 933 NOT NULL ,    --작업명
	LASTEMP CHAR(6) CCSID 833 NOT NULL ,          --최종수정자
	LASTDATE VARCHAR(19) CCSID 833 NOT NULL ,     --최종수정일시
	PRIMARY KEY( COMLTD , XYEAR, REVNO ) ) ;
	
INSERT INTO PBBPM.BPM522
( COMLTD,XYEAR,REVNO,TASKNAME,LASTEMP,LASTDATE )
VALUES('01','2012','0Z','2011.11.12 임원회의 기준(본관2층 회의실)','000030','');

INSERT INTO PBBPM.BPM522
( COMLTD,XYEAR,REVNO,TASKNAME,LASTEMP,LASTDATE )
VALUES('01','2012','0Y','2011.11.24 가야산 W/Shop기준','000030','');