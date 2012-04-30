/************************************************************************************************/
/*	File Name	: sp_pisq250i_01.SQL                                                            */
/*	SYSTEM		: 품질관리(공정품질)                                                            */
/*	Description	: 불량 유형별 현황                                                              */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQPROGRESSBADDETAIL                                                           */
/*	              TQBADTYPE                                                                     */
/*	              TMSTCODE                                                                      */
/*		          TQLARGEGROUP                                                                  */
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_QCDateFm          char(10)    => 조회일자FROM                             */
/*                @ps_QCDateTo          char(10)    => 조회일자TO                               */
/*                @ps_largegroupcode    char(02)    => 제품대분류코드                           */
/*                @ps_middlegroupcode   char(02)    => 제품중분류코드                           */
/*                @ps_smallgroupcode    char(02)    => 제품소분류코드                           */
/*                @ps_maflag            char(01)    => 가공/조립 구분							*/
/*	Notes		: 불량 유형별 현황 자료를 조회한다.                                             */
/*	Made Date	: 2002. 09. 26                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq250i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq250i_01
GO
/*
Exec sp_pisq250i_01
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
        @ps_QCDateFm        = '2002.01.01' ,
        @ps_QCDateTo        = '2002.12.31' ,
        @ps_largegroupcode  = '%'         ,
        @ps_middlegroupcode = '%'         ,
        @ps_smallgroupcode  = '%'         ,        
		@ps_maflag          = '%' 

*/


/****** Object:  Stored Procedure dbo.sp_pisq250i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq250i_01
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_QCDateFm          char(10)      ,   -- 조회일자FROM  
        @ps_QCDateTo          char(10)      ,   -- 조회일자TO    
        @ps_largegroupcode    varchar(02)   ,   -- 제품대분류코드
        @ps_middlegroupcode   varchar(02)   ,   -- 제품중분류코드
        @ps_smallgroupcode    varchar(02)   ,   -- 제품소분류코드
        @ps_maflag            char(01)          -- 가공/조립 구분

AS

BEGIN

	SELECT TOP 100
	       A.BADREASONCODE	AS AS_BADREASONCODE,   
	       C.CODENAME		AS AS_CODENAME,
		   A.BADTYPECODE	AS AS_BADTYPECODE,   
		   B.BADTYPENAME	AS AS_BADTYPENAME,   
	       SUM(A.TOTALQTY) 	AS AS_TOTALQTY,
	       AS_TOTQTY		AS AS_GRANDQTY,
	       CONVERT (DECIMAL(5,2), CAST(SUM(A.TOTALQTY) AS FLOAT) / CAST(AS_TOTQTY AS FLOAT) * 100) AS AS_RATE
	  FROM TQPROGRESSBADDETAIL A,
	       TQBADTYPE B,
	       TMSTCODE  C,
	       (SELECT SUM(D.TOTALQTY) AS AS_TOTQTY 
	          FROM TQPROGRESSBADDETAIL D,
		           TQLARGEGROUP        E
			 WHERE D.AREACODE		 =    E.AREACODE
               AND D.DIVISIONCODE 	 =    E.DIVISIONCODE
               AND D.LARGEGROUPCODE  =    E.LARGEGROUPCODE 
               AND E.MAFLAG          LIKE @ps_maflag
               AND D.AREACODE		 =    @ps_AreaCode
			   AND D.DIVISIONCODE 	 =    @ps_DivisionCode
			   AND D.ORIGINATIONDATE >=   @ps_QCDateFm
			   AND D.ORIGINATIONDATE <=   @ps_QCDateTo
			   AND D.LARGEGROUPCODE  LIKE @ps_largegroupcode
			   AND D.MIDDLEGROUPCODE LIKE @ps_middlegroupcode
			   AND D.SMALLGROUPCODE  LIKE @ps_smallgroupcode
	       ) TMP_D ,
		   TQLARGEGROUP F
	 WHERE A.AREACODE		 =    B.AREACODE
	   AND A.DIVISIONCODE 	 =    B.DIVISIONCODE
	   AND A.LARGEGROUPCODE  =    B.LARGEGROUPCODE 
	   AND A.BADREASONCODE   =    B.BADREASONCODE
	   AND A.BADTYPECODE     =    B.BADTYPECODE
	   AND C.CODEGROUP       =    'QCPR01'
	   AND A.BADREASONCODE   =    C.CODEID
	   AND A.AREACODE		 =    F.AREACODE
	   AND A.DIVISIONCODE 	 =    F.DIVISIONCODE
	   AND A.LARGEGROUPCODE  =    F.LARGEGROUPCODE 
	   AND F.MAFLAG          LIKE @ps_maflag
	   AND A.AREACODE		 =    @ps_AreaCode
	   AND A.DIVISIONCODE 	 =    @ps_DivisionCode
	   AND A.ORIGINATIONDATE >=   @ps_QCDateFm
	   AND A.ORIGINATIONDATE <=   @ps_QCDateTo
	   AND A.LARGEGROUPCODE  LIKE @ps_largegroupcode
	   AND A.MIDDLEGROUPCODE LIKE @ps_middlegroupcode
	   AND A.SMALLGROUPCODE  LIKE @ps_smallgroupcode
	 GROUP BY A.BADREASONCODE, C.CODENAME, A.BADTYPECODE, B.BADTYPENAME, AS_TOTQTY
	 ORDER BY SUM(A.TOTALQTY) DESC

END 

go
