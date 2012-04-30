/*
	File Name	: sp_pisp092u_03_u.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp092u_03_u
	Description	: ���ؼ����� ��� - ���� ���ν���
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 25
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp092u_03_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp092u_03_u]
GO

/*
Execute sp_pisp092u_03_u
	@ps_prddate		= '2002.09.30',
	@ps_kbno		= 'DA010101001',
	@ps_kbreleasedate	= '2002.09.30',
	@pi_kbreleaseseq	= 2,
	@ps_nokbgubun		= 'U',
	@ps_codegroup		= 'PUNOBSERVE',
	@ps_codeid		= '01',
	@ps_empcode		= 'TEST'

dbcc opentran

select * from tplanrelease
where plandate = '2002.09.30'	and
	itemcode = '511513'

update tplanrelease
set prdflag = 'C'
where plandate = '2002.09.30'	and
releasegubun = 'C'
	itemcode = '511513'

delete tplanrelease
where plandate = '2002.09.30'	

select * from tprdnokb

delete tprdnokb

select * from tkb

select * from tkbhis

update tkb
set	kbstatuscode = 'F'
where workcenter = '4201'
kbno = 'DA010101001'

update tkbhis
set	kbstatuscode = 'A'
--delete tkbhis
where workcenter = '4201'
kbno = 'DA010101002' and
	LastLoopFlag	= 'Y'
*/

Create Procedure sp_pisp092u_03_u
	@ps_prddate		char(10),	-- ���ؼ����� �����
	@ps_kbno		varchar(11),	-- �����ϴ� ���� ��ȣ
	@ps_kbreleasedate	char(10),
	@pi_kbreleaseseq	int,
	@ps_codegroup		varchar(10),
	@ps_codeid		varchar(10),
	@ps_empcode		varchar(6)

As
Begin

Declare	@ls_areacode		char(1),
	@ls_divisioncode		char(1),
	@ls_workcenter		varchar(5),
	@ls_linecode		char(1),
	@ls_itemcode		varchar(12),
	@ls_releasegubun	char(1),		-- ���� ���� ����
	@li_rackqty		int,

	@ldt_nowtime		datetime,	-- �������� ���ϱ� ���� ���� �Ͻ�

	@ls_error		char(2),
	@ls_errortext		varchar(100)


-- �ϴ� ���� ���� ������ ��������
Select	@ls_areacode		= AreaCode,
	@ls_divisioncode		= DivisionCode,
	@ls_workcenter		= WorkCenter,
	@ls_linecode		= LineCode,
	@ls_itemcode		= ItemCode,
	@ls_releasegubun	= ReleaseGubun,
	@li_rackqty		= RackQty
From	tkbhis
Where	KBNo		= @ps_kbno		And
	KBReleaseDate	= @ps_kbreleasedate	And
	KBReleaseSeq	= @pi_kbreleaseseq

-- �ϴ� �������� ������
Select	@ldt_nowtime	= GetDate()

--Begin Tran

-- �ϴ� tprdnokb �� ���Ӱ� ���ؼ������� �߰�����...
Insert	tprdnokb
Select	KBNo		= @ps_kbno,
	KBReleaseDate	= @ps_kbreleasedate,
	KBReleaseSeq	= @pi_kbreleaseseq,
	NoKBGubun	= 'U',
	PrdDate		= @ps_prddate,
	AreaCode	= @ls_areacode,
	DivisionCode	= @ls_divisioncode,
	WorkCenter	= @ls_workcenter,
	LineCode	= @ls_linecode,
	ItemCode	= @ls_itemcode,
	RackQty		= @li_rackqty,
	CodeGroup	= @ps_codegroup,
	CodeID		= @ps_codeid,
	ReasonDesc	= Null,
	LastEmp		= 'Y',--@ps_empcode,
	LastDate		= @ldt_nowtime

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '���ؼ����� �̷�  ���̺� ���ؼ������� ���Ӱ� �߰��Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���ؼ����� �̷�  ���̺� ���ؼ������� ���Ӱ� �߰��ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End

-- ���ؼ������ �����ϸ�
-- �������ô�� ���·� ��ȯ����..��, �������ó�� ����...��, PrdFlag �� ����,
-- ���������ϱ�.����ϱ�.���ؼ�ó���ϱ� �ϴ� ���̿� ������ �� �����ϴ�..
-- ����. �ϴ� �ܼ��ϰ� ó������.

-- �ϴ� tplanrelease �� �����ϱ�..
If @ls_releasegubun = 'Y'
Begin
	Update	tplanrelease
	Set	ReleaseGubun	= 'U',
		PrdFlag		= 'N',
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	Where	KBNo		= @ps_kbno		And
		KBReleaseDate	= @ps_kbreleasedate	And
		KBReleaseSeq	= @pi_kbreleaseseq	And
		ReleaseGubun	In ('Y', 'T')		And
		PrdFlag		In ('N')		
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '�������� ���̺� ���� �������õ� ������ ���ؼ��� ����Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '�������� ���̺� ���� �������õ� ������ ���ؼ��� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
		GoTo Proc_Exit
	End
End
Else
Begin
	Update	tplanrelease
	Set	ReleaseGubun	= 'U',
		PrdFlag		= 'N',
		LastEmp		= 'Y',--@ps_empcode,
		LastDate		= @ldt_nowtime
	Where	KBNo		= @ps_kbno		And
		KBReleaseDate	= @ps_kbreleasedate	And
		KBReleaseSeq	= @pi_kbreleaseseq	And
		ReleaseGubun	In ('Y', 'T')		And
		PrdFlag		In ('N')		
	If @@Error = 0
	Begin
		Select	@ls_error	= '00',
			@ls_errortext	= '�������� ���̺� ��� �������õ� ������ ���ؼ��� ����Ͽ����ϴ�.'
	End
	Else
	Begin
		Select	@ls_error	= '11',
			@ls_errortext	= '�������� ���̺� ��� �������õ� ������ ���ؼ��� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
		GoTo Proc_Exit
	End
End

-- tkb �� tkbhis ���̺� ������ ��������
-- tkbhis �� ��������
Update	tkbhis
Set	KBStatusCode		= 'F',
	ReleaseGubun		= 'U',
	PrdFlag			= 'N',
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime
Where	KBNo		= @ps_kbno		And
	KBReleaseDate	= @ps_kbreleasedate	And
	KBReleaseSeq	= @pi_kbreleaseseq	And
--	LastLoopFlag	= 'Y'		And
	KBStatusCode	= 'A'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '���� �̷��� ���ؼ������� ����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���� �̷��� ���ؼ������� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
	GoTo Proc_Exit
End

-- tkb �� ��������.
Update	tkb
Set	KBStatusCode		= 'F',
	ReleaseGubun		= 'U',
	PrdFlag			= 'N',
	LastEmp			= 'Y',--@ps_empcode,
	LastDate			= @ldt_nowtime
Where	KBNo		= @ps_kbno	And
	KBStatusCode	= 'A'

If @@Error = 0
Begin
	Select	@ls_error	= '00',
		@ls_errortext	= '���� ������ ���ؼ������� ����Ͽ����ϴ�.'
End
Else
Begin
	Select	@ls_error	= '11',
		@ls_errortext	= '���� ������ ���ؼ������� ����ϴ� �߿� ������ �߻��Ͽ����ϴ�.'
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
