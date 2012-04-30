/************************************************************************************************/
/*	File Name	: sp_eisq040i_01.SQL                                                            */
/*	SYSTEM		: 경영자용 통합정보	                                                            */
/*	Description	: 전사 월간 수입검사 불량율(업체별WORST-수량별)                                 */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCRESULT                                                                    */
/*	              TMSTSUPPLIER                                                                  */
/*  Parameter   : @ps_QCDateFm          char(10)    => 조회일자FROM                             */
/*                @ps_QCDateTo          char(10)    => 조회일자TO                               */
/*	Notes		: 전사 월간 수입검사 불량율 현황중 업체별 WORST 10의 자료를 조회한다.           */
/*	Made Date	: 2002. 12. 02                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_eisq040i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_eisq040i_01
GO
/*
Exec sp_eisq040i_01
        @ps_QCDateFm        = '2002.01.01'      ,
        @ps_QCDateTo        = '2002.12.31'
*/


/****** Object:  Stored Procedure dbo.sp_eisq040i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_eisq040i_01
        @ps_QCDateFm          char(10)      ,   -- 조회일자FROM
        @ps_QCDateTo          char(10)          -- 조회일자TO
AS

BEGIN

	-- 업체별 WORST 10을 저장할 임시테이블
	--
	Create Table #Tmp_Worst
	(
		Seq				Int      ,
		AreaCode        Char(1)  ,
		divisionCode    Char(1)  ,
		SupplierCode	Char(5)  ,
		InQty			Int      ,
		BadQty			Int      ,
		BadRate			float      
	)
	
	Declare	@li_Seq	            Int      , 
            @ps_Area            char(01) ,
            @ps_division        char(01) ,
            @ps_SupplierCode	char(5)  ,
            @pi_InQty			Int      ,
            @pi_BadQty			Int      ,
            @pf_BadRate			float    ,
            @pi_count			Int      

	-- 지역별 공장을 FETCH할 커서를 선언한다(대구, 진천만 해당)
	--
	DECLARE tmstdivision_cursor CURSOR
	FOR
		SELECT	AREACODE		,
				DIVISIONCODE	
		  FROM	TMSTDIVISION
		 WHERE	AREACODE IN ('D', 'J')		  
		 ORDER	BY AREACODE, SORTORDER

	-- 커서오픈
	--
	OPEN tmstdivision_cursor

	-- FETCH
	--
	FETCH NEXT FROM tmstdivision_cursor INTO @ps_area, @ps_division
	
	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
		IF (@@FETCH_STATUS <> -2)
		BEGIN   
			-- 지역, 공장별 WORST 10을 템프 테이블에 인서트한다
			--
			Insert INTO #Tmp_Worst (seq			,
									AreaCode	,
									DivisionCode,
									SupplierCode,
									InQty		,
									BadQty		,
									BadRate		) 
			SELECT	TOP 10
					0 ,
					A.AREACODE			AS AS_AREACODE,
					A.DIVISIONCODE		AS AS_DIVISIONCODE,
					A.SUPPLIERCODE		AS_SUPPLIERCODE,
					sum(ISNULL(A.SUPPLIERDELIVERYQTY, 0))	AS AS_IQTY,
					sum(ISNULL(A.BADQTY, 0))				AS AS_BQTY,
					CASE WHEN sum(ISNULL(A.SUPPLIERDELIVERYQTY,0)) = 0 
						  THEN	0
						  ELSE	 ISNULL((cast(SUM(A.BADQTY) as float) / cast(sum(A.SUPPLIERDELIVERYQTY) as float)) * 100 , 0) 
						  END 	AS AS_RATE
			  FROM TQQCRESULT A	
			WHERE 	A.AREACODE		= @ps_Area
			     AND A.DIVISIONCODE	= @ps_division
			     AND A.QCDATE      >= @ps_QCDateFm
			     AND A.QCDATE      <= @ps_QCDateTo
			 GROUP BY A.AREACODE, A.DIVISIONCODE, A.SUPPLIERCODE
			 ORDER BY A.AREACODE, A.DIVISIONCODE, AS_RATE DESC 
		END
		FETCH NEXT FROM tmstdivision_cursor INTO @ps_Area, @ps_division
	END
	-- 커서크로스
	--
	CLOSE tmstdivision_cursor
	DEALLOCATE tmstdivision_cursor

	SET @li_Seq = 0

	-- 순위를 부여하기 위하여 템프 테이블을 처음부터 읽으면서  1 ~ 10 까지 번호를 부여
	--
	DECLARE tmp_worst_cursor CURSOR
	FOR
		SELECT 	AreaCode		,
				DivisionCode	,
				SupplierCode 
		FROM #Tmp_Worst 
	OPEN tmp_worst_cursor
	FETCH NEXT FROM tmp_worst_cursor INTO @ps_area, @ps_division, @ps_suppliercode
	
	WHILE (@@FETCH_STATUS <> -1)
	BEGIN
	   IF (@@FETCH_STATUS <> -2)
	   BEGIN   
			SET @li_Seq = @li_Seq + 1
			UPDATE #Tmp_Worst
			   SET SEQ = @li_Seq 
			 WHERE AreaCode		= @ps_Area
			   AND DivisionCode	= @ps_DIVISION
			   AND SupplierCode = @ps_SupplierCode
			IF @li_Seq = 10 SET @li_Seq = 0
	   END
	  FETCH NEXT FROM tmp_worst_cursor INTO @ps_Area, @ps_DIVISION, @ps_SupplierCode
	END
	CLOSE tmp_worst_cursor
	DEALLOCATE tmp_worst_cursor

	SELECT AS_AREACODE             AS AS_AREA         ,
		   A.AREANAME 			   					  ,
		   AS_DIVISIONCODE		   AS AS_DIVISION	  ,
		   B.DIVISIONNAME		   					  ,
		   MAX(AS_SUPPLIERNAME_01) AS AS_NAME_01      ,
		   MAX(AS_SUPPLIERNAME_02) AS AS_NAME_02      ,
		   MAX(AS_SUPPLIERNAME_03) AS AS_NAME_03      ,
		   MAX(AS_SUPPLIERNAME_04) AS AS_NAME_04      ,
		   MAX(AS_SUPPLIERNAME_05) AS AS_NAME_05      ,
		   MAX(AS_SUPPLIERNAME_06) AS AS_NAME_06      ,
		   MAX(AS_SUPPLIERNAME_07) AS AS_NAME_07      ,
		   MAX(AS_SUPPLIERNAME_08) AS AS_NAME_08      ,
		   MAX(AS_SUPPLIERNAME_09) AS AS_NAME_09      ,
		   MAX(AS_SUPPLIERNAME_10) AS AS_NAME_10      ,
		   SUM(AS_INQTY_01)        AS AS_IQTY_01      ,
		   SUM(AS_INQTY_02)        AS AS_IQTY_02      ,
		   SUM(AS_INQTY_03)        AS AS_IQTY_03      ,
		   SUM(AS_INQTY_04)        AS AS_IQTY_04      ,
		   SUM(AS_INQTY_05)        AS AS_IQTY_05      ,
		   SUM(AS_INQTY_06)        AS AS_IQTY_06      ,
		   SUM(AS_INQTY_07)        AS AS_IQTY_07      ,
		   SUM(AS_INQTY_08)        AS AS_IQTY_08      ,
		   SUM(AS_INQTY_09)        AS AS_IQTY_09      ,
		   SUM(AS_INQTY_10)        AS AS_IQTY_10      ,
		   SUM(AS_BADQTY_01)       AS AS_BQTY_01      ,
		   SUM(AS_BADQTY_02)       AS AS_BQTY_02      ,
		   SUM(AS_BADQTY_03)       AS AS_BQTY_03      ,
		   SUM(AS_BADQTY_04)       AS AS_BQTY_04      ,
		   SUM(AS_BADQTY_05)       AS AS_BQTY_05      ,
		   SUM(AS_BADQTY_06)       AS AS_BQTY_06      ,
		   SUM(AS_BADQTY_07)       AS AS_BQTY_07      ,
		   SUM(AS_BADQTY_08)       AS AS_BQTY_08      ,
		   SUM(AS_BADQTY_09)       AS AS_BQTY_09      ,
		   SUM(AS_BADQTY_10)       AS AS_BQTY_10      ,
		   SUM(AS_BADRATE_01)      AS AS_BRATE_01     ,
		   SUM(AS_BADRATE_02)      AS AS_BRATE_02     ,
		   SUM(AS_BADRATE_03)      AS AS_BRATE_03     ,
		   SUM(AS_BADRATE_04)      AS AS_BRATE_04     ,
		   SUM(AS_BADRATE_05)      AS AS_BRATE_05     ,
		   SUM(AS_BADRATE_06)      AS AS_BRATE_06     ,
		   SUM(AS_BADRATE_07)      AS AS_BRATE_07     ,
		   SUM(AS_BADRATE_08)      AS AS_BRATE_08     ,
		   SUM(AS_BADRATE_09)      AS AS_BRATE_09     ,
		   SUM(AS_BADRATE_10)      AS AS_BRATE_10    
      FROM (SELECT A.AreaCode       AS AS_AREACODE        ,
				   A.DIVISIONCODE	AS AS_DIVISIONCODE	  ,
				   B.SUPPLIERKORNAME AS AS_SUPPLIERNAME_01 ,
				   A.InQty		    AS AS_INQTY_01        ,
				   A.BadQty		    AS AS_BADQTY_01       ,
				   A.BadRate		AS AS_BADRATE_01      ,
				   ' '              AS AS_SUPPLIERNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_SUPPLIERNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_SUPPLIERNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_SUPPLIERNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_SUPPLIERNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_SUPPLIERNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_SUPPLIERNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_SUPPLIERNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_SUPPLIERNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTSUPPLIER B
             WHERE A.SUPPLIERCODE *= B.SUPPLIERCODE
		       AND A.Seq = 1  
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   A.DIVISIONCODE	AS AS_DIVISIONCODE	  ,
				   ' '              AS AS_SUPPLIERNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   B.SUPPLIERKORNAME AS AS_SUPPLIERNAME_02 ,
				   A.InQty		    AS AS_INQTY_02        ,
				   A.BadQty		    AS AS_BADQTY_02       ,
				   A.BadRate		AS AS_BADRATE_02      ,
				   ' '              AS AS_SUPPLIERNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_SUPPLIERNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_SUPPLIERNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_SUPPLIERNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_SUPPLIERNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_SUPPLIERNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_SUPPLIERNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_SUPPLIERNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTSUPPLIER B
             WHERE A.SUPPLIERCODE *= B.SUPPLIERCODE
		       AND A.Seq = 2
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   A.DIVISIONCODE	AS AS_DIVISIONCODE	  ,
				   ' '              AS AS_SUPPLIERNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_SUPPLIERNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   B.SUPPLIERKORNAME AS AS_SUPPLIERNAME_03 ,
				   A.InQty		    AS AS_INQTY_03        ,
				   A.BadQty		    AS AS_BADQTY_03       ,
				   A.BadRate		AS AS_BADRATE_03      ,
				   ' '              AS AS_SUPPLIERNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_SUPPLIERNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_SUPPLIERNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_SUPPLIERNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_SUPPLIERNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_SUPPLIERNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_SUPPLIERNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTSUPPLIER B
             WHERE A.SUPPLIERCODE *= B.SUPPLIERCODE
		       AND A.Seq = 3
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   A.DIVISIONCODE	AS AS_DIVISIONCODE	  ,
				   ' '              AS AS_SUPPLIERNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_SUPPLIERNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_SUPPLIERNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   B.SUPPLIERKORNAME AS AS_SUPPLIERNAME_04 ,
				   A.InQty		    AS AS_INQTY_04        ,
				   A.BadQty		    AS AS_BADQTY_04       ,
				   A.BadRate		AS AS_BADRATE_04      ,
				   ' '              AS AS_SUPPLIERNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_SUPPLIERNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_SUPPLIERNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_SUPPLIERNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_SUPPLIERNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_SUPPLIERNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTSUPPLIER B
             WHERE A.SUPPLIERCODE *= B.SUPPLIERCODE
		       AND A.Seq = 4
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   A.DIVISIONCODE	AS AS_DIVISIONCODE	  ,
				   ' '              AS AS_SUPPLIERNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_SUPPLIERNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_SUPPLIERNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_SUPPLIERNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   B.SUPPLIERKORNAME AS AS_SUPPLIERNAME_05 ,
				   A.InQty		    AS AS_INQTY_05        ,
				   A.BadQty		    AS AS_BADQTY_05       ,
				   A.BadRate		AS AS_BADRATE_05      ,
				   ' '              AS AS_SUPPLIERNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_SUPPLIERNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_SUPPLIERNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_SUPPLIERNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_SUPPLIERNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTSUPPLIER B
             WHERE A.SUPPLIERCODE *= B.SUPPLIERCODE
		       AND A.Seq = 5
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   A.DIVISIONCODE	AS AS_DIVISIONCODE	  ,
				   ' '              AS AS_SUPPLIERNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_SUPPLIERNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_SUPPLIERNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_SUPPLIERNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_SUPPLIERNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   B.SUPPLIERKORNAME AS AS_SUPPLIERNAME_06 ,
				   A.InQty		    AS AS_INQTY_06        ,
				   A.BadQty		    AS AS_BADQTY_06       ,
				   A.BadRate		AS AS_BADRATE_06      ,
				   ' '              AS AS_SUPPLIERNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_SUPPLIERNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_SUPPLIERNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_SUPPLIERNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTSUPPLIER B
             WHERE A.SUPPLIERCODE *= B.SUPPLIERCODE
		       AND A.Seq = 6
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   A.DIVISIONCODE	AS AS_DIVISIONCODE	  ,
				   ' '              AS AS_SUPPLIERNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_SUPPLIERNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_SUPPLIERNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_SUPPLIERNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_SUPPLIERNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_SUPPLIERNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   B.SUPPLIERKORNAME AS AS_SUPPLIERNAME_07 ,
				   A.InQty		    AS AS_INQTY_07        ,
				   A.BadQty		    AS AS_BADQTY_07       ,
				   A.BadRate		AS AS_BADRATE_07      ,
				   ' '              AS AS_SUPPLIERNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_SUPPLIERNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_SUPPLIERNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTSUPPLIER B
             WHERE A.SUPPLIERCODE *= B.SUPPLIERCODE
		       AND A.Seq = 7
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   A.DIVISIONCODE	AS AS_DIVISIONCODE	  ,
				   ' '              AS AS_SUPPLIERNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_SUPPLIERNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_SUPPLIERNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_SUPPLIERNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_SUPPLIERNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_SUPPLIERNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_SUPPLIERNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   B.SUPPLIERKORNAME AS AS_SUPPLIERNAME_08 ,
				   A.InQty		    AS AS_INQTY_08        ,
				   A.BadQty		    AS AS_BADQTY_08       ,
				   A.BadRate		AS AS_BADRATE_08      ,
				   ' '              AS AS_SUPPLIERNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_SUPPLIERNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTSUPPLIER B
             WHERE A.SUPPLIERCODE *= B.SUPPLIERCODE
		       AND A.Seq = 8
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   A.DIVISIONCODE	AS AS_DIVISIONCODE	  ,
				   ' '              AS AS_SUPPLIERNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_SUPPLIERNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_SUPPLIERNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_SUPPLIERNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_SUPPLIERNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_SUPPLIERNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_SUPPLIERNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_SUPPLIERNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   B.SUPPLIERKORNAME AS AS_SUPPLIERNAME_09 ,
				   A.InQty		    AS AS_INQTY_09        ,
				   A.BadQty		    AS AS_BADQTY_09       ,
				   A.BadRate		AS AS_BADRATE_09      ,
				   ' '              AS AS_SUPPLIERNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTSUPPLIER B
             WHERE A.SUPPLIERCODE *= B.SUPPLIERCODE
		       AND A.Seq = 9
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   A.DIVISIONCODE	AS AS_DIVISIONCODE	  ,
				   ' '              AS AS_SUPPLIERNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_SUPPLIERNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_SUPPLIERNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_SUPPLIERNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_SUPPLIERNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_SUPPLIERNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_SUPPLIERNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_SUPPLIERNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_SUPPLIERNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   B.SUPPLIERKORNAME AS AS_SUPPLIERNAME_10 ,
				   A.InQty		    AS AS_INQTY_10        ,
				   A.BadQty		    AS AS_BADQTY_10       ,
				   A.BadRate		AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTSUPPLIER B
             WHERE A.SUPPLIERCODE *= B.SUPPLIERCODE
		       AND A.Seq = 10
      ) TEMP, TMSTAREA A, TMSTDIVISION B
    WHERE AS_AREACODE		= A.AREACODE
      AND AS_AREACODE		= B.AREACODE
      AND AS_DIVISIONCODE	= B.DIVISIONCODE
	GROUP BY AS_AREACODE, AS_DIVISIONCODE, A.AREANAME, B.DIVISIONNAME, B.SORTORDER
	ORDER BY AS_AREACODE, B.SORTORDER


DROP TABLE #Tmp_Worst

END 

go
