/*##############################################################################*/
/*## File Name		: sp_pisg070u_01.SQL						##*/
/*## SYSTEM		: KDAC 대구공장 IPIS2000						##*/
/*## Procedure Name	: sp_pisg070u_01							##*/
/*## Description		: 현장관리의 생산실적등록취소					##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: IPIS								##*/
/*## Use Program	: sp_pisg070u_01							##*/
/*## Parameter		: @ps_kbno, @ps_areacode, @ps_divisioncode,			##*/
/*## Parameter		: @ps_workcenter, @ps_linecode					##*/
/*## Use Table		: TKB, TMSTKB, TMSTLINE						##*/
/*## Initial		: 2002. 09. 11							##*/
/*## Change		: 2002. 12. 05							##*/
/*## Author		: 최선배								##*/
/*##############################################################################*/

If Exists ( Select * From Sysobjects Where Id = Object_Id('sp_pisg070u_01'))
	Drop Procedure sp_pisg070u_01
Go

/*
EXEC	sp_pisg070u_01
	@ps_kbno		= 'SJRA0001003',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'B',
	@ps_workcenter		= 'J104B',
	@ps_linecode		= '0'
*/

Create Procedure sp_pisg070u_01
	@ps_kbno		char(11),	/* 간판번호	*/
	@ps_areacode		char(1),		/* 지역코드	*/
	@ps_divisioncode	char(1),		/* 공장코드	*/
	@ps_workcenter		char(5),		/* 조		*/
	@ps_linecode		char(1)		/* 라인코드	*/
As
Begin

/*########################################################################################

처리할 간판 정보를 읽어 온다.

########################################################################################*/

SELECT	TKB.WorkCenter		as_WorkCenter,
	TMSTLINE.LineShortName	as_LineShortName,
	TKB.ItemCode		as_ItemCode,
	TMSTKB.ModelID		as_ModelID,
	TKB.TempGubun		as_TempGubun,
	TKB.RackQty		as_RackQty
  FROM	TKB, TMSTKB, TMSTLINE
 WHERE	TKB.AreaCode		= TMSTKB.AreaCode 
   AND	TKB.DivisionCode		= TMSTKB.DivisionCode
   AND	TKB.WorkCenter		= TMSTKB.WorkCenter
   AND	TKB.LineCode		= TMSTKB.LineCode
   AND	TKB.ItemCode		= TMSTKB.ItemCode
   AND	TKB.AreaCode		= TMSTLINE.AreaCode
   AND	TKB.DivisionCode		= TMSTLINE.DivisionCode
   AND	TKB.WorkCenter		= TMSTLINE.WorkCenter
   AND	TKB.LineCode		= TMSTLINE.LineCode
   AND	TKB.PrdFlag		= 'E'
   AND	TKB.KBNo		= @ps_kbno
   AND	TKB.AreaCode		= @ps_areacode
   AND	TKB.DivisionCode		= @ps_divisioncode
   AND	TKB.WorkCenter		= @ps_workcenter
   AND	TKB.LineCode		= @ps_linecode

End			-- Procedure End
Go
