--  Author                      김기섭
--  Description                 공정별 부대작업정보
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries
DROP TABLE PBRTN.RTN014;
CREATE TABLE PBRTN.RTN014 (
  RDLOGID     INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1, NO CACHE),
  RDCMCD      CHAR(2)       CCSID 833 NOT NULL , -- 회사
  RDPLANT     CHAR(1)       CCSID 833 NOT NULL , -- 지역
  RDDVSN      CHAR(1)       CCSID 833 NOT NULL , -- 공장
  RDITNO      VARCHAR(12)   CCSID 933 NOT NULL , -- 품번
  RDLINE1     VARCHAR(7)    CCSID 933 NOT NULL , -- 대체라인코드
  RDLINE2     CHAR(1)       CCSID 833 NOT NULL , -- 대체라인넘버
  RDOPNO      VARCHAR(7)    CCSID 933 NOT NULL , -- 공정번호
  RDNVMO      CHAR(2)       CCSID 833 NOT NULL , -- 유형
  RDMCNO      CHAR(1)       CCSID 833 NOT NULL , -- 구분
  RDTERM      CHAR(1)       CCSID 833 NOT NULL , -- 빈도
  RDMCTM      DECIMAL(7, 4)           NOT NULL , -- 기계작업(초)
  RDLBTM      DECIMAL(7, 4)           NOT NULL , -- 수작업(초)
  RDREMK      VARCHAR(240)  CCSID 933 NOT NULL , -- 비고
  RDFLAG      CHAR(1)       CCSID 833 NOT NULL , -- 입력구분
  RDEPNO      CHAR(6)       CCSID 933 NOT NULL , -- 등록자
  RDEDFM      CHAR(8)       CCSID 933 NOT NULL , -- 적용일
  RDIPAD      VARCHAR(15)   CCSID 933 NOT NULL , -- IP ADDRESS
  RDUPDT      CHAR(8)       CCSID 933 NOT NULL , -- 수정일
  RDSYDT      CHAR(8)       CCSID 933 NOT NULL ,  -- 등록일
  PRIMARY KEY( RDLOGID )
  ) ;