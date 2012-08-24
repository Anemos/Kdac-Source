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
SELECT BB.AreaCode, BB.DivisionCode, BB.ItemCode, CC.ITEMNAME, BB.WorkCenter, BB.subLineCode, BB.subLineNo,
BB.tarMH, CAST((ISNULL(AA.BASICTIME,0) / 3600) AS NUMERIC(12,5)) AS BASICTIME
FROM (SELECT A.AREACODE, A.DIVISIONCODE, A.WORKCENTER, A.ITEMCODE, A.SUBLINECODE,
A.SUBLINENO, A.TARMH FROM TMHMONTHTARGET A INNER JOIN TMSTDEPT B
	ON A.WorkCenter = B.DEPTCODE WHERE tarMonth = '2012.08') BB 
INNER JOIN TMSTITEM CC
ON BB.ITEMCODE = CC.ITEMCODE
LEFT OUTER JOIN
( SELECT AreaCode = aa.AreaCode,
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
ON BB.AreaCode = AA.AreaCode AND BB.DivisionCode = AA.DivisionCode AND
BB.ItemCode = AA.ItemCode AND BB.WorkCenter = AA.WorkCenter AND BB.subLineCode = AA.SubLineCode AND
BB.subLineNo = AA.SubLineNo
WHERE BB.AreaCode = 'D' AND BB.DivisionCode = 'M'
ORDER BY BB.AreaCode, BB.DivisionCode, BB.ItemCode


-- BOM모델별 표준시간조회
SELECT BB.ZPLANT, BB.ZDIV, BB.ZMDNO, BB.ZITNO, BB.ZDESC, BB.ZLEVEL, BB.ZSRCE,
CAST((ISNULL(AA.BASICTIME,0) / 3600) AS NUMERIC(12,5)) AS BASICTIME,
AA.WorkCenter,AA.SubLineCode, AA.SubLineNo, CC.tarMH
FROM [ipis_daegu].ipis.dbo.BOM113 BB LEFT OUTER JOIN
( SELECT AreaCode = aa.AreaCode,
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
ON BB.ZPLANT = AA.AreaCode AND BB.ZDIV = AA.DivisionCode AND
BB.ZITNO = AA.ItemCode 
LEFT OUTER JOIN (SELECT A.AREACODE, A.DIVISIONCODE, A.WORKCENTER, A.ITEMCODE, A.SUBLINECODE,
A.SUBLINENO, A.TARMH FROM TMHMONTHTARGET A INNER JOIN TMSTDEPT B
	ON A.WorkCenter = B.DEPTCODE WHERE tarMonth = '2012.08') CC
ON AA.AreaCode = CC.AreaCode AND AA.DivisionCode = CC.DivisionCode AND
AA.ItemCode = CC.ItemCode AND AA.WorkCenter = CC.WorkCenter AND AA.subLineCode = CC.SubLineCode AND
AA.subLineNo = CC.SubLineNo
WHERE BB.ZPLANT = 'D' AND BB.ZDIV = 'M'
ORDER BY BB.ZPLANT, BB.ZDIV, BB.ZMDNO, BB.ZSERIAL


-- 목표MH SUM조회
( SELECT A.AREACODE as AreaCode, A.DIVISIONCODE as DivisionCode, A.WORKCENTER as WorkCenter,
A.ITEMCODE as ItemCode, A.SubLineCode, A.SublineNo,
SUM(A.TARMH) AS TarSum, 0 AS StdSum, 0 as ActSum
FROM TMHMONTHTARGET A INNER JOIN TMSTDEPT B
	ON A.WorkCenter = B.DEPTCODE WHERE tarMonth = '2012.08' AND A.TARMH <> 0 
	GROUP BY A.AREACODE, A.DIVISIONCODE, A.WORKCENTER, A.ITEMCODE, A.SubLineCode, A.SublineNo ) SS_TAR

-- 실적MH 조회
( SELECT XX.AreaCode as AreaCode, XX.DivisionCode as DivisionCode, XX.WorkCenter as workcenter, XX.ItemCode as ItemCode, 
XX.SubLineCode, XX.SublineNo,
0 as TarSum, 0 as StdSum, CAST (XX.ACTINMH AS NUMERIC(12,5)) AS ActSum
FROM
( SELECT AreaCode, DivisionCode, WorkCenter, ItemCode, SubLineCode, SublineNo,
  CAST ( SUM(ActInMH) / SUM(pQty) AS NUMERIC(12,5))  AS ACTINMH
FROM TMHMONTHPRODLINE_S
WHERE AreaCode = 'D' AND DivisionCode = 'M' AND sMonth >= '2012.01' AND sMonth <= '2012.07'
AND pQty <> 0 AND ActInMH <> 0
GROUP BY AreaCode, DivisionCode, WorkCenter, ItemCode, SubLineCode, SublineNo ) XX ) SS_ACT

-- 표준MH SUM조회
( SELECT AA.AreaCode as AreaCode, AA.DivisionCode as DivisionCode, AA.WorkCenter as WorkCenter,
AA.ItemCode as ItemCode, AA.SubLineCode, AA.SublineNo,
0 as TarSum, CAST((SUM(AA.BasicTime) / 3600) / CC.cnt AS NUMERIC(12,5)) AS StdSum, 0 as ActSum
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
INNER JOIN 
( SELECT BB.AreaCode as AreaCode, BB.DivisionCode as DivisionCode, 
	BB.WorkCenter as WorkCenter, BB.ItemCode as ItemCode, BB.SublineCode, BB.SublineNo, count(*) as cnt
FROM (SELECT DISTINCT AreaCode = aa.AreaCode,
  DivisionCode = aa.DivisionCode,
  WorkCenter = aa.WorkCenter,
  ItemCode = aa.ItemCode,
  SubLineCode = aa.SubLineCode,
  SubLineNo = aa.SubLineNo
FROM TMSTROUTING aa INNER JOIN TMSTDEPT bb
	ON aa.WorkCenter = bb.DEPTCODE
WHERE isnull(aa.ApplyDate,'1900.01.01') <= '2012.08.09' AND isnull(aa.EndDate,'9999.12.31') >= '2012.08.09'
 ) BB
GROUP BY BB.AreaCode, BB.DivisionCode, BB.WorkCenter, BB.ItemCode, BB.SublineCode, BB.SublineNo ) CC
ON AA.AreaCode = CC.AreaCode AND AA.DivisionCode = CC.DivisionCode AND
	AA.WorkCenter = CC.WorkCenter AND AA.ItemCode = CC.ItemCode
WHERE AA.BasicTime <> 0
GROUP BY AA.AreaCode, AA.DivisionCode, AA.WorkCenter, AA.ItemCode, AA.SubLineCode, AA.SublineNo, CC.cnt ) SS_STD


-- BOM구조별 표준MH 목표MH 실적MH
SELECT BB.ZPLANT, BB.ZDIV, BB.ZMDNO, BB.ZITNO, BB.ZDESC, BB.ZLEVEL, BB.ZSRCE,BB.ZUNITQTY,SS_STD.WorkCenter,
SS_STD.SublineCode, SS_STD.SublineNo,
CAST((ISNULL(SS_STD.StdSum,0)) AS NUMERIC(12,5)) AS STDMH,
CAST((ISNULL(SS_STD.TarSum,0)) AS NUMERIC(12,5)) AS TARMH,
CAST((ISNULL(SS_STD.ActSum,0)) AS NUMERIC(12,5)) AS ACTMH
FROM [ipis_daegu].ipis.dbo.BOM113 BB LEFT OUTER JOIN
( SELECT TMP.AreaCode as AreaCode, TMP.DivisionCode as DivisionCode , TMP.WorkCenter as WorkCenter,
	TMP.ItemCode as ItemCode, TMP.SublineCode, TMP.SublineNo,
	SUM(TMP.TarSum) as TarSum, SUM(TMP.StdSum) as StdSum, Sum(TMP.ActSum) as ActSum
FROM
( SELECT AA.AreaCode as AreaCode, AA.DivisionCode as DivisionCode, AA.WorkCenter as WorkCenter,
AA.ItemCode as ItemCode, AA.SubLineCode as SublineCode, AA.SublineNo as SublineNo,
0 as TarSum, CAST((SUM(AA.BasicTime) / 3600) / CC.cnt AS NUMERIC(12,5)) AS StdSum, 0 as ActSum
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
INNER JOIN 
( SELECT BB.AreaCode as AreaCode, BB.DivisionCode as DivisionCode, 
	BB.WorkCenter as WorkCenter, BB.ItemCode as ItemCode, BB.SublineCode as SublineCode, BB.SublineNo as SublineNo, count(*) as cnt
FROM (SELECT DISTINCT AreaCode = aa.AreaCode,
  DivisionCode = aa.DivisionCode,
  WorkCenter = aa.WorkCenter,
  ItemCode = aa.ItemCode,
  SubLineCode = aa.SubLineCode,
  SubLineNo = aa.SubLineNo
FROM TMSTROUTING aa INNER JOIN TMSTDEPT bb
	ON aa.WorkCenter = bb.DEPTCODE
WHERE isnull(aa.ApplyDate,'1900.01.01') <= '2012.08.09' AND isnull(aa.EndDate,'9999.12.31') >= '2012.08.09'
 ) BB
GROUP BY BB.AreaCode, BB.DivisionCode, BB.WorkCenter, BB.ItemCode, BB.SublineCode, BB.SublineNo ) CC
ON AA.AreaCode = CC.AreaCode AND AA.DivisionCode = CC.DivisionCode AND
	AA.WorkCenter = CC.WorkCenter AND AA.ItemCode = CC.ItemCode
WHERE AA.BasicTime <> 0
GROUP BY AA.AreaCode, AA.DivisionCode, AA.WorkCenter, AA.ItemCode, AA.SubLineCode, AA.SublineNo, CC.cnt

UNION ALL

SELECT A.AREACODE as AreaCode, A.DIVISIONCODE as DivisionCode, A.WORKCENTER as WorkCenter,
A.ITEMCODE as ItemCode, A.SubLineCode as SublineCode, A.SublineNo as SublineNo,
SUM(A.TARMH) AS TarSum, 0 AS StdSum, 0 as ActSum
FROM TMHMONTHTARGET A INNER JOIN TMSTDEPT B
	ON A.WorkCenter = B.DEPTCODE WHERE tarMonth = '2012.08' AND A.TARMH <> 0 
	GROUP BY A.AREACODE, A.DIVISIONCODE, A.WORKCENTER, A.ITEMCODE, A.SubLineCode, A.SublineNo

UNION ALL

SELECT XX.AreaCode as AreaCode, XX.DivisionCode as DivisionCode, XX.WorkCenter as workcenter, XX.ItemCode as ItemCode, 
XX.SubLineCode as SublineCode, XX.SublineNo as SublineNo,
0 as TarSum, 0 as StdSum, CAST (XX.ACTINMH AS NUMERIC(12,5)) AS ActSum
FROM
( SELECT AreaCode, DivisionCode, WorkCenter, ItemCode, SubLineCode, SublineNo,
  CAST ( SUM(ActInMH) / SUM(pQty) AS NUMERIC(12,5))  AS ACTINMH
FROM TMHMONTHPRODLINE_S
WHERE AreaCode = 'D' AND DivisionCode = 'M' AND sMonth >= '2012.01' AND sMonth <= '2012.07'
AND pQty <> 0 AND ActInMH <> 0
GROUP BY AreaCode, DivisionCode, WorkCenter, ItemCode, SubLineCode, SublineNo ) XX ) TMP
GROUP BY TMP.AreaCode, TMP.DivisionCode, TMP.WorkCenter, TMP.ItemCode, TMP.SublineCode, TMP.SublineNo  ) SS_STD
ON BB.ZPLANT = SS_STD.AreaCode AND BB.ZDIV = SS_STD.DivisionCode AND
BB.ZITNO = SS_STD.ItemCode 
WHERE BB.ZPLANT = 'D' AND BB.ZDIV = 'M'
ORDER BY BB.ZPLANT, BB.ZDIV, BB.ZMDNO, BB.ZSERIAL

-- 제품별 표준MH 목표MH 실적MH
SELECT BB.ZPLANT, BB.ZDIV, BB.ZMDNO, CC.ITEMNAME,
CAST(SUM(ISNULL(SS_STD.StdSum,0) * BB.ZUNITQTY) AS NUMERIC(12,5)) AS STDMH,
CAST(SUM(ISNULL(SS_STD.TarSum,0) * BB.ZUNITQTY) AS NUMERIC(12,5)) AS TARMH,
CAST(SUM(ISNULL(SS_STD.ActSum,0) * BB.ZUNITQTY) AS NUMERIC(12,5)) AS ACTMH
FROM [ipis_daegu].ipis.dbo.BOM113 BB LEFT OUTER JOIN
( SELECT TMP.AreaCode as AreaCode, TMP.DivisionCode as DivisionCode ,
	TMP.ItemCode as ItemCode, SUM(TMP.TarSum) as TarSum, SUM(TMP.StdSum) as StdSum, Sum(TMP.ActSum) as ActSum
FROM
( SELECT AA.AreaCode as AreaCode, AA.DivisionCode as DivisionCode, AA.WorkCenter as WorkCenter,
AA.ItemCode as ItemCode, AA.SubLineCode, AA.SublineNo,
0 as TarSum, CAST((SUM(AA.BasicTime) / 3600) / CC.cnt AS NUMERIC(12,5)) AS StdSum, 0 as ActSum
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
INNER JOIN 
( SELECT BB.AreaCode as AreaCode, BB.DivisionCode as DivisionCode, 
	BB.WorkCenter as WorkCenter, BB.ItemCode as ItemCode, BB.SublineCode, BB.SublineNo, count(*) as cnt
FROM (SELECT DISTINCT AreaCode = aa.AreaCode,
  DivisionCode = aa.DivisionCode,
  WorkCenter = aa.WorkCenter,
  ItemCode = aa.ItemCode,
  SubLineCode = aa.SubLineCode,
  SubLineNo = aa.SubLineNo
FROM TMSTROUTING aa INNER JOIN TMSTDEPT bb
	ON aa.WorkCenter = bb.DEPTCODE
WHERE isnull(aa.ApplyDate,'1900.01.01') <= '2012.08.09' AND isnull(aa.EndDate,'9999.12.31') >= '2012.08.09'
 ) BB
GROUP BY BB.AreaCode, BB.DivisionCode, BB.WorkCenter, BB.ItemCode, BB.SublineCode, BB.SublineNo ) CC
ON AA.AreaCode = CC.AreaCode AND AA.DivisionCode = CC.DivisionCode AND
	AA.WorkCenter = CC.WorkCenter AND AA.ItemCode = CC.ItemCode
WHERE AA.BasicTime <> 0
GROUP BY AA.AreaCode, AA.DivisionCode, AA.WorkCenter, AA.ItemCode, AA.SubLineCode, AA.SublineNo, CC.cnt

UNION ALL

SELECT A.AREACODE as AreaCode, A.DIVISIONCODE as DivisionCode, A.WORKCENTER as WorkCenter,
A.ITEMCODE as ItemCode, A.SubLineCode, A.SublineNo,
SUM(A.TARMH) AS TarSum, 0 AS StdSum, 0 as ActSum
FROM TMHMONTHTARGET A INNER JOIN TMSTDEPT B
	ON A.WorkCenter = B.DEPTCODE WHERE tarMonth = '2012.08' AND A.TARMH <> 0 
	GROUP BY A.AREACODE, A.DIVISIONCODE, A.WORKCENTER, A.ITEMCODE, A.SubLineCode, A.SublineNo

UNION ALL

SELECT XX.AreaCode as AreaCode, XX.DivisionCode as DivisionCode, XX.WorkCenter as workcenter, XX.ItemCode as ItemCode, 
XX.SubLineCode, XX.SublineNo,
0 as TarSum, 0 as StdSum, CAST (XX.ACTINMH AS NUMERIC(12,5)) AS ActSum
FROM
( SELECT AreaCode, DivisionCode, WorkCenter, ItemCode, SubLineCode, SublineNo,
  CAST ( SUM(ActInMH) / SUM(pQty) AS NUMERIC(12,5))  AS ACTINMH
FROM TMHMONTHPRODLINE_S
WHERE AreaCode = 'D' AND DivisionCode = 'M' AND sMonth >= '2012.01' AND sMonth <= '2012.07'
AND pQty <> 0 AND ActInMH <> 0
GROUP BY AreaCode, DivisionCode, WorkCenter, ItemCode, SubLineCode, SublineNo ) XX ) TMP
GROUP BY TMP.AreaCode, TMP.DivisionCode, TMP.ItemCode ) SS_STD
ON BB.ZPLANT = SS_STD.AreaCode AND BB.ZDIV = SS_STD.DivisionCode AND
BB.ZITNO = SS_STD.ItemCode 
INNER JOIN TMSTITEM CC
ON BB.ZMDNO = CC.ITEMCODE
WHERE BB.ZPLANT = 'D' AND BB.ZDIV = 'M'
GROUP BY BB.ZPLANT, BB.ZDIV, BB.ZMDNO, CC.ITEMNAME
ORDER BY BB.ZPLANT, BB.ZDIV, BB.ZMDNO;
