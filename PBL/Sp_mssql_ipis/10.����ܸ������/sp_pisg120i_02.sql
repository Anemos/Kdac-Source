/*##############################################################################*/
/*## File Name		: sp_pisg120i_02.SQL						##*/
/*## SYSTEM		: KDAC �뱸���� IPIS2000						##*/
/*## Procedure Name	: sp_pisg120i_02							##*/
/*## Description		: ��������� ��������						##*/
/*## Supply		: DAEWOO Information Systems Co., LTD IAS Dept			##*/
/*## Use DataBase	: IPIS								##*/
/*## Use Program	: sp_pisg120i_02							##*/
/*## Parameter		: @ps_kbno, @ps_com_code, @pi_err_code				##*/
/*## Use Table		: TKB, TKBHIS							##*/
/*## Initial		: 2002. 11. 05							##*/
/*## Last Change	: 2002. 12. 12							##*/
/*## Author		: �ּ���								##*/
/*##############################################################################*/

If Exists ( Select * From Sysobjects Where Id = Object_Id('sp_pisg120i_02'))
	Drop Procedure sp_pisg120i_02
Go

/*
EXEC	sp_pisg120i_02
	@ps_kbno		= 'DH010020002',
	@ps_com_code		= 'DHA08',
	@pi_err_code		= 0
*/

Create Procedure sp_pisg120i_02
	@ps_kbno		varchar(11),		-- ���ǹ�ȣ
	@ps_com_code		varchar(15),		-- �ܸ��� �ڵ�
	@pi_err_code		INT	OUTPUT		-- ERROR �ڵ�
As
Begin
------------------------------------------------------------------------------

Begin	TRAN

Declare	@ldt_systemtime		DateTime,	-- ���� DATETIME
	@ls_areacode		char(1),		-- AREACODE
	@ls_divisioncode		char(1),		-- DIVISIONCODE
	@ls_stockgubun		char(1)		-- â�� ��� ����

/*########################################################################################

	ERROR FLAG �ʱ�ȭ

########################################################################################*/

SELECT	@pi_err_code = 0

/*########################################################################################

	�ý��� �ð�

########################################################################################*/

SELECT	@ldt_systemtime		= GETDATE()

/*########################################################################################

	�⺻����

########################################################################################*/

SELECT	@ls_areacode	= AreaCode,
	@ls_divisioncode	= DivisionCode,
	@ls_stockgubun	= StockGubun
  FROM	TKB
 WHERE	KBNo			= @ps_kbno

/*########################################################################################

	ȸ�� ���� ó��

########################################################################################*/

-- �������� �����Ϸ�� ����
/*
UPDATE	TPLANRELEASE
SET	KBNo		= 'A',
	KBReleaseDate	= 'A',
	KBReleaseSeq	= 0,
	ReleaseGubun	= 'C',
	PrdFlag		= 'C',
	ReleaseKBCount	= 0,
	ReleaseKBQty	= 0,
	LastEmp		= @ps_com_code,
	LastDate		= @ldt_systemtime
 WHERE	AreaCode	= @ls_areacode
   AND	DivisionCode	= @ls_divisioncode
   AND	KBNo		= @ps_kbno

-- ERROR üũ
Select	@pi_err_code	= @pi_err_code + @@Error
*/

-- ���� ���� ��Ȳ
UPDATE	TKB
SET	KBStatusCode	= 'F',
	KBBackTime	= @ldt_systemtime,
	LastEmp		= 'Y',
	LastDate		= @ldt_systemtime
 WHERE	KBNo		= @ps_kbno

-- ERROR üũ
Select	@pi_err_code	= @pi_err_code + @@Error

-- ���� �̷�
UPDATE	TKBHIS
SET	KBStatusCode	= 'F',
	KBBackTime	= @ldt_systemtime,
	LastEmp		= 'Y',
	LastDate		= @ldt_systemtime
 WHERE	KBNo		= @ps_kbno
   AND	LastLoopFlag	= 'Y'

-- ERROR üũ
Select	@pi_err_code	= @pi_err_code + @@Error

-- ERROR ����
IF @pi_err_code = 0
BEGIN
	COMMIT		TRAN
END
ELSE
BEGIN
	ROLLBACK	TRAN
END

RETURN	@pi_err_code

End			-- Procedure End
Go
