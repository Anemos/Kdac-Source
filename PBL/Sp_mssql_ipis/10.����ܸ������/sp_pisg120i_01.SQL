/*##############################################################################*/
/*## File Name		: sp_pisg120i_01.SQL						##*/
/*## SYSTEM		: KDAC 대구공장 IPIS2000						##*/
/*## Procedure Name	: sp_pisg120i_01							##*/
/*## Description		: 현장관리의 회수 간판정보						##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: IPIS								##*/
/*## Use Program	: sp_pisg120i_01							##*/
/*## Parameter		: @ps_areacode, @ps_divisioncode				##*/
/*## Use Table		: TPLANRELEASE, TKB, TMSTWORKCENTER, TMSTLINE, TMSTKB	##*/
/*## Initial		: 2002. 12. 05							##*/
/*## Change		: 2002. 12. 12							##*/
/*## Author		: 최선배								##*/
/*##############################################################################*/

If Exists ( Select * From Sysobjects Where Id = Object_Id('sp_pisg120i_01'))
	Drop Procedure sp_pisg120i_01
Go

/*
EXEC	sp_pisg120i_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'H',
	@ps_basedate		= '2002.12.12'

*/

Create Procedure sp_pisg120i_01
	@ps_areacode		char(1),		/* 지역코드	*/
	@ps_divisioncode	char(1),		/* 공장코드	*/
	@ps_basedate		char(10)		/* 기준일	*/
As
Begin

/*########################################################################################

회수 간판 정보

########################################################################################*/

SELECT	MAX(TPLANRELEASE.PlanDate)		AS as_PlanDate,
	MAX(TMSTWORKCENTER.WorkCenterName)	AS as_WorkCenterName,
	MAX(TMSTLINE.LineFullName)		AS as_LineFullName,
	MAX(TMSTKB.ModelID)			AS as_ModelID,
	MAX(TPLANRELEASE.KBNo)		AS as_KBNo,
	MAX(TKB.KBStatusCode)			AS as_KBStatusCode,
	MAX(TKB.KBBackTime)			AS as_KBBackTime
FROM	TPLANRELEASE, TKB, TMSTWORKCENTER, TMSTLINE, TMSTKB
WHERE	TPLANRELEASE.AreaCode			= TKB.AreaCode
   AND	TPLANRELEASE.DivisionCode		= TKB.DivisionCode
   AND	TPLANRELEASE.KBNo			= TKB.KBNo
   AND	TPLANRELEASE.PrdFlag			= TKB.PrdFlag
   AND	TPLANRELEASE.AreaCode			= TMSTWORKCENTER.AreaCode
   AND	TPLANRELEASE.DivisionCode		= TMSTWORKCENTER.DivisionCode
   AND	TPLANRELEASE.WorkCenter		= TMSTWORKCENTER.WorkCenter
   AND	TPLANRELEASE.AreaCode			= TMSTLINE.AreaCode
   AND	TPLANRELEASE.DivisionCode		= TMSTLINE.DivisionCode
   AND	TPLANRELEASE.WorkCenter		= TMSTLINE.WorkCenter
   AND	TPLANRELEASE.LineCode			= TMSTLINE.LineCode
   AND	TPLANRELEASE.AreaCode			= TMSTKB.AreaCode
   AND	TPLANRELEASE.DivisionCode		= TMSTKB.DivisionCode
   AND	TPLANRELEASE.WorkCenter		= TMSTKB.WorkCenter
   AND	TPLANRELEASE.LineCode			= TMSTKB.LineCode
   AND	TPLANRELEASE.ItemCode			= TMSTKB.ItemCode
   AND	TPLANRELEASE.AreaCode			= @ps_areacode
   AND	TPLANRELEASE.DivisionCode		= @ps_divisioncode
   AND	CONVERT(CHAR(10),TKB.KBBackTime,102)	= @ps_basedate
   AND	TPLANRELEASE.PrdFlag			= 'E'
   AND	TKB.StockGubun				= 'B'
   AND	TKB.KBStatusCode			= 'F'
GROUP BY TPLANRELEASE.KBNo

UNION

SELECT	MAX(TPLANRELEASE.PlanDate)		AS as_PlanDate,
	MAX(TMSTWORKCENTER.WorkCenterName)	AS as_WorkCenterName,
	MAX(TMSTLINE.LineFullName)		AS as_LineFullName,
	MAX(TMSTKB.ModelID)			AS as_ModelID,
	MAX(TPLANRELEASE.KBNo)		AS as_KBNo,
	MAX(TKB.KBStatusCode)			AS as_KBStatusCode,
	MAX(TKB.KBBackTime)			AS as_KBBackTime
FROM	TPLANRELEASE, TKB, TMSTWORKCENTER, TMSTLINE, TMSTKB
WHERE	TPLANRELEASE.AreaCode			= TKB.AreaCode
   AND	TPLANRELEASE.DivisionCode		= TKB.DivisionCode
   AND	TPLANRELEASE.KBNo			= TKB.KBNo
   AND	TPLANRELEASE.PrdFlag			= TKB.PrdFlag
   AND	TPLANRELEASE.AreaCode			= TMSTWORKCENTER.AreaCode
   AND	TPLANRELEASE.DivisionCode		= TMSTWORKCENTER.DivisionCode
   AND	TPLANRELEASE.WorkCenter		= TMSTWORKCENTER.WorkCenter
   AND	TPLANRELEASE.AreaCode			= TMSTLINE.AreaCode
   AND	TPLANRELEASE.DivisionCode		= TMSTLINE.DivisionCode
   AND	TPLANRELEASE.WorkCenter		= TMSTLINE.WorkCenter
   AND	TPLANRELEASE.LineCode			= TMSTLINE.LineCode
   AND	TPLANRELEASE.AreaCode			= TMSTKB.AreaCode
   AND	TPLANRELEASE.DivisionCode		= TMSTKB.DivisionCode
   AND	TPLANRELEASE.WorkCenter		= TMSTKB.WorkCenter
   AND	TPLANRELEASE.LineCode			= TMSTKB.LineCode
   AND	TPLANRELEASE.ItemCode			= TMSTKB.ItemCode
   AND	TPLANRELEASE.AreaCode			= @ps_areacode
   AND	TPLANRELEASE.DivisionCode		= @ps_divisioncode
   AND	TPLANRELEASE.PrdFlag			= 'E'
   AND	TKB.StockGubun				= 'B'
   AND	TKB.KBStatusCode			= 'C'
GROUP BY TPLANRELEASE.KBNo
ORDER BY as_KBStatusCode DESC, as_KBBackTime ASC

End			-- Procedure End
Go
