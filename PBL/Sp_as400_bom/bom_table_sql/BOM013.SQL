--  Generate SQL
--  Version:                    V5R3M0 040528
--  Generated on:               10/11/16 10:56:24
--  Relational Database:        I520
--  Standards Option:           DB2 UDB iSeries
--  Description : BOM 공장별원단위 정보

CREATE TABLE PBPDM.BOM013 (
  ZCMCD CHAR(2) CCSID 833 NOT NULL DEFAULT '' ,     -- 회사
  ZDATE CHAR(6) CCSID 833 NOT NULL DEFAULT '' ,     -- 년월
  ZPLANT CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,    -- 지역
  ZDIV CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,      -- 공장
  ZMDCD CHAR(4) CCSID 833 NOT NULL DEFAULT '' ,     -- 제품군
  ZMDNO CHAR(12) CCSID 833 NOT NULL DEFAULT '' ,    -- 완제품
  ZSERIAL NUMERIC(4, 0) NOT NULL DEFAULT 0 ,        -- Serial No
  ZLEVEL CHAR(10) CCSID 833 NOT NULL DEFAULT '' ,   -- Level
  ZITNO CHAR(12) CCSID 833 NOT NULL DEFAULT '' ,    -- 품번
  ZREV CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,      -- Revision No
  ZDESC CHAR(50) CCSID 933 NOT NULL DEFAULT '' ,    -- 품명
  ZSPEC CHAR(50) CCSID 933 NOT NULL DEFAULT '' ,    -- 규격
  ZUNIT1 CHAR(2) CCSID 833 NOT NULL DEFAULT '' ,    -- BOM단위
  ZUNITQTY CHAR(12) CCSID 833 NOT NULL DEFAULT '' , -- 원단위량
  ZCVTFACT CHAR(12) CCSID 833 NOT NULL DEFAULT '' , -- 변환계수
  ZUNIT2 CHAR(2) CCSID 833 NOT NULL DEFAULT '' ,    -- 자재단위
  ZSRCE CHAR(2) CCSID 833 NOT NULL DEFAULT '' ,     -- 구입선
  ZABCCODE CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,  -- ABC 코드
  ZISSCODE CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,  -- 불출코드
  ZWHLCODE CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,  -- 창고코드
  ZLOTSIZE CHAR(5) CCSID 833 NOT NULL DEFAULT '' ,  -- Lot Size
  ZLEADTIME CHAR(3) CCSID 833 NOT NULL DEFAULT '' , -- Lead Time
  ZMOVCOST CHAR(20) CCSID 833 NOT NULL DEFAULT '' , -- 불출평균단가
  ZRCPCOST CHAR(20) CCSID 833 NOT NULL DEFAULT '' , -- 최종입고단가
  ZWKCT CHAR(4) CCSID 833 NOT NULL DEFAULT '' ,     -- 조코드
  ZGRAD CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,     -- 호환여부
  ZALTNO CHAR(12) CCSID 833 NOT NULL DEFAULT '' ,   -- 호환품번
  ZFMDT CHAR(8) CCSID 833 NOT NULL DEFAULT '' ,     -- 적용시작일
  ZTODT CHAR(8) CCSID 833 NOT NULL DEFAULT '' ,     -- 적용완료일
  ZCALC CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,     -- 재료비여부
  ZCOMCD CHAR(1) CCSID 833 NOT NULL DEFAULT ' ' ,   -- 고객사유상여부
  PRIMARY KEY( ZCMCD , ZDATE , ZPLANT , ZDIV , ZMDCD , ZMDNO , ZSERIAL ) ) ;
  
