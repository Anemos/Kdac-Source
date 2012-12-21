--  Author                      김기섭
--  Description                 대체라인마스타
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE TABLE PBRTN.RTN012 (
  RBCMCD      CHAR(2)       NOT NULL ,  -- 회사
  RBPLANT     CHAR(1)       NOT NULL ,  -- 지역
  RBDVSN      CHAR(1)       NOT NULL ,  -- 공장
  RBLINE1     VARCHAR(7)    NOT NULL ,  -- 대체라인코드
  RBLINE2     CHAR(1)       NOT NULL ,  -- 대체라인넘버
  RBLNMN      VARCHAR(50)   NOT NULL ,  -- 대체라인명
  RBLCTN      CHAR(1)       NOT NULL ,  -- 조립 A, 가공 M
  RBVEND      CHAR(1)       NOT NULL ,  -- 외주구분 사내 I, 사외 O
  RBFLAG      CHAR(1)       NOT NULL ,  -- 입력구분 입력 A, 수정 R
  RBEPNO      CHAR(6)       NOT NULL ,  -- 입력자
  RBIPAD      VARCHAR(15)   NOT NULL ,  -- IP ADDRESS
  RBUPDT      CHAR(8)       NOT NULL ,  -- 수정일자
  RBSYDT      CHAR(8)       NOT NULL ,  -- 입력일자
  RBOPTION    INT           NOT NULL DEFAULT 0 ,  -- 생산율(%)
  RBSUBCHK    CHAR(1)       NOT NULL DEFAULT 'N' , -- SUB출하품
  PRIMARY KEY( RBCMCD, RBPLANT, RBDVSN, RBLINE1, RBLINE2 ) ) ;
