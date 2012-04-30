/************************************************************************************************/
/*	File Name	: sp_pisq155u_04.SQL                                                            */
/*	SYSTEM		: 품질관리(공정품질)                                                            */
/*	Description	: 조에 따른 라우팅시트의 품번표시                                               */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TMSTEMP                                                                       */
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(1)     => 공장코드                                 */
/*                @ps_workcenter		varchar(05) => 조코드									*/
/*	Notes		: 조에 따른 라우팅시트의 품번 자료를 조회한다.                                  */
/*	Made Date	: 2002. 10. 16                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq155u_04') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq155u_04
GO
/*
Exec sp_pisq155u_04
		@ps_AreaCode        = 'D'               ,
		@ps_DivisionCode    = 'H'               ,
		@ps_workcenter      = '%'				
*/


/****** Object:  Stored Procedure dbo.sp_pisq155u_04    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq155u_04
        @ps_AreaCode        char(01)      ,   -- 지역구분
        @ps_DivisionCode    char(01)      ,   -- 공장코드
		@ps_workcenter		varchar(05) 	  -- 조코드

AS

BEGIN

	SELECT	DISTINCT
			A.ITEMCODE,   
	  		B.ITEMNAME,
			A.SUBLINECODE,   
			A.SUBLINENO,
			'' DEL_CHK
	  FROM	TMSTROUTING A,
	  		TMSTITEM	B
	 WHERE	A.ITEMCODE		= B.ITEMCODE
	   AND	A.AREACODE		= @ps_areacode
	   AND	A.DIVISIONCODE	= @ps_divisioncode
	   AND	A.WORKCENTER	= @ps_workcenter
	   AND	A.AREACODE + A.DIVISIONCODE + RTRIM(A.WORKCENTER) + RTRIM(A.ITEMCODE) + RTRIM(A.SUBLINECODE) + (A.SUBLINENO) NOT IN
            ( SELECT C.AREACODE + C.DIVISIONCODE + C.WORKCENTER + C.ITEMCODE + C.SUBLINECODE + C.SUBLINENO 
            	FROM TQSMALLGROUPTOITEM C
			   WHERE C.AREACODE		= @ps_areacode
	   			 AND C.DIVISIONCODE	= @ps_divisioncode)

END 

go
