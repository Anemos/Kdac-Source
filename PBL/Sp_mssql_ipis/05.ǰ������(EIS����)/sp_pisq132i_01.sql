SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*
Exec sp_pisq132i_01
		@ps_AreaCode        = 'D'               ,
		@ps_DivisionCode    = 'H'               ,
        @ps_QCDateFm        = '2002.01.01'      ,
        @ps_QCDateTo        = '2002.12.31'
*/


/****** Object:  Stored Procedure dbo.sp_pisq132i_01    Script Date: 02-09-01  ******/
ALTER  PROCEDURE sp_pisq132i_01
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_QCDateFm          char(10)      ,   -- 조회일자FROM
        @ps_QCDateTo          char(10)          -- 조회일자TO
AS

BEGIN

	-- 업체별 WORST 10을 저장할 임시테이블
	--
	Create Table #Tmp_Worst
	(
		Seq				Int      	,
		AreaCode        Char(1)  	,
		ItemCode		VarChar(12) ,
		InQty			Int      	,
		BadQty			Int      	,
		BadRate			float      
	)
	
	Declare	@li_Seq	            Int      	, 
            @ps_Area            char(01) 	,
            @ps_ItemCode		Varchar(12) ,
            @pi_InQty			Int      	,
            @pi_BadQty			Int      	,
            @pf_BadRate			float       ,
            @pi_count			Int      

	SET @pi_count = 0 

	Begin
		SELECT @pi_count = count(AS_ITEMCODE)
		  FROM (
			SELECT A.ITEMCODE AS AS_ITEMCODE
			  FROM TQQCRESULT A
	         WHERE A.AREACODE      =  @ps_AreaCode
	           AND A.DIVISIONCODE  =  @ps_DivisionCode
	           AND A.QCDATE        >= @ps_QCDateFm
			   AND A.QCDATE        <= @ps_QCDateTo
		   	   AND A.BADQTY			> 0
			 GROUP BY A.ITEMCODE ) TEMP
	End

	IF @pi_count = 0 GOTO process_end
	
	IF @pi_count > 10 SET @pi_count = 10

	SET @li_Seq = 0

	While @li_Seq < @pi_count
	Begin
		SET @li_Seq = @li_Seq + 1
       	Set RowCount @li_Seq 
		SELECT @li_Seq		    = @li_Seq    		,
			   @ps_Area      	= A.AREACODE 		,
			   @ps_ItemCode 	= A.ITEMCODE		,
			   @pi_InQty		= isnull(sum(A.SUPPLIERDELIVERYQTY), 0)	,
			   @pi_BadQty		= isnull(sum(A.BADQTY), 0)					,
			   @pf_BadRate		= isnull((cast(SUM(A.BADQTY) as float) / cast(sum(A.SUPPLIERDELIVERYQTY) as float)) * 100, 0)
		  FROM TQQCRESULT A
         WHERE A.AREACODE      =  @ps_AreaCode
           AND A.DIVISIONCODE  =  @ps_DivisionCode
           AND A.QCDATE        >= @ps_QCDateFm
		   AND A.QCDATE        <= @ps_QCDateTo
		 GROUP BY A.AREACODE, A.ITEMCODE
		 HAVING sum(A.BADQTY) > 0
		 ORDER BY (cast(SUM(A.BADQTY) as float) / cast(sum(A.SUPPLIERDELIVERYQTY) as float)) * 100   DESC 
		Insert #Tmp_Worst Values(@li_Seq, @ps_Area, @ps_ItemCode, @pi_InQty, @pi_BadQty, @pf_BadRate)
	End

process_end:

	SELECT AS_AREACODE             AS AS_AREA         ,
		   MAX(AS_ITEMNAME_01) 	   AS AS_NAME_01      ,
		   SUM(AS_INQTY_01)        AS AS_IQTY_01      ,
		   SUM(AS_BADQTY_01)       AS AS_BQTY_01      ,
		   SUM(AS_BADRATE_01)      AS AS_BRATE_01     ,
		   MAX(AS_ITEMNAME_02)     AS AS_NAME_02      ,
		   SUM(AS_INQTY_02)        AS AS_IQTY_02      ,
		   SUM(AS_BADQTY_02)       AS AS_BQTY_02      ,
		   SUM(AS_BADRATE_02)      AS AS_BRATE_02     ,
		   MAX(AS_ITEMNAME_03)     AS AS_NAME_03      ,
		   SUM(AS_INQTY_03)        AS AS_IQTY_03      ,
		   SUM(AS_BADQTY_03)       AS AS_BQTY_03      ,
		   SUM(AS_BADRATE_03)      AS AS_BRATE_03     ,
		   MAX(AS_ITEMNAME_04)     AS AS_NAME_04      ,
		   SUM(AS_INQTY_04)        AS AS_IQTY_04      ,
		   SUM(AS_BADQTY_04)       AS AS_BQTY_04      ,
		   SUM(AS_BADRATE_04)      AS AS_BRATE_04     ,
		   MAX(AS_ITEMNAME_05)     AS AS_NAME_05      ,
		   SUM(AS_INQTY_05)        AS AS_IQTY_05      ,
		   SUM(AS_BADQTY_05)       AS AS_BQTY_05      ,
		   SUM(AS_BADRATE_05)      AS AS_BRATE_05     ,
		   MAX(AS_ITEMNAME_06)     AS AS_NAME_06      ,
		   SUM(AS_INQTY_06)        AS AS_IQTY_06      ,
		   SUM(AS_BADQTY_06)       AS AS_BQTY_06      ,
		   SUM(AS_BADRATE_06)      AS AS_BRATE_06     ,
		   MAX(AS_ITEMNAME_07)     AS AS_NAME_07      ,
		   SUM(AS_INQTY_07)        AS AS_IQTY_07      ,
		   SUM(AS_BADQTY_07)       AS AS_BQTY_07      ,
		   SUM(AS_BADRATE_07)      AS AS_BRATE_07     ,
		   MAX(AS_ITEMNAME_08)     AS AS_NAME_08      ,
		   SUM(AS_INQTY_08)        AS AS_IQTY_08      ,
		   SUM(AS_BADQTY_08)       AS AS_BQTY_08      ,
		   SUM(AS_BADRATE_08)      AS AS_BRATE_08     ,
		   MAX(AS_ITEMNAME_09)     AS AS_NAME_09      ,
		   SUM(AS_INQTY_09)        AS AS_IQTY_09      ,
		   SUM(AS_BADQTY_09)       AS AS_BQTY_09      ,
		   SUM(AS_BADRATE_09)      AS AS_BRATE_09     ,
		   MAX(AS_ITEMNAME_10)     AS AS_NAME_10      ,
		   SUM(AS_INQTY_10)        AS AS_IQTY_10      ,
		   SUM(AS_BADQTY_10)       AS AS_BQTY_10      ,
		   SUM(AS_BADRATE_10)      AS AS_BRATE_10    
      FROM (SELECT A.AreaCode       AS AS_AREACODE        ,
				   B.ITEMNAME 		AS AS_ITEMNAME_01 ,
				   A.InQty		    AS AS_INQTY_01        ,
				   A.BadQty		    AS AS_BADQTY_01       ,
				   A.BadRate		AS AS_BADRATE_01      ,
				   ' '              AS AS_ITEMNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_ITEMNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_ITEMNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_ITEMNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_ITEMNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_ITEMNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_ITEMNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_ITEMNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_ITEMNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTITEM B
             WHERE A.ITEMCODE = B.ITEMCODE
		       AND A.Seq = 1  
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   ' '              AS AS_ITEMNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   B.ITEMNAME 		AS AS_ITEMNAME_02 ,
				   A.InQty		    AS AS_INQTY_02        ,
				   A.BadQty		    AS AS_BADQTY_02       ,
				   A.BadRate		AS AS_BADRATE_02      ,
				   ' '              AS AS_ITEMNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_ITEMNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_ITEMNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_ITEMNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_ITEMNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_ITEMNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_ITEMNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_ITEMNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTITEM B
             WHERE A.ITEMCODE = B.ITEMCODE
		       AND A.Seq = 2
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   ' '              AS AS_ITEMNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_ITEMNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   B.ITEMNAME 		AS AS_ITEMNAME_03 ,
				   A.InQty		    AS AS_INQTY_03        ,
				   A.BadQty		    AS AS_BADQTY_03       ,
				   A.BadRate		AS AS_BADRATE_03      ,
				   ' '              AS AS_ITEMNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_ITEMNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_ITEMNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_ITEMNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_ITEMNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_ITEMNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_ITEMNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTITEM B
             WHERE A.ITEMCODE = B.ITEMCODE
		       AND A.Seq = 3
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   ' '              AS AS_ITEMNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_ITEMNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_ITEMNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   B.ITEMNAME 		AS AS_ITEMNAME_04 ,
				   A.InQty		    AS AS_INQTY_04        ,
				   A.BadQty		    AS AS_BADQTY_04       ,
				   A.BadRate		AS AS_BADRATE_04      ,
				   ' '              AS AS_ITEMNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_ITEMNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_ITEMNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_ITEMNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_ITEMNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_ITEMNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTITEM B
             WHERE A.ITEMCODE = B.ITEMCODE
		       AND A.Seq = 4
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   ' '              AS AS_ITEMNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_ITEMNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_ITEMNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_ITEMNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   B.ITEMNAME 		AS AS_ITEMNAME_05 ,
				   A.InQty		    AS AS_INQTY_05        ,
				   A.BadQty		    AS AS_BADQTY_05       ,
				   A.BadRate		AS AS_BADRATE_05      ,
				   ' '              AS AS_ITEMNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_ITEMNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_ITEMNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_ITEMNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_ITEMNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTITEM B
             WHERE A.ITEMCODE = B.ITEMCODE
		       AND A.Seq = 5
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   ' '              AS AS_ITEMNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_ITEMNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_ITEMNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_ITEMNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_ITEMNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   B.ITEMNAME 		AS AS_ITEMNAME_06 ,
				   A.InQty		    AS AS_INQTY_06        ,
				   A.BadQty		    AS AS_BADQTY_06       ,
				   A.BadRate		AS AS_BADRATE_06      ,
				   ' '              AS AS_ITEMNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_ITEMNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_ITEMNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_ITEMNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTITEM B
             WHERE A.ITEMCODE = B.ITEMCODE
		       AND A.Seq = 6
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   ' '              AS AS_ITEMNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_ITEMNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_ITEMNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_ITEMNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_ITEMNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_ITEMNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   B.ITEMNAME 		AS AS_ITEMNAME_07 ,
				   A.InQty		    AS AS_INQTY_07        ,
				   A.BadQty		    AS AS_BADQTY_07       ,
				   A.BadRate		AS AS_BADRATE_07      ,
				   ' '              AS AS_ITEMNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_ITEMNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_ITEMNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTITEM B
             WHERE A.ITEMCODE = B.ITEMCODE
		       AND A.Seq = 7
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   ' '              AS AS_ITEMNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_ITEMNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_ITEMNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_ITEMNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_ITEMNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_ITEMNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_ITEMNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   B.ITEMNAME 		AS AS_ITEMNAME_08 ,
				   A.InQty		    AS AS_INQTY_08        ,
				   A.BadQty		    AS AS_BADQTY_08       ,
				   A.BadRate		AS AS_BADRATE_08      ,
				   ' '              AS AS_ITEMNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   ' '              AS AS_ITEMNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTITEM B
             WHERE A.ITEMCODE = B.ITEMCODE
		       AND A.Seq = 8
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   ' '              AS AS_ITEMNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_ITEMNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_ITEMNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_ITEMNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_ITEMNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_ITEMNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_ITEMNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_ITEMNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   B.ITEMNAME 		AS AS_ITEMNAME_09 ,
				   A.InQty		    AS AS_INQTY_09        ,
				   A.BadQty		    AS AS_BADQTY_09       ,
				   A.BadRate		AS AS_BADRATE_09      ,
				   ' '              AS AS_ITEMNAME_10 ,
				   0                AS AS_INQTY_10        ,
				   0                AS AS_BADQTY_10       ,
				   0                AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTITEM B
             WHERE A.ITEMCODE = B.ITEMCODE
		       AND A.Seq = 9
		
		    UNION ALL
		    
			SELECT A.AreaCode       AS AS_AREACODE        ,
				   ' '              AS AS_ITEMNAME_01 ,
				   0                AS AS_INQTY_01        ,
				   0                AS AS_BADQTY_01       ,
				   0                AS AS_BADRATE_01      ,
				   ' '              AS AS_ITEMNAME_02 ,
				   0                AS AS_INQTY_02        ,
				   0                AS AS_BADQTY_02       ,
				   0                AS AS_BADRATE_02      ,
				   ' '              AS AS_ITEMNAME_03 ,
				   0                AS AS_INQTY_03        ,
				   0                AS AS_BADQTY_03       ,
				   0                AS AS_BADRATE_03      ,
				   ' '              AS AS_ITEMNAME_04 ,
				   0                AS AS_INQTY_04        ,
				   0                AS AS_BADQTY_04       ,
				   0                AS AS_BADRATE_04      ,
				   ' '              AS AS_ITEMNAME_05 ,
				   0                AS AS_INQTY_05        ,
				   0                AS AS_BADQTY_05       ,
				   0                AS AS_BADRATE_05      ,
				   ' '              AS AS_ITEMNAME_06 ,
				   0                AS AS_INQTY_06        ,
				   0                AS AS_BADQTY_06       ,
				   0                AS AS_BADRATE_06      ,
				   ' '              AS AS_ITEMNAME_07 ,
				   0                AS AS_INQTY_07        ,
				   0                AS AS_BADQTY_07       ,
				   0                AS AS_BADRATE_07      ,
				   ' '              AS AS_ITEMNAME_08 ,
				   0                AS AS_INQTY_08        ,
				   0                AS AS_BADQTY_08       ,
				   0                AS AS_BADRATE_08      ,
				   ' '              AS AS_ITEMNAME_09 ,
				   0                AS AS_INQTY_09        ,
				   0                AS AS_BADQTY_09       ,
				   0                AS AS_BADRATE_09      ,
				   B.ITEMNAME 		AS AS_ITEMNAME_10 ,
				   A.InQty		    AS AS_INQTY_10        ,
				   A.BadQty		    AS AS_BADQTY_10       ,
				   A.BadRate		AS AS_BADRATE_10      
		      FROM #Tmp_Worst A, TMSTITEM B
             WHERE A.ITEMCODE = B.ITEMCODE
		       AND A.Seq = 10
      ) TEMP
	GROUP BY AS_AREACODE

    Drop Table #Tmp_Worst

END 


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

