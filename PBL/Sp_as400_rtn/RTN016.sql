--  Author                      김기섭
--  Description                 유형별 부대작업 이력
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries
DROP TABLE PBRTN.RTN016;
CREATE TABLE PBRTN.RTN016 (
  RFLOGID     INTEGER                 NOT NULL ,
  RFCMCD      CHAR(2)       CCSID 833 NOT NULL , -- 회사
  RFPLANT     CHAR(1)       CCSID 833 NOT NULL , -- 지역
  RFDVSN      CHAR(1)       CCSID 833 NOT NULL , -- 공장
  RFITNO      VARCHAR(12)   CCSID 933 NOT NULL , -- 품번
  RFLINE1     VARCHAR(7)    CCSID 933 NOT NULL , -- 대체라인코드
  RFLINE2     CHAR(1)       CCSID 833 NOT NULL , -- 대체라인넘버
  RFOPNO      VARCHAR(7)    CCSID 933 NOT NULL , -- 공정번호
  RFNVMO      CHAR(2)       CCSID 833 NOT NULL , -- 유형
  RFMCNO      CHAR(1)       CCSID 833 NOT NULL , -- 구분
  RFTERM      CHAR(1)       CCSID 833 NOT NULL , -- 빈도
  RFEDFM      VARCHAR(8)    CCSID 933 NOT NULL , -- 적용일
  RFMCTM      DECIMAL(7, 4)           NOT NULL , -- 기계작업(초)
  RFLBTM      DECIMAL(7, 4)           NOT NULL , -- 수작업(초)
  RFREMK      VARCHAR(240)  CCSID 933 NOT NULL , -- 비고
  RFFLAG      CHAR(1)       CCSID 833 NOT NULL , -- 입력구분
  RFEPNO      VARCHAR(6)    CCSID 933 NOT NULL , -- 등록자
  RFEDTO      VARCHAR(8)    CCSID 933 NOT NULL , -- 완료일
  RFIPAD      VARCHAR(15)   CCSID 933 NOT NULL , -- IP ADDRESS
  RFUPDT      CHAR(8)       CCSID 933 NOT NULL , -- 수정일
  RFSYDT      CHAR(8)       CCSID 933 NOT NULL , -- 등록일
  PRIMARY KEY( RFLOGID , RFEDFM )
  ) ;