/*
	File Name	: sp_pisi_d_tsrorder_move_movelog.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_d_tsrorder_move_movelog
	Description	: Download sr ��ü
			  tsrorder, tsrheader
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim

	-- SRAreaCode, SRDivisionCode - �������
	-- MoveAreaCode, MoveDivisionCode - �Ƿڰ���
	-- CustCode(�ŷ�ó) - �Ƿ����� + �Ƿڰ��� 
	-- ����Ÿ�� ������� ������...
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tsrorder_move_movelog]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tsrorder_move_movelog]
GO

/*
Execute sp_pisi_d_tsrorder_move_movelog
*/

Create Procedure sp_pisi_d_tsrorder_move_movelog
	
	
As
Begin

SET XACT_ABORT OFF

Begin Tran
	
-- SR ��ü down log table

Insert	into pdinv601_log
	(CHGDATE,	CHGCD,		SRNO,		XPLANT,		DIV,
	PDCD,		ITNO,		DUDT,		REQQT,		CLS,
	SRC,		LOT,		SLNO,		XPLANT1,	DIV1,
	STSCD,		DOWNDATE,		ISTSCD)
Select	CHGDATE,	CHGCD,		SRNO,		XPLANT,		DIV,
	PDCD,		ITNO,		DUDT,		REQQT,		CLS,
	SRC,		LOT,		SLNO,		XPLANT1,	DIV1,
	STSCD,		DOWNDATE,		ISTSCD
from	pdinv601
where	stscd = 'N'	and
	chgdate	not in	(select chgdate	from pdinv601_log)
order by chgdate

if @@error <> 0
	begin
	RollBack Tran
	Return
	End

Update	pdinv601
Set	stscd	=	'Y'
From	Pdinv601	a,
	Pdinv601_log	b
Where	a.chgdate	=	b.chgdate

if @@error <> 0
	begin
	RollBack Tran
	Return
	End
			
Commit Tran

End		-- Procedure End
Go
