/************************************************************************************************/
/*	File Name	: sp_pisq345i_01.SQL                                                            */
/*	SYSTEM		: 품질관리(고객품질)                                                            */
/*	Description	: Warranty품 분석 SHEET 현황                                                    */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCRESULT	                                                                */
/*	              TMSTAREA	                                                                    */
/*	              TMSTDIVISION	                                                                */
/*	              TMSTSUPPLIER	                                                                */
/*	              TMSTITEM		                                                                */
/*	              TMSTEMP		                                                                */
/*	              TMSTEMP		                                                                */
/*  Parameter   : @ps_areacode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_datefm			char(10)    => 분석일자 FROM                            */
/*                @ps_dateto			char(10)    => 분석일자 TO								*/
/*				  @ps_customercode		char(06)    => CUSTOMER CODE							*/
/*	Notes		: Warranty품 분석 SHEET 현황을 조회한다.  	                                    */
/*	Made Date	: 2002. 10. 31                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq345i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq345i_01
GO
/*
Exec sp_pisq345i_01
		@ps_areacode        = 'D'           ,
		@ps_divisioncode    = 'A'           ,
		@ps_datefm			= '2001.01.01'	,
		@ps_dateto			= '2003.01.01'	,
		@ps_customercode	= '%'
*/


/****** Object:  Stored Procedure dbo.sp_pisq345i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq345i_01
        @ps_areacode			char(01)	,   -- 지역구분
        @ps_divisioncode		char(01)	,   -- 공장코드
		@ps_datefm				char(10)    ,	-- 일자 FROM
		@ps_dateto				char(10)    ,	-- 일자 TO
		@ps_customercode		varchar(06)		-- CUSTOMER CODE

AS

BEGIN
	SELECT	A.AREACODE,   
			A.DIVISIONCODE,   
			A.ANALYZEDATE,   
			A.CUSTOMERCODE,   
			C.CUSTNAME,   
			A.ITEMCODE,   
			D.ITEMNAME,   
			A.SEQNO,   
			A.RAISEDATE,   
			A.ACCOUNTDATE,   
			A.PRODUCTGROUP,   
			E.PRODUCTGROUPNAME,   
			A.CUSTOMITEMCODE,   
			A.ADAPTCAR,   
			A.MODELNAME,   
			A.CARNO,   
			A.DCRNO,   
			A.REPAIRSITE,   
			A.CARDISTANCE,   
			A.LOTNO,   
			A.OUTDATE,   
			A.REPAIRDATE,   
			A.BADCONTENT,   
			A.ANALYZECODE,   
			B.SMALLGROUPNAME,
			A.CUSTOMCODE,   
			A.OUTSIDECUSTOMCODE,   
			A.EXTERNALVIEW,   
			A.PERFORMANCE,   
			A.SIZE,   
			A.MEMO  
	  FROM	TQWARRANTYSHEET		A,
			TQWARRANTYSMALL		B,
			TMSTCUSTOMER		C,
			TMSTITEM			D,
			TMSTPRODUCTGROUP	E
	 WHERE	A.AREACODE			*= B.AREACODE 
	   AND	A.DIVISIONCODE		*= B.DIVISIONCODE
	   AND	A.PRODUCTGROUP   	*= B.PRODUCTGROUP
	   AND	A.ANALYZECODE		*= B.LARGEGROUPCODE + B.MIDDLEGROUPCODE + B.SMALLGROUPCODE
	   AND	A.CUSTOMERCODE  	*= C.CUSTCODE
	   AND	A.ITEMCODE			*= D.ITEMCODE
	   AND	A.AREACODE			*= E.AREACODE 
	   AND	A.DIVISIONCODE		*= E.DIVISIONCODE
	   AND	A.PRODUCTGROUP  	*= E.PRODUCTGROUP
	   AND	A.AREACODE		 	 = @ps_areacode
	   AND	A.DIVISIONCODE	 	 = @ps_divisioncode
	   AND	A.ANALYZEDATE		>= @ps_datefm
	   AND	A.ANALYZEDATE		<= @ps_dateto
	   AND	A.CUSTOMERCODE	  LIKE @ps_customercode

END 

go
