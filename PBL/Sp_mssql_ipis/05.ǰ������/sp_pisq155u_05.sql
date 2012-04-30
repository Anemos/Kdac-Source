/************************************************************************************************/
/*	File Name	: sp_pisq155u_05.SQL                                                            */
/*	SYSTEM		: ǰ������(����ǰ��)                                                            */
/*	Description	: ��ǰ�Һз��� ǰ�� ��� 		                                                */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TMSTEMP                                                                       */
/*  Parameter   : @ps_AreaCode          char(01)    => ��������                                 */
/*                @ps_divisioncode      char(1)     => �����ڵ�                                 */
/*	Notes		: ��ǰ�Һз��� ǰ���ڷḦ ����Ѵ�.    				                            */
/*	Made Date	: 2002. 10. 25                                                                  */
/*	Author		: �������-������                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq155u_05') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq155u_05
GO
/*
Exec sp_pisq155u_05
		@ps_AreaCode        = 'D'               ,
		@ps_DivisionCode    = 'H'               
*/


/****** Object:  Stored Procedure dbo.sp_pisq155u_05    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq155u_05
        @ps_AreaCode        char(01)      ,   -- ��������
        @ps_DivisionCode    char(01)         -- �����ڵ�

AS

BEGIN

	SELECT	A.AREACODE,   
			A.DIVISIONCODE,   
			A.LARGEGROUPCODE,   
			A.MIDDLEGROUPCODE,   
			A.SMALLGROUPCODE,   
			A.WORKCENTER,   
			A.ITEMCODE,   
			A.SUBLINECODE,   
			A.SUBLINENO,   
			A.LASTEMP,   
			A.LASTDATE,   
			B.LARGEGROUPNAME,   
			C.MIDDLEGROUPNAME,   
			D.SMALLGROUPNAME,   
			E.ITEMNAME,
			F.AREANAME,
			G.DIVISIONNAME
	  FROM	TQSMALLGROUPTOITEM	A,   
			TQLARGEGROUP		B,   
			TQMIDDLEGROUP		C,   
			TQSMALLGROUP  		D,
			TMSTITEM			E,
			TMSTAREA      		F,
			TMSTDIVISION  		G
	 WHERE	A.AREACODE			= B.AREACODE
	   AND	A.DIVISIONCODE		= B.DIVISIONCODE
	   AND	A.LARGEGROUPCODE	= B.LARGEGROUPCODE
	   AND	A.AREACODE			= C.AREACODE
	   AND	A.DIVISIONCODE		= C.DIVISIONCODE
	   AND	A.LARGEGROUPCODE	= C.LARGEGROUPCODE
	   AND	A.MIDDLEGROUPCODE	= C.MIDDLEGROUPCODE
	   AND	A.AREACODE			= D.AREACODE
	   AND	A.DIVISIONCODE		= D.DIVISIONCODE
	   AND	A.LARGEGROUPCODE	= D.LARGEGROUPCODE
	   AND	A.MIDDLEGROUPCODE	= D.MIDDLEGROUPCODE
	   AND	A.SMALLGROUPCODE	= D.SMALLGROUPCODE
	   AND	A.ITEMCODE			= E.ITEMCODE
	   AND	A.AREACODE      	= F.AREACODE
	   AND	A.AREACODE      	= G.AREACODE
	   AND	A.DIVISIONCODE  	= G.DIVISIONCODE
	   AND	A.AREACODE			= @ps_AreaCode
	   AND	A.DIVISIONCODE		= @ps_DivisionCode

END 

go
