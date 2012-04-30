/*##############################################################################*/
/*## File Name		: sp_pisg030i_01.SQL						##*/
/*## SYSTEM		: KDAC 대구공장 IPIS2000						##*/
/*## Procedure Name	: sp_pisg030i_01							##*/
/*## Description		: 현장관리의 조립순서						##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: IPIS								##*/
/*## Use Program	: sp_pisg030i_01							##*/
/*## Parameter		: @ps_plandate, @ps_areacode, @ps_divisioncode,			##*/
/*## Parameter		: @ps_workcenter, @ps_linecode					##*/
/*## Use Table		: TPLANRELEASE, TKB, TMSTKB					##*/
/*## Initial		: 2002. 09. 12							##*/
/*## Last Change	: 2003. 01. 13							##*/
/*## Author		: 최선배								##*/
/*##############################################################################*/

If Exists ( Select * From Sysobjects Where Id = Object_Id('sp_pisg030i_01'))
	Drop Procedure sp_pisg030i_01
Go

/*
EXEC	sp_pisg030i_01
	@ps_plandate		= '2002.12.09',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'H',
	@ps_workcenter		= '521M',
	@ps_linecode		= 'A'
*/

Create Procedure sp_pisg030i_01
	@ps_plandate		char(10),	/* 계획일자	*/
	@ps_areacode		char(1),		/* 지역코드	*/
	@ps_divisioncode	char(1),		/* 공장코드	*/
	@ps_workcenter		char(5),		/* 조		*/
	@ps_linecode		char(1)		/* 라인코드	*/
As
Begin
/*########################################################################################

조립순서

########################################################################################*/

SELECT	TPLANRELEASE.CycleOrder	AS as_CycleOrder,
	TPLANRELEASE.ItemCode		AS as_ItemCode,
	TMSTKB.ModelID			AS as_ModelID,
	TPLANRELEASE.KBNo		AS as_KBNo,
	TPLANRELEASE.TempGubun	AS as_TempGubun,
	TPLANRELEASE.ReleaseKBQty	AS as_RackQty,
	TKB.KBEndTime			AS as_KBEndTime,
	TKB.LotNo			AS as_LotNo,
	TPLANRELEASE.PrdFlag		AS as_PrdFlag,
	TPLANRELEASE.ReleaseGubun	AS as_ReleaseGubun
  FROM	TPLANRELEASE, TKB, TMSTKB
 WHERE	TPLANRELEASE.KBNo		= TKB.KBNo
   AND	TPLANRELEASE.AreaCode		= TKB.AreaCode
   AND	TPLANRELEASE.DivisionCode	= TKB.DivisionCode
   AND	TPLANRELEASE.WorkCenter	= TKB.WorkCenter
   AND	TPLANRELEASE.LineCode		= TKB.LineCode
   AND	TPLANRELEASE.ItemCode		= TKB.ItemCode
   AND	TPLANRELEASE.AreaCode		= TMSTKB.AreaCode
   AND	TPLANRELEASE.DivisionCode	= TMSTKB.DivisionCode
   AND	TPLANRELEASE.WorkCenter	= TMSTKB.WorkCenter
   AND	TPLANRELEASE.LineCode		= TMSTKB.LineCode
   AND	TPLANRELEASE.ItemCode		= TMSTKB.ItemCode
   AND	TKB.KBActiveGubun		= 'A'
   AND	TPLANRELEASE.ReleaseGubun	IN('T','Y')
   AND	TPLANRELEASE.PlanDate		= @ps_plandate
   AND	TPLANRELEASE.AreaCode		= @ps_areacode
   AND	TPLANRELEASE.DivisionCode	= @ps_divisioncode
   AND	TPLANRELEASE.WorkCenter	= @ps_workcenter
   AND	TPLANRELEASE.LineCode		= @ps_linecode
ORDER BY as_PrdFlag, as_KBEndTime, as_CycleOrder

End			-- Procedure End
Go
