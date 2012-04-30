--  Generate SQL 
--  Version:                   	V5R3M0 040528 
--  Generated on:              	11/10/20 16:19:41 
--  Relational Database:       	I520 
--  Standards Option:          	DB2 UDB iSeries 
--  사업계획 원단위정보( 호환율, 누적호환율추가 )

DROP TABLE QTEMP.TMP_BPM;

CREATE TABLE QTEMP.TMP_BPM ( 
	TCMCD CHAR(2) CCSID 833 NOT NULL ,     --회사
	TPLNT CHAR(1) CCSID 833 NOT NULL ,  -- 지역
	TDVSN CHAR(2) CCSID 833 NOT NULL ,       --공장
	TMODL CHAR(15) CCSID 933 NOT NULL ,     --제품
	TOPTION CHAR(15) CCSID 933 NOT NULL ,     --호환주품번
	TLEVEL NUMERIC(2, 0) CCSID 833 NOT NULL ,       --레벨
	TPITN CHAR(15) CCSID 933 NOT NULL ,      --상위품번
	TCITN CHAR(15) CCSID 933 NOT NULL ,     --하위품번
	TQTYM NUMERIC(8, 3) NOT NULL ,         --원단위
	TQTY1 NUMERIC(8, 3) NOT NULL ,         --적용원단위
	TWKCT CHAR(4) CCSID 933 NOT NULL ,     --작업장
	TEDTM CHAR(8) CCSID 933 NOT NULL ,           --시작일자
	TEDTE CHAR(8) CCSID 933 NOT NULL ,          --완료일자
	TOPCD CHAR(1) CCSID 833 NOT NULL ,        --호환구분 ' ','1','2'
	TEXPLANT CHAR(1) CCSID 833 NOT NULL ,      --이체지역
	TEXDV CHAR(1) CCSID 833 NOT NULL ,          --이체공장
	TOSCD CHAR(1) CCSID 833 NOT NULL ,         --유상사급유무 '*'
	TCALCULATE CHAR(1) CCSID 933 NOT NULL ,    --재료비대상
	TCOMCD CHAR(1) CCSID 933 NOT NULL ,      --고객사유상
	TSERL VARCHAR(600) CCSID 833 NOT NULL ,      --레벨시리얼
	TOPCHK CHAR(1) CCSID 833 NOT NULL ,       --호환줄기 ' ','1','2'
	TYGCHK CHAR(1) CCSID 833 NOT NULL ,       --가공관리비대상여부
	TORATE NUMERIC(5, 2) NOT NULL ,           --호환율
	TCUMORATE NUMERIC(7, 4) NOT NULL           --누적호환율(절사)
	) ;
	
create table qtemp.tmp_bpm (tcmcd char(2) not null,
 tplnt char(1) not null, tdvsn char(1) not null,
 tmodl char(15) not null, toption char(15) not null,
 tlevel numeric(2,0) not null, tpitn char(15) not null,
 tcitn char(15) not null, tqtym numeric(8,3) not null,
 tqty1 numeric(8,3) not null, twkct char(4) not null,
 tedtm char(8) not null, tedte char(8) not null,
 topcd char(1) not null, texplant char(1) not null,
 texdv char(1) not null, toscd char(1) not null,
 tcalculate char(1) not null,tcomcd char(1) not null,
 tserl varchar(600) not null,topchk char(1) not null,
 tygchk char(1) not null,torate numeric(5, 2) not null,
 tcumorate numeric(7, 4) not null);