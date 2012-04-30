/*##############################################################################*/
/*## File Name		: sp_pisg110b_01.SQL						##*/
/*## SYSTEM		: KDAC �뱸���� IPIS2000						##*/
/*## Procedure Name	: sp_pisg110b_01							##*/
/*## Description		: ��������� ���� ����						##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: IPIS								##*/
/*## Use Program	: sp_pisg110b_01							##*/
/*## Parameter		: @ps_areacode, @ps_divisioncode, @ps_com_code			##*/
/*## Use Table		: TMSTLINE, TMSTTERMINALLINE					##*/
/*## Initial		: 2002. 10. 29							##*/
/*## Change		: 2002. 12. 05							##*/
/*## Author		: �ּ���								##*/
/*##############################################################################*/

If Exists ( Select * From Sysobjects Where Id = Object_Id('sp_pisg110b_01'))
	Drop Procedure sp_pisg110b_01
Go

/*
EXEC	sp_pisg110b_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'S',
	@ps_com_code		= 'IPISMAC_402'
*/

Create Procedure sp_pisg110b_01
	@ps_areacode		char(1),		/* �����ڵ�	*/
	@ps_divisioncode	char(1),		/* �����ڵ�	*/
	@ps_com_code		varchar(15)	/* �ܸ��� �ڵ�	*/
As
Begin

/*########################################################################################

�ش� ���� ���� �����´�.

########################################################################################*/

SELECT	TMSTLINE.LineCode		AS as_LineCode,
	TMSTLINE.LineFullName		AS as_LineName
 FROM	TMSTLINE, TMSTTERMINALLINE
WHERE	TMSTLINE.AreaCode		= TMSTTERMINALLINE.AreaCode
   AND	TMSTLINE.DivisionCode		= TMSTTERMINALLINE.DivisionCode
   AND	TMSTLINE.WorkCenter		= TMSTTERMINALLINE.WorkCenter
   AND	TMSTLINE.LineCode		= TMSTTERMINALLINE.LineCode
   AND	TMSTLINE.AreaCode		= @ps_areacode
   AND	TMSTLINE.DivisionCode		= @ps_divisioncode
   AND	TMSTTERMINALLINE.TerminalCode	= @ps_com_code

End					-- Procedure End
Go
