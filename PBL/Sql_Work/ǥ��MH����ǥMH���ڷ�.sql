-- 라우팅 표준시간 정보
( SELECT AreaCode = aa.AreaCode,
  DivisionCode = aa.DivisionCode,
  WorkCenter = aa.WorkCenter,
  ApplyDate = Min(aa.ApplyDate),
  EndDate = Max(aa.EndDate),
  ItemCode = aa.ItemCode,
  SubLineCode = aa.SubLineCode,
  SubLineNo = aa.SubLineNo,
  BasicTime = Cast ( Sum ( (IsNull(aa.BaseManualWorkTime,0) + IsNull(aa.SideManualWorkTime,0)) / IsNull(aa.EmpCount,1) ) as Numeric(9,4) )
FROM TMSTROUTING aa
WHERE isnull(aa.ApplyDate,'1900.01.01') <= @ps_dispday AND isnull(aa.EndDate,'9999.12.31') >= @ps_dispday
GROUP BY aa.AreaCode, aa.DivisionCode, aa.WorkCenter, aa.ItemCode, aa.SubLineCode, aa.SubLineNo ) A


-- BOM 히스토리정보
TPARTWARNINGBOM B

-- 표준MH 집계
SELECT BB.AreaCode, BB.DivisionCode, BB.ModelItemNo, 
SUM(CAST((BB.QuantityPerUnit * ISNULL(AA.BASICTIME,0) / 3600) AS NUMERIC(12,6))) AS BASICTIME
FROM TPARTWARNINGBOM BB LEFT OUTER JOIN 
( SELECT AreaCode = aa.AreaCode,
  DivisionCode = aa.DivisionCode,
  WorkCenter = aa.WorkCenter,
  ApplyDate = Min(aa.ApplyDate),
  EndDate = Max(aa.EndDate),
  ItemCode = aa.ItemCode,
  SubLineCode = aa.SubLineCode,
  SubLineNo = aa.SubLineNo,
  BasicTime = Cast ( Sum ( (IsNull(aa.BaseManualWorkTime,0) + IsNull(aa.SideManualWorkTime,0)) / CASE WHEN IsNull(aa.EmpCount,1) = 0 THEN 1 ELSE IsNull(aa.EmpCount,1) END ) as Numeric(9,4) )
FROM TMSTROUTING aa
WHERE isnull(aa.ApplyDate,'1900.01.01') <= '2012.08.09' AND isnull(aa.EndDate,'9999.12.31') >= '2012.08.09'
GROUP BY aa.AreaCode, aa.DivisionCode, aa.WorkCenter, aa.ItemCode, aa.SubLineCode, aa.SubLineNo ) AA
ON BB.AreaCode = AA.AreaCode AND BB.DivisionCode = AA.DivisionCode AND
	BB.ChildItemNo = AA.ItemCode
GROUP BY BB.AreaCode, BB.DivisionCode, BB.ModelItemNo
ORDER BY BB.AreaCode, BB.DivisionCode, BB.ModelItemNo

-- 목표MH / 표준MH 가져오기
SELECT BB.AreaCode, BB.DivisionCode, BB.ItemCode, BB.WorkCenter, BB.subLineCode, BB.subLineNo,
BB.tarMH, CAST((ISNULL(AA.BASICTIME,0) / 3600) AS NUMERIC(12,5)) AS BASICTIME
FROM (SELECT A.AREACODE, A.DIVISIONCODE, A.WORKCENTER, A.ITEMCODE, A.SUBLINECODE,
A.SUBLINENO, A.TARMH FROM TMHMONTHTARGET A INNER JOIN TMSTDEPT B
	ON A.WorkCenter = B.DEPTCODE WHERE tarMonth = '2012.08') BB LEFT OUTER JOIN
( SELECT AreaCode = aa.AreaCode,
  DivisionCode = aa.DivisionCode,
  WorkCenter = aa.WorkCenter,
  ApplyDate = Min(aa.ApplyDate),
  EndDate = Max(aa.EndDate),
  ItemCode = aa.ItemCode,
  SubLineCode = aa.SubLineCode,
  SubLineNo = aa.SubLineNo,
  BasicTime = Cast ( Sum ( (IsNull(aa.BaseManualWorkTime,0) + IsNull(aa.SideManualWorkTime,0)) / CASE WHEN IsNull(aa.EmpCount,1) = 0 THEN 1 ELSE IsNull(aa.EmpCount,1) END ) as Numeric(9,4) )
FROM TMSTROUTING aa
WHERE isnull(aa.ApplyDate,'1900.01.01') <= '2012.08.09' AND isnull(aa.EndDate,'9999.12.31') >= '2012.08.09'
GROUP BY aa.AreaCode, aa.DivisionCode, aa.WorkCenter, aa.ItemCode, aa.SubLineCode, aa.SubLineNo ) AA
ON BB.AreaCode = AA.AreaCode AND BB.DivisionCode = AA.DivisionCode AND
BB.ItemCode = AA.ItemCode AND BB.WorkCenter = AA.WorkCenter AND BB.subLineCode = AA.SubLineCode AND
BB.subLineNo = AA.SubLineNo
WHERE BB.AreaCode = 'D' AND BB.DivisionCode = 'M'
ORDER BY BB.AreaCode, BB.DivisionCode, BB.ItemCode


-- BOM모델별 표준시간조회
SELECT BB.ZPLANT, BB.ZDIV, BB.ZMDNO, BB.ZITNO, BB.ZLEVEL, BB.ZSRCE,
CAST((ISNULL(AA.BASICTIME,0) / 3600) AS NUMERIC(12,5)) AS BASICTIME,
AA.WorkCenter,AA.SubLineCode, AA.SubLineNo
FROM BOM113 BB LEFT OUTER JOIN
( SELECT AreaCode = aa.AreaCode,
  DivisionCode = aa.DivisionCode,
  WorkCenter = aa.WorkCenter,
  ApplyDate = Min(aa.ApplyDate),
  EndDate = Max(aa.EndDate),
  ItemCode = aa.ItemCode,
  SubLineCode = aa.SubLineCode,
  SubLineNo = aa.SubLineNo,
  BasicTime = Cast ( Sum ( (IsNull(aa.BaseManualWorkTime,0) + IsNull(aa.SideManualWorkTime,0)) / CASE WHEN IsNull(aa.EmpCount,1) = 0 THEN 1 ELSE IsNull(aa.EmpCount,1) END ) as Numeric(9,4) )
FROM TMSTROUTING aa
WHERE isnull(aa.ApplyDate,'1900.01.01') <= '2012.08.09' AND isnull(aa.EndDate,'9999.12.31') >= '2012.08.09'
GROUP BY aa.AreaCode, aa.DivisionCode, aa.WorkCenter, aa.ItemCode, aa.SubLineCode, aa.SubLineNo ) AA
ON BB.ZPLANT = AA.AreaCode AND BB.ZDIV = AA.DivisionCode AND
BB.ZITNO = AA.ItemCode 
WHERE BB.ZPLANT = 'D' AND BB.ZDIV = 'M'
ORDER BY BB.ZPLANT, BB.ZDIV, BB.ZMDNO, BB.ZSERIAL


-- 목표MH SUM조회
( SELECT A.AREACODE as AreaCode, A.DIVISIONCODE as DivisionCode, 
A.ITEMCODE as ItemCode, SUM(A.TARMH) as TargeMh, COUNT(*) AS cnt, SUM(A.TARMH) / COUNT(*) AS TarSum
FROM TMHMONTHTARGET A INNER JOIN TMSTDEPT B
	ON A.WorkCenter = B.DEPTCODE WHERE tarMonth = '2012.08' AND A.TARMH <> 0 
	GROUP BY A.AREACODE, A.DIVISIONCODE, A.ITEMCODE ) SS_TAR
	
-- 표준MH SUM조회
( SELECT AA.AreaCode as AreaCode, AA.DivisionCode as DivisionCode, 
AA.ItemCode as ItemCode, SUM(AA.BasicTime) as BasicTime, COUNT(*) as cnt,
CAST((SUM(AA.BasicTime) / 3600) / COUNT(*) AS NUMERIC(12,5)) AS StdSum
FROM ( SELECT AreaCode = aa.AreaCode,
  DivisionCode = aa.DivisionCode,
  WorkCenter = aa.WorkCenter,
  ApplyDate = Min(aa.ApplyDate),
  EndDate = Max(aa.EndDate),
  ItemCode = aa.ItemCode,
  SubLineCode = aa.SubLineCode,
  SubLineNo = aa.SubLineNo,
  BasicTime = Cast ( Sum ( (IsNull(aa.BaseManualWorkTime,0) + IsNull(aa.SideManualWorkTime,0)) / CASE WHEN IsNull(aa.EmpCount,1) = 0 THEN 1 ELSE IsNull(aa.EmpCount,1) END ) as Numeric(9,4) )
FROM TMSTROUTING aa INNER JOIN TMSTDEPT bb
	ON aa.WorkCenter = bb.DEPTCODE
WHERE isnull(aa.ApplyDate,'1900.01.01') <= '2012.08.09' AND isnull(aa.EndDate,'9999.12.31') >= '2012.08.09'
GROUP BY aa.AreaCode, aa.DivisionCode, aa.WorkCenter, aa.ItemCode, aa.SubLineCode, aa.SubLineNo ) AA
WHERE AA.BasicTime <> 0
GROUP BY AA.AreaCode, AA.DivisionCode, AA.ItemCode ) SS_STD


-- BOM구조별 표준MH 목표MH
SELECT BB.ZPLANT, BB.ZDIV, BB.ZMDNO, BB.ZITNO, BB.ZLEVEL, BB.ZSRCE,BB.ZUNITQTY,
CAST((ISNULL(SS_STD.StdSum,0)) AS NUMERIC(12,5)) AS STDMH,
CAST((ISNULL(SS_STD.TarSum,0)) AS NUMERIC(12,5)) AS TARMH
FROM BOM113 BB LEFT OUTER JOIN
( SELECT TMP.AreaCode as AreaCode, TMP.DivisionCode as DivisionCode ,
	TMP.ItemCode as ItemCode, SUM(TMP.TarSum) as TarSum, SUM(TMP.StdSum) as StdSum
FROM
( SELECT AA.AreaCode as AreaCode, AA.DivisionCode as DivisionCode, 
AA.ItemCode as ItemCode, 0 as TarSum, CAST((SUM(AA.BasicTime) / 3600) / COUNT(*) AS NUMERIC(12,5)) AS StdSum
FROM ( SELECT AreaCode = aa.AreaCode,
  DivisionCode = aa.DivisionCode,
  WorkCenter = aa.WorkCenter,
  ApplyDate = Min(aa.ApplyDate),
  EndDate = Max(aa.EndDate),
  ItemCode = aa.ItemCode,
  SubLineCode = aa.SubLineCode,
  SubLineNo = aa.SubLineNo,
  BasicTime = Cast ( Sum ( (IsNull(aa.BaseManualWorkTime,0) + IsNull(aa.SideManualWorkTime,0)) / CASE WHEN IsNull(aa.EmpCount,1) = 0 THEN 1 ELSE IsNull(aa.EmpCount,1) END ) as Numeric(9,4) )
FROM TMSTROUTING aa INNER JOIN TMSTDEPT bb
	ON aa.WorkCenter = bb.DEPTCODE
WHERE isnull(aa.ApplyDate,'1900.01.01') <= '2012.08.09' AND isnull(aa.EndDate,'9999.12.31') >= '2012.08.09'
GROUP BY aa.AreaCode, aa.DivisionCode, aa.WorkCenter, aa.ItemCode, aa.SubLineCode, aa.SubLineNo ) AA
WHERE AA.BasicTime <> 0
GROUP BY AA.AreaCode, AA.DivisionCode, AA.ItemCode 

UNION ALL

SELECT A.AREACODE as AreaCode, A.DIVISIONCODE as DivisionCode, 
A.ITEMCODE as ItemCode, SUM(A.TARMH) / COUNT(*) AS TarSum, 0 AS StdSum
FROM TMHMONTHTARGET A INNER JOIN TMSTDEPT B
	ON A.WorkCenter = B.DEPTCODE WHERE tarMonth = '2012.08' AND A.TARMH <> 0 
	GROUP BY A.AREACODE, A.DIVISIONCODE, A.ITEMCODE ) TMP
GROUP BY TMP.AreaCode, TMP.DivisionCode, TMP.ItemCode ) SS_STD
ON BB.ZPLANT = SS_STD.AreaCode AND BB.ZDIV = SS_STD.DivisionCode AND
BB.ZITNO = SS_STD.ItemCode 
WHERE BB.ZPLANT = 'D' AND BB.ZDIV = 'M'
ORDER BY BB.ZPLANT, BB.ZDIV, BB.ZMDNO, BB.ZSERIAL

-- 제품별 표준MH 목표MH
