/*#######################################################################*/
/*## File Name		: sp_pisg080i_01.SQL					##*/
/*## SYSTEM		: KDAC 대구공장 IPIS2000					##*/
/*## Procedure Name	: sp_pisg080i_01						##*/
/*## Description		: 현장관리의 생산실적등록					##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept		##*/
/*## Use DataBase	: IPIS							##*/
/*## Use Program	: sp_pisg080i_01						##*/
/*## Parameter		: @ps_plandate, @ps_areacode, @ps_divisioncode,		##*/
/*## Parameter		: @ps_workcenter, @ps_linecode				##*/
/*## Use Table		: TKB, TMSTKB						##*/
/*## Initial		: 2002. 09. 11						##*/
/*## Change		: 2002. 12. 11						##*/
/*## Author		: 최선배							##*/
/*#######################################################################*/

If Exists ( Select * From Sysobjects Where Id = Object_Id('sp_pisg080i_01'))
	Drop Procedure sp_pisg080i_01
Go

/*
EXEC	sp_pisg080i_01
	@ps_plandate		= '2002.12.03',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '421E',
	@ps_linecode		= 'D'
*/

Create Procedure sp_pisg080i_01
	@ps_plandate		char(10),	/* 기준일	*/
	@ps_areacode		char(1),		/* 지역코드	*/
	@ps_divisioncode	char(1),		/* 공장코드	*/
	@ps_workcenter		char(5),		/* 조 코드	*/
	@ps_linecode		char(1)		/* 라인코드	*/
As
Begin

/*########################################################################################

처리할 간판 정보를 읽어 온다.

########################################################################################*/

SELECT	A.ItemCode					AS as_ItemCode,
	A.ModelID					AS as_ModelID,
	A.ReleaseKBQty					AS as_OrderCount,
	B.ReleaseKBQty					AS as_ResultCount,
	CONVERT(FLOAT(5), B.ReleaseKBQty) / CONVERT(FLOAT(5), A.ReleaseKBQty)
							AS as_PerCount

FROM	(SELECT	TPLANRELEASE.ItemCode			AS ItemCode,
		TMSTKB.ModelID				AS ModelID,
		SUM(TPLANRELEASE.ReleaseKBQty)	AS ReleaseKBQty,
		SUM(TKB.PrdQty)				AS ResultCount
	 FROM	TPLANRELEASE,
		TMSTKB,
		TKB
	WHERE	TPLANRELEASE.AreaCode			= TMSTKB.AreaCode
	   AND	TPLANRELEASE.DivisionCode		= TMSTKB.DivisionCode
	   AND	TPLANRELEASE.WorkCenter		= TMSTKB.WorkCenter
	   AND	TPLANRELEASE.LineCode			= TMSTKB.LineCode
	   AND	TPLANRELEASE.ItemCode			= TMSTKB.ItemCode
	   AND	TPLANRELEASE.AreaCode			= TKB.AreaCode
	   AND	TPLANRELEASE.DivisionCode		= TKB.DivisionCode
	   AND	TPLANRELEASE.WorkCenter		= TKB.WorkCenter
	   AND	TPLANRELEASE.LineCode			= TKB.LineCode
	   AND	TPLANRELEASE.ItemCode			= TKB.ItemCode
	   AND	TPLANRELEASE.KBNo			= TKB.KBNo
	   AND	TPLANRELEASE.ReleaseGubun		IN('Y','T', 'U')
	   AND	TPLANRELEASE.PlanDate			= @ps_plandate
	   AND	TPLANRELEASE.AreaCode			= @ps_areacode
	   AND	TPLANRELEASE.DivisionCode		= @ps_divisioncode
	   AND	TPLANRELEASE.WorkCenter		= @ps_workcenter
	   AND	TPLANRELEASE.LineCode			= @ps_linecode
	GROUP BY TPLANRELEASE.ItemCode, TMSTKB.ModelID ) A 

	LEFT OUTER JOIN 

	(SELECT	ItemCode				AS ItemCode,
		SUM(releaseKBQty)			AS releaseKBQty
	 FROM	TPLANRELEASE
	WHERE	ReleaseGubun				IN('Y','T')
	   AND	PlanDate				= @ps_plandate
	   AND	AreaCode				= @ps_areacode
	   AND	DivisionCode				= @ps_divisioncode
	   AND	WorkCenter				= @ps_workcenter
	   AND	LineCode				= @ps_linecode
	   AND	PrdFlag					= 'E'
	GROUP BY ItemCode				) B

  ON	A.ItemCode	= B.ItemCode

End			-- Procedure End
Go
