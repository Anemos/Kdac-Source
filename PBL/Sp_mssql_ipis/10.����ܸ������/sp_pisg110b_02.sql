/*##############################################################################*/
/*## File Name		: sp_pisg110b_02.SQL						##*/
/*## SYSTEM		: KDAC �뱸���� IPIS2000						##*/
/*## Procedure Name	: sp_pisg110b_02							##*/
/*## Description		: ��������� ���� ����						##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: IPIS								##*/
/*## Use Program	: sp_pisg110b_02							##*/
/*## Parameter		: @ps_areacode, @ps_divisioncode				##*/
/*## Use Table		: TMSTIP							##*/
/*## Initial		: 2002. 10. 29							##*/
/*## Change		: 2002. 12. 05							##*/
/*## Author		: �ּ���								##*/
/*##############################################################################*/

If Exists ( Select * From Sysobjects Where Id = Object_Id('sp_pisg110b_02'))
	Drop Procedure sp_pisg110b_02
Go

/*
EXEC	sp_pisg110b_02
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'S'
*/

Create Procedure sp_pisg110b_02
	@ps_areacode		char(1),		/* �����ڵ�	*/
	@ps_divisioncode	char(1)		/* �����ڵ�	*/
As
Begin

/*########################################################################################

������ �޽���

########################################################################################*/

SELECT	MessageGubun
FROM	TMSTIP
WHERE	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
GROUP BY MessageGubun

End					-- Procedure End
Go
