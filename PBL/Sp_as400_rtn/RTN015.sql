--  Author                      김기섭
--  Description                 공정별 세부정보[확정]
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries
--  Desc : 전력비추가 (2012.10.15)

CREATE TABLE PBRTN.RTN015 (
  RECMCD      CHAR(2)       CCSID 833 NOT NULL , -- 회사
  REPLANT     CHAR(1)       CCSID 833 NOT NULL , -- 지역
  REDVSN      CHAR(1)       CCSID 833 NOT NULL , -- 공장
  REITNO      VARCHAR(12)   CCSID 933 NOT NULL , -- 품번
  RELINE1     VARCHAR(7)    CCSID 933 NOT NULL , -- 대체라인코드
  RELINE2     CHAR(1)       CCSID 833 NOT NULL , -- 대체라인넘버
  REOPNO      VARCHAR(7)    CCSID 933 NOT NULL , -- 공정번호
  REEDFM      CHAR(8)       CCSID 933 NOT NULL , -- 적용일
  REEDTO      CHAR(8)       CCSID 933 NOT NULL , -- 완료일
  REOPNM      VARCHAR(50)   CCSID 933 NOT NULL , -- 공정명
  REOPSQ      NUMERIC(3, 0)           NOT NULL , -- 공정순서
  RELINE3     VARCHAR(5)    CCSID 933 NOT NULL , -- 조
  REGRDE      CHAR(1)       CCSID 833 NOT NULL , -- GRADE
  REMCYN      CHAR(1)       CCSID 833 NOT NULL , -- 장비유무
  REBMTM      DECIMAL(7, 4)           NOT NULL , -- 기본 기계작업
  REBLTM      DECIMAL(7, 4)           NOT NULL , -- 기본 수작업
  REBSTM      DECIMAL(7, 4)           NOT NULL , -- 기본 기본작업
  RENVCD      CHAR(1)       CCSID 833 NOT NULL , -- 부대작업 유무
  RENVMC      DECIMAL(7, 4)           NOT NULL , -- 부대 기계작업
  RENVLB      DECIMAL(7, 4)           NOT NULL , -- 부대 수작업
  RELBCNT     NUMERIC(3, 0)           NOT NULL , -- 인원
  REFLAG      CHAR(1)       CCSID 833 NOT NULL , -- 입력구분
  REEPNO      VARCHAR(6)    CCSID 933 NOT NULL , -- 등록자
  REIPAD      VARCHAR(15)   CCSID 933 NOT NULL , -- IP ADDRESS
  REUPDT      CHAR(8)       CCSID 833 NOT NULL , -- 수정일
  RESYDT      CHAR(8)       CCSID 833 NOT NULL , -- 등록일
  REINEMP     VARCHAR(6)    CCSID 933 NOT NULL , -- 담당자
  REINCHK     CHAR(1)       CCSID 833 NOT NULL , -- 담당자승인여부
  REINTIME    VARCHAR(19)   CCSID 933 NOT NULL , -- 담당자승인시간
  REPLEMP     VARCHAR(6)    CCSID 933 NOT NULL , -- P/L
  REPLCHK     CHAR(1)       CCSID 833 NOT NULL , -- P/L 승인여부
  REPLTIME    VARCHAR(19)   CCSID 933 NOT NULL , -- P/L 승인시간
  REDLEMP     VARCHAR(6)    CCSID 933 NOT NULL , -- 팀장
  REDLCHK     CHAR(1)       CCSID 833 NOT NULL , -- 팀장승인여부
  REDLTIME    VARCHAR(19)   CCSID 933 NOT NULL , -- 팀장승인시간
  REPOWER     NUMERIC(10,5) CCSID 833 NOT NULL DEFAULT 0, -- 전력비(KW/EA)
  PRIMARY KEY( RECMCD , REPLANT , REDVSN , REITNO , RELINE1 , RELINE2 , REOPNO , REEDFM )
  ) ;
  
ALTER TABLE PBRTN.RTN015
ADD COLUMN REPOWER DECIMAL(10, 5) NOT NULL DEFAULT 0.00000;