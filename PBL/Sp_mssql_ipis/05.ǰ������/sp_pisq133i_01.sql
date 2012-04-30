/************************************************************************************************/
/*	File Name	: sp_pisq133i_01.SQL                                                            */
/*	SYSTEM		: ǰ������(��ǰǰ��)                                                            */
/*	Description	: ���԰˻� �ҷ���(�������ҷ���-������)                                          */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCRESULT                                                                    */
/*  Parameter   : @ps_AreaCode          char(01)    => ��������                                 */
/*                @ps_divisioncode      char(1)     => �����ڵ�                                 */
/*                @ps_suppliercode      varchar(05) => ���¾�ü�ڵ�								*/
/*                @ps_itemcode 			varchar(12) => ǰ���ڵ�									*/
/*                @ps_QCDateFm          char(10)    => ��ȸ����FROM                             */
/*                @ps_QCDateTo          char(10)    => ��ȸ����TO                               */
/*	Notes		: ���԰˻� �ҷ��� ��Ȳ�� ������ �ҷ��� �ڷḦ ��ȸ�Ѵ�.                         */
/*	Made Date	: 2002. 09. 16                                                                  */
/*	Author		: �������-������                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq133i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq133i_01
GO
/*
Exec sp_pisq133i_01
		@ps_AreaCode        = 'D'               ,
		@ps_DivisionCode    = 'H'               ,
		@ps_suppliercode    = '%'				,
		@ps_itemcode		= '%'				,
        @ps_QCDateFm        = '2002.01.01'      ,
        @ps_QCDateTo        = '2002.12.31'		

*/


/****** Object:  Stored Procedure dbo.sp_pisq133i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq133i_01
        @ps_AreaCode          char(01)      ,   -- ��������
        @ps_DivisionCode      char(01)      ,   -- �����ڵ�
		@ps_suppliercode      varchar(05)	,	-- ���¾�ü�ڵ�
		@ps_itemcode 		  varchar(12)	,	-- ǰ���ڵ�
        @ps_QCDateFm          char(10)      ,   -- ��ȸ����FROM
        @ps_QCDateTo          char(10)          -- ��ȸ����TO

AS

BEGIN

	SELECT AS_AREACODE			   AS AS_AREA		,
		   MAX(AS_BADREASON_01)	   AS AS_REASON_01	,
		   MAX(AS_INAME_01)		   AS AS_NAME_01	,
		   SUM(AS_IN_01)		   AS AS_INQTY_01	,
		   SUM(AS_BAD_01)	   	   AS AS_BADQTY_01	,
		   SUM(AS_RATE_01)		   AS AS_BADRATE_01	,
		   MAX(AS_BADREASON_02)	   AS AS_REASON_02	,
		   MAX(AS_INAME_02)		   AS AS_NAME_02	,    
		   SUM(AS_IN_02)		   AS AS_INQTY_02	,    
		   SUM(AS_BAD_02)	   	   AS AS_BADQTY_02	,
		   SUM(AS_RATE_02)		   AS AS_BADRATE_02	,
		   MAX(AS_BADREASON_03)	   AS AS_REASON_03	,
		   MAX(AS_INAME_03)		   AS AS_NAME_03	,    
		   SUM(AS_IN_03)		   AS AS_INQTY_03	,    
		   SUM(AS_BAD_03)	   	   AS AS_BADQTY_03	,
		   SUM(AS_RATE_03)		   AS AS_BADRATE_03	,
		   MAX(AS_BADREASON_04)	   AS AS_REASON_04	,
		   MAX(AS_INAME_04)		   AS AS_NAME_04	,    
		   SUM(AS_IN_04)		   AS AS_INQTY_04	,    
		   SUM(AS_BAD_04)	   	   AS AS_BADQTY_04	,
		   SUM(AS_RATE_04)		   AS AS_BADRATE_04	,
		   MAX(AS_BADREASON_05)	   AS AS_REASON_05	,
		   MAX(AS_INAME_05)		   AS AS_NAME_05	,    
		   SUM(AS_IN_05)		   AS AS_INQTY_05	,    
		   SUM(AS_BAD_05)	   	   AS AS_BADQTY_05	,
		   SUM(AS_RATE_05)		   AS AS_BADRATE_05	,
		   MAX(AS_BADREASON_06)	   AS AS_REASON_06	,
		   MAX(AS_INAME_06)		   AS AS_NAME_06	,    
		   SUM(AS_IN_06)		   AS AS_INQTY_06	,    
		   SUM(AS_BAD_06)	   	   AS AS_BADQTY_06	,
		   SUM(AS_RATE_06)		   AS AS_BADRATE_06	
	  FROM ( SELECT A.AREACODE													AS AS_AREACODE			,
					A.BADREASON													AS AS_BADREASON_01		,
					CASE A.BADREASON WHEN '1' THEN '�ܰ��ҷ�' END 				AS AS_INAME_01			,
					AS_INQTY 													AS AS_IN_01				,
					sum(A.BADQTY)												AS AS_BAD_01	    	,
					(cast(SUM(A.BADQTY) as float) / cast(AS_INQTY as float)) * 100 AS AS_RATE_01,
					' '															AS AS_BADREASON_02		,
					' '															AS AS_INAME_02			,
					0															AS AS_IN_02				,
					0															AS AS_BAD_02	    	,
					0															AS AS_RATE_02			,
					' '															AS AS_BADREASON_03		,
					' '															AS AS_INAME_03			,
					0															AS AS_IN_03				,
					0															AS AS_BAD_03	    	,
					0															AS AS_RATE_03			,
					' '															AS AS_BADREASON_04		,
					' '															AS AS_INAME_04			,
					0															AS AS_IN_04				,
					0															AS AS_BAD_04	    	,
					0															AS AS_RATE_04			,
					' '															AS AS_BADREASON_05		,
					' '															AS AS_INAME_05			,
					0															AS AS_IN_05				,
					0															AS AS_BAD_05	    	,
					0															AS AS_RATE_05			,
					' '															AS AS_BADREASON_06		,
					' '															AS AS_INAME_06			,
					0															AS AS_IN_06				,
					0															AS AS_BAD_06	    	,
					0															AS AS_RATE_06		
			   FROM TQQCRESULT A,
				   ( SELECT sum(A.SUPPLIERDELIVERYQTY)	AS AS_INQTY
					   FROM TQQCRESULT A
		     		  WHERE A.AREACODE      =	@ps_AreaCode
		       		    AND A.DIVISIONCODE  =	@ps_DivisionCode
			   			AND A.SUPPLIERCODE  LIKE @ps_suppliercode
			   			AND A.ITEMCODE	    LIKE @ps_itemcode
		       			AND A.QCDATE        >=	@ps_QCDateFm
		       			AND A.QCDATE        <=	@ps_QCDateTo ) TMP
			  WHERE A.AREACODE      =	 @ps_AreaCode
			    AND A.DIVISIONCODE  =	 @ps_DivisionCode
			    AND A.SUPPLIERCODE  LIKE @ps_suppliercode
			    AND A.ITEMCODE	    LIKE @ps_itemcode
			    AND A.QCDATE        >=	 @ps_QCDateFm
			    AND A.QCDATE        <=	 @ps_QCDateTo
			    AND A.BADREASON     =    '1'
			  GROUP BY A.AREACODE, A.BADREASON, AS_INQTY
			
			UNION ALL

			 SELECT A.AREACODE													AS AS_AREACODE			,
					' '															AS AS_BADREASON_01		,
					' '															AS AS_INAME_01			,
					0															AS AS_IN_01				,
					0															AS AS_BAD_01	    	,
					0															AS AS_RATE_01			,
					A.BADREASON													AS AS_BADREASON_02		,
					CASE A.BADREASON WHEN '2' THEN 'ġ���ҷ�' END 				AS AS_INAME_02			,
					AS_INQTY													AS AS_IN_02				,
					sum(A.BADQTY)												AS AS_BAD_02	    	,
					(cast(SUM(A.BADQTY) as float) / cast(AS_INQTY as float)) * 100 AS AS_RATE_02,
					' '															AS AS_BADREASON_03		,
					' '															AS AS_INAME_03			,
					0															AS AS_IN_03				,
					0															AS AS_BAD_03	    	,
					0															AS AS_RATE_03			,
					' '															AS AS_BADREASON_04		,
					' '															AS AS_INAME_04			,
					0															AS AS_IN_04				,
					0															AS AS_BAD_04	    	,
					0															AS AS_RATE_04			,
					' '															AS AS_BADREASON_05		,
					' '															AS AS_INAME_05			,
					0															AS AS_IN_05				,
					0															AS AS_BAD_05	    	,
					0															AS AS_RATE_05			,
					' '															AS AS_BADREASON_06		,
					' '															AS AS_INAME_06			,
					0															AS AS_IN_06				,
					0															AS AS_BAD_06	    	,
					0															AS AS_RATE_06		
			   FROM TQQCRESULT A,
				   ( SELECT sum(A.SUPPLIERDELIVERYQTY)	AS AS_INQTY
					   FROM TQQCRESULT A
		     		  WHERE A.AREACODE      =	@ps_AreaCode
		       		    AND A.DIVISIONCODE  =	@ps_DivisionCode
			   			AND A.SUPPLIERCODE  LIKE @ps_suppliercode
			   			AND A.ITEMCODE	    LIKE @ps_itemcode
		       			AND A.QCDATE        >=	@ps_QCDateFm
		       			AND A.QCDATE        <=	@ps_QCDateTo ) TMP
			  WHERE A.AREACODE      =	 @ps_AreaCode
			    AND A.DIVISIONCODE  =	 @ps_DivisionCode
			    AND A.SUPPLIERCODE  LIKE @ps_suppliercode
			    AND A.ITEMCODE	    LIKE @ps_itemcode
			    AND A.QCDATE        >=	 @ps_QCDateFm
			    AND A.QCDATE        <=	 @ps_QCDateTo
			    AND A.BADREASON     =    '2'
			  GROUP BY A.AREACODE, A.BADREASON, AS_INQTY

			UNION ALL

			 SELECT A.AREACODE													AS AS_AREACODE			,
					' '															AS AS_BADREASON_01		,
					' '															AS AS_INAME_01			,
					0															AS AS_IN_01				,
					0															AS AS_BAD_01	    	,
					0															AS AS_RATE_01			,
					' '															AS AS_BADREASON_02		,
					' '															AS AS_INAME_02			,
					0															AS AS_IN_02				,
					0															AS AS_BAD_02	    	,
					0															AS AS_RATE_02			,
					A.BADREASON													AS AS_BADREASON_03		,
					CASE A.BADREASON WHEN '3' THEN '���ɺҷ�' END 				AS AS_INAME_03			,
					AS_INQTY													AS AS_IN_03				,
					sum(A.BADQTY)												AS AS_BAD_03	    	,
					(cast(SUM(A.BADQTY) as float) / cast(AS_INQTY as float)) * 100 AS AS_RATE_03,
					' '															AS AS_BADREASON_04		,
					' '															AS AS_INAME_04			,
					0															AS AS_IN_04				,
					0															AS AS_BAD_04	    	,
					0															AS AS_RATE_04			,
					' '															AS AS_BADREASON_05		,
					' '															AS AS_INAME_05			,
					0															AS AS_IN_05				,
					0															AS AS_BAD_05	    	,
					0															AS AS_RATE_05			,
					' '															AS AS_BADREASON_06		,
					' '															AS AS_INAME_06			,
					0															AS AS_IN_06				,
					0															AS AS_BAD_06	    	,
					0															AS AS_RATE_06		
			   FROM TQQCRESULT A,
				   ( SELECT sum(A.SUPPLIERDELIVERYQTY)	AS AS_INQTY
					   FROM TQQCRESULT A
		     		  WHERE A.AREACODE      =	@ps_AreaCode
		       		    AND A.DIVISIONCODE  =	@ps_DivisionCode
			   			AND A.SUPPLIERCODE  LIKE @ps_suppliercode
			   			AND A.ITEMCODE	    LIKE @ps_itemcode
		       			AND A.QCDATE        >=	@ps_QCDateFm
		       			AND A.QCDATE        <=	@ps_QCDateTo ) TMP
			  WHERE A.AREACODE      =	 @ps_AreaCode
			    AND A.DIVISIONCODE  =	 @ps_DivisionCode
			    AND A.SUPPLIERCODE  LIKE @ps_suppliercode
			    AND A.ITEMCODE	    LIKE @ps_itemcode
			    AND A.QCDATE        >=	 @ps_QCDateFm
			    AND A.QCDATE        <=	 @ps_QCDateTo
			    AND A.BADREASON     =    '3'
			  GROUP BY A.AREACODE, A.BADREASON, AS_INQTY

			UNION ALL

			 SELECT A.AREACODE													AS AS_AREACODE			,
					' '															AS AS_BADREASON_01		,
					' '															AS AS_INAME_01			,
					0															AS AS_IN_01				,
					0															AS AS_BAD_01	    	,
					0															AS AS_RATE_01			,
					' '															AS AS_BADREASON_02		,
					' '															AS AS_INAME_02			,
					0															AS AS_IN_02				,
					0															AS AS_BAD_02	    	,
					0															AS AS_RATE_02			,
					' '															AS AS_BADREASON_03		,
					' '															AS AS_INAME_03			,
					0															AS AS_IN_03				,
					0															AS AS_BAD_03	    	,
					0															AS AS_RATE_03			,
					A.BADREASON													AS AS_BADREASON_04		,
					CASE A.BADREASON WHEN '4' THEN '����ҷ�' END 				AS AS_INAME_04			,
					AS_INQTY													AS AS_IN_04				,
					sum(A.BADQTY)												AS AS_BAD_04	    	,
					(cast(SUM(A.BADQTY) as float) / cast(AS_INQTY as float)) * 100 AS AS_RATE_04,
					' '															AS AS_BADREASON_05		,
					' '															AS AS_INAME_05			,
					0															AS AS_IN_05				,
					0															AS AS_BAD_05	    	,
					0															AS AS_RATE_05			,
					' '															AS AS_BADREASON_06		,
					' '															AS AS_INAME_06			,
					0															AS AS_IN_06				,
					0															AS AS_BAD_06	    	,
					0															AS AS_RATE_06		
			   FROM TQQCRESULT A,
				   ( SELECT sum(A.SUPPLIERDELIVERYQTY)	AS AS_INQTY
					   FROM TQQCRESULT A
		     		  WHERE A.AREACODE      =	@ps_AreaCode
		       		    AND A.DIVISIONCODE  =	@ps_DivisionCode
			   			AND A.SUPPLIERCODE  LIKE @ps_suppliercode
			   			AND A.ITEMCODE	    LIKE @ps_itemcode
		       			AND A.QCDATE        >=	@ps_QCDateFm
		       			AND A.QCDATE        <=	@ps_QCDateTo ) TMP
			  WHERE A.AREACODE      =	 @ps_AreaCode
			    AND A.DIVISIONCODE  =	 @ps_DivisionCode
			    AND A.SUPPLIERCODE  LIKE @ps_suppliercode
			    AND A.ITEMCODE	    LIKE @ps_itemcode
			    AND A.QCDATE        >=	 @ps_QCDateFm
			    AND A.QCDATE        <=	 @ps_QCDateTo
			    AND A.BADREASON     =    '4'
			  GROUP BY A.AREACODE, A.BADREASON, AS_INQTY

			UNION ALL

			 SELECT A.AREACODE													AS AS_AREACODE			,
					' '															AS AS_BADREASON_01		,
					' '															AS AS_INAME_01			,
					0															AS AS_IN_01				,
					0															AS AS_BAD_01	    	,
					0															AS AS_RATE_01			,
					' '															AS AS_BADREASON_02		,
					' '															AS AS_INAME_02			,
					0															AS AS_IN_02				,
					0															AS AS_BAD_02	    	,
					0															AS AS_RATE_02			,
					' '															AS AS_BADREASON_03		,
					' '															AS AS_INAME_03			,
					0															AS AS_IN_03				,
					0															AS AS_BAD_03	    	,
					0															AS AS_RATE_03			,
					' '															AS AS_BADREASON_04		,
					' '															AS AS_INAME_04			,
					0															AS AS_IN_04				,
					0															AS AS_BAD_04	    	,
					0															AS AS_RATE_04			,
					A.BADREASON													AS AS_BADREASON_05		,
					CASE A.BADREASON WHEN '5' THEN '�����ҷ�' END 				AS AS_INAME_05			,
					AS_INQTY													AS AS_IN_05				,
					sum(A.BADQTY)												AS AS_BAD_05	    	,
					(cast(SUM(A.BADQTY) as float) / cast(AS_INQTY as float)) * 100 AS AS_RATE_05,
					' '															AS AS_BADREASON_06		,
					' '															AS AS_INAME_06			,
					0															AS AS_IN_06				,
					0															AS AS_BAD_06	    	,
					0															AS AS_RATE_06		
			   FROM TQQCRESULT A,
				   ( SELECT sum(A.SUPPLIERDELIVERYQTY)	AS AS_INQTY
					   FROM TQQCRESULT A
		     		  WHERE A.AREACODE      =	@ps_AreaCode
		       		    AND A.DIVISIONCODE  =	@ps_DivisionCode
			   			AND A.SUPPLIERCODE  LIKE @ps_suppliercode
			   			AND A.ITEMCODE	    LIKE @ps_itemcode
		       			AND A.QCDATE        >=	@ps_QCDateFm
		       			AND A.QCDATE        <=	@ps_QCDateTo ) TMP
			  WHERE A.AREACODE      =	 @ps_AreaCode
			    AND A.DIVISIONCODE  =	 @ps_DivisionCode
			    AND A.SUPPLIERCODE  LIKE @ps_suppliercode
			    AND A.ITEMCODE	    LIKE @ps_itemcode
			    AND A.QCDATE        >=	 @ps_QCDateFm
			    AND A.QCDATE        <=	 @ps_QCDateTo
			    AND A.BADREASON     =    '5'
			  GROUP BY A.AREACODE, A.BADREASON, AS_INQTY
			
			UNION ALL

			 SELECT A.AREACODE													AS AS_AREACODE			,
					' '															AS AS_BADREASON_01		,
					' '															AS AS_INAME_01			,
					0															AS AS_IN_01				,
					0															AS AS_BAD_01	    	,
					0															AS AS_RATE_01			,
					' '															AS AS_BADREASON_02		,
					' '															AS AS_INAME_02			,
					0															AS AS_IN_02				,
					0															AS AS_BAD_02	    	,
					0															AS AS_RATE_02			,
					' '															AS AS_BADREASON_03		,
					' '															AS AS_INAME_03			,
					0															AS AS_IN_03				,
					0															AS AS_BAD_03	    	,
					0															AS AS_RATE_03			,
					' '															AS AS_BADREASON_04		,
					' '															AS AS_INAME_04			,
					0															AS AS_IN_04				,
					0															AS AS_BAD_04	    	,
					0															AS AS_RATE_04			,
					' '															AS AS_BADREASON_05		,
					' '															AS AS_INAME_05			,
					0															AS AS_IN_05				,
					0															AS AS_BAD_05	    	,
					0															AS AS_RATE_05			,
					A.BADREASON													AS AS_BADREASON_06		,
					CASE A.BADREASON WHEN '6' THEN '��Ÿ�ҷ�' END 				AS AS_INAME_06			,
					AS_INQTY													AS AS_IN_06				,
					sum(A.BADQTY)												AS AS_BAD_06	    	,
					(cast(SUM(A.BADQTY) as float) / cast(AS_INQTY as float)) * 100 AS AS_RATE_06
			   FROM TQQCRESULT A,
				   ( SELECT sum(A.SUPPLIERDELIVERYQTY)	AS AS_INQTY
					   FROM TQQCRESULT A
		     		  WHERE A.AREACODE      =	@ps_AreaCode
		       		    AND A.DIVISIONCODE  =	@ps_DivisionCode
			   			AND A.SUPPLIERCODE  LIKE @ps_suppliercode
			   			AND A.ITEMCODE	    LIKE @ps_itemcode
		       			AND A.QCDATE        >=	@ps_QCDateFm
		       			AND A.QCDATE        <=	@ps_QCDateTo ) TMP
			  WHERE A.AREACODE      =	 @ps_AreaCode
			    AND A.DIVISIONCODE  =	 @ps_DivisionCode
			    AND A.SUPPLIERCODE  LIKE @ps_suppliercode
			    AND A.ITEMCODE	    LIKE @ps_itemcode
			    AND A.QCDATE        >=	 @ps_QCDateFm
			    AND A.QCDATE        <=	 @ps_QCDateTo
			    AND A.BADREASON     =    '6'
			  GROUP BY A.AREACODE, A.BADREASON, AS_INQTY
		   ) TEMP
	GROUP BY AS_AREACODE

    
END 

go
