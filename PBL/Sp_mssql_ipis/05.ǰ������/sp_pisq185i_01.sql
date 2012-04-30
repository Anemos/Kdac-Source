/************************************************************************************************/
/*	File Name	: sp_pisq185i_01.SQL                                                            */
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
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq185i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq185i_01
GO
/*
Exec sp_pisq185i_01
		@ps_areacode        = 'D'           ,
		@ps_divisioncode    = 'A'           ,
		@ps_datefm			= '2001.01.01'	,
		@ps_dateto			= '2003.01.01'	
*/


/****** Object:  Stored Procedure dbo.sp_pisq185i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq185i_01
        @ps_areacode			char(01)	,   -- 지역구분
        @ps_divisioncode		char(01)	,   -- 공장코드
		@ps_datefm				char(10)    ,	-- 일자 FROM
		@ps_dateto				char(10)    	-- 일자 TO

AS

BEGIN

	SELECT	A.AREACODE,   
			C.AREANAME,   
			A.DIVISIONCODE,   
			D.DIVISIONNAME,   
			A.ORIGINATIONDATE,   
			A.LARGEGROUPCODE,   
			E.LARGEGROUPNAME,   
			A.MIDDLEGROUPCODE,   
			F.MIDDLEGROUPNAME,   
			A.SMALLGROUPCODE,   
			G.SMALLGROUPNAME,   
			A.PRODUCTQTY,   
			A.PROCESSCOST,   
			B.PROCESSCODE,   
			B.BADREASONCODE,   
			H.CODENAME,   
			B.BADTYPECODE,   
			I.BADTYPENAME,   
			B.MEMO,   
			B.REPAIRQTY,   
			B.DISUSEQTY,   
			B.TOTALQTY,   
			B.PROCESSCOST  
	  FROM  TQPROGRESSBADMASTER	A,
			TQPROGRESSBADDETAIL	B, 
			TMSTAREA			C,
			TMSTDIVISION		D,
			TQLARGEGROUP		E,
			TQMIDDLEGROUP		F,
			TQSMALLGROUP  		G,
			TMSTCODE			H,
			TQBADTYPE			I
	 WHERE 	A.AREACODE			= B.AREACODE
	   AND	A.DIVISIONCODE		= B.DIVISIONCODE
	   AND	A.ORIGINATIONDATE	= B.ORIGINATIONDATE
	   AND	A.LARGEGROUPCODE	= B.LARGEGROUPCODE
	   AND	A.MIDDLEGROUPCODE	= B.MIDDLEGROUPCODE
	   AND	A.SMALLGROUPCODE	= B.SMALLGROUPCODE
	   AND	A.AREACODE			= C.AREACODE
	   AND	A.AREACODE			= D.AREACODE
	   AND	A.DIVISIONCODE		= D.DIVISIONCODE
	   AND	A.AREACODE			= E.AREACODE
	   AND	A.DIVISIONCODE		= E.DIVISIONCODE
	   AND	A.LARGEGROUPCODE	= E.LARGEGROUPCODE
	   AND	A.AREACODE			= F.AREACODE
	   AND	A.DIVISIONCODE		= F.DIVISIONCODE
	   AND	A.LARGEGROUPCODE	= F.LARGEGROUPCODE
	   AND	A.MIDDLEGROUPCODE	= F.MIDDLEGROUPCODE
	   AND	A.AREACODE			= G.AREACODE
	   AND	A.DIVISIONCODE		= G.DIVISIONCODE
	   AND	A.LARGEGROUPCODE	= G.LARGEGROUPCODE
	   AND	A.MIDDLEGROUPCODE	= G.MIDDLEGROUPCODE
	   AND	A.SMALLGROUPCODE	= G.SMALLGROUPCODE
	   AND	A.AREACODE			= I.AREACODE
	   AND	A.DIVISIONCODE		= I.DIVISIONCODE
	   AND	A.LARGEGROUPCODE	= I.LARGEGROUPCODE
	   AND	B.BADREASONCODE		= I.BADREASONCODE
	   AND	B.BADTYPECODE		= I.BADTYPECODE
	   AND	H.CODEGROUP       	= 'QCPR01'
	   AND	B.BADREASONCODE		= H.CODEID
	   AND	A.AREACODE			= @ps_areacode
	   AND	A.DIVISIONCODE		= @ps_divisioncode
	   AND	A.ORIGINATIONDATE  >= @ps_datefm
	   AND	A.ORIGINATIONDATE  <= @ps_dateto

END 

go
