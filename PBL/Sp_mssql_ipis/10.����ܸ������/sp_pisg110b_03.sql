/*##############################################################################*/
/*## File Name		: sp_pisg110b_03.SQL						##*/
/*## SYSTEM		: KDAC �뱸���� IPIS2000						##*/
/*## Procedure Name	: sp_pisg110b_03							##*/
/*## Description		: ��������� �޼��� ����						##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: IPIS								##*/
/*## Use Program	: sp_pisg110b_03							##*/
/*## Parameter		: @ps_areacode, @ps_divisioncode				##*/
/*## Use Table		: TMSTIP							##*/
/*## Initial		: 2002. 10. 31							##*/
/*## Change		: 2002. 12. 05							##*/
/*## Author		: �ּ���								##*/
/*##############################################################################*/

If Exists ( Select * From Sysobjects Where Id = Object_Id('sp_pisg110b_03'))
	Drop Procedure sp_pisg110b_03
Go

/*
EXEC	sp_pisg110b_03
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'S',
	@ps_message		= '�������'
*/

Create Procedure sp_pisg110b_03
	@ps_areacode		char(1),		/* �����ڵ�	*/
	@ps_divisioncode	char(1),		/* �����ڵ�	*/
	@ps_message		char(20)		/* �����ڵ�	*/
As
Begin

/*########################################################################################

������ �޽���

########################################################################################*/

SELECT	PCIP,
	PCName
  FROM	TMSTIP
WHERE	AreaCode	= @ps_areacode
   AND	DivisionCode	= @ps_divisioncode
   AND	MessageGubun	= @ps_message

End					-- Procedure End
Go
