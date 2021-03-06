--  Generate SQL 
--  Version:                   	V5R3M0 040528 
--  Generated on:              	09/05/20 16:11:33 
--  Relational Database:       	I520 
--  Standards Option:          	DB2 UDB iSeries 
--  사업계획 BOM정보

DROP TABLE PBBPM.BPM504;

CREATE TABLE PBBPM.BPM504 ( 
	PCMCD CHAR(2) CCSID 833 NOT NULL ,    -- 회사
  XYEAR CHAR(4) CCSID 933 NOT NULL ,    -- 해당년도
  REVNO CHAR(2) CCSID 833 NOT NULL ,    -- 버전
	PLANT CHAR(1) CCSID 833 NOT NULL ,    -- 지역
	PDVSN CHAR(1) CCSID 833 NOT NULL ,    -- 공장
	PPITN CHAR(15) CCSID 933 NOT NULL ,   -- 상위품번
	PROUT CHAR(4) CCSID 933 NOT NULL ,    -- ROUTING
	PCITN CHAR(15) CCSID 933 NOT NULL ,   -- 하위품번
	PCHDT CHAR(8) CCSID 933 NOT NULL ,    -- 수정일자
	PQTYM NUMERIC(8, 3) NOT NULL ,        -- 원단위수량(생산)
	PQTYE NUMERIC(8, 3) NOT NULL ,        -- 원단위수량(E-BOM)
	PWKCT CHAR(4) CCSID 933 NOT NULL ,    -- WORK CENTER
	PEDTM CHAR(8) CCSID 933 NOT NULL ,    -- 적용시작일자
	PEDTE CHAR(8) CCSID 933 NOT NULL ,    -- 적용완료일자
	POPCD CHAR(1) CCSID 833 NOT NULL ,    -- 호환체크코드 * : 호환품목
	PEXPLANT CHAR(1) CCSID 833 NOT NULL , -- 이체지역
	PEXDV CHAR(1) CCSID 833 NOT NULL ,    -- 이체공장
	PCHCD CHAR(1) CCSID 833 NOT NULL ,    -- 변경코드 C,A,D
	POSCD CHAR(1) CCSID 833 NOT NULL ,    -- 사급코드 1:유상, 2:무상
	PEBST CHAR(1) CCSID 833 NOT NULL ,    -- E-BOM관련코드 1:존재
	PMACADDR CHAR(30) CCSID 933 NOT NULL , 
	PIPADDR CHAR(30) CCSID 933 NOT NULL , 
	PINDT CHAR(8) CCSID 933 NOT NULL , 
	PEMNO CHAR(6) CCSID 933 NOT NULL , 
	PREMK CHAR(20) CCSID 933 NOT NULL , 
	PRIMARY KEY( PCMCD , XYEAR, REVNO, PLANT , PDVSN , PPITN , PROUT , PCITN , PCHDT ) ) ;
	
--  Generate SQL
--  Version:                    V5R3M0 040528
--  Generated on:               10/08/19 16:49:35
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE INDEX PBBPM.BPM504L01
  ON PBBPM.BPM504 ( XYEAR ASC , REVNO ASC , PLANT ASC , PDVSN ASC , PCITN ASC , PPITN ASC ) ;

CREATE INDEX PBBPM.BPM504L02
  ON PBBPM.BPM504 ( XYEAR ASC , REVNO ASC , PLANT ASC , PDVSN ASC , PCITN ASC ) ;

CREATE UNIQUE INDEX PBBPM.BPM504L03
  ON PBBPM.BPM504 ( XYEAR ASC , REVNO ASC , PLANT ASC , PDVSN ASC , PPITN ASC , PCITN ASC , PROUT ASC , PCHDT ASC ) ;

CREATE INDEX PBBPM.BPM504L04
  ON PBBPM.BPM504 ( XYEAR ASC , REVNO ASC , PCITN ASC , PPITN ASC ) ;

CREATE INDEX PBBPM.BPM504L05
  ON PBBPM.BPM504 ( XYEAR ASC , REVNO ASC , PPITN ASC , PCITN ASC ) ;
  
INSERT INTO PBBPM.BPM504
( PCMCD,XYEAR,REVNO,PLANT,PDVSN,PPITN,PROUT,PCITN,
PCHDT,PQTYM,PQTYE,PWKCT,PEDTM,PEDTE,POPCD,PEXPLANT,PEXDV,
PCHCD,POSCD,PEBST,PMACADDR,PIPADDR,PINDT,PEMNO,PREMK )
SELECT PCMCD,XYEAR,CASE WHEN XYEAR = '2010' THEN '0D' ELSE '0A' END,PLANT,PDVSN,PPITN,PROUT,PCITN,
PCHDT,PQTYM,PQTYE,PWKCT,PEDTM,PEDTE,POPCD,PEXPLANT,PEXDV,
PCHCD,POSCD,PEBST,PMACADDR,PIPADDR,PINDT,PEMNO,PREMK
FROM PBTEST.BPM504

INSERT INTO PBBPM.BPM504
( PCMCD,XYEAR,REVNO,PLANT,PDVSN,PPITN,PROUT,PCITN,
PCHDT,PQTYM,PQTYE,PWKCT,PEDTM,PEDTE,POPCD,PEXPLANT,PEXDV,
PCHCD,POSCD,PEBST,PMACADDR,PIPADDR,PINDT,PEMNO,PREMK )
SELECT PCMCD,XYEAR,'0A',PLANT,PDVSN,PPITN,PROUT,PCITN,
PCHDT,PQTYM,PQTYE,PWKCT,PEDTM,PEDTE,POPCD,PEXPLANT,PEXDV,
PCHCD,POSCD,PEBST,PMACADDR,PIPADDR,PINDT,PEMNO,PREMK
FROM PBBPM.BPM504_0A WHERE XYEAR = '2010'
