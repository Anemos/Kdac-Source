--  Generate SQL 
--  Version:                   	V5R3M0 040528 
--  Generated on:              	09/05/20 16:34:18 
--  Relational Database:       	I520 
--  Standards Option:          	DB2 UDB iSeries 
--  모델별 재료비
  
DROP TABLE PBBPM.BPM413;

CREATE TABLE PBBPM.BPM413 ( 
	COMLTD CHAR(2) CCSID 833 NOT NULL DEFAULT '' ,   -- 회사
	AYEAR CHAR(4) CCSID 833 NOT NULL DEFAULT '' ,    -- 계획년도
	APLANT CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,   -- 지역
	ADIV CHAR(1) CCSID 833 NOT NULL DEFAULT '' ,     -- 공장
	APDCD VARCHAR(4) CCSID 833 NOT NULL DEFAULT '' ,    -- 제품군
	AMDNO VARCHAR(12) CCSID 833 NOT NULL DEFAULT '' ,   -- 제품품번
	BPLANT CHAR(1) CCSID 833 NOT NULL ,     --지역
	BDIV CHAR(1) CCSID 833 NOT NULL ,       --공장
	BMDNO CHAR(12) CCSID 933 NOT NULL ,     --제품모델
	BSERNO NUMERIC(4, 0) NOT NULL ,         --순번
	BPRNO CHAR(12) CCSID 933 NOT NULL ,     --모품번
	BCHNO CHAR(12) CCSID 933 NOT NULL ,     --자품번
	BWOCT CHAR(4) CCSID 933 NOT NULL ,      --조코드
	BPRQT NUMERIC(9, 3) NOT NULL ,          --모델에대한원단위
	BYOU CHAR(1) CCSID 833 NOT NULL ,       --유무상구분
	CLS  CHAR(2) CCSID 833 NOT NULL ,
	SRCE CHAR(2) CCSID 833 NOT NULL ,
	YVNDSR VARCHAR(8) CCSID 933 NOT NULL DEFAULT '', 
	YPLAN CHAR(2) CCSID 833 NOT NULL DEFAULT '', 
	YCURD CHAR(3) CCSID 833 NOT NULL DEFAULT '', 
	YCURE CHAR(3) CCSID 833 NOT NULL DEFAULT '', 
	YCSTD0 DECIMAL(17, 8) NOT NULL DEFAULT 0, 
	YCSTE0 DECIMAL(17, 8) NOT NULL DEFAULT 0, 
	YCSTD01 DECIMAL(17, 8) NOT NULL DEFAULT 0, 
	YCSTE01 DECIMAL(17, 8) NOT NULL DEFAULT 0, 
	CURD_NO CHAR(2) CCSID 833 NOT NULL DEFAULT '',
	CURE_NO CHAR(2) CCSID 833 NOT NULL DEFAULT '',
	CURDCST DECIMAL(17, 8) NOT NULL DEFAULT 0, 
	CURECST DECIMAL(17, 8) NOT NULL DEFAULT 0, 
	CONV_FACTOR NUMERIC(13, 5) NOT NULL DEFAULT 0,
	WKEXCD NUMERIC(7, 3) NOT NULL DEFAULT 0, 
	WKEXCE NUMERIC(7, 3) NOT NULL DEFAULT 0,
	PRIMARY KEY( COMLTD,AYEAR,APLANT,ADIV,APDCD,AMDNO,BSERNO ) ) ;
	
	
-- CREATE PBBPM.BPM413
INSERT INTO PBBPM.BPM413
( COMLTD,AYEAR,APLANT,ADIV,APDCD,AMDNO,
BPLANT,BDIV,BMDNO,BSERNO,BPRNO,BCHNO,BWOCT,BPRQT,BYOU,SRCE,CLS,
YVNDSR,YPLAN,YCURD,YCURE,YCSTD0,YCSTE0,YCSTD01,YCSTE01,
CURD_NO,CURE_NO,CURDCST,CURECST,CONV_FACTOR,WKEXCD,WKEXCE )
SELECT AA.COMLTD,AA.AYEAR,AA.APLANT,AA.ADIV,AA.APDCD,AA.AMDNO,
BB.BPLANT,BB.BDIV,BB.BMDNO,BB.BSERNO,BB.BPRNO,BB.BCHNO,BB.BWOCT,BB.BPRQT,BB.BYOU,DD.SRCE,DD.CLS,
IFNULL(CC.YVNDSR,''),IFNULL(CC.YPLAN,''),IFNULL(CC.YCURD,''),IFNULL(CC.YCURE,''),
IFNULL(CC.YCSTD0,0),IFNULL(CC.YCSTE0,0),IFNULL(CC.YCSTD01,0),IFNULL(CC.YCSTE01,0),
-- 내자환율 적용
IFNULL(CASE WHEN DD.SRCE = '01' THEN 
  ( CASE WHEN CC.YCURE = '' THEN '10' 
    ELSE (SELECT IFNULL(DD.SEQNO,'99') FROM PBBPM.BPM412 DD WHERE DD.COMLTD = '01' AND DD.CURUNIT = CC.YCURE) 
    END )
ELSE 
  ( CASE WHEN CC.YCSTD01 = 0 THEN 
     '10' 
    ELSE 
     ( CASE WHEN CC.YCURD = '' THEN 
        '10' 
       ELSE (SELECT IFNULL(DD.SEQNO,'99') FROM PBBPM.BPM412 DD WHERE DD.COMLTD = '01' AND DD.CURUNIT = CC.YCURD) 
		 END) 
    END ) 
END,'10') AS CURD_NO,
-- 외자환율 적용
IFNULL(CASE WHEN DD.SRCE <> '01' THEN 
     ( CASE WHEN CC.YCSTE01 = 0 THEN 
			'10'
		 ELSE (SELECT IFNULL(DD.SEQNO,'99') FROM PBBPM.BPM412 DD WHERE DD.COMLTD = '01' AND DD.CURUNIT = CC.YCURE) 
		 END ) 
ELSE (SELECT IFNULL(DD.SEQNO,'99') FROM PBBPM.BPM412 DD WHERE DD.COMLTD = '01' AND DD.CURUNIT = CC.YCURE) 
END,'10') AS CURE_NO,
-- 내자적용기준단가
IFNULL(CASE WHEN DD.CLS = '10' OR DD.CLS = '20' OR DD.CLS = '40' OR DD.CLS = '50' OR DD.CLS = '35' THEN
	CASE WHEN ( DD.SRCE = '03' OR DD.SRCE = '05' OR DD.SRCE = '06' ) OR DD.CLS = '30' THEN 
	  0
  ELSE 
    CASE WHEN DD.SRCE <> '01' THEN 
      CASE WHEN CC.YCSTE01 = 0 THEN 
        CC.YCSTD01 
      ELSE 
        CASE WHEN CC.YCSTD01 = 0 THEN CC.YCSTE01 ELSE CC.YCSTD01 END
      END
    ELSE CC.YCSTD01 END 
  END
ELSE 0 END,0) AS CURDCST,
-- 외자적용기준단가
IFNULL(CASE WHEN DD.CLS = '10' OR DD.CLS = '20' OR DD.CLS = '40' OR DD.CLS = '50' AND DD.CLS = '35' THEN
	CASE WHEN ( DD.SRCE = '03' OR DD.SRCE = '05' OR DD.SRCE = '06' ) OR DD.CLS = '30' THEN 0
   ELSE CASE WHEN DD.SRCE <> '01' THEN 
          CASE WHEN CC.YCSTE01 = 0 THEN CC.YCSTD01 ELSE CC.YCSTE01 END
        ELSE CC.YCSTE01 END 
   END
ELSE 0 END,0) AS CURECST,
-- 변환계수
IFNULL(CASE WHEN DD.SRCE = '01' THEN ( CASE WHEN BB.BUM = CC.YUNIT THEN 1 
  ELSE ( SELECT UUMCV FROM PBBPM.BPM105 
	WHERE COMLTD = '01' AND UYEAR = '2009' AND UPLANT = BB.BPLANT AND UDIV = BB.BDIV AND
		UITNO = BB.BCHNO AND UUNIT1 = BB.BUM AND UUNIT2 = CC.YUNIT ) END )
ELSE DD.CONVQTY END,1) AS CONV_FACTOR,
-- 내자환율
IFNULL(CASE WHEN DD.SRCE = '01' THEN
	CASE WHEN CC.YCURE <> '' AND CC.YCURE <> 'WON' THEN
   ( SELECT CEXC FROM PBBPM.BPM104 WHERE COMLTD = '01' AND CYEAR = '2009' AND CCUR = CC.YCURE )
   ELSE 1 END 
ELSE
   CASE WHEN CC.YCURD <> '' AND CC.YCURD <> 'WON' THEN
   ( SELECT CEXC FROM PBBPM.BPM104 WHERE COMLTD = '01' AND CYEAR = '2009' AND CCUR = CC.YCURD)
   ELSE 1 END 
END,1) AS WKEXCD,
-- 외자환율
IFNULL(CASE WHEN CC.YCURE <> '' AND CC.YCURE <> 'KRW' THEN
   ( SELECT CEXC FROM PBBPM.BPM104 WHERE COMLTD = '01' AND CYEAR = '2009' AND CCUR = CC.YCURE )
ELSE 1 END,1) AS WKEXCE,
-- COSTDOWN 처리
-- 1월
CASE WHEN TMP.CLS = '40' OR TMP.CLS = '50' THEN 0
ELSE 
  CASE WHEN (TMP.CURECST - 
   ( CASE WHEN TMP.SRCE = '01' THEN BB.YCSTE11
     ELSE
       CASE WHEN BB.YCSTE11 = 0 THEN BB.YCSTD11 ELSE BB.YCSTE11 END
     END )) > 0 THEN 
         (TMP.CURECST - ( CASE WHEN TMP.SRCE = '01' THEN
           BB.YCSTE11
          ELSE
           CASE WHEN BB.YCSTE11 = 0 THEN BB.YCSTD11 ELSE BB.YCSTE11 END
          END ))
  ELSE 0 END
END  AS CDEXPCST11,
CASE WHEN TMP.CLS = '40' OR TMP.CLS = '50' THEN 0
ELSE 
  CASE WHEN (
  TMP.CURDCST - 
   ( CASE WHEN TMP.SRCE = '01' THEN BB.YCSTD11
     ELSE
       CASE WHEN BB.YCSTD11 = 0 THEN BB.YCSTE11 ELSE BB.YCSTD11 END
     END )) > 0 THEN 
         (TMP.CURDCST - ( CASE WHEN TMP.SRCE = '01' THEN
           BB.YCSTD11
          ELSE
           CASE WHEN BB.YCSTD11 = 0 THEN BB.YCSTE11 ELSE BB.YCSTD11 END
          END ))
  ELSE 0 END
END  AS CDDOMCST11

FROM ( SELECT DISTINCT COMLTD,AYEAR,APLANT,ADIV,APDCD,AMDNO FROM PBBPM.BPM106
WHERE COMLTD = '01' AND AYEAR = '2009' AND APLANT = 'D' AND ADIV = 'A' AND ACODE = 'A') AA
INNER JOIN PBBPM.BPM101 BB
ON AA.COMLTD = BB.COMLTD AND AA.APLANT = BB.BPLANT AND AA.ADIV = BB.BDIV AND
	AA.AMDNO = BB.BMDNO
LEFT OUTER JOIN PBBPM.BPM102 DD
ON BB.COMLTD = DD.COMLTD AND BB.BPLANT = DD.XPLANT AND BB.BDIV = DD.DIV AND BB.BCHNO = DD.ITNO
LEFT OUTER JOIN ( SELECT COMLTD,YPLANT,YDIV,YITNO,YVNDSR,YPLAN,YCURD,YCURE,
	YSRCE,YUNIT,YCSTD0,YCSTE0,YCSTD01,YCSTE01
FROM PBBPM.BPM103
WHERE COMLTD = '01' AND YCCYY = '2009' AND YGRAD = '1') CC
ON BB.COMLTD = CC.COMLTD AND BB.BPLANT = CC.YPLANT AND BB.BDIV = CC.YDIV AND BB.BCHNO = CC.YITNO
;