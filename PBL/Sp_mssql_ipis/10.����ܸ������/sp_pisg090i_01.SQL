/*##############################################################################*/
/*## File Name		: sp_pisg090i_01.SQL						##*/
/*## SYSTEM		: KDAC 대구공장 IPIS2000						##*/
/*## Procedure Name	: sp_pisg090i_01							##*/
/*## Description		: 현장관리의 분할 LOT 정보						##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: IPIS								##*/
/*## Use Program	: sp_pisg090i_01							##*/
/*## Parameter		: @ps_tracedate, @ps_areacode, @ps_divisioncode			##*/
/*## Use Table		: TLOTNODIVIDE, TKB, TMSTKB, TMSTWORKCENTER, TMSTLINE	##*/
/*## Initial		: 2002. 09. 11							##*/
/*## Change		: 2002. 12. 05							##*/
/*## Author		: 최선배								##*/
/*##############################################################################*/

If Exists ( Select * From Sysobjects Where Id = Object_Id('sp_pisg090i_01'))
	Drop Procedure sp_pisg090i_01
Go

/*
EXEC	sp_pisg090i_01
	@ps_tracedate		= '2002.09.11',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'B'
*/

Create Procedure sp_pisg090i_01
	@ps_tracedate		char(10),	/* 기준일	*/
	@ps_areacode		char(1),		/* 지역코드	*/
	@ps_divisioncode	char(1)		/* 공장코드	*/
As
Begin

/*########################################################################################

분할 Lot 정보

########################################################################################*/

SELECT	TKB.ItemCode			AS as_ItemCode,
	TMSTKB.ModelID			AS as_ModelID,
	TLOTNODIVIDE.RackQty		AS as_RackQty,
--	TMSTWORKCENTER.WorkCenterName + '/' + TMSTLINE.LineShortName
--					AS as_WorkLine_Name,
	TMSTLINE.LineShortName		AS as_WorkLine_Name,
	TLOTNODIVIDE.LotNo		AS as_LotNo,
	TLOTNODIVIDE.DivideQty		AS as_DivideQty
  FROM	TLOTNODIVIDE, TKB, TMSTKB, TMSTWORKCENTER, TMSTLINE
 WHERE	TLOTNODIVIDE.KBNo		= TKB.KBNo
   AND	TKB.AreaCode			= TMSTKB.AreaCode
   AND	TKB.DivisionCode			= TMSTKB.DivisionCode
   AND	TKB.WorkCenter			= TMSTKB.WorkCenter
   AND	TKB.LineCode			= TMSTKB.LineCode
   AND	TKB.ItemCode			= TMSTKB.ItemCode
   AND	TKB.AreaCode			= TMSTWORKCENTER.AreaCode
   AND	TKB.DivisionCode			= TMSTWORKCENTER.DivisionCode
   AND	TKB.WorkCenter			= TMSTWORKCENTER.WorkCenter
   AND	TKB.AreaCode			= TMSTLINE.AreaCode
   AND	TKB.DivisionCode			= TMSTLINE.DivisionCode
   AND	TKB.WorkCenter			= TMSTLINE.WorkCenter
   AND	TKB.LineCode			= TMSTLINE.LineCode
   AND	TLOTNODIVIDE.TraceDate		= @ps_tracedate
   AND	TKB.AreaCode			= @ps_areacode
   AND	TKB.DivisionCode			= @ps_divisioncode

End			-- Procedure End
Go
