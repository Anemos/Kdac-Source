-- 수량별
SELECT A.AREACODE,A.SUPPLIERCODE,B.SUPPLIERKORNAME,
InQty		= isnull(sum(A.SUPPLIERDELIVERYQTY), 0)	,
BadQty		= isnull(sum(A.BADQTY), 0)				,
BadRate		= cast(isnull((cast(SUM(A.BADQTY) as float) / cast(sum(A.SUPPLIERDELIVERYQTY) as float)) * 100, 0) as numeric(15,2))
FROM TQQCRESULT A left outer join tmstsupplier B
	on A.suppliercode = B.suppliercode
WHERE A.AREACODE      =  'D'
  AND A.DIVISIONCODE  =  'A'
  AND A.QCDATE        >= '2007.01.01'
	AND A.QCDATE        <= '2007.12.31'
GROUP BY A.AREACODE, A.SUPPLIERCODE,B.SUPPLIERKORNAME
ORDER BY (cast(SUM(A.BADQTY) as float) / cast(sum(A.SUPPLIERDELIVERYQTY) as float)) * 100   DESC, A.SUPPLIERCODE

-- LOT 별
SELECT TMP.AS_AREACODE,TMP.AS_SUPPLIERCODE, B.SUPPLIERKORNAME,                                                                    
InQty		= isnull(SUM(TMP.AS_SUPPLIERDELIVERYQTY), 0),
BadQty		= isnull(SUM(TMP.AS_BADQTY), 0),
BadRate		= cast(isnull((cast(SUM(TMP.AS_BADQTY) as float) / cast(sum(TMP.AS_SUPPLIERDELIVERYQTY) as float)) * 100, 0) as numeric(15,2)) 
FROM (
				SELECT A.AREACODE 		     AS AS_AREACODE,
					   A.SUPPLIERCODE	       AS AS_SUPPLIERCODE,
					   count(A.SUPPLIERDELIVERYQTY)  AS AS_SUPPLIERDELIVERYQTY,
					   0                             AS AS_BADQTY
				  FROM TQQCRESULT A
		         WHERE A.AREACODE      =  @ps_AreaCode
		           AND A.DIVISIONCODE  =  @ps_DivisionCode
		           AND A.QCDATE        >= @ps_QCDateFm
				   AND A.QCDATE        <= @ps_QCDateTo
		         GROUP BY A.AREACODE, A.SUPPLIERCODE
		
				UNION ALL
		
				SELECT A.AREACODE 		             AS AS_AREACODE,
					   A.SUPPLIERCODE	             AS AS_SUPPLIERCODE,
					   0                             AS AS_SUPPLIERDELIVERYQTY,
					   count(A.BADQTY)	             AS AS_BADQTY
				  FROM TQQCRESULT A
		         WHERE A.AREACODE      =  @ps_AreaCode
		           AND A.DIVISIONCODE  =  @ps_DivisionCode
		           AND A.QCDATE        >= @ps_QCDateFm
				   AND A.QCDATE        <= @ps_QCDateTo
		           AND A.JUDGEFLAG     IN ('2', '3')
		         GROUP BY A.AREACODE, A.SUPPLIERCODE
		) TMP left outer join tmstsupplier B
	on TMP.AS_SUPPLIERCODE = B.suppliercode
		GROUP BY TMP.AS_AREACODE,
		         TMP.AS_SUPPLIERCODE,
		         B.SUPPLIERKORNAME
		HAVING  SUM(TMP.AS_BADQTY) > 0
		ORDER BY (cast(SUM(TMP.AS_BADQTY) as float) / cast(sum(TMP.AS_SUPPLIERDELIVERYQTY) as float)) * 100   DESC
