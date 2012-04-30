/************************************************************************************************/
/*	File Name	: sp_pisq115i_01.SQL                                                            */
/*	SYSTEM		: 품질관리(부품품질)                                                            */
/*	Description	: 검사성적서 현황		                                                        */
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
/*                @ps_suppliercode		char(05)    => 업체코드                                 */
/*                @ps_itemcode			varchar(12) => 품번		                                */
/*                @ps_datefm			char(10)    => 일자 FROM                            	*/
/*                @ps_dateto			char(10)    => 일자 TO									*/
/*                @ps_gubun				char(01)	=> 일자구분 1:검사일자, 2:작성일자			*/
/*	Notes		: 검사 성적서 자료를 조회한다.  		                                        */
/*	Made Date	: 2002. 09. 17                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq115i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq115i_01
GO
/*
Exec sp_pisq115i_01
		@ps_areacode        = 'D'           ,
		@ps_divisioncode    = 'S'           ,
		@ps_suppliercode	= '%'			,
		@ps_itemcode		= '%'			,
		@ps_datefm			= '2001.01.01'	,
		@ps_dateto			= '2001.01.01'	,
		@ps_gubun			= '1'
*/


/****** Object:  Stored Procedure dbo.sp_pisq115i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq115i_01
        @ps_areacode			char(01)	,   -- 지역구분
        @ps_divisioncode		char(01)	,   -- 공장코드
		@ps_suppliercode		varchar(05) ,	-- 업체코드
		@ps_itemcode			varchar(12) ,	-- 품번
		@ps_datefm				char(10)    ,	-- 일자 FROM
		@ps_dateto				char(10)    ,	-- 일자 TO
		@ps_gubun				char(01)		-- 일자구분 1:검사일자, 2:작성일자

AS

BEGIN

  SELECT CASE H.QCGUBUN
	         WHEN 'A' THEN 'A'
	         WHEN 'B' THEN 'B'
	         WHEN 'C' THEN 'C'
	         ELSE 'Z'
	     END 		AS AS_QCGUBUN,
  		 A.AREACODE				,
         B.AREANAME				,
         A.DIVISIONCODE			,
         C.DIVISIONNAME			,
         A.SUPPLIERCODE			,
         D.SUPPLIERKORNAME		,
         A.DELIVERYNO			,
         A.ITEMCODE				,
         E.ITEMNAME				,
         A.MAKEDATE				,
         A.CHARGENAME			,
         A.STANDARDREVNO		,
         A.SUPPLIERLOTQTY		,
         A.KBCOUNT				,
         A.SUPPLIERDELIVERYQTY	,
         A.QCMETHOD				,
         A.KDACREMARK			,
         A.REMARK				,
         A.JUDGEFLAG			,
         A.GOODQTY				,
         A.BADQTY				,
         A.BADREASON			,
         A.BADMEMO				,
         A.INSPECTORCODE		,
         F.EMPNAME 		AS AS_INSPECTOREMPNAME		,
         A.CONFIRMCODE			,
         G.EMPNAME		AS AS_CONFIRMEMPNAME		,
         A.CONFIRMFLAG			,
         A.PRINTFLAG			,
         A.QCDATE				,
         A.QCKBFLAG				,
         A.SLNO					,
         A.DELIVERYDATE			,
         A.DELIVERYTIME			
    FROM TQQCRESULT		A,
		 TMSTAREA		B,
         TMSTDIVISION	C,
         TMSTSUPPLIER	D,
         TMSTITEM		E,
         TMSTEMP		F,
         TMSTEMP		G,
		 TQQCITEM		H
   WHERE A.AREACODE			= B.AREACODE
	 AND A.AREACODE			= C.AREACODE
	 AND A.DIVISIONCODE		= C.DIVISIONCODE
	 AND A.SUPPLIERCODE		= D.SUPPLIERCODE
	 AND A.ITEMCODE			= E.ITEMCODE
	 AND A.INSPECTORCODE   *= F.EMPNO
	 AND A.CONFIRMCODE	   *= G.EMPNO
	 AND A.AREACODE		   *= H.AREACODE
	 AND A.DIVISIONCODE	   *= H.DIVISIONCODE
	 AND A.ITEMCODE		   *= H.ITEMCODE
	 AND A.SUPPLIERCODE	   *= H.SUPPLIERCODE
	 AND A.AREACODE			= @ps_areacode
	 AND A.DIVISIONCODE	 	= @ps_divisioncode
	 AND A.SUPPLIERCODE	 LIKE @ps_suppliercode
	 AND A.ITEMCODE		 LIKE @ps_itemcode
	 AND A.QCDATE		   >= @ps_datefm
	 AND A.QCDATE		   <= @ps_dateto
	 AND '1'			 	= @ps_gubun		

  UNION ALL
  	
  SELECT CASE H.QCGUBUN
	         WHEN 'A' THEN 'A'
	         WHEN 'B' THEN 'B'
	         WHEN 'C' THEN 'C'
	         ELSE 'Z'
	     END 		AS AS_QCGUBUN,
  		 A.AREACODE				,
         B.AREANAME				,
         A.DIVISIONCODE			,
         C.DIVISIONNAME			,
         A.SUPPLIERCODE			,
         D.SUPPLIERKORNAME		,
         A.DELIVERYNO			,
         A.ITEMCODE				,
         E.ITEMNAME				,
         A.MAKEDATE				,
         A.CHARGENAME			,
         A.STANDARDREVNO		,
         A.SUPPLIERLOTQTY		,
         A.KBCOUNT				,
         A.SUPPLIERDELIVERYQTY	,
         A.QCMETHOD				,
         A.KDACREMARK			,
         A.REMARK				,
         A.JUDGEFLAG			,
         A.GOODQTY				,
         A.BADQTY				,
         A.BADREASON			,
         A.BADMEMO				,
         A.INSPECTORCODE		,
         F.EMPNAME 		AS AS_INSPECTOREMPNAME		,
         A.CONFIRMCODE			,
         G.EMPNAME		AS AS_CONFIRMEMPNAME		,
         A.CONFIRMFLAG			,
         A.PRINTFLAG			,
         A.QCDATE				,
         A.QCKBFLAG				,
         A.SLNO					,
         A.DELIVERYDATE			,
         A.DELIVERYTIME			
    FROM TQQCRESULT		A,
		 TMSTAREA		B,
         TMSTDIVISION	C,
         TMSTSUPPLIER	D,
         TMSTITEM		E,
         TMSTEMP		F,
         TMSTEMP		G,
		 TQQCITEM		H
   WHERE A.AREACODE			= B.AREACODE
	 AND A.AREACODE			= C.AREACODE
	 AND A.DIVISIONCODE		= C.DIVISIONCODE
	 AND A.SUPPLIERCODE		= D.SUPPLIERCODE
	 AND A.ITEMCODE			= E.ITEMCODE
	 AND A.INSPECTORCODE   *= F.EMPNO
	 AND A.CONFIRMCODE	   *= G.EMPNO
	 AND A.AREACODE		   *= H.AREACODE
	 AND A.DIVISIONCODE	   *= H.DIVISIONCODE
	 AND A.ITEMCODE		   *= H.ITEMCODE
	 AND A.SUPPLIERCODE	   *= H.SUPPLIERCODE
	 AND A.AREACODE			= @ps_areacode
	 AND A.DIVISIONCODE		= @ps_divisioncode
	 AND A.SUPPLIERCODE	 LIKE @ps_suppliercode
	 AND A.ITEMCODE		 LIKE @ps_itemcode
	 AND A.MAKEDATE		   >= @ps_datefm
	 AND A.MAKEDATE		   <= @ps_dateto
	 AND '2'			 	= @ps_gubun		

END 

go
