--  Author                      김기섭
--  Description                 라우팅 세부정보 이력
--  Version:                    V5R3M0 040528
--  Generated on:               08/07/15
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries

CREATE TABLE PBRTN.RTN013 (
  RCCMCD      CHAR(2)       CCSID 833 NOT NULL , -- 회사
  RCPLANT     CHAR(1)       CCSID 833 NOT NULL , -- 지역
  RCDVSN      CHAR(1)       CCSID 833 NOT NULL , -- 공장
  RCITNO      VARCHAR(12)   CCSID 933 NOT NULL , -- 품번
  RCLINE1     VARCHAR(7)    CCSID 933 NOT NULL , -- 대체라인코드
  RCLINE2     CHAR(1)       CCSID 833 NOT NULL , -- 대체라인넘버
  RCOPNO      VARCHAR(7)    CCSID 933 NOT NULL , -- 공정번호
  RCCHTIME    VARCHAR(19)   CCSID 933 NOT NULL , -- 변경시간
  RCEDFM      CHAR(8)       CCSID 833 NOT NULL , -- 적용일
  RCOPNM      VARCHAR(50)   CCSID 933 NOT NULL , -- 공정명
  RCOPSQ      NUMERIC(3, 0)           NOT NULL , -- 공정순서
  RCLINE3     VARCHAR(5)    CCSID 933 NOT NULL , -- 조
  RCGRDE      CHAR(1)       CCSID 833 NOT NULL , -- 등급 주A,부B
  RCMCYN      CHAR(1)       CCSID 833 NOT NULL , -- 장비유무 유Y, 무N
  RCBMTM      DECIMAL(7, 4)           NOT NULL , -- 기본기계작업시간
  RCBLTM      DECIMAL(7, 4)           NOT NULL , -- 기본수작업시간
  RCBSTM      DECIMAL(7, 4)           NOT NULL , -- 기본작업시간
  RCNVCD      CHAR(1)       CCSID 833 NOT NULL , -- 부대작업유무 유Y,무N
  RCNVMC      DECIMAL(7, 4)           NOT NULL , -- 부대기계작업
  RCNVLB      DECIMAL(7, 4)           NOT NULL , -- 부대수작업
  RCLBCNT     NUMERIC(3, 0)           NOT NULL , -- 인원
  RCFLAG      CHAR(1)       CCSID 833 NOT NULL , -- 입력구분
  RCEPNO      VARCHAR(6)    CCSID 933 NOT NULL , -- 등록자
  RCIPAD      VARCHAR(15)   CCSID 933 NOT NULL , -- IP ADDRESS
  RCUPDT      CHAR(8)       CCSID 833 NOT NULL , -- 수정일
  RCSYDT      CHAR(8)       CCSID 833 NOT NULL , -- 등록일
  RCINEMP     VARCHAR(6)    CCSID 933 NOT NULL , -- 담당자
  RCINCHK     CHAR(1)       CCSID 833 NOT NULL , -- 담당자승인여부
  RCINTIME    VARCHAR(19)   CCSID 933 NOT NULL , -- 담당자승인시간
  RCPLEMP     VARCHAR(6)    CCSID 933 NOT NULL , -- P/L
  RCPLCHK     CHAR(1)       CCSID 833 NOT NULL , -- P/L 승인여부
  RCPLTIME    VARCHAR(19)   CCSID 933 NOT NULL , -- P/L 승인시간
  RCDLEMP     VARCHAR(6)    CCSID 933 NOT NULL , -- 팀장
  RCDLCHK     CHAR(1)       CCSID 833 NOT NULL , -- 팀장승인여부
  RCDLTIME    VARCHAR(19)   CCSID 933 NOT NULL , -- 팀장승인시간
  RCPOWER     NUMERIC(10,5) CCSID 833 NOT NULL DEFAULT 0, -- 전력비(KW/EA)
  PRIMARY KEY( RCCMCD , RCPLANT , RCDVSN , RCITNO , RCLINE1 , RCLINE2 , RCOPNO ) ) ;
  
ALTER TABLE PBRTN.RTN013
ADD COLUMN RCPOWER DECIMAL(10, 5) NOT NULL DEFAULT 0.00000;