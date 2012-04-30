/*##############################################################################*/
/*## File Name		: sp_pisg010b_01.SQL						##*/
/*## SYSTEM		: KDAC 대구공장 IPIS2000						##*/
/*## Procedure Name	: sp_pisg010b_01							##*/
/*## Description		: 현장관리의 조,라인 정보						##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: IPIS								##*/
/*## Use Program	: sp_pisg010b_01							##*/
/*## Parameter		: @ps_areacode, @ps_divisioncode, @ps_terminalcode		##*/
/*## Use Table		: TMSTTERMINALLINE						##*/
/*## Initial		: 2002. 09. 11							##*/
/*## Change		: 2002. 12. 05							##*/
/*## Author		: 최선배								##*/
/*##############################################################################*/

If Exists ( Select * From Sysobjects Where Id = Object_Id('sp_pisg010b_01'))
	Drop Procedure sp_pisg010b_01
Go

/*
EXEC	sp_pisg010b_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'S',
	@ps_terminalcode	= 'ABS001'
*/

Create Procedure sp_pisg010b_01
	@ps_areacode		char(1),		/* 지역코드	*/
	@ps_divisioncode	char(1),		/* 공장코드	*/
	@ps_terminalcode	varchar(15)	/* 단말기 코드	*/
As
Begin
/*########################################################################################

단말기에 물려있는 조와 라인코드를 가져온다.

########################################################################################*/

SELECT	WorkCenter	AS as_WorkCenter,
	LineCode	AS as_LineCode
  FROM	TMSTTERMINALLINE
 WHERE	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	TerminalCode	= @ps_terminalcode
ORDER	BY as_WorkCenter, as_LineCode

End			-- Procedure End
Go
