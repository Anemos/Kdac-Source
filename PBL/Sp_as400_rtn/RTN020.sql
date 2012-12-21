--  Author                      김기섭
--  Description                 서브출하품 등록
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE TABLE PBRTN.RTN020 (
  RCMCD      CHAR(2)       NOT NULL , -- 회사
  RPLANT     CHAR(1)       NOT NULL , -- 지역
  RDVSN      CHAR(1)       NOT NULL , -- 공장
  RITNO      VARCHAR(15)   NOT NULL , -- Sub출하품
  REPNO      CHAR(6)       NOT NULL , -- 입력자
  RIPAD      VARCHAR(15)   NOT NULL , -- IP ADDRESS
  RSYDT      CHAR(8)       NOT NULL , -- 입력일자
  PRIMARY KEY( RCMCD , RPLANT , RDVSN , RITNO )
  ) ;