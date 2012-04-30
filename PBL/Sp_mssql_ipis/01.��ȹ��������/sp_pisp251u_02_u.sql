/*
	File Name	: sp_pisp251u_02_u.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp251u_02_u
	Description	: ���� ���� ��ȯ - ��ȯ ������ ���� ����
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 10
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp251u_02_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp251u_02_u]
GO

/*
Execute sp_pisp251u_02_u
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= '%',
	@ps_itemcode		= '%',
	@ps_kbactivegubun	= '%'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp251u_02_u
	@ps_kbno		varchar(11),
	@ps_kbactivegubun	char(1),
	@ps_empcode		varchar(6)

As
Begin

Declare	@ldt_nowtime		datetime,	-- �������� ���ϱ� ���� ���� �Ͻ�
	@ls_error		char(2),
	@ls_errortext		varchar(100)

Select	@ldt_nowtime	= GetDate()

-- tkb ����
Update	tkb
Set	KBActiveGubun	= @ps_kbactivegubun,
	LastEmp		= 'Y',--@ps_empcode,
	LastDate		= @ldt_nowtime
From	tkb	A
Where	A.KBNo		= @ps_kbno	And
	A.KBStatusCode	= 'F'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '������ Active ���¸� �����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '������ Active ���¸� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End

-- tkbhis ����
Update	tkbhis
Set	KBActiveGubun	= @ps_kbactivegubun,
	LastEmp		= 'Y',--@ps_empcode,
	LastDate		= @ldt_nowtime
From	tkbhis	A
Where	A.KBNo		= @ps_kbno	And
	A.KBStatusCode	= 'F'		And
	A.LastLoopFlag	= 'Y'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '������ Active ���¸� �����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���� �̷��� Active ���¸� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End


Proc_Exit:

/*
If @ls_error = '00'
Begin
	Commit Tran
End
Else
Begin
	RollBack Tran
End
*/

Select	Error		= @ls_error,
	ErrorText	= @ls_errortext

Return

End		-- Procedure End
Go
