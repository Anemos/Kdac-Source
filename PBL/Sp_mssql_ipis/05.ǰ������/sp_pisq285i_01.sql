/************************************************************************************************/
/*	File Name	: sp_pisq285i_01.SQL                                                            */
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
/*                @ps_datefm			char(10)    => 일자 FROM                            	*/
/*                @ps_dateto			char(10)    => 일자 TO									*/
/*	Notes		: 검사 성적서 자료를 조회한다.  		                                        */
/*	Made Date	: 2002. 09. 17                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq285i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq285i_01
GO
/*
Exec sp_pisq285i_01
		@ps_areacode        = 'D'           ,
		@ps_divisioncode    = 'A'           ,
		@ps_datefm			= '2001.01.01'	,
		@ps_dateto			= '2003.01.01'	
*/


/****** Object:  Stored Procedure dbo.sp_pisq285i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq285i_01
        @ps_areacode			char(01)	,   -- 지역구분
        @ps_divisioncode		char(01)	,   -- 공장코드
		@ps_datefm				char(10)    ,	-- 일자 FROM
		@ps_dateto				char(10)    	-- 일자 TO

AS

BEGIN

  SELECT A.AREACODE				,
         C.AREANAME				,
         A.DIVISIONCODE			,
         D.DIVISIONNAME			,
         A.PRDENDDATE			,
         A.KBNO					,
         A.PRDENDTIME			,
         A.ITEMCODE				,
         E.ITEMNAME  			,
         A.PRODUCTGROUP			,
         F.PRODUCTGROUPNAME		,
         A.MODELGROUP			,
         G.MODELGROUPNAME		,
         A.RACKQTY				,
         A.QCQTY				,
         A.QCFLAG				,
         A.QCEMPNO				,
         J.EMPNAME				,
         A.QCDATE				,
         B.BADREASONCODE		,
         H.CONTAINBADREASONNAME	,  
         B.BADTYPECODE			,
         I.CONTAINBADTYPENAME	,
         B.BADQTY
    FROM TQCONTAINQCENTRY		A,   
         TQCONTAINQCENTRYDETAIL	B,  
	     TMSTAREA				C,
         TMSTDIVISION			D,
         TMSTITEM				E,
         TMSTPRODUCTGROUP		F,
         TMSTMODELGROUP			G,
         TQCONTAINBADREASON		H,
         TQCONTAINBADTYPE		I,
		 TMSTEMP				J
   WHERE A.AREACODE			= B.AREACODE
	 AND A.DIVISIONCODE		= B.DIVISIONCODE
	 AND A.PRDENDDATE		= B.PRDENDDATE
	 AND A.KBNO				= B.KBNO
	 AND A.AREACODE			= C.AREACODE
	 AND A.AREACODE			= D.AREACODE
	 AND A.DIVISIONCODE		= D.DIVISIONCODE
	 AND A.ITEMCODE			= E.ITEMCODE
	 AND A.AREACODE			= F.AREACODE
	 AND A.DIVISIONCODE		= F.DIVISIONCODE
	 AND A.PRODUCTGROUP		= F.PRODUCTGROUP
	 AND A.AREACODE			= G.AREACODE
	 AND A.DIVISIONCODE		= G.DIVISIONCODE
	 AND A.PRODUCTGROUP		= G.PRODUCTGROUP
	 AND A.MODELGROUP		= G.MODELGROUP
	 AND B.AREACODE			= H.AREACODE
	 AND B.DIVISIONCODE		= H.DIVISIONCODE
	 AND B.BADREASONCODE	= H.CONTAINBADREASONCODE
	 AND B.AREACODE			= I.AREACODE
	 AND B.DIVISIONCODE		= I.DIVISIONCODE
	 AND B.BADREASONCODE	= I.CONTAINBADREASONCODE
	 AND B.BADTYPECODE		= I.CONTAINBADTYPECODE
	 AND A.QCEMPNO			= J.EMPNO
	 AND A.AREACODE			= @ps_areacode
	 AND A.DIVISIONCODE		= @ps_divisioncode
	 AND A.PRDENDDATE	   >= @ps_datefm
	 AND A.PRDENDDATE	   <= @ps_dateto

END 

go
